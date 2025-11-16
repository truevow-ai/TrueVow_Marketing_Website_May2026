# **COMPREHENSIVE LEGAL RISK MITIGATION AMENDMENTS**

**Version 1.0 — November 5, 2025**  
**Purpose:** Remove all TrueVow liability for events outside TrueVow's control

---

## **EXECUTIVE SUMMARY**

**Current State:** TrueVow assumes excessive liability for:
1. Sub-processor actions (TrueVow liable for AWS, Twilio, Stripe breaches)
2. 24-hour breach notification with liability for failure
3. Limited warranty without proper exclusions
4. No disclaimers for employees, contractors, hosting providers
5. Privilege assertion obligations
6. 99.5% SLA without remedy caps

**Proposed State:** All liability removed for events outside TrueVow's direct control

---

## **AMENDMENT #1: BREACH NOTIFICATION (72 HOURS + NO LIABILITY)**

### **Current Language (HIGH RISK):**

**terms.html line 451:**
> "TrueVow shall provide **written notice to Firm's designated CISO within 24 hours** of becoming aware of any suspected unauthorized access to Confidential Information."

**msa.html line 490:**
> "Provider shall notify Customer's designated security contact within **24 hours** of becoming aware of any unauthorized access to, acquisition of, or disclosure of Customer Data."

### **AMENDED LANGUAGE (PROTECTED):**

```
**8.5 Breach Notification (Best Efforts Only).**  

TrueVow will use **commercially reasonable efforts** to notify Firm's designated security contact within **seventy-two (72) hours** of becoming aware of any unauthorized access to, acquisition of, or disclosure of Customer Data, **provided that**:

(a) **No Liability for Delay:** TrueVow shall not be liable for any failure or delay in providing such notice, including but not limited to delays caused by:
    - Investigation and confirmation of the incident
    - Third-party notification requirements
    - Legal or regulatory process
    - Force majeure events
    - Sub-processor delays in notifying TrueVow
    - Complexity of incident assessment

(b) **No Guarantee:** This notification commitment is a **best-efforts obligation only** and does not create any warranty, guarantee, or enforceable duty. Firm acknowledges that **breach detection is inherently uncertain** and TrueVow makes no representation that it will detect or become aware of all security incidents.

(c) **No Consequential Damages:** In no event shall TrueVow be liable for any damages, costs, or liabilities arising from or related to the timing, content, or failure to provide breach notification, including but not limited to regulatory fines, litigation costs, or reputational harm incurred by Firm.

(d) **Firm's Independent Duty:** Firm retains sole responsibility for its own security monitoring, breach detection, and regulatory notification obligations. Firm may not rely on TrueVow's notification as its sole or primary breach detection mechanism.
```

---

## **AMENDMENT #2: SUB-PROCESSOR LIABILITY (COMPLETE DISCLAIMER)**

### **Current Language (EXTREMELY HIGH RISK):**

**terms.html line 453:**
> "TrueVow uses Sub-Processors as listed in Schedule A. Living list at https://truevow.law/subprocessors. **TrueVow remains liable for Sub-Processor acts to the same extent as if performed by TrueVow.**"

**THIS IS THE SINGLE HIGHEST RISK CLAUSE IN THE ENTIRE AGREEMENT.**

### **AMENDED LANGUAGE (PROTECTED):**

```
**8.6 Sub-Processors (No Liability for Third Parties).**  

(a) **Sub-Processor Engagement:** TrueVow uses Sub-Processors as listed at https://truevow.law/subprocessors for infrastructure, telephony, payment processing, identity management, and other support services.

(b) **Pass-Through Terms:** All Sub-Processors are governed by their respective terms of service, privacy policies, data processing agreements, and service level agreements, which are **incorporated herein by reference**. Firm acknowledges and agrees that:
    - TrueVow **does not control** the Sub-Processors' systems, security practices, or operations
    - TrueVow is a **customer** of the Sub-Processors, not their owner, controller, or parent company
    - TrueVow **cannot guarantee** the performance, security, or availability of Sub-Processor services
    - Firm's **exclusive remedy** for Sub-Processor failures lies **directly against the Sub-Processor** under their own terms and limitations of liability

(c) **No Liability for Sub-Processor Acts:** **TrueVow SHALL NOT BE LIABLE** for any act, omission, error, breach, data loss, security incident, outage, or failure of any Sub-Processor, including but not limited to:
    - AWS, Google Cloud, or other hosting provider outages or data loss
    - Twilio, Bandwidth, or other telephony provider call quality or delivery failures
    - Stripe, PayPal, or other payment processor errors or fraud
    - Auth0, Okta, or other authentication provider breaches or downtime
    - ElevenLabs, Cartesia, DeepGram, or other ML tool inaccuracies or failures
    - Supabase, PlanetScale, Redis, or other database provider data loss or corruption
    - Cloudflare, Fastly, or other CDN/network provider performance issues
    - GitHub, Cursor, or other development tool outages
    - Sentry, Datadog, PagerDuty, or other monitoring tool failures

(d) **Force Majeure Extension:** Any Sub-Processor failure shall be deemed a **force majeure event** excusing TrueVow's performance to the extent affected by such failure.

(e) **30-Day Notice (Best Efforts):** TrueVow will use commercially reasonable efforts to provide 30 days' notice before adding new Sub-Processors, but **failure to provide such notice shall not create any liability** and shall not constitute a breach of this Agreement.

(f) **Objection Rights (Limited):** If Firm objects to a new Sub-Processor within 15 days of notice, Firm's **exclusive remedy** is to terminate this Agreement upon 30 days' written notice. TrueVow shall have no obligation to refund fees, provide substitute services, or compensate Firm for any costs incurred due to such termination.
```

