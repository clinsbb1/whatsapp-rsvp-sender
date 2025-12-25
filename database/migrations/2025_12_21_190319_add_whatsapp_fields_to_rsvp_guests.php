<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('rsvp_guests', function (Blueprint $table) {
            $table->id();

            // Guest details
            $table->string('full_name');
            $table->string('phone');

            // RSVP QR image (e.g. 1.png)
            $table->string('rsvp_image');


            // WhatsApp tracking
            $table->boolean('whatsapp_sent')->default(false);
            $table->timestamp('whatsapp_sent_at')->nullable();

            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('rsvp_guests');
    }
};
