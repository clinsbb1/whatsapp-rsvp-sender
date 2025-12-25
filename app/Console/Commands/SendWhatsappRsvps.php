<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\RsvpGuest;
use App\Services\WhatsAppService;

class SendWhatsappRsvps extends Command
{
    /**
     * The name and signature of the console command.
     */
    protected $signature = 'rsvp:send-whatsapp {--limit=10}';

    /**
     * The console command description.
     */
    protected $description = 'Send RSVP WhatsApp messages in safe batches';

    public function handle(WhatsAppService $whatsapp)
    {
        // 👉 EVENT CONFIG
        $eventName  = "Biodun Onilogbo 40th Birthday Golden Reverie";
        $eventDate  = '26th December 2025 (tomorrow)';
        $eventVenue = 'Fame Lagos, 37 Glover Court, Off Glover Road, Ikoyi, Lagos';
        $eventTime  = '4:00 PM';
        $googleMapsUrl = 'https://maps.google.com/?q=Fame+Lagos,+37+Glover+Court,+Off+Glover+Road,+Ikoyi,+Lagos';

        $limit = (int) $this->option('limit');

        $guests = RsvpGuest::where('whatsapp_sent', false)
            ->whereNotNull('phone')
            ->orderBy('id')
            ->limit($limit)
            ->get();

        if ($guests->isEmpty()) {
            $this->info('No pending WhatsApp invites.');
            return;
        }

        $sentCount = 0;

        foreach ($guests as $guest) {

            // 🔐 Normalize phone number
            $phone = preg_replace('/\s+/', '', $guest->phone);

            if (!str_starts_with($phone, '+')) {
                $this->error("Invalid phone format: {$phone}");
                continue;
            }

            try {
                $response = $whatsapp->sendInvite(
                    $phone,
                    $guest->full_name,
                    $eventName,
                    $eventDate,
                    $eventVenue,
                    $eventTime,
                    $googleMapsUrl,
                    $guest->rsvp_image
                );

                // ✅ Only mark as sent if Twilio accepted it
                if ($response && isset($response->sid)) {
                    $guest->update([
                        'whatsapp_sent' => true,
                        'whatsapp_sent_at' => now(),
                    ]);

                    $this->info("Sent to {$guest->full_name} ({$phone})");
                    $sentCount++;
                } else {
                    $this->error("No SID returned for {$phone}");
                }

                // ⏱ Per-message throttle (very safe)
                sleep(5);

                // 🧱 Batch throttle (critical after Meta re-enable)
                if ($sentCount > 0 && $sentCount % 10 === 0) {
                    $this->info('Batch pause...');
                    sleep(60);
                }

            } catch (\Throwable $e) {
                $this->error("Failed for {$phone}");
                $this->error($e->getMessage());

                // ⛔ Back off harder on any failure
                sleep(30);
            }
        }

        $this->info("WhatsApp send completed. Total sent: {$sentCount}");
    }

}
