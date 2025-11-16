# TRUEVOW PRIVACY POLICY

**Effective Date:** November 4, 2025  
**Version:** 1.0  
**Last Updated:** November 4, 2025

---

## **IMPORTANT NOTICE**

**TrueVow is not a law firm.** We are a technology and services provider. This Privacy Policy explains how **TrueVow Global Technologies FZ-LLC (UAE)** collects, uses, discloses, and protects information in connection with our Services.

**By using our Services, you acknowledge that you have read, understood, and agree to be bound by this Privacy Policy and our Terms of Service.**

---

## **TABLE OF CONTENTS**

1. Corporate Structure & Data Controller
2. Scope & Application
3. Information We Collect
4. Zero-Knowledge Architecture
5. How We Use Information
6. Information We Share & Sub-Processors
7. Ancillary ML Tools & Third-Party Services
8. Data Retention & Deletion
9. Data Security Measures
10. Your Privacy Rights
11. California Privacy Rights (CCPA/CPRA)
12. European Data Subject Rights (GDPR)
13. International Data Transfers
14. Children's Privacy
15. Do Not Track Signals
16. Changes to This Privacy Policy
17. Contact Us

---

## **1. CORPORATE STRUCTURE & DATA CONTROLLER**

### **1.1 Contracting Entity & Data Controller**

The **data controller** for the Services is:

**TrueVow Global Technologies FZ-LLC (UAE)**  
Dubai South, P.O. Box [TBD]  
Dubai, United Arab Emirates  
Email: privacy@truevow.com

### **1.2 Related Entities**

**TrueVow Global Technologies Holdings Ltd. (Nevis):** Passive intellectual property holding entity. Not a party to customer agreements and not a data controller or processor.

**TrueVow Global Technologies (USA) Inc. (Wyoming):** Performs passive marketing activities only within the United States. Not a party to customer agreements and not a data controller or processor.

**All customer agreements, data processing, and privacy obligations are exclusively with TrueVow Global Technologies FZ-LLC (UAE).**

---

## **2. SCOPE & APPLICATION**

### **2.1 Services Covered**

This Privacy Policy applies to:

- **TrueVow INTAKE™** - AI-powered phone answering and lead qualification
- **TrueVow DRAFT™** - Automated legal document assembly
- **TrueVow SETTLE™** - Historical settlement data visualization
- **TrueVow CONNECT™** - Referral network and client management
- **TrueVow VERIFY™** - Blockchain-anchored compliance certificates
- **Website** - truevow.law and all subdomains
- **Marketing Communications** - Emails, newsletters, promotional materials

### **2.2 Who This Policy Applies To**

- **Customers** - Law firms and attorneys who subscribe to our Services
- **End Users** - Individuals who call or interact with Customer's TrueVow-powered intake system
- **Website Visitors** - Anyone who visits truevow.law
- **Partners & Affiliates** - Participants in our referral programs

### **2.3 Attorney-Client Privilege**

**TrueVow does not create an attorney-client relationship** with End Users. Any attorney-client privilege exists solely between the Customer (law firm) and their clients. Information disclosed to TrueVow is subject to the limited waiver protections of **Federal Rule of Evidence 502(d)** and analogous state rules.

---

## **3. INFORMATION WE COLLECT**

### **3.1 Information Collected from Customers (Law Firms)**

**Account Information:**
- Firm name, attorney names, bar numbers
- Email addresses, phone numbers
- Billing addresses, payment information
- State bar jurisdiction(s)
- Practice area(s)

**Configuration Data:**
- Intake scripts and qualification questions
- Calendar integration settings
- Document templates
- Jurisdictional preferences
- Custom branding assets

**Usage Data:**
- Number of calls handled
- Bookings generated
- Documents created
- Settlement reports accessed
- Feature usage analytics
- Login timestamps and IP addresses

### **3.2 Information Collected from End Users (Callers)**

