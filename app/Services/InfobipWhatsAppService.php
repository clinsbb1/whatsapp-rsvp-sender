<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Str;
use RuntimeException;

class InfobipWhatsAppService
{
    public function sendTemplate(
        string $phone,
        array $bodyPlaceholders,
        ?array $header = null,
        array $buttons = [],
        ?string $messageId = null,
    ): array {
        $this->ensureConfigured();

        $templateData = [
            'body' => [
                'placeholders' => array_values($bodyPlaceholders),
            ],
        ];

        if ($header !== null) {
            $templateData['header'] = $header;
        }

        if ($buttons !== []) {
            $templateData['buttons'] = array_values($buttons);
        }

        $message = [
            'from' => config('services.infobip.whatsapp_from'),
            'to' => $phone,
            'messageId' => $messageId ?? (string) Str::uuid(),
            'content' => [
                'templateName' => config('services.infobip.whatsapp_template_name'),
                'templateData' => $templateData,
                'language' => config('services.infobip.whatsapp_template_language'),
            ],
        ];

        if ($callbackData = config('rsvp.infobip.callback_data')) {
            $message['callbackData'] = $callbackData;
        }

        if ($notifyUrl = config('rsvp.infobip.notify_url')) {
            $message['notifyUrl'] = $notifyUrl;
        }

        $response = Http::acceptJson()
            ->asJson()
            ->timeout(30)
            ->withHeaders([
                'Authorization' => 'App '.config('services.infobip.api_key'),
            ])
            ->post(
                rtrim((string) config('services.infobip.base_url'), '/').'/whatsapp/1/message/template',
                ['messages' => [$message]],
            );

        $response->throw();

        return $response->json() ?? [];
    }

    public function wasAccepted(array $response): bool
    {
        return filled(data_get($response, 'messages.0.messageId'));
    }

    private function ensureConfigured(): void
    {
        $required = [
            'services.infobip.base_url' => config('services.infobip.base_url'),
            'services.infobip.api_key' => config('services.infobip.api_key'),
            'services.infobip.whatsapp_from' => config('services.infobip.whatsapp_from'),
            'services.infobip.whatsapp_template_name' => config('services.infobip.whatsapp_template_name'),
            'services.infobip.whatsapp_template_language' => config('services.infobip.whatsapp_template_language'),
        ];

        $missing = [];

        foreach ($required as $key => $value) {
            if (blank($value)) {
                $missing[] = $key;
            }
        }

        if ($missing !== []) {
            throw new RuntimeException('Missing Infobip configuration: '.implode(', ', $missing));
        }
    }
}
