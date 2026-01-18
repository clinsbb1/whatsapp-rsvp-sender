<?php

namespace App\Console\Commands;

use App\Services\SmsService;
use Illuminate\Console\Command;

class SendSms extends Command
{
    protected $signature = 'sms:send';
    protected $description = 'Send an SMS via Twilio';

    public function handle(SmsService $sms): int
    {
        // ====== EDIT THESE VALUES ======
        $phone = '+2348038308186';
        $message = "You're invited! Ibukun & Abayomi Traditional Wedding.\nAccess card: https://invyt.ng/samples/X7F4N.png\nPlease present this at the venue for entry.";
        // ================================

        try {
            $sms->send($phone, $message);
            $this->info("SMS sent to {$phone}");
            $this->info("Message: {$message}");
            return Command::SUCCESS;
        } catch (\Exception $e) {
            $this->error("Failed: " . $e->getMessage());
            return Command::FAILURE;
        }
    }
}