**By Default (Zero-Knowledge Architecture):**
- **Minimal Data Only:**
  - First name (for greeting purposes)
  - Phone number (for callback/SMS confirmation)
  - Practice area interest
  - Jurisdiction (state)
  - Consent to booking (yes/no)
  - Appointment date/time selected

**What We DO NOT Collect (Default):**
- Full legal names
- Addresses
- Social Security Numbers
- Medical records or PHI
- Financial account information
- Detailed case facts
- Attorney-client privileged communications

**If Customer Enables Optional 7-Day Retention:**
- Call audio recordings (encrypted)
- Machine-generated transcripts (encrypted)
- **Stored for maximum 7 days, then irretrievably deleted**
- **Customer assumes all legal and compliance risk**

### **3.3 Information Collected Automatically**

**Website Analytics:**
- IP address (anonymized)
- Browser type and version
- Device type (desktop, mobile, tablet)
- Operating system
- Pages visited and time spent
- Referral source (how you found our site)
- Geographic location (city/state level only)

**Cookies & Tracking Technologies:**
- Essential cookies (required for site functionality)
- Analytics cookies (Google Analytics - anonymized IP)
- No advertising or third-party tracking cookies

### **3.4 Information from Third Parties**

**Sub-Processors:**
- Error logs from Sentry (system errors only, no user data)
- Performance metrics from Datadog (system health only)
- Authentication data from Auth0/Okta (login credentials)

**Public Sources:**
- Settlement data from public court dockets (TrueVow SETTLE)
- Attorney licensing data from state bar websites (verification only)

---

## **4. ZERO-KNOWLEDGE ARCHITECTURE**

### **4.1 Core Design Principle**

TrueVow is architected to **minimize our access to and storage of** sensitive personal information and protected data. This is our **Zero-Knowledge Architecture**.

### **4.2 How It Works**

**Default Operation:**

1. **Ephemeral Processing:** End User information is processed in memory during the call and **immediately discarded** after booking confirmation
2. **No Permanent Storage:** Call audio and transcripts are **not stored** on TrueVow servers
3. **Hash-Based Caching:** For performance, keywords may be temporarily cached using **SHA-256 hashed keys** (raw text never stored)
4. **TTL ≤ 900 Seconds:** Cached data expires after 15 minutes maximum
5. **Automatic Purge:** All cached data purged before call termination

**What Gets Transmitted to Customer:**

Only **anonymized booking metadata:**
- Timestamp
- Practice area
- Jurisdiction
- Consent status (yes/no)
- Appointed date/time
- Caller first name and phone number (for Customer follow-up)

**No substantive case facts, medical information, or privileged communications are transmitted or stored.**

### **4.3 Optional 7-Day Retention (Opt-In)**

**Customer May Enable:**

If Customer explicitly enables the "Retention Toggle" in their account settings:

- Call recordings encrypted and stored for **7 calendar days**
- Machine-generated transcripts encrypted and stored for **7 calendar days**
- Export window: Customer must download within 7 days
- **Automatic deletion:** All data irretrievably deleted after 7 days
- **No PHI:** Even with retention enabled, we do not store Social Security Numbers, medical records, or financial account details

**Customer Obligations:**

By enabling retention, Customer:
- Assumes **all legal and compliance risk**
- Is solely responsible for:
  - State recording-consent laws (CA, FL, etc.)
  - TCPA compliance
  - CCPA/GDPR compliance (if applicable)
  - HIPAA compliance (if applicable)
- **Indemnifies TrueVow** for any violations of recording-consent laws

---

## **5. HOW WE USE INFORMATION**

### **5.1 Primary Purposes**

**To Provide the Services:**
- Process intake calls and qualify leads
- Generate legal documents
- Display settlement benchmarking data
- Facilitate attorney referrals (TrueVow CONNECT)
- Issue blockchain compliance certificates (TrueVow VERIFY)

