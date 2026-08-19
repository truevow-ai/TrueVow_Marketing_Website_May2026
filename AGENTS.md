# TrueVow Website — Agent Rules (2026_TrueVow_Website)

This file governs how any agent creates or reviews TrueVow website copy and pages.

## Authority Hierarchy (highest to lowest)

```text
1. Legal/compliance safety
2. ICP file + behavioral psychology stats
3. Product/pricing authority
4. Page funnel objective
5. Narrative architecture: Story / Knife / Purchase Urgency
6. Sales and marketing guru principles
7. Design taste
```

**Conflict rules:**

- If a guru principle conflicts with the ICP psychology, the ICP psychology wins.
- If the narrative system conflicts with compliance, compliance wins.
- If a line is emotionally powerful but legally unsafe, rewrite it.
- If design preference conflicts with narrative clarity, narrative clarity wins.

---

## Layer 1 — Legal & Compliance Safety

**Source of truth:** `ICP_STATS_AND_PRICING.md` Section S (banned language, required substitutions, CTA rules) + the `legal/` pages (terms, msa, privacy, bar-compliance).

- Banned: "24/7," "guaranteed," "priority access," absolute claims ("never," "always," "exactly"), "PII ever stored," "cases signed/won."
- Required substitutions: "high-value case" → "high-priority opportunity"; "guaranteed" → "may/can/is designed to"; "signed case" → "consultation booked / A+ lead flagged."
- Approved CTAs only: See Benjamin Live (8 min) · Review the 90-Day Trial Path · Check 90-Day Trial Fit · Submit Firm Details. Forbidden: Buy Now, Checkout, Purchase, Subscribe Now, Start Free, Get Started, Pay Today, Apply for Access, Get Approved, Check Eligibility.
- CTA psychology rule: **The attorney is the evaluator, never the applicant.** The CTA must make the attorney feel like a decision-maker: "Check 90-Day Trial Fit" (he is evaluating fit), "Submit Firm Details" (he is providing information), "See Benjamin Live" (he is judging the proof). Avoid "Apply" (rejection anxiety), "Request" (supplicant posture), "Get Approved," "Check Eligibility," "Submit Application," "Limited Access," "For Approved Firms." "Fit" means mutual workflow fit, never personal approval. Success states say "We received your firm details" — never "Application received."
- Setup language rule: use "enabled after workflow review," "configured during onboarding," "discuss readiness," "confirm fit and setup" instead of status language ("approved firms," "eligible firms," "approval-gated," "early access"). Legal pages may use "approved" where necessary; marketing pages use softer setup language.
- Every public page must pass Section S review before shipping.

---

## Layer 2 — ICP File + Behavioral Psychology Stats

**Source of truth:** `ICP_STATS_AND_PRICING.md` — Sections B–E (market, personas, fears, desires), Y (BLAC), AB (Forces of Progress), AP (The One Problem), AQ (Purchase Urgency).

- The two personas: **A — Predictability Buyer** (solo PI, 40–60 calls, wants freedom from the phone and one predictable price) and **B — Efficiency Buyer** (small firm, 60–120 calls, wants consistent intake and per-unit economics).
- Fear hierarchy is evidence, not decoration: #1 missing calls/losing leads, #2 cash flow unpredictability, #3 malpractice/bar complaint.
- Only 20–30% of the ICP tracks cost-per-case. Copy must be simple; reports dead-simple.
- Copy must be traceable to a documented pain or gain in the ICP file — untraceable claims don't ship.

---

## Layer 3 — Product & Pricing Authority

**Source of truth:** `ICP_STATS_AND_PRICING.md` Sections AN (product lineup) and AO (Billing Catalogue v1.0) + the `TrueVow-Tenant_Billing-Service` repo (`billing_products` and `billing_catalogue_plans` tables are price authority; `constants.py` is NOT).

