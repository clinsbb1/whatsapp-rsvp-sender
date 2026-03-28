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
                'contentSid' => config('services.twilio.template_sid'),
                'contentVariables' => json_encode([
                    //"1" => $name,
                    "1" => $qrImageUrl,
                ]),
            ]
        );
    }

    /**
     * Send free-form WhatsApp message (within 24-hour session window)
     */
    public function sendFreeForm(string $phone, string $message, ?string $mediaUrl = null)
    {
        $payload = [
            'from' => config('services.twilio.whatsapp_from'),
            'body' => $message,
        ];

        if ($mediaUrl) {
            $payload['mediaUrl'] = [$mediaUrl];
        }

        return $this->client->messages->create("whatsapp:$phone", $payload);
    }

    /**
     * Send Google Maps location response
     */
    public function sendLocationLink(string $phone, string $eventName, string $googleMapsUrl)
    {
        $message = "Here's the Google Maps location for {$eventName}:\n\n{$googleMapsUrl}\n\nSee you there!\n\nSent by InVyt\nPhone: +234 916 249 4770\nInstagram: @InVyt.ng\nAccess Redefined";

        return $this->sendFreeForm($phone, $message);
    }
}