**To Communicate with Customers:**
- Send service notifications and updates
- Respond to support requests
- Send billing invoices and payment confirmations
- Provide product updates and feature releases

**To Improve the Services:**
- Analyze usage patterns (aggregated, anonymized data only)
- Debug technical issues and system errors
- Develop new features based on customer feedback
- Optimize system performance and reliability

**To Ensure Security & Compliance:**
- Detect and prevent fraud or abuse
- Enforce our Terms of Service and MSA
- Comply with legal obligations
- Respond to law enforcement requests (with notice to Customer)

### **5.2 Legal Bases for Processing (GDPR)**

For users in the European Economic Area (EEA), UK, or Switzerland, we process personal data based on:

- **Contract Performance:** Processing necessary to provide Services under our MSA/Terms
- **Legitimate Interests:** Fraud prevention, system security, product improvement
- **Consent:** Where explicitly provided (e.g., marketing emails, optional data retention)
- **Legal Obligation:** Compliance with applicable laws and regulations

### **5.3 What We DO NOT Do**

**We do not:**
- Sell personal information to third parties
- Use personal information for advertising or marketing to End Users
- Train machine learning models on customer or end user data
- Share data with law enforcement without Customer notice (except when prohibited by law)
- Use data for purposes incompatible with this Privacy Policy

---

## **6. INFORMATION WE SHARE & SUB-PROCESSORS**

### **6.1 When We Share Information**

**With Customers (Law Firms):**
- Booking metadata (timestamp, practice area, jurisdiction, consent, appointment)
- Caller first name and phone number (for follow-up)
- If 7-day retention enabled: Encrypted call recordings and transcripts

**With Sub-Processors (Service Providers):**

We share limited information with sub-processors who help us deliver the Services. All sub-processors:
- Are contractually bound to confidentiality obligations
- Process data only on our instructions
- Maintain appropriate security measures
- Are listed at **https://truevow.law/subprocessors**

**Key Sub-Processors:**

| Category | Provider | Data Shared | Purpose |
|----------|---------|-------------|---------|
| **Speech AI** | ElevenLabs, Cartesia, DeepGram, Silero, Faster-Whisper | Audio streams (ephemeral) | Voice synthesis, speech-to-text |
| **Auth** | Auth0, Okta | Login credentials | Secure authentication |
| **Database** | Supabase, PlanetScale, Redis | Booking metadata, user settings | Data storage and caching |
| **CDN/Edge** | Cloudflare, AWS CloudFront | IP addresses (anonymized) | Content delivery, DDoS protection |
| **Monitoring** | Sentry, Datadog, PagerDuty | System logs (no user data) | Error tracking, performance monitoring |
| **DevOps** | GitHub, Cursor, Vercel | Source code (no user data) | Code hosting, deployment |
| **Storage** | Backblaze B2 (opt-in only) | Encrypted recordings (if retention enabled) | Long-term object storage |

**Complete, up-to-date list:** https://truevow.law/subprocessors

### **6.2 When Required by Law**

We may disclose information when required by:
- Valid court order or subpoena
- Law enforcement request (with Customer notice, unless prohibited)
- Legal obligation to prevent harm or illegal activity
- Enforcement of our Terms of Service or MSA

**Our Policy:** We will notify Customers of legal requests unless prohibited by law, and we will assert all applicable privileges and protections on Customer's behalf.

### **6.3 Business Transfers**

If TrueVow is acquired, merged, or sells substantially all assets:
- Personal information may be transferred to the successor entity
- You will be notified via email and/or website notice
- The successor must honor this Privacy Policy
- You may delete your account before the transfer completes

### **6.4 With Your Consent**

We may share information with third parties when you explicitly consent (e.g., authorizing a referral through TrueVow CONNECT).

---

## **7. ANCILLARY ML TOOLS & THIRD-PARTY SERVICES**

### **7.1 What Are Ancillary ML Tools?**