- **Lineup:** **INTAKE captures → TRACE develops → SETTLE resolves → COMMAND measures.** VERIFY spans all stages. TRACE = Matter Development (engagement through readiness; RETAINER folded into TRACE Start). **LEVERAGE is retired — never mention it.**
- **INTAKE plans:** Solo $499/mo (40 calls, $15 overflow, 1 attorney) · Growth $1,299/mo (100 calls, $12 overflow, 1–3 attorneys) · Team $1,999/mo (200 calls, $10 overflow, 2–6 attorneys). Monthly only. No yearly. No enterprise tier. No unlock fees. All records visible.
- **Trial:** 90 days or 12 qualifying completed intakes, whichever comes first.
- **SETTLE:** Per Case $79/report · Pro $299/mo (15 reports, $25 overage, 3-month min).
- **TRACE:** Start $35 / Essential $179 / Complete $299 per activated Matter (founder decision; billing catalogue update pending). First 12 Complete Matters promotion for approved INTAKE firms.
- Never state prices, feature lists, or product names that don't exist in the authoritative catalogue.

---

## Layer 4 — Page Funnel Objective

Before writing any page, define:
- **The stage:** interest (discovery) / consideration (demo, comparison) / conversion (apply, pricing) / retention (portal, trial-end) / referral.
- **The single Ask:** one 15-minute-sized action per page (see Narrative System → Micro-Commitment Ladder). Never two asks.
- Every page element either serves the objective or is cut.

---

## Layer 5 — TrueVow Narrative Operating System — Story, Knife, Urgency

## Purpose

This section governs how the TrueVow website turns ICP pain into action without sounding like a pitch.

Sales and marketing guru principles are useful, but this narrative system is more important because it is derived from the TrueVow ICP file, behavioral psychology, pricing model, and product strategy.

The website must not merely describe TrueVow.

It must make the right attorney feel:

1. "This is my Tuesday."
2. "This is the leak I have tolerated for years."
3. "This system understands my practice."
4. "Trying this does not create new pain."
5. "Going back would feel worse than moving forward."

**Strategy source sections (internal):** `ICP_STATS_AND_PRICING.md` — Section AQ (purchase-urgency system), Section AT (the knife emotional architecture), Section AU (the narrative architecture). These are INTERNAL strategy. Public copy must always pass the compliance rewrite table below.

## Final Authority

When creating or reviewing any page, the authority order is:

1. Legal and compliance safety
2. ICP file and behavioral psychology evidence
3. Product and pricing authority
4. Page funnel objective
5. TrueVow narrative system: Story / Knife / Purchase Urgency
6. Sales and marketing guru principles
7. Design preference

If a guru principle conflicts with the ICP psychology, the ICP psychology wins.

If the narrative system conflicts with compliance, compliance wins.

If a line is emotionally powerful but legally unsafe, rewrite it.

## Core Narrative Rule

Do not pitch attorneys.

Attorneys are trained to detect persuasion and cross-examine claims. A pitch invites skepticism. A story disarms skepticism because the story is about the attorney, not TrueVow.

The ICP is the hero.

TrueVow is the guide.

Benjamin is the proof scene.

The trial is the lived experience.

The pricing decision happens only after value has already been felt.

## The Seven-Beat Story Spine

Use this story spine when building high-conversion INTAKE pages, especially the homepage, demo page, pricing page, and trial path.

### Beat 1 — The Normal

Scene:

"It's 2:14 on a Tuesday. You're with a client. Your phone rings three times, and stops."

Purpose:

Make the visitor recognize their own day before TrueVow appears.

Emotion:

Recognition.

Page use:

Hero opening, landing page intro, video script, ad opening.

Avoid:

Generic AI language like "automated intake platform."

### Beat 2 — The Wound

Scene:

"Some of the calls your ads paid for reach voicemail. At your spend, that can become a real monthly leak."

Purpose:

Make the hidden loss visible.

Emotion:

Concern, not panic.

Page use:

Voicemail leak calculator, profitability page, pricing intro.

Compliance note:

Do not hard-code aggressive dollar claims everywhere. Prefer calculator-generated numbers based on visitor input, or phrase as "industry estimates" when used publicly.

### Beat 3 — The Cost

Scene:

"The one that mattered signed with the firm that answered first."

Purpose:

Make speed-to-lead concrete.

Emotion:

Loss, urgency.

Page use:

Homepage, ROI page, ad landing pages.

Guardrail:

Never say TrueVow guarantees signed cases. The safe public language is missed calls, missed consultations, or missed intake opportunities.

### Beat 4 — The Turn

Scene:

"Then someone answers — and knows your practice area by name."

Purpose:

Introduce Benjamin as the proof, not as a claim.

Emotion:

Recognition and relief.

Page use:

Demo CTA, demo page, above-the-fold transition.

CTA:

"See Benjamin Live (8 min)"

### Beat 5 — The Relief

Scene:

"Ninety days or twelve qualifying intakes. Same-day live where available. One flat price after approval. Every record visible."

Purpose:

Remove adoption pain.

Emotion:

Relief.

Page use:

Trial application, pricing page, demo success state.

Compliance note:

Do not use forbidden CTA language like "Start Free." Use "Check 90-Day Trial Fit" or "See Benjamin Live."

### Beat 6 — The New Life

Scene:

"It's Saturday. You're at your kid's game. The priority intake text arrives at dinner."

Purpose:

Show the desired life after adoption.

Emotion:

Pride, freedom, control.

Page use:

Homepage emotional close, pricing close, email follow-up, trial nurture.

Guardrail:

Use "priority intake opportunity" or "A+ lead flagged" only if consistent with product language. Avoid "high-value case."

### Beat 7 — The Guard + The Ask

Scene:

"Pause Benjamin, and the old voicemail pattern returns."

Purpose:

Turn removal into the painful act.

Emotion:

Protection.

Page use:

Trial-end page, retention email, cancellation save flow.

Guardrail:

Do not overstate. Do not threaten. Do not use fake fear.

CTA:

"See Benjamin Live (8 min)"

## The One-Breath Story

Use this as the strategic spine behind the page, not necessarily as public copy:

"Your day → the wound → what it has cost you → someone finally sees it → it comes out without pain → here is your Saturday back → do not go back."

## The Felt-Value Ladder

Before asking the buyer to accept a paid plan, the website and product journey should make the attorney feel value five times.

### Felt Value 1 — Someone understands my business

Mechanism:

The demo runs the attorney's practice area.

Website implication:

The demo page should make clear Benjamin can walk through a PI-specific call, not a generic AI receptionist script.

### Felt Value 2 — My number is real

Mechanism:

The leak calculator returns the attorney's own leak estimate.

Website implication:

Use ad spend and call volume inputs. Let the visitor generate the number.

### Felt Value 3 — That is my firm name

Mechanism:

Benjamin answers a test call using the firm's name.

Website implication:

Demo page and trial onboarding should highlight the own-firm-name moment.

### Felt Value 4 — A case arrived at dinner

Mechanism:

The first priority intake text lands during the trial.

Website implication:

Follow-up copy should prepare the attorney for what the first real alert feels like.

### Felt Value 5 — I took a weekend

Mechanism:

By Day 60, the attorney experiences time away from the phone.

Website implication:

Use "You take a weekend. Benjamin answers." as a recurring emotional line, but avoid turning it into a guarantee.

## The Knife Architecture

This is an internal metaphor only.

Do not publish "knife in your side" language on public pages unless explicitly approved. Public copy should use safer language such as "leak," "gap," "missed calls," "phone burden," or "old pattern."

### Movement 1 — Twist

Purpose:

Make chronic pain acute again.

Tools:

- Leak calculator
- Years slider
- Speed-to-lead story
- Struggling-moment campaigns
- Month-1 leak report

Rule:

Twist with truth only. Never fabricate urgency or loss.

### Movement 2 — Anesthetic

Purpose:

Reduce anxiety before the ask.

Tools:

- 8-minute Benjamin demo
- Practice-area-specific demo
- Own firm name in test call
- Visible records
- Clear legal boundaries
- No public checkout pressure

Rule:

The demo is not a feature. It is the trust anesthetic.

### Movement 3 — Extract

Purpose:

Remove the pain without creating new pain.

Pain dimensions to reduce:

1. Money pain
2. Trust pain
3. Effort pain
4. Risk pain
5. Embarrassment pain
6. Malpractice anxiety
7. Continuity pain

Website implication:

Every product page must explain why the next step is low-friction and controlled.

