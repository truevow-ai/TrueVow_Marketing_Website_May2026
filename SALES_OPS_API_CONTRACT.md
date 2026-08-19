# Sales Ops API Contract — Website Submission Forwarding

**Source of truth:** `server.js` (this repo). If `server.js` changes, update this file in the same commit.

This document is the hand-off contract between the TrueVow marketing website and the Sales Ops service. The website is the client; Sales Ops is the durable receiver.

---

## 1. Configuration (Fly.io secrets on the website app)

| Variable | Purpose | Notes |
|---|---|---|
| `SALES_OPS_API_URL` | Sales Ops base URL | **No trailing slash** — server appends endpoint paths |
| `SALES_OPS_API_KEY` | Shared API key | Sent as `X-API-Key` header |

**Critical:** if `SALES_OPS_API_URL` is unset, `forwardToSalesOps` logs a warning and returns `{ accepted: true, simulated: true }` — **the form shows success but nothing is delivered anywhere.** Both secrets must be configured on Fly before any live-form QA.

---

## 2. Transport Contract (identical for all endpoints)

```
POST {SALES_OPS_API_URL}<path>
Headers:
  Content-Type: application/json
  X-API-Key: <SALES_OPS_API_KEY>
  X-Correlation-Id: <UUID generated per submission>
Timeout: 15s (client aborts on expiry)
```

**Acceptance rules (what Sales Ops must return):**

| Sales Ops response | Website behavior |
|---|---|
| Any 2xx | Submission accepted; visitor sees success |
| 409 with body containing `"duplicate"` (e.g. `{"message": "duplicate submission"}`) | Visitor sees the friendly "we already received your details" message |
| Any other non-2xx | Visitor sees the `message`/`error` field from the body, or a generic failure |
| Unreachable / timeout | Website returns 502 "Unable to reach intake service" |

Sales Ops responses may include any JSON body; the website reads `message` or `error` fields only.

---

## 3. Endpoint A — `POST /website/application-received`

**Purpose:** 90-Day INTAKE Trial submissions (`product === 'INTAKE_TRIAL'`).

**Payload** (built by `buildSalesOpsTrialPayload`, server.js:233):

```json
{
  "product": "INTAKE_TRIAL",
  "source": "trial-page",

  "first_name": "string (required)",
  "last_name": "string (required)",
  "attorney_email": "string (required, valid email)",
  "attorney_mobile": "string (required)",
  "bar_state": "US state abbrev (required)",
  "bar_number": "string (required)",

  "firm_name": "string (required)",
  "firm_website": "string|null",
  "firm_email": "string (required, valid email)",
  "firm_phone": "string (required)",
  "state": "US state abbrev (required)",
  "primary_county": "string (required)",

  "primary_practice_area": "string (required)",
  "firm_size": "string (required)",
  "monthly_inbound_calls": "string (required)",

  "current_after_hours_process": "string|null",
  "calendar_booking_available": "string|null",
  "willing_to_forward_calls": "string|null",
  "referral_source": "string|null",

  "agree_terms_privacy": "boolean (required true)",
  "confirm_accuracy_authority": "boolean (required true)",
  "understands_setup_confirmation_required": "boolean (required true)",
  "understands_90_day_trial": "boolean (required true)",
  "understands_onboarding_required": "boolean (required true)",

  "disclosure_version": "trial-step3-2026-08",
  "disclosure_text_displayed": true,

  "landing_page": "string|null",
  "query_string": "string|null",
  "utm_source": "string|null",
  "utm_medium": "string|null",
  "utm_campaign": "string|null",
  "utm_content": "string|null",
  "utm_term": "string|null",
  "gclid": "string|null",
  "fbclid": "string|null",
  "msclid": "string|null",

  "submitted_at": "ISO-8601 string",
  "user_agent": "string|null",
  "referrer": "string|null",
  "ip_addr": "string|null"
}
```

**Field rename (breaking, effective commit `faae990`):** the governance confirmation is now `understands_setup_confirmation_required`. The legacy `understands_approval_required` field is **no longer sent**. Sales Ops must read the new field name; if it still maps only the old one, the confirmation will be silently dropped.

`disclosure_version` + `disclosure_text_displayed` are display evidence, not fabricated consent — store them as-is for audit.

`correlationId` is **not** in the body for this endpoint; it travels in the `X-Correlation-Id` header.

---

## 4. Endpoint B — `POST /demo-request`

**Purpose:** Benjamin demo callbacks ("Have Benjamin Call My Cell").

**Payload** (built by `buildSalesOpsDemoPayload`, server.js:291):