We use third-party technologies that employ **machine learning solely for non-legal, operational purposes**, including:

**Speech & Audio Processing:**
- Speech-to-text transcription (STT)
- Text-to-speech synthesis (TTS)
- Voice activity detection (VAD)
- Audio format conversion and noise suppression

**Infrastructure & Operations:**
- Authentication (OAuth 2.0, SAML, MFA)
- Database optimization (query caching, indexing)
- Network delivery (CDN, edge computing)
- Code generation and deployment (AI-assisted development)

### **7.2 Important Disclosures**

**These tools:**
- ✅ Are used **exclusively for operational efficiency**
- ✅ Process **non-substantive inputs only** (audio streams, system logs, auth tokens)
- ✅ **Do not influence** legal qualification, document content, or case strategy
- ✅ **Do not train** on customer or end user data
- ✅ Are **modular and replaceable**
- ✅ Are **decoupled from Core Logic** (our deterministic FSM engine)

**These tools DO NOT:**
- ❌ Make legal determinations
- ❌ Assess case merit
- ❌ Generate legal advice
- ❌ Process privileged attorney-client communications as training data

### **7.3 Customer Control**

Customers may disable any Ancillary ML Tool in **Settings > Integrations**. Fallback mechanisms (human voice-over, manual data entry, deterministic alternatives) will apply.

### **7.4 Vendor Policies**

Each Ancillary ML Tool vendor has its own privacy policy and terms of service, incorporated by reference at https://truevow.law/subprocessors. **TrueVow passes through** all vendor limitations of liability and data-use restrictions.

---

## **8. DATA RETENTION & DELETION**

### **8.1 Customer Account Data**

**Active Accounts:**
- Retained for the duration of the customer relationship
- Updated as needed to reflect current information

**Closed Accounts:**
- Account data retained for **90 days** after termination
- Billing/payment records retained for **7 years** (tax/audit requirements)
- All other data deleted within **30 days** of termination

### **8.2 End User Data (Zero-Knowledge Default)**

**Default (No Retention Toggle):**
- **Immediate deletion** after call completion
- Only booking metadata transmitted to Customer
- No call recordings, transcripts, or substantive data stored

**With Retention Toggle Enabled:**
- Call recordings and transcripts stored for **7 calendar days**
- **Automatic irretrievable deletion** after 7 days
- No extension available (hard 7-day limit)

### **8.3 Website Analytics Data**

- Anonymized analytics data retained for **26 months** (Google Analytics default)
- Cookies expire per cookie table (Section 10.3)

### **8.4 Aggregated & Anonymized Data**

- Settlement benchmarking data (TrueVow SETTLE): Retained indefinitely in anonymized form
- System performance metrics: Retained for **12 months**
- **No personally identifiable information** in aggregated data

### **8.5 Legal Holds**

If we receive a litigation hold, valid court order, or legal preservation request, we will:
- Suspend deletion for affected data
- Notify Customer of the hold
- Maintain data in secure, encrypted form until hold is lifted

---

## **9. DATA SECURITY MEASURES**

### **9.1 Technical Safeguards**

**Encryption:**
- **In Transit:** TLS 1.3 for all data transmission
- **At Rest:** AES-256 encryption for all stored data
- **Backups:** Encrypted with separate keys

**Access Controls:**
- Multi-factor authentication (MFA) required for all internal access
- Role-based access control (RBAC)
- Principle of least privilege
- Annual access reviews

**Network Security:**
- Web Application Firewall (WAF) via Cloudflare
- DDoS protection (Cloudflare + AWS Shield)
- Intrusion detection and prevention systems (IDS/IPS)
- Regular penetration testing (annually)

**Monitoring & Logging:**
- Real-time security monitoring (Sentry, Datadog)
- Automated alerting for suspicious activity
- Logs retained for 90 days
- Annual security audits

### **9.2 Organizational Safeguards**