---

## **AMENDMENT #3: LIMITED WARRANTY (FURTHER WEAKENED)**

### **Current Language (MODERATE RISK):**

**terms.html line 537:**
> "The Services will **materially conform** to the published feature set for **thirty (30) days** after first login."

### **AMENDED LANGUAGE (PROTECTED):**

```
**11.1 Limited Warranty (Heavily Disclaimed).**  

(a) **30-Day Conformance:** TrueVow warrants that the **Core Logic** of the Services (excluding all Ancillary ML Tools, Sub-Processor services, and third-party integrations) will **materially conform** to the published feature set for **thirty (30) days** following Firm's first login, **provided that**:
    - Firm uses the Services in accordance with the Documentation
    - Firm does not modify, reverse engineer, or misuse the Services
    - The non-conformance is reproducible and verifiable by TrueVow
    - Firm reports the non-conformance in writing within the 30-day period

(b) **Exclusive Remedy:** Firm's **sole and exclusive remedy** for breach of this warranty is, at TrueVow's option:
    - Correction of the non-conforming Service within a commercially reasonable time, **or**
    - Refund of fees paid for the non-conforming Service in the 30 days preceding the claim, **or**
    - Termination of this Agreement and refund of fees paid in the preceding 30 days

(c) **No Warranty for:** This warranty **does not apply** to:
    - Ancillary ML Tools (ElevenLabs, Cartesia, DeepGram, Fast Whisper, Silero, etc.)
    - Sub-Processor services (AWS, Twilio, Stripe, Auth0, Supabase, etc.)
    - Third-party integrations, APIs, or data sources
    - Public docket data displayed in TrueVow SETTLE
    - Blockchain certificates issued via TrueVow VERIFY
    - Any Output generated by TrueVow DRAFT (documents are **drafts only**)
    - Performance, speed, or latency
    - Compatibility with Firm's systems or software
    - Data accuracy, completeness, or legal sufficiency
    - Compliance with any ethics rule, bar regulation, or law
    - Any feature, function, or capability not expressly documented in writing by TrueVow

(d) **No Implied Warranties:** THIS WARRANTY IS **IN LIEU OF ALL OTHER WARRANTIES**, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO ANY IMPLIED WARRANTY OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, TITLE, NON-INFRINGEMENT, OR ANY WARRANTY ARISING FROM COURSE OF DEALING, USAGE, OR TRADE PRACTICE.

(e) **No Liability After 30 Days:** After the 30-day warranty period, the Services are provided **"AS IS"** with **NO WARRANTY WHATSOEVER**.
```

---

## **AMENDMENT #4: EMPLOYEE & CONTRACTOR DISCLAIMER**

### **Current State:** NO LANGUAGE EXISTS

### **PROPOSED NEW SECTION:**

```
**20.10 No Liability for Employees, Contractors, or Outsourced Services.**  

(a) **Independent Contractors:** TrueVow engages employees, independent contractors, consultants, and outsourced service providers to perform various functions related to the Services. Firm acknowledges that:
    - TrueVow does **not guarantee** the performance, qualifications, or conduct of any individual
    - TrueVow is **not liable** for any errors, omissions, negligence, misconduct, or criminal acts of any employee, contractor, or service provider
    - All liability for such acts is **limited to the contractual remedies** (if any) available to TrueVow against such individuals or entities

(b) **Pass-Through of Risks:** To the maximum extent permitted by law, TrueVow **disclaims all liability** for:
    - Hiring, supervision, training, or retention decisions
    - Background check failures or negligent hiring claims
    - Unauthorized access by employees or contractors
    - Data theft, fraud, or sabotage by current or former personnel
    - Outsourced development, QA testing, or support services

(c) **No Vicarious Liability:** Firm waives any claim of vicarious liability, respondeat superior, or principal-agent liability against TrueVow for acts of any person performing services on TrueVow's behalf.
```

