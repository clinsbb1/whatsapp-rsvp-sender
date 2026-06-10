<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RsvpGuest extends Model
{
    protected $fillable = [
        'full_name',
        'email',
        'phone',
        'rsvp_image',
        'whatsapp_sent',
        'whatsapp_sent_at',
    ];

    protected $casts = [
        'whatsapp_sent' => 'boolean',
        'whatsapp_sent_at' => 'datetime',
    ];
}
