# TrueVow Marketing Website — Checkpoint (April 27, 2026)

## What Was Done This Session

### 1. Pricing Page Overhaul (pricing.html)
- INTAKE cards updated: Solo $199/3 A+/500min, Growth $599/11 A+/1,500min, Team $1,499/33 A+/4,500min
- "How A+ Unlocks Work" explanatory block added
- Add-on section rebuilt: FOLLOW-UP, COMPLETE, Recordings & Transcripts
- FOLLOW-UP two-meter wording: actions + connected voice minutes counted separately
- Add-on overage small text: COMPLETE $9/$5 per packet, Recordings $0.05/min, Transcripts $0.15/min and $0.10/min
- LEVERAGE cards: active case capacity, no rollover, ecosystem pricing
- SETTLE: removed rollover language, Customer Portal reference
- FAQ: 5 new FAQs for unlocks and add-ons
- All old references eliminated (5/15/45 A+ unlocks, Rollover bank, case credits, Unlock $99)

### 2. 90-Day Trial Funnel Built
- `trial.html` — Public acquisition page for solo/small PI firms
  - 3-step form: Attorney+Firm → Firm Fit → Trial Confirmation
  - Sections: Why PI call matters, What Benjamin does, Trial includes, Who qualifies, Approval flow, FAQ
  - Approval-first, no checkout, no LEVERAGE/SETTLE
  - Success: "We usually review applications within 2 business days."
- `trial-onboarding.html` — Approved-only onboarding form (noindex)
  - 8 sections: Firm Setup, Contact Users, Phone Routing, Calendar, Intake Preferences, Alerts, Recording/Transcript Policy, Activation Readiness
  - POSTs to `/api/onboarding` with `form_type: 'onboarding_preparation'`

### 3. Ad Landing Page Built
- `benjamin-ad-landing-page-01.html` — INTAKE-only for cold traffic
  - Pricing preview matching locked pricing
  - Footer logo + "No payment happens on this page" line

### 4. Cross-Page Compliance Audit Complete
- All pages reviewed and approved: pricing, index, how-it-works, profitability, county-cap, compliance, integrations, settle, leverage
- Claim-safe language enforced everywhere

### 5. Documentation Updated
- README.md: Full rewrite with pricing model, trial funnel, compliance rules, CTA rules, service ownership
- LAUNCH_READY_SUMMARY.md: Updated with current page list and recent changes
- .cursor/rules/no-cache.mdc: Updated with project context, pricing, claim-safety rules
- .qoder/skills/truevow-marketing-claims.md: New skill for claim-safe page builds
- .qoder/agents/marketing-website.md: New agent config

## Current Marketing Files (28 HTML)

### Product & Pricing
- pricing.html — Full pricing (INTAKE + LEVERAGE + SETTLE + add-ons + FAQ)
- settle.html — SETTLE product page
- leverage.html — LEVERAGE product page
- how-it-works.html — Product explanation
- integrations.html — Integrations
- compliance.html — Compliance
- profitability.html — ROI/profitability
- county-cap.html — 33% County Cap

### Trial Funnel
- trial.html — 90-Day Intake Trial (public, ads/email traffic)
- trial-onboarding.html — Onboarding prep (approved firms only, noindex)

### Ad Landing
- benjamin-ad-landing-page-01.html — INTAKE-only ad landing page

### Other
- index.html — Homepage
- apply.html — General application (legacy, still live)
- blog.html — Blog hub (Supabase dynamic)
- about.html, careers.html, press.html, case-studies.html
- partner.html, affiliate.html, affiliate-apply.html
- founding-members.html, demo-oakwood.html

## Locked Pricing (do not change without user approval)

### INTAKE
| Plan | Price | A+ Unlocks | Voice Min | Attorneys | Overage |
|------|-------|-----------|-----------|-----------|---------|
| Solo | $199/mo | 3 | 500 | 1 | $49/unlock |
| Growth | $599/mo | 11 | 1,500 | 1 seat | $39/unlock |
| Team | $1,499/mo | 33 | 4,500 | Up to 5 | $29/unlock |

### Add-ons (Growth & Team only)
- FOLLOW-UP Starter: $149/mo (200 actions + 300 voice min)
- FOLLOW-UP Scale: $299/mo (600 actions + 750 voice min)
- COMPLETE Starter: $99/mo (15 packets + 250MB, $9 overage)
- COMPLETE Scale: $199/mo (55 packets + 1GB, $5 overage)
- Recordings Only: $49/mo (1,500 recorded min, $0.05/min overage)
- Rec+Transcripts Starter: $199/mo (1,500 transcribed min, $0.15/min overage)
- Rec+Transcripts Scale: $399/mo (4,500 transcribed min, $0.10/min overage)

### LEVERAGE
| Plan | Standalone | With INTAKE | Active Cases | Overage |
|------|-----------|-------------|-------------|---------|
| Solo | $99/mo | $79/mo | 5 | $19 |
| Growth | $349/mo | $279/mo | 21 | $14 |
| Team | $899/mo | $699/mo | 55 | $12 |

### SETTLE
Single $39, Ecosystem $29, Pro $299/mo, 11-Pack $385, 25-Pack $750

## Pending / Not Yet Done

### Backend
- `/api/waitlist` endpoint needs to handle `product: 'INTAKE_TRIAL'` payload
- `/api/onboarding` endpoint needs to be created for onboarding form
- Supabase Edge Functions not yet deployed for trial/onboarding forms
- Forms currently POST but will 404 until backend is wired

### Pages Not Yet Audited
- about.html, careers.html, press.html, case-studies.html
- partner.html, affiliate.html, affiliate-apply.html
- founding-members.html, demo-oakwood.html
- blog.html (partially dynamic)

### apply.html
- Still the old general-purpose application page
- User said "Do not replace apply.html yet" — keep as-is for now
- Trial funnel (trial.html) is the new primary conversion path

### Customer Portal
- Needs trial subscription badge, trial days remaining, A+ unlock counter
- Subscription page should show detailed add-on meters, allowances, overages
- Not this agent's scope (separate agent)

### UTM Campaign Fields
- User mentioned "Add hidden UTM campaign fields later (not needed now)" for ad landing page
- Still pending, low priority

## Key Memories to Recall

### Pricing
- Memory: "TrueVow 6-month public pricing model deployment" (task summary)
- Memory: "Public Pricing Messaging Norms" (project intro)

### Compliance
- Memory: "Legal marketing copy hardening workflow" (claim control)
- Memory: "Banned Language List" (claim control)
- Memory: "FAQ claim wording规范" (data compliance)

### CTA Flow
- Memory: "Marketing Website CTA and Purchase Flow Rules" (project spec)
- Memory: "90-Day Intake Trial Page Specification" (project info)

### Architecture
- Memory: "Mandatory File Location: DialogFlowCX Project Only" (environment)
- Memory: "Section background rhythm convention" (coding practice)
