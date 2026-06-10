<?php

namespace App\Console\Commands;

use App\Models\RsvpGuest;
use App\Services\InfobipWhatsAppService;
use Illuminate\Console\Command;
use Illuminate\Support\Arr;
use RuntimeException;

class SendInfobipWhatsappRsvps extends Command
{
    protected $signature = 'rsvp:send-whatsapp-infobip
        {--limit=10 : Number of pending guests to process}
        {--dry-run : Build payloads without sending them}';

    protected $description = 'Send RSVP WhatsApp template messages through Infobip using the existing rsvp_guests table';

    public function handle(InfobipWhatsAppService $whatsapp): int
    {
        $limit = (int) $this->option('limit');
        $dryRun = (bool) $this->option('dry-run');

        $guests = RsvpGuest::query()
            ->where('whatsapp_sent', false)
            ->whereNotNull('phone')
            ->orderBy('id')
            ->limit($limit)
            ->get();

        if ($guests->isEmpty()) {
            $this->info('No pending WhatsApp invites.');

            return self::SUCCESS;
        }

        $this->info(sprintf(
            '%s %d guest(s) with Infobip template "%s".',
            $dryRun ? 'Preparing' : 'Sending',
            $guests->count(),
            (string) config('services.infobip.whatsapp_template_name')
        ));

        $sentCount = 0;

        foreach ($guests as $guest) {
            $phone = preg_replace('/\s+/', '', (string) $guest->phone);

            if (! str_starts_with($phone, '+')) {
                $this->error("Invalid phone format: {$phone}");
                continue;
            }

            try {
                $context = $this->buildContext($guest);
                $bodyPlaceholders = $this->buildBodyPlaceholders($context);
                $header = $this->buildHeader($context);
                $buttons = $this->buildButtons($context);

                if ($dryRun) {
                    $this->line(sprintf(
                        '[dry-run] %s (%s) body=%s header=%s',
                        $guest->full_name,
                        $phone,
                        json_encode($bodyPlaceholders, JSON_UNESCAPED_SLASHES),
                        json_encode($header, JSON_UNESCAPED_SLASHES),
                    ));
                    continue;
                }

                $response = $whatsapp->sendTemplate(
                    phone: $phone,
                    bodyPlaceholders: $bodyPlaceholders,
                    header: $header,
                    buttons: $buttons,
                );

                if ($whatsapp->wasAccepted($response)) {
                    $guest->update([
                        'whatsapp_sent' => true,
                        'whatsapp_sent_at' => now(),
                    ]);

                    $this->info(sprintf(
                        'Sent to %s (%s) [%s]',
                        $guest->full_name,
                        $phone,
                        data_get($response, 'messages.0.messageId', 'accepted')
                    ));

                    $sentCount++;
                } else {
                    $this->error("Infobip did not accept message for {$phone}");
                }

                $this->throttleAfterMessage($dryRun, $sentCount);
            } catch (\Throwable $e) {
                $this->error("Failed for {$phone}");
                $this->error($e->getMessage());

                if (! $dryRun) {
                    sleep((int) config('rsvp.rate_limit.failure_backoff_seconds', 30));
                }
            }
        }

        $summaryPrefix = $dryRun ? 'Dry run completed.' : 'Infobip WhatsApp send completed.';
        $this->info("{$summaryPrefix} Total accepted: {$sentCount}");

        return self::SUCCESS;
    }

    private function buildContext(RsvpGuest $guest): array
    {
        $guestImageValue = $this->resolveGuestImageValue($guest->rsvp_image);

        return [
            'guest_name' => (string) $guest->full_name,
            'full_name' => (string) $guest->full_name,
            'guest_phone' => (string) $guest->phone,
            'phone' => (string) $guest->phone,
            'event_name' => (string) config('rsvp.event.name'),
            'event_date' => (string) config('rsvp.event.date'),
            'event_venue' => (string) config('rsvp.event.venue'),
            'event_time' => (string) config('rsvp.event.time'),
            'full_address' => (string) config('rsvp.event.full_address'),
            'google_maps_url' => (string) config('rsvp.event.google_maps_url'),
            'guest_image_url' => $guestImageValue,
            'rsvp_image' => $guestImageValue,
        ];
    }