**Personnel:**
- Background checks for all employees with data access
- Confidentiality agreements (NDAs) for all staff and contractors
- Security awareness training (quarterly)
- Incident response training (annually)

**Policies & Procedures:**
- Written information security policy (WISP)
- Incident response plan
- Business continuity and disaster recovery plans
- Annual policy review and updates

### **9.3 Sub-Processor Security**

All sub-processors must:
- Maintain SOC 2 Type II certification or equivalent
- Provide data processing agreements (DPAs)
- Implement appropriate technical and organizational measures
- Notify us of any security incidents within 24 hours

### **9.4 Breach Notification**

In the event of a data breach affecting personal information:

**Customer Notification:**
- **Within 24 hours** to Customer's designated CISO/security contact
- Written notice via email with incident details
- Recommended remediation steps

**Regulatory Notification (if applicable):**
- CCPA: Within 72 hours to California Attorney General (if >500 CA residents affected)
- GDPR: Within 72 hours to relevant supervisory authority
- State breach notification laws: As required

**Affected Individuals:**
- Notification as required by applicable law
- Typically within 30 days of discovery

### **9.5 What We Cannot Guarantee**

Despite our security measures, **no system is 100% secure**. We cannot guarantee:
- That unauthorized third parties will never breach our systems
- That data transmission over the internet is completely secure
- That sub-processors will never experience security incidents

**Customer Responsibility:** Customers must implement their own security measures, including strong passwords, device security, and access controls for their staff.

---

## **10. YOUR PRIVACY RIGHTS**

### **10.1 Rights Available to All Users**

**Access & Portability:**
- Request a copy of your personal information
- Receive data in a structured, machine-readable format (JSON, CSV)
- Transfer data to another service provider

**Correction:**
- Update inaccurate or incomplete information
- Request correction of errors

**Deletion ("Right to be Forgotten"):**
- Request deletion of your personal information
- Subject to legal retention requirements (e.g., tax records, litigation holds)

**Opt-Out:**
- Unsubscribe from marketing emails (click "Unsubscribe" link)
- Disable Ancillary ML Tools (Settings > Integrations)
- Close your account (Settings > Account > Delete Account)

### **10.2 How to Exercise Your Rights**

**For Customers (Law Firms):**
- Log into your account at https://truevow.law/login
- Go to Settings > Privacy
- Or email: privacy@truevow.com

**For End Users (Callers):**
- Contact the law firm you called (they are the data controller for your interaction)
- Or email: privacy@truevow.com with details (date/time of call, phone number, law firm name)

**Response Time:**
- We will respond within **30 days** (45 days if complex request)
- No fee for first request; reasonable fee for excessive/repetitive requests

### **10.3 Cookie Preferences**

**Cookie Categories:**

| Type | Purpose | Duration | Can Opt Out? |
|------|---------|----------|--------------|
| **Essential** | Site functionality, security | Session | No (required) |
| **Analytics** | Google Analytics (anonymized IP) | 26 months | Yes |
| **Preferences** | Language, settings | 12 months | Yes |

**Manage Cookies:**
- Click "Cookie Settings" in footer
- Or adjust browser settings to block cookies
- Note: Blocking essential cookies may impair site functionality

---

## **11. CALIFORNIA PRIVACY RIGHTS (CCPA/CPRA)**

### **11.1 Scope**

This section applies to **California residents** only and supplements the rest of this Privacy Policy.

### **11.2 Categories of Personal Information Collected**

In the past 12 months, we have collected:

| Category | Examples | Collected? | Source | Business Purpose |
|----------|----------|------------|--------|------------------|
| **Identifiers** | Name, email, phone, IP address | Yes | Directly from you | Provide Services |
| **Commercial Information** | Payment info, purchase history | Yes | Directly from you | Billing |
| **Internet Activity** | Pages viewed, clicks | Yes | Automatically | Analytics |
| **Geolocation** | City/state (not precise location) | Yes | Automatically | Service delivery |
| **Audio/Visual** | Call recordings (opt-in only) | Yes (opt-in) | Intake calls | Export to Customer |
| **Professional Information** | Bar number, law firm name | Yes | Directly from you | Verification |
| **Sensitive Personal Information** | SSN, PHI, financial accounts | **NO** | N/A | N/A |