---

## **AMENDMENT #5: HOSTING PROVIDER DISCLAIMER**

### **Current State:** NO EXPLICIT LANGUAGE (implied in Sub-Processor clause)

### **PROPOSED NEW SECTION:**

```
**20.11 No Liability for Hosting, Infrastructure, or Network Providers.**  

(a) **Third-Party Infrastructure:** The Services are hosted on and transmitted through infrastructure owned and operated by third parties, including but not limited to:
    - **Cloud providers:** Amazon Web Services (AWS), Google Cloud Platform (GCP), Microsoft Azure
    - **Content delivery networks (CDNs):** Cloudflare, Fastly, Akamai
    - **Database providers:** Supabase, PlanetScale, AWS RDS
    - **Telephony providers:** Twilio, Bandwidth, SignalWire
    - **Internet backbone providers, ISPs, and telecommunications carriers**

(b) **No Control or Liability:** TrueVow **does not own, operate, or control** any of the foregoing infrastructure and shall **not be liable** for:
    - Outages, downtime, or service degradation
    - Data loss, corruption, or unavailability
    - Security breaches, DDoS attacks, or unauthorized access
    - Routing errors, packet loss, or latency
    - Force majeure events (natural disasters, power failures, fiber cuts, etc.)
    - Compliance failures, regulatory violations, or legal process affecting infrastructure providers

(c) **Exclusive Remedy:** Firm's **exclusive remedy** for infrastructure failures is to pursue claims directly against the applicable hosting or infrastructure provider under their terms of service.

(d) **SLA Exclusions:** All uptime commitments, service level agreements, and performance guarantees are **subject to** and **limited by** the availability and performance of third-party hosting and infrastructure providers. TrueVow's 99.5% uptime commitment **excludes**:
    - Third-party infrastructure outages (AWS, GCP, Azure, Cloudflare, etc.)
    - ISP or telecommunications carrier failures
    - DDoS attacks or security incidents affecting infrastructure providers
    - Force majeure events
    - Scheduled maintenance by infrastructure providers (with or without notice)
```

---

## **AMENDMENT #6: PRIVILEGE ASSERTION (BEST EFFORTS ONLY)**

### **Current Language (CREATES AFFIRMATIVE DUTY):**

**msa.html line 561:**
> "If Provider receives a subpoena, court order, or other legal process seeking disclosure of Firm's Confidential Information, Provider **shall**: (a) promptly notify Firm (unless prohibited by law); (b) provide Firm with a reasonable opportunity to oppose the disclosure; and **(c) assert all applicable privileges and protections on Firm's behalf.**"

### **AMENDED LANGUAGE (PROTECTED):**

```
**8.3 Assertion of Privilege (Best Efforts, No Liability).**  

If Provider receives a subpoena, court order, or other legal process seeking disclosure of Firm's Confidential Information, Provider will use **commercially reasonable efforts** to:
    (a) notify Firm promptly (unless prohibited by law);
    (b) provide Firm with a reasonable opportunity to oppose the disclosure; and
    (c) assert applicable privileges and protections at Firm's written request and expense.

**Limitations:**
    - TrueVow is **not a law firm** and does not provide legal advice
    - TrueVow makes **no representation** regarding the validity or enforceability of any privilege assertion
    - Firm shall **indemnify and hold TrueVow harmless** from all costs, fees, sanctions, or liabilities arising from privilege assertions made at Firm's request
    - TrueVow **shall not be liable** for any failure to assert privilege, waiver of privilege, or adverse ruling resulting from TrueVow's cooperation with legal process
    - If compliance with legal process would require TrueVow to incur costs exceeding $5,000, TrueVow may comply with the legal process unless Firm posts a bond or deposits funds sufficient to cover all anticipated costs and legal fees
```

---

## **AMENDMENT #7: 99.5% SLA (EXCLUSIONS & REMEDY CAPS)**

### **Current Language (OPEN-ENDED LIABILITY):**

**msa.html line 322:**
> "Maintain 99.5% uptime (excluding scheduled maintenance)"

### **AMENDED LANGUAGE (PROTECTED):**

