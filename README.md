# TrueVow Marketing Website — Developer Documentation

**Purpose:** Public-facing static HTML website for TrueVow (marketing, legal, trial funnel, ad landing pages)
**Architecture:** Static HTML + Supabase Backend (REST API & Edge Functions)
**Deployment:** Namecheap Static Hosting
**Last Updated:** April 27, 2026

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Directory Structure](#directory-structure)
3. [Marketing Pages](#marketing-pages)
4. [Pricing Model (Current)](#pricing-model-current)
5. [Trial Funnel](#trial-funnel)
6. [Supabase Backend Integration](#supabase-backend-integration)
7. [API Endpoints](#api-endpoints)
8. [Compliance & Claim-Safety Rules](#compliance--claim-safety-rules)
9. [CTA & Purchase Flow Rules](#cta--purchase-flow-rules)
10. [Deployment Guide](#deployment-guide)
11. [Development Workflow](#development-workflow)
12. [Service Ownership](#service-ownership)

---

## Project Overview

### Architecture

This is a **static HTML website** that connects to **Supabase** for backend functionality:

- **Frontend:** Pure HTML/CSS/JavaScript (no build process, no frameworks)
- **Backend:** Supabase (PostgreSQL database + Edge Functions + REST API)
- **Hosting:** Namecheap Static Hosting (traditional web hosting)
- **Domain:** truevow.law / sales.truevow.com

### Key Features

- 28+ production HTML pages (marketing + legal + trial funnel + ad landing pages)
- 90-Day Intake Trial funnel (trial.html + trial-onboarding.html)
- Ad landing pages for cold traffic (benjamin-ad-landing-page-01.html)
- Approval-first purchase flow (no public checkout)
- Claim-safe legal marketing language across all pages
- Automated Blog Hub (fetches content from Supabase)
- Form Submissions (demo requests, applications, trial applications, onboarding)
- Reusable Components (navigation, footer, widgets)
- Responsive Design (mobile-first, works on all devices)
- Analytics tracking (analytics.js)

---

## Directory Structure

```
2025_TrueVow_Website/
├── marketing/                    # Marketing pages (28 files)
│   ├── index.html               # Homepage
│   ├── pricing.html             # Full pricing (INTAKE + LEVERAGE + SETTLE + add-ons)
│   ├── how-it-works.html        # Product explanation
│   ├── trial.html               # 90-Day Intake Trial application (public)
│   ├── trial-onboarding.html    # Onboarding prep form (approved firms only)
│   ├── benjamin-ad-landing-page-01.html  # Ad landing page (cold traffic)
│   ├── apply.html               # General application form
│   ├── settle.html              # SETTLE product page
│   ├── leverage.html            # LEVERAGE product page
│   ├── compliance.html          # Compliance page
│   ├── integrations.html        # Integrations page
│   ├── profitability.html       # ROI/profitability page
│   ├── county-cap.html          # 33% County Cap strategy
│   ├── blog.html                # Blog hub (dynamic content)
│   ├── about.html               # About page
│   ├── careers.html             # Careers page
│   ├── press.html               # Press/media
│   ├── case-studies.html        # Case studies
│   ├── partner.html             # Partner program
│   ├── affiliate.html           # Affiliate program
│   ├── affiliate-apply.html     # Affiliate application
│   ├── founding-members.html    # Founding members
│   ├── demo-oakwood.html        # Demo page
│   ├── analytics.js             # Analytics tracking script
│   ├── archive/                 # Archived backup files
│   └── js/                      # Page-specific JS
│
├── legal/                        # Legal documents (5 files)
│   ├── terms.html               # Terms of Service
│   ├── privacy.html             # Privacy Policy
│   ├── msa.html                 # Master Services Agreement
│   ├── bar-compliance.html      # Bar compliance documentation
│   └── subprocessors.html       # Sub-processors list
│
├── components/                   # Reusable HTML components
├── assets/                       # Static assets (logo, images)
├── js/                          # JavaScript modules
│   └── blog-content.js          # Blog content fetcher (Supabase)
├── scripts/                     # Utility scripts
├── supabase/                    # Database migration files
├── rules/                       # Deployment documentation
├── .qoder/                      # Qoder agent config, skills, repowiki
└── .cursor/                     # Cursor rules and commands
```

---

## Marketing Pages

### Core Product & Pricing Pages

| Page | Purpose | Key Features |
|------|---------|--------------|
| `index.html` | Homepage | Hero, features, demo form, testimonials |
| `pricing.html` | Full pricing | INTAKE + LEVERAGE + SETTLE + add-ons + FAQ |
| `how-it-works.html` | Product explanation | Step-by-step process, features |
| `settle.html` | SETTLE product page | Settlement demand reports |
| `leverage.html` | LEVERAGE product page | Active case management |
| `integrations.html` | Integrations page | Calendar, phone, CRM connections |
| `compliance.html` | Compliance page | Claim-safe language, legal positioning |
| `profitability.html` | ROI/profitability | ROI calculator, value metrics |
| `county-cap.html` | 33% County Cap | Interactive strategy guide |

### Trial Funnel Pages

| Page | Purpose | Access |
|------|---------|--------|
| `trial.html` | 90-Day Intake Trial application | Public (ads, email, direct links) |
| `trial-onboarding.html` | Onboarding preparation form | Approved firms only (email link) |

### Ad Landing Pages

| Page | Purpose | Traffic Source |
|------|---------|---------------|
| `benjamin-ad-landing-page-01.html` | INTAKE-only ad landing page | Facebook/Instagram/Google ads |

### Other Marketing Pages

| Page | Purpose |
|------|---------|
| `apply.html` | General application form |
| `blog.html` | Blog hub (dynamic Supabase content) |
| `about.html` | About TrueVow |
| `careers.html` | Careers |
| `press.html` | Press/media |
| `case-studies.html` | Case studies |
| `partner.html` | Partner program |
| `affiliate.html` | Affiliate program |
| `affiliate-apply.html` | Affiliate application |
| `founding-members.html` | Founding members |
| `demo-oakwood.html` | Demo page |

### Legal Pages (5 files)

| Page | Purpose |
|------|----------|
| `terms.html` | Terms of Service |
| `privacy.html` | Privacy Policy |
| `msa.html` | Master Services Agreement |
| `bar-compliance.html` | Bar compliance |
| `subprocessors.html` | Sub-processors list |

---

## Pricing Model (Current)

### INTAKE

| Plan | Price | A+ Unlocks | Voice Minutes | Attorneys | Add-ons |
|------|-------|------------|---------------|-----------|--------|
| Solo | $199/mo | 3 | 500 | 1 | Core INTAKE only |
| Growth | $599/mo | 11 | 1,500 | 1 seat | Available |
| Team | $1,499/mo | 33 | 4,500 | Up to 5 | Available |

- A, B, C, D leads visible without unlock. Only A+ requires unlock.
- Included A+ unlocks reset monthly and do not roll over.
- Additional A+ unlocks: Solo $49, Growth $39, Team $29.

### FOLLOW-UP (Add-on, Growth & Team only)

| Tier | Price | Included |
|------|-------|----------|
| Starter | $149/mo | 200 actions + 300 connected voice min |
| Scale | $299/mo | 600 actions + 750 connected voice min |

### COMPLETE (Add-on, Growth & Team only)

| Tier | Price | Included |
|------|-------|----------|
| Starter | $99/mo | 15 packets + 250 MB |
| Scale | $199/mo | 55 packets + 1 GB |

### Recordings & Transcripts (Add-on, Growth & Team only)

| Tier | Price | Included |
|------|-------|----------|
| Recordings Only | $49/mo | 1,500 recorded min |
| Rec + Transcripts Starter | $199/mo | 1,500 transcribed min |
| Rec + Transcripts Scale | $399/mo | 4,500 transcribed min |

### LEVERAGE

| Plan | Standalone | With INTAKE | Included |
|------|-----------|-------------|----------|
| Solo | $99/mo | $79/mo | 5 active cases |
| Growth | $349/mo | $279/mo | 21 active cases |
| Team | $899/mo | $699/mo | 55 active cases |

- Active case capacity, not case credits. Unused capacity does not roll over.
- Lower ecosystem pricing applies when INTAKE is active.

### SETTLE

| Option | Price |
|--------|-------|
| Single Report | $39 |
| 11-Pack | $385 |
| 25-Pack | $750 |
| Ecosystem Rate | $29/report (active INTAKE or LEVERAGE) |
| SETTLE Pro | $299/mo (15 included, $25/report after) |

---

## Trial Funnel

### Flow

```
1. Prospect lands on trial.html
2. Prospect submits Trial Application (3-step form)
3. SaaS Admin receives application
4. SaaS Admin reviews: attorney eligibility, firm size, PI fit, state/county availability
5. If rejected: polite rejection/waitlist email
6. If approved: create prospect record, send onboarding form link
7. Firm submits trial-onboarding.html (8 sections)
8. Customer Success reviews onboarding form
9. Firm books onboarding call
10. CSM creates/configures tenant or triggers PLG activation
11. Billing Service creates trial subscription (90-day, 11 A+ unlocks)
12. Test call completed
13. Trial activated
14. Customer Portal invite sent
```

### trial.html — Public Acquisition Page

- Purpose: Convert cold traffic (ads, email) into trial applicants
- 3-step form: Attorney+Firm → Firm Fit → Trial Confirmation
- Success message: "We usually review applications within 2 business days."
- No checkout, no plan selection, no LEVERAGE/SETTLE

### trial-onboarding.html — Approved Firms Only

- Purpose: Collect setup requirements before onboarding call
- 8 sections: Firm Setup, Contact Users, Phone Routing, Calendar, Intake Preferences, Alerts, Recording/Transcript Policy, Activation Readiness
- noindex/nofollow — not discoverable by search engines
- Sent by email only after approval

---

## Compliance & Claim-Safety Rules

### Banned Language (never use)

- "24/7", "guaranteed", "priority access", "skip the waitlist"
- "exactly", "always", "never" (absolute claims)
- "PII ever stored", "zero PII"
- "high-value cases guaranteed"
- "whichever comes first"

### Required Substitutions

| Do NOT say | Say instead |
|-----------|-------------|
| high-value case | high-priority opportunity |
| guaranteed | may, can, is designed to |
| 24/7 | after-hours, configured hours |
| verified attorney | helps us verify attorney status |
| exclusive community | practical eligibility verification |

### Bar Number Wording

- Placeholder: "Bar Number (optional — helps us verify attorney status)"
- Note: "Providing your Bar # may help us verify your application faster."
- Success: "Bar number received. This may help us verify your application faster."

### Recording/Transcript Stance

- Always: "optional and configured during onboarding based on firm policy, caller disclosure requirements, and jurisdiction"
- Never present as default-included in INTAKE plans

---

## CTA & Purchase Flow Rules

The public marketing website does NOT process direct purchases. All CTAs route prospects into application, request-access, or waitlist flow.

### Approved CTA Language

| Context | CTA Text |
|---------|----------|
| INTAKE | Apply for INTAKE |
| INTAKE (Growth) | Apply for Growth |
| INTAKE (Team) | Apply for Team |
| FOLLOW-UP | Add FOLLOW-UP |
| COMPLETE | Add COMPLETE |
| Recordings | Add Recordings |
| LEVERAGE | Request LEVERAGE Access |
| SETTLE | Request SETTLE Access |
| Trial | Apply for the 90-Day Intake Trial |
| Demo | See Benjamin Live (8 min) |

### Forbidden CTA Language

Buy Now, Checkout, Purchase, Subscribe Now, Add to Cart, Pay Today, Unlock $99, Start Free, Get Started, No monthly fees, Pay only when you win

### Application Flow

Marketing Website → Application/Waitlist → Internal review → Approval email → Customer portal invite → Plan selection → Billing setup → Onboarding/Activation
