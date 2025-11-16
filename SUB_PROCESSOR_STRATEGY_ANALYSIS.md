# **SUB-PROCESSOR LIST STRATEGY: LEGAL ANALYSIS**

**Date:** November 5, 2025

---

## **⚖️ THE CORE DILEMMA**

### **Option A: Comprehensive List (100+ vendors)**
**PROS:**
- ✅ Maximum transparency
- ✅ Shows thoroughness to privacy regulators
- ✅ Covers all potential future use cases

**CONS:**
- ❌ Creates DPA/compliance obligations for vendors you're NOT using yet
- ❌ If you list a vendor and DON'T use it → false disclosure
- ❌ If you list a vendor and REMOVE it later → customer trust issues
- ❌ Competitors get your entire tech stack roadmap
- ❌ Audit burden for 100+ vendor security questionnaires
- ❌ **BIGGEST RISK:** If you use a vendor NOT on the list → GDPR/CCPA violation

### **Option B: Minimal List (Only Active Vendors)**
**PROS:**
- ✅ Accurate disclosure (no false representations)
- ✅ Lower audit/compliance burden
- ✅ Easier to manage DPAs and security reviews
- ✅ Protects competitive intelligence
- ✅ Can add vendors as needed with 30-day notice

**CONS:**
- ❌ Requires updates whenever you onboard a vendor
- ❌ Could create compliance gap if you use a vendor before updating the list

---

## **🎯 RECOMMENDED APPROACH: "CATEGORY-BASED + LIVING LIST"**

### **Strategy:**
1. **List specific vendors** for HIGH-RISK categories only (those that touch customer data directly)
2. **Use category descriptions** for LOW-RISK vendors (infrastructure, monitoring, dev tools)
3. **Add catch-all language** that pre-authorizes operational vendors
4. **Make 30-day notice** truly operational (not just aspirational)
5. **Include protective disclaimer** that list is indicative, not exhaustive

---

## **📋 PROPOSED SUB-PROCESSOR STRUCTURE**

### **Tier 1: Named Vendors (High-Risk — Direct Customer Data Contact)**
These MUST be listed by name because they process call audio, transcripts, or customer PII:

**Voice & Telephony:**
- Twilio (SMS, call routing) — **CONFIRMED ACTIVE**
- [Other telephony providers when confirmed]

**Speech Processing:**
- Fast-Whisper (speech-to-text) — **CONFIRMED ACTIVE**
- ElevenLabs OR Cartesia (text-to-speech) — **LIST ONLY WHAT YOU'RE USING**
- Silero VAD (voice activity detection) — **CONFIRMED ACTIVE**

**Payment & Billing:**
- Stripe (payment processing) — **CONFIRMED ACTIVE**

