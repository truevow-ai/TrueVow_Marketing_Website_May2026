# TrueVow Marketing Website — Claim-Safe Page Build

## Purpose
Build or update marketing website pages with claim-safe, approval-first language and correct pricing.

## Rules

### Pricing (locked, do not change)
- INTAKE Solo: $199/mo, 3 A+ unlocks, 500 voice minutes, $49 overage
- INTAKE Growth: $599/mo, 11 A+ unlocks, 1,500 voice minutes, $39 overage
- INTAKE Team: $1,499/mo, 33 A+ unlocks, 4,500 voice minutes, $29 overage
- LEVERAGE Solo: $99/$79 with INTAKE, 5 active cases
- LEVERAGE Growth: $349/$279 with INTAKE, 21 active cases
- LEVERAGE Team: $899/$699 with INTAKE, 55 active cases
- SETTLE: $39 single, $29 ecosystem, $299/mo Pro, 11-Pack $385, 25-Pack $750
- FOLLOW-UP Starter: $149/mo (200 actions + 300 voice min), Scale: $299/mo (600 + 750)
- COMPLETE Starter: $99/mo (15 packets + 250MB), Scale: $199/mo (55 + 1GB)
- Recordings Only: $49/mo, Rec+Transcripts Starter: $199/mo, Scale: $399/mo
- Add-ons available on Growth and Team only

### Banned language
Never use: 24/7, guaranteed, priority access, skip the waitlist, exactly, PII ever stored, high-value cases guaranteed, whichever comes first, Unlock $99

### Required substitutions
- "high-value case" → "high-priority opportunity"
- "guaranteed" → "may, can, is designed to"
- "24/7" → "after-hours, configured hours"
- "verified attorney" → "helps us verify attorney status"
- "exclusive community" → "practical eligibility verification"

### CTA rules (approval-first)
Approved CTAs: Apply for INTAKE, Apply for Growth, Apply for Team, Request LEVERAGE Access, Request SETTLE Access, Add FOLLOW-UP, Add COMPLETE, Add Recordings, Apply for the 90-Day Intake Trial, See Benjamin Live (8 min)
Forbidden CTAs: Buy Now, Checkout, Purchase, Subscribe Now, Start Free, Get Started, Unlock $99, No monthly fees, Pay only when you win

### Bar number wording
- Placeholder: "Bar Number (optional — helps us verify attorney status)"
- Note: "Providing your Bar # may help us verify your application faster."
- Success: "Bar number received. This may help us verify your application faster."

### Recording/transcript stance
- Always: "optional and configured during onboarding based on firm policy, caller disclosure requirements, and jurisdiction"
- Never present as default-included in INTAKE plans

### Form endpoints
- Trial application: POST `/api/waitlist` with `product: 'INTAKE_TRIAL'`
- Onboarding form: POST `/api/onboarding` with `form_type: 'onboarding_preparation'`
- General apply: POST `/api/waitlist`

### A+ unlock policy
- A, B, C, D leads visible without unlock
- Only A+ requires unlock
- Included unlocks reset monthly, do not roll over
- "Each plan includes monthly A+ unlocks. If included unlocks are used, additional A+ unlocks are added to the monthly invoice based on the plan."

### FOLLOW-UP wording
- Two meters: follow-up actions + connected outbound AI voice minutes
- "A follow-up action means one outbound SMS follow-up, one outbound call attempt, or one scheduled reminder action. Connected AI voice minutes are counted separately when Benjamin handles an answered outbound call."

### What NOT to show on public website
- Voice overage alert thresholds
- FIFO report expiration logic
- Internal billing pseudocode
- Storage abuse-protection pricing
- Guardrail dependencies
- SKU names
- Detailed subscription management (belongs in Customer Portal)