Examples:

- No payment on demo
- Setup review before activation
- Trial fit reviewed before activation
- Firm stays in control
- Attorney review remains required
- All records visible
- One flat price after setup review

### Movement 4 — Close

Purpose:

Help the attorney experience the new life.

Tools:

- Priority intake text
- Week-1 report
- Month-1 report
- Weekend-off messaging
- TRACE/Nurture attach after value is proven

### Movement 5 — Guard

Purpose:

Make the old workflow feel visibly worse than keeping Benjamin.

Tools:

- Pause/removal preview
- Trial-end comparison
- Month-over-month leak visibility
- Retention save flow

Guardrail:

Do not threaten the buyer. Show the operational contrast calmly.

## Purchase Urgency System

The core purchase-urgency insight:

The missed-call pain is urgent, but the purchase decision often defers because the buyer has tolerated the wound for years.

Therefore, urgency must be built from losses already happening, not from fake future pressure.

### Canonical Urgency Lines (Approved Patterns)

Urgency comes from the caller, the ad spend, and time already moving — never from vendor gatekeeping. These lines are approved for INTAKE pages:

- "Your next paid call should not be the next voicemail you regret."
- "You do not need more ad spend if the calls you already paid for are not getting reviewed."
- "The caller who reaches voicemail may keep searching — and the firm that answers first gets the first real conversation."
- "More reviewed opportunities from the same marketing spend."
- "You do not need to change your phone system today. Just hear the call."
- "Eight minutes is enough to know whether Benjamin should handle your next routed PI call."

Rejected pressure (never use): approval gates, county eligibility, limited access, vendor judgment, fake scarcity, "your competitors are stealing your cases."

### Status & Legacy Lines (Approved Patterns — Pricing and Close Sections)

The ICP is a late-career owner asking a private question: *can this firm still become what I meant it to build?* Speak to that truth without accusing him. Public copy must be dignified — never expose age, exhaustion, or failure.

| Private Truth | Public-Safe Rendering |
| --- | --- |
| You are trapped inside the firm you built | Your firm should not depend on you personally catching every opportunity |
| You are tired and considering selling | The firm you built deserves an intake function that can grow beyond owner availability |
| You settle too early because cash flow is tight | A steadier intake pipeline gives the firm more room to review opportunities carefully instead of operating from pressure |
| I am buying another software tool | The price is not for another tool. It is for making the next opportunity less dependent on whether you are at the desk |

Approved section frame for the pricing page: **"You Do Not Need Another Tool. You Need the Firm to Stop Depending on Your Availability."** — with the beats: the pain list (missed call, weekend catch-up, late callback, scattered notes) → "the problem is not that the owner does not care" → the front door → the legacy line → grow / step back / less-dependent choice → the price-is-not-for-a-tool close.

Never on a public INTAKE page: "stop settling early," "get better case values," settlement outcome promises, "before you sell your firm." Settlement-pressure language belongs to TRACE/SETTLE strategy only.

Emotional balance target for the homepage: ~40% financial loss · ~25% competitive urgency · ~20% control/status · ~15% relief/life-back. The page must make the attorney feel *safe enough to act, proud enough to upgrade, and uneasy enough about waiting.*

## Owner-Led PI Attorney Psychology Layer

This layer governs all public TrueVow marketing pages, especially homepage, pricing, trial, demo, and email/outreach landing flows. It sits above page copy and below legal boundaries.

### Core Buyer Reality

The primary ICP is not only buying intake coverage.

He is often a 50+ owner-led plaintiff PI attorney who has carried the firm personally for years. He may be tech-averse, comfortable with old systems, and used to manual work, weekend catch-up, scattered notes, voicemail review, and slow callbacks.

He may already know the firm leaks opportunity, but the pain has become familiar. Familiar pain does not create action by itself.

The deeper emotional trigger is not "buy intake software."

The deeper trigger is:

"The firm you built should not still depend on you personally catching every opportunity."

### Public Copy Translation Rule

Never publicly shame the attorney.

Do not say or imply: you are old · you are behind · you failed to scale · you are tech averse · your firm is chaotic · you settle too early · you are unhealthy · you wasted weekends · you need to be rescued.