### **11.3 Sale of Personal Information**

**We do not sell personal information.**

In the past 12 months:
- **0 records sold** to third parties
- **0 records shared** for monetary or other valuable consideration
- **0 records shared** with third parties for cross-context behavioral advertising

**We do not sell the personal information of minors under 16 years of age.**

### **11.4 Your California Rights**

**Right to Know:**
- Categories of personal information collected
- Sources from which collected
- Business purposes for collection
- Categories of third parties with whom shared

**Right to Delete:**
- Request deletion of personal information
- Subject to legal retention requirements

**Right to Correct:**
- Request correction of inaccurate information

**Right to Opt-Out:**
- Opt-out of sale/sharing (N/A - we don't sell)
- Limit use of sensitive personal information (N/A - we don't collect)

**Right to Non-Discrimination:**
- We will not discriminate against you for exercising your CCPA rights
- No denial of service, different prices, or different quality of service

### **11.5 Authorized Agent**

You may designate an authorized agent to make CCPA requests on your behalf. The agent must:
- Provide written authorization signed by you
- Verify their identity and authority
- We may still require you to verify your identity directly

### **11.6 Verification Process**

To verify your identity, we may request:
- Email address associated with your account
- Phone number or account number
- Answers to security questions
- Government-issued ID (for sensitive requests only)

### **11.7 Contact for California Requests**

**Email:** privacy@truevow.com  
**Subject Line:** "California Privacy Rights Request"  
**Response Time:** 45 days (may extend to 90 days for complex requests with notice)

---

## **12. EUROPEAN DATA SUBJECT RIGHTS (GDPR)**

### **12.1 Scope**

This section applies to individuals in the **European Economic Area (EEA), United Kingdom, and Switzerland**.

### **12.2 Legal Basis for Processing**

We process personal data based on:

| Purpose | Legal Basis |
|---------|-------------|
| Provide Services | Contract performance (MSA/Terms) |
| Customer support | Contract performance |
| Billing & payment | Contract performance |
| Security & fraud prevention | Legitimate interest |
| Product improvement | Legitimate interest |
| Marketing emails | Consent (opt-in) |
| Legal compliance | Legal obligation |

### **12.3 Your GDPR Rights**

**Right of Access (Article 15):**
- Obtain confirmation of whether we process your personal data
- Request a copy of your personal data
- Information about processing purposes, categories, recipients, retention periods

**Right to Rectification (Article 16):**
- Correct inaccurate or incomplete personal data

**Right to Erasure / "Right to be Forgotten" (Article 17):**
- Request deletion of personal data
- Exceptions: Legal obligations, legal claims, public interest

**Right to Restriction of Processing (Article 18):**
- Request we limit processing in certain circumstances
- Data stored but not used

**Right to Data Portability (Article 20):**
- Receive personal data in structured, machine-readable format
- Transmit data to another controller

**Right to Object (Article 21):**
- Object to processing based on legitimate interests
- Object to direct marketing (absolute right)

**Right Not to Be Subject to Automated Decision-Making (Article 22):**
- We do not make automated decisions with legal or similarly significant effects
- Human review always involved in qualification decisions (intake specialists)

### **12.4 Supervisory Authority**

You have the right to lodge a complaint with your local supervisory authority:

**UAE (our location):**  
Telecommunications and Digital Government Regulatory Authority (TDRA)  
https://tdra.gov.ae

**Your local authority:**  
Find your local authority at: https://edpb.europa.eu/about-edpb/about-edpb/members_en

### **12.5 Data Protection Officer (DPO)**

**Email:** dpo@truevow.com  
**Response Time:** 30 days

### **12.6 International Transfers**

Data may be transferred to the United States and other countries where our sub-processors operate. Transfers are protected by:

- **Standard Contractual Clauses (SCCs)** approved by the European Commission
- **Data Processing Agreements (DPAs)** with all sub-processors
- **Adequacy Decisions** (where applicable)

**Request a copy:** Email privacy@truevow.com

---

## **13. INTERNATIONAL DATA TRANSFERS**

### **13.1 Where Data Is Stored**

**Primary Data Centers:**
- United States (Supabase, AWS, Redis)
- UAE (primary contracting entity location)
- EU (n8n - Germany)

**CDN & Edge Locations:**
- Global (Cloudflare, AWS CloudFront, Fastly)

### **13.2 Transfer Mechanisms**

**From EEA/UK/Switzerland to UAE or USA:**
- Standard Contractual Clauses (SCCs)
- Data Processing Agreements (DPAs)

**From USA to UAE (for billing/contracting):**
- Contractual protections
- Encryption in transit and at rest

**Between Sub-Processors:**
- Each sub-processor has its own DPA/SCC framework
- Listed at https://truevow.law/subprocessors

### **13.3 Data Localization**

We do not currently offer data localization (storage in specific countries). All data is processed globally through our sub-processor network.

**If you require data localization:**
- Contact: enterprise@truevow.com
- May be available for Enterprise customers (custom terms)

---

## **14. CHILDREN'S PRIVACY**

### **14.1 Age Restriction**

**The Services are not intended for individuals under 18 years of age.**

We do not knowingly collect personal information from children under 18 (or 16 in the EEA, or 13 under COPPA).

### **14.2 Parental Notice**

If we become aware that we have collected personal information from a child without parental consent:
- We will delete the information immediately
- We will notify the parent/guardian (if contact information available)
- We will investigate how the information was collected

### **14.3 If You Believe We Have Information About a Child**

**Contact us immediately:**
- Email: privacy@truevow.com
- Subject: "Child Privacy Concern"
- Provide: Child's name, age, date of interaction, any other relevant details

**We will:**
- Investigate within 24 hours
- Delete information within 48 hours (if confirmed)
- Notify you of actions taken

---

## **15. DO NOT TRACK SIGNALS**

### **15.1 Our Policy**

We **do not currently respond** to "Do Not Track" (DNT) browser signals because there is no industry-wide standard for interpreting DNT signals.

### **15.2 Alternative Privacy Controls**

**You can:**
- Block cookies in browser settings
- Use privacy-focused browsers (Brave, Firefox with privacy extensions)
- Opt out of Google Analytics: https://tools.google.com/dlpage/gaoptout
- Adjust cookie preferences: Click "Cookie Settings" in footer

---

## **16. CHANGES TO THIS PRIVACY POLICY**

### **16.1 Update Frequency**

We may update this Privacy Policy:
- To reflect changes in our Services
- To comply with new legal requirements
- To improve clarity or transparency
- To reflect changes in our data practices

### **16.2 Material Changes**

For **material changes** (changes that significantly affect your rights), we will:

1. **Update the "Last Updated" date** at the top of this policy
2. **Notify Customers via email** at least **30 days** before the change takes effect
3. **Display a banner** on truevow.law website
4. **Highlight changes** in red text in the updated policy

**Material changes include:**
- Expanding categories of personal information collected
- Changing purposes for processing
- Sharing with new categories of third parties
- Reducing data security protections
- Changing data retention periods

### **16.3 Non-Material Changes**

For **non-material changes** (clarifications, formatting, minor updates):
- Update the "Last Updated" date
- No advance notice required
- Changes effective immediately upon posting

### **16.4 Your Acceptance**

**Continued use** of the Services after the effective date constitutes acceptance of the updated Privacy Policy.

**If you do not agree** with the changes:
- You may terminate your account at any time (Settings > Account > Delete Account)
- For Customers: 30-day termination notice required (per MSA Section 12.1)

### **16.5 Version History**

**Version 1.0 - November 4, 2025:** Initial release

---

## **17. CONTACT US**

### **17.1 Privacy Inquiries**

**General Privacy Questions:**  
Email: privacy@truevow.com  
Response Time: 5 business days

**Data Subject Rights Requests:**  
Email: privacy@truevow.com  
Subject: "Data Rights Request - [Your Name]"  
Response Time: 30 days (45 days for complex requests)

**Data Protection Officer (EU/GDPR):**  
Email: dpo@truevow.com  
Response Time: 30 days

**Security Incidents:**  
Email: security@truevow.com  
Response Time: 24 hours

### **17.2 Mailing Address**

**TrueVow Global Technologies FZ-LLC**  
Legal Department - Privacy  
Dubai South  
P.O. Box [TBD]  
Dubai, United Arab Emirates

### **17.3 Phone (Enterprise Customers Only)**

Enterprise customers may contact their dedicated account manager for privacy inquiries.

---

## **APPENDIX A: DEFINITIONS**

**Anonymized Data:** Information that cannot be used to identify a specific individual, even with additional information.

**Ancillary ML Tools:** Third-party technologies using machine learning for non-legal, operational purposes only (see Section 7).

**Core Logic:** TrueVow's deterministic, rule-based finite-state machine (FSM) engine. Does not use generative AI or probabilistic models.

**Customer:** Law firm or attorney that subscribes to TrueVow Services.

**End User:** Individual who interacts with Customer's TrueVow-powered intake system (caller, website visitor).

**Personal Information:** Information that identifies, relates to, describes, or could reasonably be linked to a specific individual.

**Sensitive Personal Information (California):** SSN, driver's license, passport, financial account + security code, precise geolocation, race, ethnicity, religion, sexual orientation, genetic data, health data, biometric data.

**Sub-Processor:** Third-party service provider that processes personal data on TrueVow's behalf (see https://truevow.law/subprocessors).

**Zero-Knowledge Architecture:** Technical design that minimizes TrueVow's access to or storage of sensitive personal information by processing data ephemerally and using hash-based caching.

---

## **APPENDIX B: COOKIE TABLE**

| Cookie Name | Type | Purpose | Duration | Can Opt Out? |
|-------------|------|---------|----------|--------------|
| `_truevow_session` | Essential | Maintain login session | Session (closes browser) | No |
| `_truevow_csrf` | Essential | CSRF attack prevention | Session | No |
| `_ga` | Analytics | Google Analytics (anonymized) | 2 years | Yes |
| `_gid` | Analytics | Google Analytics (anonymized) | 24 hours | Yes |
| `_truevow_prefs` | Preferences | Language, settings | 1 year | Yes |
| `cookie_consent` | Preferences | Remember cookie choices | 1 year | Yes |

**Manage Cookies:** Click "Cookie Settings" in footer or email privacy@truevow.com

---

## **APPENDIX C: SUB-PROCESSOR SUMMARY**

**Complete, up-to-date list with legal links:**  
https://truevow.law/subprocessors

**Categories:**
1. Speech AI & Voice Processing (5 vendors)
2. Authentication & Identity (2 vendors)
3. Database & Caching (3 vendors)
4. Workflow Automation (2 vendors)
5. CDN & Edge Computing (3 vendors)
6. Monitoring & Observability (3 vendors)
7. DevOps & Development Tools (3 vendors)
8. Object Storage - Opt-In Only (1 vendor)

**Data Processing Agreements (DPAs):** Available upon request to enterprise@truevow.com

---

**END OF PRIVACY POLICY**

**© 2025 TrueVow Global Technologies FZ-LLC (UAE)**  
*Last Updated: November 4, 2025 | Version 1.0*

---

**Questions?** Email: privacy@truevow.com | Visit: https://truevow.law/privacy

