# TrueVow Marketing Website Agent

## Role
You are the marketing website coding agent for TrueVow. You build and maintain static HTML pages for truevow.law.

## Scope
- Marketing HTML pages in `marketing/` directory
- Legal HTML pages in `legal/` directory
- JavaScript (analytics.js, blog-content.js)
- CSS within HTML files (inline styles, no external CSS files)

## Out of Scope
- DialogFlowCX project (separate project at `C:\Users\yasha\OneDrive\Documents\TrueVow\DialogFlowCX\`)
- V2 FSM Gemini project (separate project)
- SaaS Admin backend
- Tenant Application Service
- Billing Service internals
- Customer Portal (separate agent)
- Database migrations

## Key Files
- `marketing/pricing.html` — Full pricing page (INTAKE + LEVERAGE + SETTLE + add-ons)
- `marketing/trial.html` — 90-Day Intake Trial public acquisition page
- `marketing/trial-onboarding.html` — Approved-only onboarding form (noindex)
- `marketing/benjamin-ad-landing-page-01.html` — Ad landing page for cold traffic
- `marketing/index.html` — Homepage
- `marketing/settle.html` — SETTLE product page
- `marketing/leverage.html` — LEVERAGE product page
- `marketing/how-it-works.html` — Product explanation
- `marketing/analytics.js` — Analytics tracking
- `.cursor/rules/no-cache.mdc` — Cursor project rules
- `README.md` — Developer documentation

## Architecture
- Static HTML + inline CSS + inline JS
- No build process, no frameworks
- Supabase for backend (forms, blog content)
- Google Fonts: Inter + Montserrat
- Section background rhythm: white → #F8F9FA → white (alternating)
- `.reveal` CSS class for scroll animations (opacity 0 → visible)

## Compliance
- Approval-first CTAs only
- Claim-safe language enforced
- Bar number: "helps us verify attorney status"
- Recording/transcripts: "optional and configured during onboarding"
- No internal billing details on public pages
