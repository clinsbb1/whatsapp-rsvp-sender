<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SmsRecipient extends Model
{
    protected $fillable = [
        'phone',
        'code',
        'sent',
        'sent_at',
    ];

    protected $casts = [
        'sent' => 'boolean',
        'sent_at' => 'datetime',
    ];
}