    private function buildBodyPlaceholders(array $context): array
    {
        return array_map(
            fn (string $value): string => (string) ($this->resolveTemplateValue($value, $context) ?? ''),
            config('rsvp.infobip.body_placeholders', ['guest_name'])
        );
    }

    private function buildHeader(array $context): ?array
    {
        $type = strtoupper((string) config('rsvp.infobip.header_type'));

        if ($type === '') {
            return null;
        }

        return match ($type) {
            'TEXT' => $this->buildTextHeader($context),
            'IMAGE', 'VIDEO', 'DOCUMENT' => $this->buildMediaHeader($type, $context),
            default => throw new RuntimeException("Unsupported Infobip header type [{$type}]."),
        };
    }

    private function buildTextHeader(array $context): array
    {
        $placeholder = $this->resolveTemplateValue(
            (string) config('rsvp.infobip.header_text'),
            $context
        );

        if (blank($placeholder)) {
            throw new RuntimeException('INFOBIP_WHATSAPP_HEADER_TEXT is required for TEXT headers.');
        }

        return [
            'type' => 'TEXT',
            'placeholder' => $placeholder,
        ];
    }

    private function buildMediaHeader(string $type, array $context): array
    {
        $mediaUrl = $this->resolveTemplateValue(
            (string) config('rsvp.infobip.header_media_url'),
            $context
        );

        if (! filled($mediaUrl) || ! filter_var($mediaUrl, FILTER_VALIDATE_URL)) {
            throw new RuntimeException("A valid media URL is required for {$type} headers.");
        }

        $header = [
            'type' => $type,
            'mediaUrl' => $mediaUrl,
        ];

        if ($type === 'DOCUMENT') {
            $filename = $this->resolveTemplateValue(
                (string) config('rsvp.infobip.header_document_filename'),
                $context
            );

            if (blank($filename)) {
                $filename = basename((string) parse_url($mediaUrl, PHP_URL_PATH));
            }

            if (blank($filename)) {
                throw new RuntimeException('A document filename is required for DOCUMENT headers.');
            }

            $header['filename'] = $filename;
        }

        return $header;
    }

    private function buildButtons(array $context): array
    {
        $buttons = config('rsvp.infobip.buttons', []);

        if (! is_array($buttons)) {
            return [];
        }

        return array_values(array_map(function (array $button) use ($context): array {
            $resolved = [];

            foreach ($button as $key => $value) {
                if (is_string($value)) {
                    $resolved[$key] = $this->resolveTemplateValue($value, $context) ?? '';
                    continue;
                }

                $resolved[$key] = $value;
            }

            $resolved['type'] = strtoupper((string) Arr::get($resolved, 'type', ''));

            if ($resolved['type'] === '') {
                throw new RuntimeException('Each Infobip template button must include a type.');
            }

            return $resolved;
        }, array_filter($buttons, 'is_array')));
    }

    private function resolveTemplateValue(string $value, array $context): ?string
    {
        if ($value === '') {
            return null;
        }

        return array_key_exists($value, $context)
            ? ($context[$value] !== null ? (string) $context[$value] : null)
            : $value;
    }

    private function resolveGuestImageValue(?string $value): ?string
    {
        if (blank($value)) {
            return null;
        }

        if (filter_var($value, FILTER_VALIDATE_URL)) {
            return $value;
        }

        $baseUrl = rtrim((string) config('rsvp.guest_image_base_url'), '/');

        if ($baseUrl === '') {
            return $value;
        }

        return $baseUrl.'/'.ltrim($value, '/');
    }

    private function throttleAfterMessage(bool $dryRun, int $sentCount): void
    {
        if ($dryRun) {
            return;
        }

        sleep((int) config('rsvp.rate_limit.message_delay_seconds', 5));

        $batchSize = (int) config('rsvp.rate_limit.batch_size', 50);

        if ($batchSize > 0 && $sentCount > 0 && $sentCount % $batchSize === 0) {
            $this->info('Batch pause...');
            sleep((int) config('rsvp.rate_limit.batch_pause_seconds', 60));
        }
    }
}