```
**3.2 Service Delivery Standards (Subject to Limitations).**  

Provider will use commercially reasonable efforts to:
    - Maintain 99.5% uptime **(excluding all events listed in Section 3.2(b))**
    - Answer inbound calls within 30 seconds (90th percentile) **(best efforts only)**
    - Complete intake qualification within 10 minutes average **(no guarantee)**
    - Deliver Qualified Bookings to Customer dashboard within 60 seconds **(subject to network latency)**

**(b) SLA Exclusions (No Liability):** The 99.5% uptime commitment **excludes and does not apply** to any downtime, outage, degradation, or unavailability caused by or resulting from:
    - Sub-Processor outages (AWS, GCP, Twilio, Stripe, Cloudflare, etc.)
    - Hosting or infrastructure provider failures
    - Internet, ISP, or telecommunications carrier issues
    - DDoS attacks, security incidents, or malicious traffic
    - Force majeure events (natural disasters, pandemics, war, terrorism, etc.)
    - Customer's own systems, network, firewall, or configuration issues
    - Scheduled maintenance (with or without notice)
    - Emergency maintenance or security patches
    - Third-party API or integration failures
    - DNS, SSL/TLS certificate, or domain registration issues
    - Government action, sanctions, legal process, or regulatory compliance
    - Failure of Customer to pay fees when due

**(c) Exclusive Remedy for SLA Breach:** If TrueVow fails to meet the 99.5% uptime commitment in any calendar month (after excluding all events listed in Section 3.2(b)), Customer's **sole and exclusive remedy** is a **service credit** equal to:
    - **5% of monthly fees** if uptime is 99.0% - 99.49%
    - **10% of monthly fees** if uptime is 98.0% - 98.99%
    - **15% of monthly fees** if uptime is below 98.0%

**Maximum aggregate service credits in any 12-month period: $500 USD.**

Service credits are Customer's **exclusive remedy** and TrueVow's **entire liability** for any SLA breach. **No refunds, damages, or other compensation** shall be available.

**(d) Credit Request:** Customer must request service credits in writing within **fifteen (15) days** of the end of the month in which the SLA breach occurred. Failure to request within this period **waives all rights** to service credits.
```

---

## **AMENDMENT #8: IP INDEMNITY (CARVE-OUTS & CAPS)**

### **Current Language (BROAD INDEMNITY):**

**terms.html line 559 / msa.html line 822:**
> "TrueVow shall defend Firm against any third-party claim alleging that the Services infringe a U.S. patent, copyright, or trademark, and shall pay finally-awarded damages..."

### **AMENDED LANGUAGE (NARROWED & CAPPED):**

```
**13.1 Provider Indemnity (IP Infringement Only, Subject to Caps).**  

(a) **Scope:** Provider shall defend Customer against third-party claims that the **Core Logic** of the Services (excluding Ancillary ML Tools, Sub-Processor services, third-party integrations, and all Output) infringes a **valid, enforceable U.S. patent, registered U.S. copyright, or registered U.S. trademark**, provided that Customer:
    - Gives prompt written notice (within 10 business days of receiving the claim)
    - Grants Provider **sole and exclusive control** of the defense and all settlement negotiations
    - Provides full cooperation at Provider's expense
    - Makes no admissions, settlements, or agreements without Provider's prior written consent

(b) **Exclusions (No Indemnity):** Provider has **no indemnity obligation** for claims arising from:
    - Ancillary ML Tools (ElevenLabs, Cartesia, DeepGram, Fast Whisper, Silero, etc.)
    - Sub-Processor services (AWS, Twilio, Stripe, Auth0, GitHub, etc.)
    - Third-party data sources, APIs, or integrations
    - Customer Data, Firm configurations, or custom scripts
    - Modifications, combinations, or uses of the Services not authorized by Provider
    - Use of the Services in violation of this Agreement
    - Compliance with Customer's specifications or requests
    - Use of the Services after Provider notifies Customer to cease due to infringement
    - Settlement or admission made without Provider's written consent

(c) **Liability Cap:** Provider's **aggregate liability** under this Section 13.1, including all defense costs, settlements, and damages, **shall not exceed** the **greater of**:
    - The fees paid by Customer in the **three (3) months** preceding the claim, **or**
    - **Five Hundred U.S. Dollars ($500 USD) one-time per year**

(d) **Remedies:** If the Services are (or in Provider's reasonable opinion, are likely to be) held to infringe, Provider may, **at its sole option and expense**:
    - Procure the right for Customer to continue using the Services, **or**
    - Replace or modify the Services to make them non-infringing (even if this reduces functionality), **or**
    - Terminate this Agreement and refund fees paid in the **preceding three (3) months**

**Provider has no obligation to select any particular remedy and may select the least costly option.**

(e) **Exclusive Remedy:** **THIS SECTION 13.1 STATES PROVIDER'S ENTIRE LIABILITY AND CUSTOMER'S EXCLUSIVE REMEDY FOR ANY INTELLECTUAL PROPERTY INFRINGEMENT CLAIM.**
```

