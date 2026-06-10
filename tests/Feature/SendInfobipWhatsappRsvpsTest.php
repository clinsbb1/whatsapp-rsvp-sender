<?php

namespace Tests\Feature;

use App\Models\RsvpGuest;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Http;
use Tests\TestCase;

class SendInfobipWhatsappRsvpsTest extends TestCase
{
    use RefreshDatabase;

    public function test_it_sends_an_infobip_template_and_marks_the_guest_as_sent(): void
    {
        config([
            'services.infobip.base_url' => 'https://api.infobip.com',
            'services.infobip.api_key' => 'test-api-key',
            'services.infobip.whatsapp_from' => '447492263897',
            'services.infobip.whatsapp_template_name' => 'image_media_template',
            'services.infobip.whatsapp_template_language' => 'en_GB',
            'rsvp.event.name' => 'Test Event',
            'rsvp.event.date' => 'Sunday, 15th February 2026',
            'rsvp.event.venue' => 'Banana Island Playground',
            'rsvp.event.time' => '1:00 PM',
            'rsvp.event.full_address' => 'Banana Island, Lagos',
            'rsvp.guest_image_base_url' => 'https://cdn.example.com/rsvp',
            'rsvp.infobip.header_type' => 'IMAGE',
            'rsvp.infobip.header_media_url' => 'guest_image_url',
            'rsvp.infobip.body_placeholders' => ['guest_name', 'event_name', 'event_date'],
            'rsvp.infobip.buttons' => [],
            'rsvp.infobip.notify_url' => '',
            'rsvp.infobip.callback_data' => 'rsvp-invite',
            'rsvp.rate_limit.message_delay_seconds' => 0,
            'rsvp.rate_limit.batch_size' => 50,
            'rsvp.rate_limit.batch_pause_seconds' => 0,
            'rsvp.rate_limit.failure_backoff_seconds' => 0,
        ]);

        $guest = RsvpGuest::query()->create([
            'full_name' => 'Ada Guest',
            'phone' => '+2348012345678',
            'rsvp_image' => 'ada-guest.jpg',
            'whatsapp_sent' => false,
        ]);

        Http::fake([
            'https://api.infobip.com/whatsapp/1/message/template' => Http::response([
                'messages' => [
                    [
                        'to' => '+2348012345678',
                        'messageCount' => 1,
                        'messageId' => 'infobip-message-123',
                        'status' => [
                            'groupName' => 'PENDING',
                            'name' => 'PENDING_ENROUTE',
                        ],
                    ],
                ],
                'bulkId' => 'bulk-123',
            ], 200),
        ]);

        $this->artisan('rsvp:send-whatsapp-infobip --limit=1')
            ->expectsOutputToContain('Sent to Ada Guest')
            ->assertSuccessful();

        Http::assertSent(function ($request) {
            return $request->url() === 'https://api.infobip.com/whatsapp/1/message/template'
                && $request->hasHeader('Authorization', 'App test-api-key')
                && $request['messages'][0]['from'] === '447492263897'
                && $request['messages'][0]['to'] === '+2348012345678'
                && $request['messages'][0]['content']['templateName'] === 'image_media_template'
                && $request['messages'][0]['content']['language'] === 'en_GB'
                && $request['messages'][0]['content']['templateData']['header']['type'] === 'IMAGE'
                && $request['messages'][0]['content']['templateData']['header']['mediaUrl'] === 'https://cdn.example.com/rsvp/ada-guest.jpg'
                && $request['messages'][0]['content']['templateData']['body']['placeholders'] === [
                    'Ada Guest',
                    'Test Event',
                    'Sunday, 15th February 2026',
                ]
                && $request['messages'][0]['callbackData'] === 'rsvp-invite';
        });

        $guest->refresh();

        $this->assertTrue($guest->whatsapp_sent);
        $this->assertNotNull($guest->whatsapp_sent_at);
    }
}