Translate private truths into dignified public language:

| Private Truth | Public Language |
| --- | --- |
| The owner is exhausted and the firm depends too much on him | The firm you built should not depend on you personally catching every opportunity |
| He is manually catching up on weekends | Your intake path should not rely on weekend catch-up, voicemail review, or scattered notes |
| He is thinking about selling because the firm feels heavy | Whether you want to grow, step back from the phone, or make the firm less owner-dependent, intake is the first operating layer to fix |
| He wants status, growth, and proof he built something valuable | Your intake should look as serious as your legal work |

### Emotional Conversion Target

A page should make the attorney feel:

- I already paid for the call.
- The next caller may not wait.
- My competitor only has to answer faster.
- My firm should look more serious at the front door.
- I do not need to replace my case system.
- I do not need another tool to babysit.
- This could be the first step toward a less owner-dependent firm.
- I should hear Benjamin before the next good call hits voicemail.

### Required Pressure Mix

For homepage and pricing pages, target the following emotional balance:

- 40% financial pressure: protect the calls, referrals, and ad spend already created.
- 25% competitive urgency: the caller who reaches voicemail may keep searching; the first serious response often earns the first serious conversation.
- 20% status/control/legacy: the firm should look serious, operate with control, and become less dependent on the owner personally catching every ball.
- 15% relief/life-back: family time, health, weekends, and owner breathing room appear as the reward, not the opening pitch.

### Correct Urgency Source

Use urgency from: this month's ad spend already running · the next paid call · the next caller who may not wait · the next voicemail the owner may regret · the cost of keeping the same intake path unchanged.

Do not use urgency from: approval · eligibility · county availability · limited access · countdowns · vendor gatekeeping · fake scarcity.

### CTA Doctrine

Primary CTA remains "See Benjamin Live (8 min)" — but its meaning is: *"Hear what your firm's front door could sound like when the next serious caller reaches out."*

Secondary CTAs: Review the 90-Day Trial Path · View INTAKE Pricing · Estimate Your Intake Leak.

Avoid: Apply · Request · Get approved · Check eligibility · Check fit · Trial fit · County availability · Start free · Buy now · Checkout · Subscribe.

### Homepage Thesis

The deeper thesis is: **"The firm you built should not depend on you personally catching every opportunity."** All homepage copy ladders from paid-call leakage into owner-dependence, firm status, controlled intake, and demo action.

### Pricing Page Thesis

Pricing is not a SaaS plan comparison page. It frames TrueVow as *the first operating layer that helps the firm stop depending on the owner's personal availability.* Pricing anchors against paid calls that never reach review, receptionist overhead, answering limitations, weekend catch-up, and owner dependence — never against cheap software tools.

### Mandatory Latent-Friction Sweep

Before approving any page, search for and remove or justify: apply · approval · approved · eligible · eligibility · request access · county availability · market availability · service-area availability · trial fit · check fit · application · low-fit · screen intake fit · "when enabled" (if overused) · public checkout (if repeated) · add-ons after approval · signed case · signed matter · case won · guaranteed.

Replace with: setup confirmed before activation · routed-call setup · practice areas · booking flow · selected intake path · review the 90-day trial path · submit firm details · structured intake record · priority opportunity · booked consultation · attorney review · no payment on the public website.

### Approval Standard — The Five Gates

Do not approve a page because it is legally safe. A page passes only if it satisfies all five gates:

1. **Compliance gate:** no legal advice, outcome guarantees, case-value promises, settlement recommendations, or representation claims.
2. **ICP dignity gate:** the attorney never feels small, old, behind, judged, excluded, needy, or technologically inferior.
3. **Urgency/growth gate:** the attorney feels the financial and competitive cost of waiting.
4. **Owner-dependence gate:** the page makes clear that the firm should not depend on the owner personally catching every opportunity.
5. **Action gate:** the next action feels small, safe, and immediate: "See Benjamin Live (8 min)."

If a page cannot pass these five gates, do not mark it staging-approved.

## The Seven Urgency Drivers

### 1. Visible Loss

Use:

The visitor's own leak math.

Best mechanism:

Leak calculator.

