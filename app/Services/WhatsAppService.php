<?php

namespace App\Services;

use Twilio\Rest\Client;

class WhatsAppService
{
    protected Client $client;

    public function __construct()
    {
        $this->client = new Client(
            config('services.twilio.sid'),
            config('services.twilio.token')
        );
    }

    /**
     * Send RSVP WhatsApp message using approved template
     */
    public function sendInvite(
        string $phone,
        string $name,
        string $eventName,
        string $eventDate,
        string $eventVenue,
        string $eventTime,
        string $googleMapsUrl,
        string $qrImageUrl
    ) {
        return $this->client->messages->create(
            "whatsapp:$phone",
            [
                'from' => config('services.twilio.whatsapp_from'),

                // Approved WhatsApp template
                'contentSid' => config('services.twilio.template_sid'),

                // Template variables {{1}} - {{5}}
                'contentVariables' => json_encode([
                    "1" => $name,
                    "2" => $eventName,
                    "3" => $eventDate,
                    "4" => $eventVenue,
                    "5" => $eventTime,
                    "6" => $googleMapsUrl,
                    "7" => $qrImageUrl,
                ]),
            ]
        );
    }
}
