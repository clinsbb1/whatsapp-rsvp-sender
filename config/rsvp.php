<?php

$csv = static fn (string $value): array => array_values(array_filter(
    array_map('trim', explode(',', $value)),
    static fn (string $item): bool => $item !== ''
));

$buttons = json_decode((string) env('INFOBIP_WHATSAPP_BUTTONS_JSON', '[]'), true);

return [
    'event' => [
        'name' => env('RSVP_EVENT_NAME', ''),
        'date' => env('RSVP_EVENT_DATE', ''),
        'venue' => env('RSVP_EVENT_VENUE', ''),
        'time' => env('RSVP_EVENT_TIME', ''),
        'full_address' => env('RSVP_EVENT_FULL_ADDRESS', ''),
        'google_maps_url' => env('RSVP_EVENT_GOOGLE_MAPS_URL', ''),
    ],

    'guest_image_base_url' => env('RSVP_GUEST_IMAGE_BASE_URL', ''),

    'rate_limit' => [
        'message_delay_seconds' => (int) env('RSVP_MESSAGE_DELAY_SECONDS', 5),
        'batch_size' => (int) env('RSVP_BATCH_SIZE', 50),
        'batch_pause_seconds' => (int) env('RSVP_BATCH_PAUSE_SECONDS', 60),
        'failure_backoff_seconds' => (int) env('RSVP_FAILURE_BACKOFF_SECONDS', 30),
    ],

    'infobip' => [
        'header_type' => env('INFOBIP_WHATSAPP_HEADER_TYPE', 'IMAGE'),
        'header_media_url' => env('INFOBIP_WHATSAPP_HEADER_MEDIA_URL', 'guest_image_url'),
        'header_text' => env('INFOBIP_WHATSAPP_HEADER_TEXT', ''),
        'header_document_filename' => env('INFOBIP_WHATSAPP_HEADER_DOCUMENT_FILENAME', ''),
        'body_placeholders' => $csv((string) env(
            'INFOBIP_WHATSAPP_BODY_PLACEHOLDERS',
            'guest_name,event_name,event_date,event_venue,event_time'
        )),
        'buttons' => is_array($buttons) ? $buttons : [],
        'notify_url' => env('INFOBIP_WHATSAPP_NOTIFY_URL', ''),
        'callback_data' => env('INFOBIP_WHATSAPP_CALLBACK_DATA', ''),
    ],
];