```json
{
  "source": "benjamin-demo",
  "first_name": "string (required)",
  "last_name": "string (required)",
  "email": "string (required, valid email)",
  "cell_phone": "string (required)",
  "law_firm_name": "string (required)",
  "state": "US state abbrev (required)",
  "county": "string (required)",
  "demo_consent": "boolean (required true)",
  "page_url": "string|null",
  "submitted_at": "ISO-8601 string"
}
```

**Sales Ops SLA:** the demo page promises a callback **within ~8 minutes** of submission, dependent on outbound line availability. Sales Ops owns triggering the callback workflow on acceptance and must honor or exceed this expectation (delays degrade the funnel).

---

## 5. Endpoint C — `POST /website/waitlist-submission`

**Purpose:** legacy pass-through for lightweight waitlist forms.

**Status:** no live page currently submits to this path (SETTLE/TRACE forms were removed from the website). The server keeps the route as a fallback.

**Payload:** the raw form body plus a `correlationId` field.

If Sales Ops has already removed this endpoint, delete the non-trial branch in `/api/waitlist` and update this file.

---

## 6. Deduplication Ownership

The website's idempotency cache is **in-memory per-process** (not shared across Fly machines; resets on restart). It is an optimization, not an integrity boundary.

**Sales Ops is the authoritative dedup layer.** Requirements:

1. Persist a durable uniqueness check (suggested key: `product + normalized email + normalized firm_name` for trial; `email` for demo).
2. On duplicate: return `409` with `{"message": "duplicate submission"}` — the website frontends render the friendly "already received" state for this exact pattern.
3. On first-time acceptance: return 2xx.

---

## 7. Website-side validation (already enforced before forwarding)

- Trial: required strings, valid emails, valid US states, three boolean checkboxes (terms, accuracy/authority, setup confirmation).
- Demo: required strings, valid email, valid US state, `demo_consent` true.
- Rate limit: 5 requests/minute/IP per endpoint.
- Body size cap: 64kb.

Sales Ops may re-validate, but must not reject fields the website sends as `null`.

---

## 8. Implementation Status (2026-08-19)

**Sales Ops side: BUILT AND VERIFIED** (truevow-sales-ops repo):

- `POST /website/application-received` — INTAKE_TRIAL: durable receipt → `sales_leads` → intake routing (fire-and-forget)
- `POST /demo-request` — BENJAMIN_DEMO: receipt → lead upsert by email → `sales_demos` (source=`benjamin-demo`, ASAP) → demo trigger (~8-min SLA), 3/24h rate limit, watchdog backstop
- `POST /website/waitlist-submission` — legacy pass-through, raw body stored
- `lib/website-submission-contract.ts` — zod schemas; **`understands_setup_confirmation_required` is required (400 if the website regresses)**
- `lib/website-submission-auth.ts` — `X-API-Key` auth, fail-closed 503 in prod
- `supabase/migrations/20260819000001_website_submission_contract.sql` — `website_submissions` UNIQUE dedup + `sales_demos.source` CHECK — applied live
- `middleware.ts` — new paths public
- Verified: 15 unit tests, typecheck, live E2E (trial 201→dup 409, demo 201→dup 409, waitlist 200, bad key 401)

**Website side: NO CHANGES NEEDED** — server.js already sends the canonical field, correct headers, and correct endpoint paths.

**Remaining ops actions (outside both repos):**

1. Set `WEBSITE_SUBMISSION_API_KEY` on Fly app `truevow-sales-ops` = the website's `SALES_OPS_API_KEY`
2. Set/confirm `SALES_OPS_API_URL` on Fly app `truevow-ai` = Sales Ops app root, no trailing slash
3. Set `SALES_OPS_API_KEY` on Fly app `truevow-ai` (same value as #1)
4. Deploy the Sales Ops app (routes currently in-repo only)
5. Run the E2E checklist in section 8 below

---

## 9. Operational Checklist Before Go-Live

- [ ] `SALES_OPS_API_URL` and `SALES_OPS_API_KEY` set on Fly (website app `truevow-ai`)
- [ ] `WEBSITE_SUBMISSION_API_KEY` set on Fly (Sales Ops app `truevow-sales-ops`) — same value as `SALES_OPS_API_KEY`
- [ ] Sales Ops app deployed with the new routes (currently in-repo only)
- [ ] Sales Ops `/website/application-received` deployed and reading `understands_setup_confirmation_required`
- [ ] Sales Ops `/demo-request` deployed with ~8-minute callback workflow
- [ ] Durable dedup + 409 `"duplicate"` contract implemented
- [ ] E2E test: submit trial form -> record visible in Sales Ops with all UTM fields
- [ ] E2E test: submit demo form -> callback triggered; duplicate submit shows friendly message