Public-safe phrasing:

"Estimate what unanswered calls may be costing your firm."

### 2. Real Deadlines

Use only real clocks:

- January call surge
- Summer surge
- Trial ending
- 90 days or 12 qualifying intakes
- onboarding capacity if genuinely limited

Do not use:

- fake countdowns
- fake waitlists
- fake "spots closing"
- fake scarcity

### 3. Cost of Delay

Use:

Every month of delay continues the old pattern.

Public-safe phrasing:

"Every month you wait, the same call pattern continues."

Avoid:

"Every month you wait, you lose cases."

### 4. Competitive Urgency

Use:

Speed-to-lead story.

Public-safe phrasing:

"In PI, the firm that responds first often gets the first real conversation."

Avoid:

"Your competitor will steal your cases."

### 5. Micro-Commitment Ladder

The action ladder is:

1. See Benjamin Live
2. Submit demo request
3. Hear own practice-area demo
4. Review the 90-Day Trial Path
5. Test own firm-name call
6. Forward calls
7. Receive first priority alert
8. Convert to paid plan

Do not ask for the full application before the visitor has enough trust.

### 6. Risk Reversal

Use:

- demo first
- no public checkout
- approved access
- trial after approval
- flat pricing
- visible records

Guardrail:

Do not use "guaranteed" unless legal/compliance has approved exact guarantee terms.

### 7. Temporal Framing

Use:

Years slider carefully.

Public-safe concept:

"See what the same missed-call pattern may add up to over time."

Guardrail:

Do not imply precise historical loss unless the user entered their own data and assumptions are shown.

## The Four-Layer Urgency Stack

### Layer 1 — Always-On

Leak calculator appears where appropriate:

- homepage
- profitability page
- pricing page
- demo follow-up
- application page sidebar

### Layer 2 — Event-Triggered

Campaigns timed around real struggling moments:

- January call surge
- summer vacation / call surge
- ad-spend-up cases-flat
- staff turnover
- after-hours call leakage
- missed-call incident

### Layer 3 — Funnel Urgency

Use:

- demo within 8 minutes
- application review timeline
- same-day/fast activation where true
- 90-day/12-intake trial boundary

### Layer 4 — Trial-End Decision Frame

Frame the decision as:

"Keep Benjamin at the approved plan, or return to the old call pattern."

Do not frame as:

"Buy now or lose access forever."

### Layer 5 — Retention Guard

Use calm removal preview:

"Pausing Benjamin means calls return to your prior routing setup."

If supported by data:

"Based on your prior estimate, that may reintroduce the same unanswered-call pattern."

## Medium Map

Each story beat belongs in a different medium.

| Medium | Beats Used | Purpose |
|---|---|---|
| Homepage | Normal, Wound, Turn, New Life, Ask | Recognition and demo click |
| Demo page | Turn, Anesthetic, Relief | Reduce AI anxiety |
| Leak calculator | Wound, Cost, Urgency | Make latent loss visible |
| Pricing page | Relief, Guard, Ask | Reduce billing anxiety |
| Trial application | Relief, Micro-commitment, Safety | Convert high-intent visitor |
| Trial onboarding | Own-firm-name proof, Extract | Build trust fast |
| Week-1 report | Relief, New Life | Show early value |
| Month-1 report | Wound, Relief, Guard | Make pain-of-loss visible |
| Cancellation flow | Guard | Show what returns if paused |
| TRACE page | Education + ecosystem reinforcement, NOT acquisition: the rich matter-development story (lifecycle, board, owns, deterministic, PMS boundary, plans, limits) with NO TRACE form or signup CTA — route existing firms to the Customer Portal, everyone else to Explore INTAKE |

## Eight Voice Rules

1. Use scenes before claims.
2. Use numbers only when sourced, user-generated, or clearly framed as estimates.
3. Keep the attorney dignified.
4. Do not blame staff.
5. Do not call the buyer outdated.
6. Never make TrueVow the hero.
7. Never use fake urgency.
8. Close with a next step, not pressure.

## Persona Variants

### Persona A — Solo PI Attorney

Emotional center:

Freedom from the phone.

Best story:

