<?php

namespace App\Console\Commands;

use App\Models\SmsRecipient;
use App\Services\SmsService;
use Illuminate\Console\Command;

class SendSms extends Command
{
    protected $signature = 'sms:send {--limit= : Number of SMS to send}';
    protected $description = 'Send invite SMS to all unsent recipients';

    public function handle(SmsService $sms): int
    {
        $query = SmsRecipient::where('sent', false);

        // Apply limit if specified
        if ($limit = $this->option('limit')) {
            $query->limit((int) $limit);
        }

        $recipients = $query->get();

        if ($recipients->isEmpty()) {
            $this->info('No pending recipients found.');
            return Command::SUCCESS;
        }

        $this->info("Sending SMS to {$recipients->count()} recipients...");

        foreach ($recipients as $recipient) {
            $message = "You're invited! T-POP (Ten-Ten turns Ten) Birthday Party.\nAccess card: https://invyt.ng/samples/{$recipient->code}.jpg\nShow at venue for entry.\nDo not reply";

            try {
                $sms->send($recipient->phone, $message);

                $recipient->update([
                    'sent' => true,
                    'sent_at' => now(),
                ]);

                $this->info("✓ Sent to {$recipient->phone}");
            } catch (\Exception $e) {
                $this->error("✗ Failed for {$recipient->phone}: " . $e->getMessage());
            }

            sleep(3); // Rate limiting
        }

        $this->info('Done!');
        return Command::SUCCESS;
    }
}