**Authentication:**
- Auth0 OR Okta (NOT BOTH unless you're actually using both) — **CONFIRM WHICH ONE**

---

### **Tier 2: Category-Based Vendors (Low-Risk — Infrastructure/Operational)**
These are listed by CATEGORY, not specific names:

**Cloud Infrastructure & Hosting:**
- "Enterprise cloud providers including but not limited to Amazon Web Services (AWS), Google Cloud Platform, Microsoft Azure, or comparable SOC 2 Type II certified infrastructure providers"

**Database & Storage:**
- "Enterprise database and caching services including but not limited to Supabase, PlanetScale, Redis Labs, AWS RDS, or comparable providers"

**CDN & Network:**
- "Content delivery and network optimization providers including but not limited to Cloudflare, Fastly, AWS CloudFront, or comparable providers"

**Monitoring & Observability:**
- "Application monitoring, error tracking, and logging services including but not limited to Sentry, Datadog, LogRocket, or comparable providers"

**Development Tools:**
- "Software development and deployment tools including but not limited to GitHub, Vercel, Cursor, AWS CodePipeline, or comparable providers"

---

### **Tier 3: Catch-All Authorization**

**Add this protective language:**

> **"Additional Operational Vendors"**
> 
> Customer pre-authorizes Provider to engage additional sub-processors in the following categories without prior notice, provided such sub-processors:
> - (a) are SOC 2 Type II certified or equivalent
> - (b) execute Standard Contractual Clauses (SCCs) where required
> - (c) do NOT process call audio, transcripts, or customer PII
> - (d) are used solely for: software development, testing, deployment, infrastructure management, network optimization, internal collaboration, project management, documentation, or non-customer-facing operations
> 
> Categories include but are not limited to: version control systems, CI/CD pipelines, container registries, package managers, API testing tools, documentation platforms, internal chat/collaboration tools, HR systems, accounting software, and office productivity suites.

---

## **🚨 CRITICAL LEGAL ISSUES WITH YOUR RAW LIST**

### **Issue #1: LLM/AI Vendors Listed**
**Your list includes:**
- xAI Grok
- OpenAI Ireland
- Anthropic
- Cohere
- Hugging Face

**PROBLEM:** Your entire legal positioning is "NO LLMs in Core Logic." If you list these as sub-processors, it:
- ❌ **Contradicts your core marketing message** ("deterministic, no AI")
- ❌ Creates **regulatory exposure** (bar ethics, UPL concerns)
- ❌ Undermines **Swiss law arbitration strategy** (U.S. firms could argue you're AI-based after all)

**RECOMMENDATION:** 
- **If you're using LLMs:** List them as "Ancillary ML Tools" (NOT Core Logic) with explicit use-case limitations
- **If you're NOT using them yet:** Don't list them until you actually deploy them

### **Issue #2: Duplicate/Overlapping Vendors**
Your list includes:
- OpenAI Whisper AND Fast-Whisper AND AWS Transcribe AND DeepGram (all for STT)
- ElevenLabs AND Cartesia AND Play.ht AND 15+ other TTS vendors

**PROBLEM:** You're probably using 1-2 of these, not all 20. Listing all of them:
- ❌ Creates false impression you've vetted all of them
- ❌ Requires DPAs with vendors you may never use
- ❌ If a listed vendor has a breach and you weren't even using them → confusion/liability

**RECOMMENDATION:** List ONLY the vendor(s) you're ACTIVELY using today.

### **Issue #3: Consumer Tools Listed**
Your list includes:
- Microsoft Word, Microsoft Excel, Google Docs, Google Sheets
- Slack, WhatsApp, Discord, Telegram
- Calendly, HubSpot

**PROBLEM:** These are likely for YOUR internal operations, not customer data processing. If you list them as sub-processors:
- ❌ Implies customer data flows through Slack/WhatsApp (massive compliance issue)
- ❌ Requires DPAs with Microsoft, Google for Office suite (unnecessary)
- ❌ Creates audit burden for tools that never touch customer PII

**RECOMMENDATION:** 
- **Internal tools:** Exclude from sub-processor list
- **Customer-facing tools:** Include only if they actually process customer data

---

## **✅ RECOMMENDED SUB-PROCESSOR APPROACH**

### **1. Minimal Specific List (What You're ACTUALLY Using Today):**

**Essential Vendors (Process Customer Data):**
- Twilio (telephony)
- Stripe (payments)
- Auth0 (authentication)
- AWS (hosting/storage)
- Cloudflare (CDN/security)

**Speech Processing (If Confirmed Active):**
- Fast-Whisper OR OpenAI Whisper (pick ONE)
- ElevenLabs OR Cartesia (pick ONE, not both)
- Silero VAD (if confirmed active)

**Database (If Confirmed Active):**
- Supabase OR PlanetScale OR Redis (list only what you're using)

**Total:** 8-12 vendors maximum

---

### **2. Category-Based Catch-All (Operational Flexibility):**

**Add this protective language to Terms, MSA, and Privacy:**

> **"Sub-Processor Flexibility Clause"**
> 
> The sub-processor list at https://truevow.law/subprocessors is **indicative and non-exhaustive**. Provider may engage additional sub-processors in the following categories without 30-day notice, provided they meet security standards:
> 
> **Pre-Authorized Categories (No Notice Required):**
> - Development tools (code editors, version control, CI/CD, testing)
> - Infrastructure (load balancers, edge computing, DNS, SSL/TLS)
> - Monitoring (logging, error tracking, performance analytics)
> - Internal operations (collaboration, HR, accounting, documentation)
> - Network security (firewalls, DDoS protection, WAF)
> 
> **30-Day Notice Required For:**
> - New vendors processing call audio or transcripts
> - New vendors processing customer PII (name, phone, email)
> - New vendors processing payment data
> - New vendors storing data >24 hours
> 
> **Immediate Notice (Best Efforts) + Right to Object:**
> - Any vendor processing attorney-client privileged data
> - Any vendor with access to unencrypted customer data

---

### **3. Update "No Liability" Language:**

**Change sub-processor clause to:**

> **"Provider uses sub-processors as listed at https://truevow.law/subprocessors and may engage additional sub-processors as described in this Section. The list is updated regularly but may not reflect all operational vendors at any given time. Customer acknowledges that:**
> - **(a)** The list is **indicative, not exhaustive**, and Provider may use unlisted vendors for infrastructure, development, and internal operations
> - **(b)** Provider will use **commercially reasonable efforts** to keep the list current
> - **(c)** Failure to list a vendor does **not** constitute a breach of this Agreement unless such vendor processes customer PII without proper security safeguards
> - **(d)** Provider **shall not be liable** for any act or omission of any sub-processor (listed or unlisted)"

---

## **📊 COMPARISON: CURRENT vs. PROPOSED**

| Approach | Current | Proposed |
|----------|---------|----------|
| **Named Vendors** | ~20 specific vendors | **8-12 confirmed active vendors** |
| **Coverage** | Fixed list | **Category-based + catch-all** |
| **LLM Vendors** | Not listed | **Conditional (only if using, with explicit limits)** |
| **Internal Tools** | Not listed | **Excluded (correct)** |
| **Flexibility** | 30-day notice for ALL changes | **30-day notice only for high-risk vendors** |
| **Liability** | No liability for sub-processors | **Strengthened: no liability + indicative list** |
| **Compliance Burden** | High (20+ DPAs) | **Low (8-12 DPAs)** |
| **Operational Flexibility** | Low | **High** |

---

## **🎯 MY RECOMMENDATION**

### **STEP 1: Confirm Active Vendors (CRITICAL)**
Before finalizing the list, confirm which vendors you're ACTUALLY using in production TODAY:

**Must List (High-Risk — Process Customer Data):**
- [ ] Twilio — YES/NO?
- [ ] Stripe — YES/NO?
- [ ] Auth0 or Okta — WHICH ONE?
- [ ] AWS or GCP or Azure — WHICH ONE(S)?
- [ ] Cloudflare — YES/NO?

**Speech Processing (Confirm Active):**
- [ ] Fast-Whisper or OpenAI Whisper — WHICH ONE?
- [ ] ElevenLabs or Cartesia — WHICH ONE?
- [ ] Silero VAD — YES/NO?
- [ ] DeepGram — YES/NO?

**Database (Confirm Active):**
- [ ] Supabase — YES/NO?
- [ ] PlanetScale — YES/NO?
- [ ] Redis — YES/NO?

### **STEP 2: Remove Uncertain/Future Vendors**
**DO NOT list:**
- ❌ xAI Grok, Anthropic, Cohere, OpenAI (unless you're ACTIVELY using for specific Ancillary ML function)
- ❌ Microsoft Word/Excel, Google Docs/Sheets (internal tools, not sub-processors)
- ❌ Slack, WhatsApp, Discord (internal comms, should NOT touch customer data)
- ❌ 15+ TTS vendors (pick the ONE you're using)
- ❌ 10+ STT vendors (pick the ONE you're using)

### **STEP 3: Add Category-Based Catch-All**
Allows operational flexibility without compliance violations.

### **STEP 4: Update Legal Language**
Make list "indicative, not exhaustive" with proper disclaimers.

---

## **⚠️ SPECIFIC CONCERNS WITH YOUR RAW LIST**

### **🚨 RED FLAG: xAI Grok, OpenAI, Anthropic**
**Your text says:**
> "U.S.-based large language models (e.g., xAI Grok, OpenAI Ireland, Anthropic, LangChain) for AI-driven features, with law firm verification required for accuracy and compliance (RPC 1.6, HIPAA)."

**LEGAL PROBLEM:**
- Your ENTIRE legal strategy is "Core Logic = FSM, NO AI"
- If you list LLMs as sub-processors, you undermine this positioning
- Law firms will ask: "Wait, you DO use LLMs? Which parts? For what?"
- Bar regulators could classify you as "AI-based legal tech" with higher scrutiny

**RECOMMENDATION:**
- **If not using LLMs for anything:** Don't list them
- **If using for Ancillary ML Tools only:** List with VERY specific use-case restrictions:
  - "OpenAI GPT models used EXCLUSIVELY for internal documentation generation, NOT for customer-facing legal functions"
  - OR: Don't list in sub-processors; treat as internal tool like Microsoft Word

### **🚨 RED FLAG: VAPI, Retell AI**
These are AI voice agent platforms. If you're using them:
- They ARE sub-processors (they handle call audio)
- They MUST be listed
- But this contradicts "Benjamin = deterministic FSM"

**Clarification needed:** Are you using VAPI/Retell for:
- (a) The Core Logic engine? → Major legal issue
- (b) A separate optional feature? → Must be disclosed with clear separation
- (c) Not using them at all? → Don't list them

### **🚨 RED FLAG: Microsoft Word, Excel, Google Docs, Sheets**
**PROBLEM:** These are internal productivity tools, not sub-processors UNLESS:
- You're using them to process customer data (which you shouldn't be)
- They're integrated into your workflow in a way that touches PII

**RECOMMENDATION:** **Remove from sub-processor list.** These are internal tools.

---

## **✅ FINAL RECOMMENDATION**

### **For Privacy Policy, MSA, and Terms:**

**Replace current sub-processor language with:**

---

**"8.6 Sub-Processors (Flexible, Category-Based Approach)"**

**(a) Living List:** Provider maintains a current list of sub-processors at **https://truevow.law/subprocessors**. This list is **indicative and non-exhaustive** and reflects vendors actively processing Customer Data as of the last update date.

**(b) Vendor Categories:** Provider may engage sub-processors in the following categories:

**Category 1 — High-Risk (30-Day Notice Required):**
- Telephony and voice services (e.g., Twilio, Bandwidth)
- Speech-to-text and text-to-speech processing (e.g., Fast-Whisper, ElevenLabs)
- Payment processing (e.g., Stripe)
- Authentication and identity management (e.g., Auth0)
- Any vendor storing Customer Data >24 hours

**Category 2 — Medium-Risk (Best-Efforts Notice):**
- Cloud hosting and storage (e.g., AWS, Google Cloud, Azure)
- Database and caching services (e.g., Supabase, PlanetScale, Redis)
- CDN and network optimization (e.g., Cloudflare, Fastly)

**Category 3 — Low-Risk (Pre-Authorized, No Notice):**
- Development tools (GitHub, Cursor, Vercel, CI/CD pipelines)
- Monitoring and logging (Sentry, Datadog, PagerDuty)
- Infrastructure management (Kubernetes, Docker, load balancers)
- Network security (firewalls, DDoS protection, WAF)
- Internal operations (collaboration, HR, accounting, documentation)

**(c) Security Requirements:** All sub-processors must:
- Execute Data Processing Agreements (DPAs) or Standard Contractual Clauses (SCCs)
- Maintain SOC 2 Type II, ISO 27001, or equivalent certification (for Category 1 & 2)
- Implement encryption in transit (TLS 1.3+) and at rest (AES-256+)
- Provide breach notification within 72 hours

**(d) Notice Obligations:**
- **Category 1:** 30 days' written notice to **dpo@truevow.com** with right to object (exclusive remedy: termination)
- **Category 2:** Best-efforts notice via email or list update
- **Category 3:** No notice required

**(e) Indicative Nature:** The list at **truevow.law/subprocessors** is **not exhaustive**. Provider may engage unlisted vendors for operational purposes without violating this Agreement, provided:
- Vendor does NOT process call audio, transcripts, or customer PII, OR
- Vendor is engaged for emergency purposes (e.g., failover, incident response), OR
- Vendor falls within a pre-authorized Category 3

**(f) No Liability:** Provider **shall not be liable** for: 
- Failure to list a vendor on the public list
- Using an unlisted vendor for operational purposes
- Any act, omission, breach, or failure of any sub-processor (listed or unlisted)

---

## **🎯 SPECIFIC ANSWERS TO YOUR QUESTIONS**

### **Q1: "Is putting as many companies as possible on the list helpful or harmful?"**

**ANSWER: HARMFUL.**

**Reasons:**
1. ❌ Creates audit burden for vendors you're not using
2. ❌ False disclosure if listed vendors aren't active
3. ❌ GDPR compliance gap if you use an unlisted vendor
4. ❌ Competitors get your tech stack
5. ❌ Requires maintaining 100+ DPAs

**Better Approach:**
- List 8-12 confirmed active vendors
- Use category-based descriptions
- Add catch-all for operational vendors
- Make list "indicative, not exhaustive"

---

### **Q2: "Are these categories even accurate?"**

**Your categories are GOOD but need refinement:**

✅ **KEEP:**
- Speech-to-text transcription
- Text-to-speech synthesis
- Voice activity detection
- Cloud infrastructure & hosting
- Payment processors
- Authentication providers

❌ **REMOVE/REVISE:**
- "Large language models for AI-driven features" → **Contradicts your positioning**
- "Microsoft Word, Excel, Google Docs" → **Internal tools, not sub-processors**
- "Slack, WhatsApp, Discord" → **Internal comms, should NOT touch customer data**

⚠️ **CLARIFY:**
- "VAPI, Retell AI" → Are you using these? They're AI voice agents (contradicts FSM positioning)
- "Agentic development tools" → Internal dev tools, probably don't need to list

---

### **Q3: "How do we handle vendors we MIGHT use in the future?"**

**ANSWER: Category-based pre-authorization + living list.**

**Legal Language:**

> "Provider may engage additional vendors within pre-authorized categories without constituting a breach of this Agreement. The list at truevow.law/subprocessors is updated regularly to reflect active vendors, but operational flexibility is preserved for infrastructure, development, and internal tools."

This allows you to:
- ✅ Add/remove vendors operationally
- ✅ Not breach contract if list is slightly out of date
- ✅ Avoid 30-day notice for low-risk vendors
- ✅ Maintain compliance without operational rigidity

---

## **📝 ACTION ITEMS**

### **IMMEDIATE:**

1. **Audit Current Vendors (TODAY):**
   - Which vendors are you ACTIVELY using in production?
   - Which vendors process customer data (call audio, transcripts, PII)?
   - Which are internal-only (Slack, Google Docs, etc.)?

2. **Create Accurate Minimal List:**
   - List ONLY confirmed active vendors for customer data
   - Use categories for infrastructure/monitoring
   - Add catch-all for operational flexibility

3. **Update Legal Language:**
   - Change "TrueVow remains liable" → "No liability for sub-processors"
   - Add "indicative, not exhaustive" disclaimer
   - Add category-based pre-authorization

4. **Remove Contradictions:**
   - Don't list LLMs unless you're actually using them
   - If using LLMs, specify EXACT use case (and it must be Ancillary, not Core)

---

## **⚖️ LEGAL RULE OF THUMB**

**"List only what you're using TODAY. Pre-authorize categories for TOMORROW."**

This gives you:
- ✅ Accurate disclosure (compliance)
- ✅ Operational flexibility (can add vendors quickly)
- ✅ Competitive protection (don't reveal full roadmap)
- ✅ Lower audit burden (fewer DPAs to manage)

---

**BOTTOM LINE:**

**Your current subprocessors.html has ~20 vendors. This is probably TOO MANY if you're not actively using all of them.**

**Recommended: 8-12 confirmed vendors + category-based catch-all = OPTIMAL**

---

**Would you like me to:**
1. Help you audit which vendors you're ACTUALLY using today?
2. Create a revised, minimal sub-processor list?
3. Update the legal language to allow category-based flexibility?

All three?