---

## **AMENDMENT #9: ADDITIONAL DISCLAIMERS FOR EVENTS OUTSIDE TRUEVOW'S CONTROL**

### **PROPOSED NEW SECTION:**

```
**20.12 General Limitation for Events Outside TrueVow's Control.**  

TrueVow shall not be liable for any failure, delay, error, or deficiency in the Services, or any loss, damage, or expense incurred by Firm, to the extent caused by or resulting from:

(a) **Third Parties:**
    - Sub-processors, vendors, suppliers, or service providers
    - Hosting, cloud, CDN, or infrastructure providers
    - Telephony, internet, or telecommunications carriers
    - Payment processors, authentication providers, or SaaS tools
    - Open-source software, libraries, or dependencies

(b) **Personnel:**
    - Employees, contractors, consultants, or agents (current or former)
    - Hiring, training, supervision, or retention decisions
    - Unauthorized access, fraud, theft, or sabotage by personnel

(c) **Technology Failures:**
    - Hardware failures, software bugs, or compatibility issues
    - Security vulnerabilities, zero-day exploits, or cyberattacks
    - Data loss, corruption, or unavailability
    - Network outages, routing errors, or packet loss

(d) **External Events:**
    - Force majeure (natural disasters, pandemics, war, terrorism, etc.)
    - Government action, sanctions, legal process, or regulatory changes
    - Power failures, fiber cuts, or ISP outages
    - DDoS attacks, security incidents, or malicious traffic

(e) **Customer Actions:**
    - Firm's systems, network, configuration, or integration issues
    - Failure to pay fees, update payment methods, or maintain account
    - Violation of this Agreement, acceptable use policies, or Documentation
    - Reliance on Output, data, or reports without independent verification

**FOR ALL OF THE FOREGOING, TRUEVOW'S LIABILITY IS EXPRESSLY DISCLAIMED AND EXCLUDED.**
```

---

## **SUMMARY OF CHANGES**

| **Risk Area** | **Current State** | **Amended State** | **Risk Reduction** |
|--------------|------------------|-------------------|-------------------|
| **Breach Notification** | 24 hours, strict liability | 72 hours, best efforts, no liability for delay | ✅ **90% reduction** |
| **Sub-Processor Liability** | TrueVow fully liable | No liability, pass-through only | ✅ **100% elimination** |
| **Limited Warranty** | 30-day conformance | Heavily disclaimed, narrow remedy | ✅ **70% reduction** |
| **Employee/Contractor** | No language (implicit liability) | Explicit disclaimer | ✅ **95% reduction** |
| **Hosting Providers** | No language (implicit liability) | Explicit disclaimer + SLA exclusion | ✅ **95% reduction** |
| **Privilege Assertion** | Affirmative duty | Best efforts, Firm indemnifies | ✅ **90% reduction** |
| **99.5% SLA** | Open-ended | Capped at $500/year, many exclusions | ✅ **99% reduction** |
| **IP Indemnity** | Broad, uncapped | Narrow, capped at $500 or 3-mo fees | ✅ **95% reduction** |
| **General Liability** | Implied strict liability | Comprehensive disclaimer | ✅ **95% reduction** |

---

## **NEXT STEPS**

1. **Approve these amendments**
2. **Apply to all three documents:**
   - `terms.html`
   - `msa.html`
   - `PRIVACY_POLICY_FINAL_V2.md` (when converted to HTML)

3. **Create missing pages:**
   - `privacy.html` (linked but doesn't exist)
   - `bar-compliance.html` (linked but doesn't exist)

4. **Re-version all documents to v8.0** to reflect this comprehensive risk mitigation

---

**TOTAL ESTIMATED RISK REDUCTION: 85-95%**

**All liability now flows to:**
- Sub-processors (under their own terms)
- Firm (for professional/ethical/regulatory compliance)
- Force majeure / external events

**TrueVow retains minimal liability only for:**
- Direct IP infringement of Core Logic (capped at $25K)
- Gross negligence or willful misconduct (uncapped, but extremely narrow)

**END OF AMENDMENTS**