The phone rings during client work, dinner, and weekends. Benjamin gives the attorney time back while preserving intake visibility.

Best lines:

- "You take a weekend. Benjamin answers."
- "One price. Every record visible."
- "Your phone stops being your job."

Avoid:

Too much analytics language.

### Persona B — Small PI Firm

Emotional center:

Consistency and scale.

Best story:

Multiple staff members handle intake differently. Benjamin gives the firm one consistent intake path and clearer visibility.

Best lines:

- "Same intake path, every time."
- "Know which calls became consultations."
- "Less retyping. Less intake drift."

Avoid:

Making it sound like staff replacement.

## Page Review Requirement

Before approving any INTAKE page, the agent must identify which story beats the page uses.

Required review format:

```text
Narrative beats used:
- Normal:
- Wound:
- Cost:
- Turn:
- Relief:
- New Life:
- Guard/Ask:

Felt-value ladder supported:
- Understands my business:
- My number is real:
- My firm name:
- First priority alert:
- Weekend back:

Urgency layer:
- Visible loss:
- Real deadline:
- Cost of delay:
- Competitive urgency:
- Micro-commitment:
- Risk reversal:
- Temporal framing:
```

A page does not need every beat. But the agent must know which beat it is responsible for.

## Compliance Rewrite Rules

When adapting internal strategy into public copy:

| Internal Concept | Public-Safe Rendering |
| --- | --- |
| knife in the side | missed-call leak / old call pattern / phone burden |
| bleeding money | ad spend may be leaking into voicemail |
| competitor stole the case | the caller may move on to the firm that answers first |
| guaranteed recovery | designed to help capture intake opportunities |
| high-value case | priority intake opportunity |
| case signed | consultation booked / intake record prepared |
| free trial CTA | Review the 90-Day Trial Path |
| buy now | Review the 90-Day Trial Path / See Benjamin Live |
| never miss a call | reduce unanswered-call gaps / configured intake coverage |

## Metrics The Agent Should Protect

The website and funnel should be designed around these measurement goals:

- Demo to application conversion
- Application to live activation
- Calculator to demo/application conversion
- Application to live in under 24 hours where operationally supported
- First-touch to first booked consultation
- Trial to paid conversion
- Post-trial churn
- TRACE attach rate after accepted matters

Do not write copy that optimizes clicks while harming qualified activation.

## Final Narrative Rule

Every major INTAKE page should make the right attorney feel this sequence:

"They understand my day."
"They see the cost I have normalized."
"I can hear the solution before I trust it."
"Trying it does not create new pain."
"Going back would feel worse than moving forward."

---

## Layer 6 — Sales & Marketing Mastery Layer

**Source:** `legacy/marketing/TRUEVOW_COMPREHENSIVE_EXPERT_PANEL.md` — the guru catalogue (psychology, decision-making, pricing, sales & marketing).

These principles sharpen strategy and craft. They rank BELOW the narrative system:

- Kahneman/Tversky: loss framing beats gain framing — already encoded in the Wound/Cost beats.
- Cialdini: scarcity only via real clocks (trial boundary, real capacity). Fake scarcity is forbidden (Layer 1 + narrative system).
- Schwartz/Iyengar: 2–3 options optimal — the tier structure stays simple.
- Ariely: anchoring — anchor up ($4,000 receptionist, $1,900 leak), never down ($69 competitor).

**Rule:** a guru principle is used only if it serves a documented ICP pain and survives the narrative system. When in conflict, Layer 5 wins.

---

## Layer 7 — Design Taste

Aesthetics serve clarity and the story beats. Design may enhance a beat (scene imagery, calculator prominence) but may never bury the Ask, obscure the numbers, or override any higher layer.

---

## Sources (Read Before Writing Copy)

- `ICP_STATS_AND_PRICING.md` — Sections S (compliance), B–E (ICP), AN (lineup), AO (pricing authority), AQ/AT/AU (narrative system internals), AP (the one problem), AB (forces), AK (SLIP)
- `TrueVow-Tenant_Billing-Service` — `billing_catalogue_plans` / `billing_products` (price authority)
- `legal/` pages — terms, MSA, privacy, bar compliance
