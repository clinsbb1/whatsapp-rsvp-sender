# WhatsApp RSVP Sender

A Laravel-based open-source tool for sending personalized, rate-limited WhatsApp RSVP invitations using approved WhatsApp Business templates and dynamic media (such as QR codes).

This project is designed with **compliance, reliability, and production safety** in mind and can be integrated with WhatsApp Business API providers such as **Twilio**, **Termii**, or similar platforms.

---

## Features

* Personalized WhatsApp template messages
* Dynamic template variables (guest name, event details, links)
* Dynamic media support (e.g. per-guest QR codes)
* Built-in rate limiting and batch sending
* Resume-safe delivery (prevents duplicate sends)
* Robust error handling and logging
* CLI-based execution via Laravel Artisan

---

## Tech Stack

* PHP (Laravel)
* WhatsApp Business API (via supported providers)
* MySQL / PostgreSQL / SQLite (Laravel-supported databases)

---

## Requirements

* PHP 8.1+
* Laravel 10+
* A WhatsApp Business API provider account
* At least one **approved WhatsApp template**
* Publicly accessible HTTPS URLs for media (images)

---

## ⚙️ Installation

### 1️⃣ Clone the repository

```bash
git clone https://github.com/your-username/whatsapp-rsvp-sender.git
cd whatsapp-rsvp-sender
```

---

### 2️⃣ Install dependencies

```bash
composer install
```

---

### 3️⃣ Environment setup

Create your environment file:

```bash
cp .env.example .env
php artisan key:generate
```

Configure your WhatsApp provider credentials (example):

```env
WHATSAPP_PROVIDER_SID=your_provider_sid
WHATSAPP_PROVIDER_TOKEN=your_provider_token
WHATSAPP_FROM=whatsapp:+1234567890
WHATSAPP_TEMPLATE_SID=HXxxxxxxxxxxxxxxxx
```

> ⚠️ Templates must be approved by WhatsApp before use.

---

### 4️⃣ Database setup

Run migrations:

```bash
php artisan migrate
```

Your guest table should include at minimum:

* `full_name`
* `phone`
* `rsvp_image`
* `whatsapp_sent`
* `whatsapp_sent_at`

---

## 🚀 Usage (CLI)

Messages are sent using a Laravel Artisan command.

### Basic usage

```bash
php artisan rsvp:send-whatsapp --limit=10
```

* `--limit` specifies how many pending records to process
* Only guests with `whatsapp_sent = false` are sent messages

### Infobip template usage

The project now includes a parallel Infobip sender that uses the same `rsvp_guests` table and the same `whatsapp_sent` tracking fields:

```bash
php artisan rsvp:send-whatsapp-infobip --limit=10
```

Optional dry run:

```bash
php artisan rsvp:send-whatsapp-infobip --limit=3 --dry-run
```

Set the template and media-header details in `.env`:

```env
INFOBIP_BASE_URL=https://api.infobip.com
INFOBIP_API_KEY=your_infobip_api_key
INFOBIP_WHATSAPP_FROM=447492263897
INFOBIP_WHATSAPP_TEMPLATE_NAME=your_approved_template_name
INFOBIP_WHATSAPP_TEMPLATE_LANGUAGE=en_GB
INFOBIP_WHATSAPP_HEADER_TYPE=IMAGE
INFOBIP_WHATSAPP_HEADER_MEDIA_URL=guest_image_url
INFOBIP_WHATSAPP_BODY_PLACEHOLDERS=guest_name,event_name,event_date,event_venue,event_time
```

If `rsvp_guests.rsvp_image` stores just a filename, also set:

```env
RSVP_GUEST_IMAGE_BASE_URL=https://your-domain.com/path-to-images
```

`INFOBIP_WHATSAPP_HEADER_MEDIA_URL` can be either:

* `guest_image_url` to use each guest's `rsvp_image`
* a full HTTPS URL to use the same image/video/document for everyone

If your Infobip template has dynamic buttons, set `INFOBIP_WHATSAPP_BUTTONS_JSON` to a JSON array such as:

```env
INFOBIP_WHATSAPP_BUTTONS_JSON=[{"type":"URL","parameter":"guest_name"}]
```

---

### Recommended sending strategy

For new or recently restored WhatsApp Business Accounts:

```bash
php artisan rsvp:send-whatsapp --limit=3
# wait 10–15 minutes

php artisan rsvp:send-whatsapp --limit=5
# wait

php artisan rsvp:send-whatsapp --limit=10
```

Gradually increase volume to avoid throttling.

---

## ⏱ Rate Limiting (Important)

This project intentionally sends messages **slowly** to comply with WhatsApp and Meta policies.

Typical safeguards include:

* Delays between messages
* Pauses between batches
* Backoff on failures

**Do not remove rate limiting** unless your WhatsApp Business Account has an established sending history.

---

## 📌 Important WhatsApp Compliance Notes

WhatsApp Business API usage is strictly monitored.

### ❌ Do NOT:

* Spam the same number repeatedly
* Test aggressively on your own phone number
* Retry failed messages immediately
* Send large batches too quickly
* Change templates while actively sending

---

### ✅ Best practices:

* Use approved templates only
* Send messages gradually
* Use E.164 phone number format (`+2341234567890`)
* Ensure media URLs are HTTPS and publicly accessible
* Avoid spaces in filenames and URLs
* Send messages only to users who expect them

---

## ⚠️ Delivery Disclaimer

A successful API response does **not guarantee delivery**.

Delivery depends on:

* Recipient availability
* Opt-in status
* WhatsApp quality limits
* Meta rate enforcement

Always monitor provider logs and message statuses.

---

## 🧪 Testing Guidelines

* Use a dedicated test phone number
* Send one test message at a time
* Wait between tests
* Avoid repeated testing on the same number

---

## 🤝 Contributing

Contributions are welcome.

Please ensure:

* Code follows Laravel best practices
* Rate-limiting safeguards are preserved
* New features do not violate WhatsApp or Meta policies

Open a pull request with a clear description of changes.

---

## 📄 License

This project is open-source and provided **as is**.
You are responsible for ensuring compliance with WhatsApp, Meta, and your provider’s terms of service.

---

## 🚨 Final Note

WhatsApp Business messaging is powerful but unforgiving.

This project prioritizes **safety over speed** by default.
If you modify sending limits or safeguards, do so carefully and at your own risk.
