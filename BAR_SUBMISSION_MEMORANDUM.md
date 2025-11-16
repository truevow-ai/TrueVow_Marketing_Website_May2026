# TrueVow Bar Compliance Memorandum

**To:** State Bar Committee on Professional Ethics / Law Firm Compliance Officer  
**From:** TrueVow Global Technologies FZ-LLC  
**Date:** January 8, 2026  
**Re:** Ethical Compliance of the TrueVow Deterministic Legal Practice Automation Platform (INTAKE™, DRAFT™, SETTLE™, CONNECT™ & VERIFY™)

---

## 1. Executive Summary

TrueVow is a **deterministic, rule-based software automation platform** designed exclusively for licensed attorneys. It functions as a **non-lawyer assistant** under Model Rule 5.3, providing intake, drafting, and settlement benchmarking services.

The platform's core technology is a **Finite State Machine (FSM) engine** that is explicitly **not generative artificial intelligence (AI)**. It does not learn, adapt, or make probabilistic judgments.

This memorandum outlines how a law firm's use of each TrueVow service—**INTAKE, DRAFT, SETTLE, CONNECT, and VERIFY**—complies with key professional responsibility mandates, including the duty of supervision, confidentiality, conflicts checking, and the prohibition against the unauthorized practice of law (UPL).

**Key Finding:** TrueVow is engineered from the ground up to be an ethically compliant tool that empowers lawyers to run more efficient and effective practices. Each product is structured not to replace attorney judgment, but to augment it under their direct supervision.

---

## 2. Core Technology: Distinction from Generative AI

### 2.1 Deterministic vs. Probabilistic Systems

| Feature | TrueVow (Deterministic) | Generative AI (Probabilistic) |
|---------|------------------------|-------------------------------|
| **Operation** | Pre-defined, attorney-configured rules and decision trees | Machine learning generating novel content from training data |
| **Output** | Predictable, repeatable for same input | Non-deterministic, varies with each query |
| **Legal Decisions** | Cannot create new arguments or provide strategic advice | May generate novel legal arguments (accuracy uncertain) |
| **Hallucinations** | Not possible (executes only configured rules) | Frequent (may invent cases, citations, facts) |
| **Transparency** | Fully auditable, exact logic path traceable | "Black box" — path to output unclear |

### 2.2 The "Core Logic" Guarantee

The platform's qualification, routing, document assembly, and data visualization functions are governed by its **Core Logic**, which is a rules-based FSM. This Core Logic is expressly walled off from any ancillary machine-learning tools used for non-legal, operational tasks (e.g., speech-to-text transcription).

**Ancillary ML Tools** (e.g., Fast Whisper, DeepGram, ElevenLabs, Silero VAD) are used **solely** for:
- Speech-to-text transcription (audio → text)
- Text-to-speech synthesis (text → audio)
- Voice activity detection (silence detection)
- OAuth authentication
- Database operations

**These tools do not participate in, influence, or affect any legal or quasi-legal determination.**

---

## 3. Product-Specific Ethical Analysis & Safeguards

### 3.1 TrueVow INTAKE™ (Lead Qualification & Scheduling)

**Function:** Answers calls 24/7, conducts a structured interview based on firm-defined rules, and schedules consultations with qualified leads.

**Ethical Compliance:**

| Risk | Safeguard | Rule Compliance |
|------|-----------|-----------------|
| **UPL (Rule 5.5)** | System provides no legal advice; collects information based on attorney-approved script | ✅ Compliant |
| **Confidentiality (Rule 1.6)** | Default "zero-retention" — no call audio/transcripts stored; 7-day opt-in encrypted, firm assumes all risk | ✅ Compliant |
| **Supervision (Rule 5.3)** | Attorney configures all questions and criteria; output is summary for attorney review before client relationship formed | ✅ Compliant |

**Required Script Language:**
> "Thank you for calling [Firm Name]. I am an automated intake assistant, not a lawyer. No attorney-client relationship is created until you sign a written fee agreement and we confirm no conflicts. If you proceed, this call may be recorded for quality purposes."

---

### 3.2 TrueVow DRAFT™ (Document Assembly)

**Function:** Assembles initial drafts of legal documents (e.g., demand letters, pleadings) from attorney-configured templates and data inputs.

**Ethical Compliance:**

| Risk | Safeguard | Rule Compliance |
|------|-----------|-----------------|
| **Competence (Rule 1.1)** | All documents labeled "DRAFT ONLY"; attorney bears non-delegable duty to review, edit, certify before filing | ✅ Compliant |
| **UPL (Rule 5.5)** | System applies attorney-defined logic; does not conduct legal research or generate novel arguments | ✅ Compliant |
| **Malpractice** | Signature block lock-out (forces review); citation audit required; watermark on every page | ✅ Compliant |

**Mandatory Watermark:**
> "DRAFT – FOR ATTORNEY REVIEW ONLY. NOT FILED. NO WARRANTY OF ACCURACY. TRUEVOW IS NOT RESPONSIBLE FOR SUBSEQUENT EDITS."

**Critical Warning:**
> **Reliance on DRAFT™ without independent attorney review is a breach of the ethical duty of competence.**

---

### 3.3 TrueVow SETTLE™ (Settlement Benchmarking)

**Function:** Visualizes historical settlement ranges from public dockets and anonymized contributions.

**Ethical Compliance:**

| Risk | Safeguard | Rule Compliance |
|------|-----------|-----------------|
| **Communication (Rule 1.4)** | Attorney must disclose to client that data is historical, not predictive; no guarantee of outcome | ✅ Compliant |
| **Competence (Rule 1.1)** | Tool informs attorney's independent professional judgment; does not replace negotiation strategy | ✅ Compliant |
| **Confidentiality (Rule 1.6)** | Anonymous database; all PII/PHI stripped; no client identifiers stored | ✅ Compliant |

**Prohibited Actions:**
- ❌ Never attach SETTLE report to pleadings (violates MR 3.3, waives work-product)
- ❌ Never input client-specific medical specials or lost-wage figures
- ❌ Never represent settlement data as predictions or guarantees to clients

**Required Client Disclosure:**
> "The enclosed ranges are **not** a guarantee, promise, or estimation of your recovery. Many factors — liability, comparative fault, venue, your credibility — can move the result outside the displayed bands."

---

### 3.4 TrueVow CONNECT™ (Referral Network — Pre-Launch)

**Function:** Upon launch, will facilitate referrals of cases to other law firms or medical providers within the network.

**Ethical Compliance:**

| Risk | Safeguard | Rule Compliance |
|------|-----------|-----------------|
| **Fee Sharing (Rule 5.4, 1.5(e))** | TrueVow does not participate in fee splits; referring/receiving attorneys solely responsible for written agreement + client consent | ✅ Compliant |
| **Conflicts (Rule 1.7)** | Referring and receiving firms solely responsible for independent conflicts checks | ✅ Compliant |
| **UPL (Rule 5.5)** | TrueVow provides directory only; attorneys make professional decision to refer/accept | ✅ Compliant |

**Pre-Launch Requirement:**
> **Do not use CONNECT until officially launched and state-approved.** Requires pre-clearance from state bars (e.g., FL Bar Ethics Opinion 24-1).

---

### 3.5 TrueVow VERIFY™ (Cryptographic Proof of Action)

**Function:** Generates an immutable, timestamped, cryptographic certificate (via OpenTimestamps) for key actions within the platform.

**Ethical Value:**
- **Demonstration of Due Diligence:** Provides verifiable proof that an action occurred at a specific time
- **Malpractice Defense:** Can prove draft creation/review occurred before filing deadline
- **Bar Investigation Support:** Can demonstrate adherence to processes and timelines

**Limitation:**
> VERIFY proves the **technical integrity** of the vendor's data handling process (Zero-Knowledge), but **does not absolve the attorney** of primary ethical duties to maintain confidentiality and professional privilege.

---

## 4. Overarching Compliance with ABA Model Rules

### 4.1 Rule 5.3 (Nonlawyer Assistance)
TrueVow, in its entirety, is a tool that requires **active attorney supervision**. The attorney configures it, directs its use, and reviews all outputs.

**Compliance Mechanism:**
- Designated "TrueVow Supervisory Partner" (TSP) in writing
- Quarterly attestations of compliance
- Monthly script audits
- Documented CLE attendance on technology competence

### 4.2 Rule 1.1 (Competence)
TrueVow enhances competence by ensuring systematic processes and 24/7 availability. The attorney's duty is fulfilled by their **mandatory review and application of independent professional judgment** to all platform outputs.

### 4.3 Rule 1.6 (Confidentiality)
The platform's "zero-knowledge" default and encrypted opt-in retention, combined with vendor DPAs, provide a robust framework for protecting client confidences.

**Privilege Preservation:**
- Federal Rule of Evidence 502(d) protections invoked
- Common-interest doctrine applies
- Limited waiver for purpose of facilitating legal services
- TrueVow asserts privilege if subpoenaed

### 4.4 Rule 5.5 (Unauthorized Practice of Law)
None of TrueVow's services constitute the practice of law. They automate administrative and preparatory tasks under the direct control and supervision of a licensed attorney.

**"Attorney-in-the-Loop" Principle:**
All critical functions require attorney oversight. TrueVow performs administrative and preparatory tasks, the final product of which is always subject to attorney review, revision, and approval.

---

## 5. Fee Structure & Rule 5.4 Compliance (No Fee-Sharing)

### 5.1 TrueVow's Pricing Model
TrueVow charges **flat fees for services rendered**, not a percentage of legal fees:
- **$29 per Qualified Booking** (intake service)
- **$49 per Settlement Report** (data visualization)
- **19% of document list price** (document assembly service — fee for software, not share of legal fees)

### 5.2 Not a Referral Fee
TrueVow's pay-per-qualified-booking model is **not a referral fee**; it is a **bona fide charge for automated clerical services**.

### 5.3 Analogous Bar Approvals
- **ABA Formal Op. 474 (2017):** Permissible to pay lead-gen company that does not recommend lawyer
- **Florida Bar Op. A-22-1 (2022):** Pay-per-call allowed if no exercise of judgment
- **Texas Prof. Ethics Op. 673:** Same

### 5.4 No Contingency, No Fee-Sharing
TrueVow receives **no portion of**:
- Attorney contingency fees
- Client settlements or judgments
- Retainer fees
- Hourly billing revenue

---

## 6. Confidentiality & Data Security

### 6.1 Zero-Knowledge Architecture
By default, TrueVow **does not store**:
- Call audio or transcripts
- Personally identifiable information (PII)
- Protected health information (PHI)
- Social Security Numbers
- Financial account details

**Ephemeral Processing:** Data is processed in memory for the purpose of completing a specific task and is then discarded.

### 6.2 Optional 7-Day Retention
Attorneys may opt-in to 7-day retention of call recordings and transcripts (encrypted). **The attorney assumes all risk and responsibility for this choice**, including compliance with recording consent laws.

### 6.3 Encryption & Security
- **AES-256-GCM encryption** at rest
- **TLS 1.3 encryption** in transit
- **SHA-256 hashing** for cached data (no plaintext storage)
- **SOC 2 Type II aligned controls** (annual audits)

### 6.4 Sub-Processors
All sub-processors are listed at https://truevow.law/subprocessors with full transparency regarding data processing activities. All are bound by Data Processing Agreements (DPAs) and Standard Contractual Clauses (SCCs).

---

## 7. Attorney Responsibilities & Indemnification

By using TrueVow, attorneys **acknowledge and agree** they are solely responsible for:

1. **Supervising** TrueVow as a nonlawyer assistant (Rule 5.3)
2. **Verifying** all outputs before client use (Rule 1.1)
3. **Complying** with state-specific rules on:
   - Recording consent
   - Advertising disclosures
   - Conflicts of interest
   - Fee arrangements
4. **Disclosing** to clients that non-legal, operational tools may be used in intake (per Rule 1.4)

**Comprehensive Indemnification (MSA Section 11.2):**

The attorney indemnifies TrueVow against all claims arising from:
- Ethics complaints to state bar associations
- Bar grievances or disciplinary proceedings
- Unauthorized practice of law (UPL) allegations
- Malpractice, negligence, or professional misconduct
- Failure to supervise or review outputs
- Recording-consent violations
- Conflicts of interest failures
- Fee-splitting violations
- Failure to disclose TrueVow usage to clients (where required)
- Any other violation of professional conduct rules

**Conditional Use:**
> The use of the TrueVow platform is **conditional** upon the attorney's acceptance of this explicit assumption of all professional and ethical liability.

---

## 8. Conclusion

TrueVow is engineered from the ground up to be an ethically compliant tool that empowers lawyers to run more efficient and effective practices. It is structured not to replace attorney judgment, but to augment it under their direct supervision.

By adhering to the principles of:
- **Determinism** (no AI in legal functions)
- **Attorney control** (full configuration and oversight)
- **Zero-knowledge architecture** (no persistent sensitive data)
- **Comprehensive indemnification** (attorney assumes all liability)

...a law firm can leverage TrueVow to enhance its client intake and operational efficiency while fully complying with its professional ethical obligations.

**TrueVow assumes ZERO liability for attorney professional conduct, ethical compliance, or client outcomes. All risk rests with the attorney.**

---

## Attachments

1. TrueVow Master Services Agreement (MSA)
2. TrueVow Terms of Service (Terms)
3. TrueVow Privacy Policy
4. TrueVow Bar Compliance & Ethical Usage Guide (Complete)
5. Sub-Processor List (https://truevow.law/subprocessors)

---

**Disclaimer:** *This memorandum is for informational purposes and does not constitute legal advice. Each law firm is responsible for ensuring its use of technology complies with the specific rules and opinions of its jurisdiction's bar association. TrueVow makes no guarantee of bar approval.*

---

**Prepared by:** TrueVow Legal Team  
**Contact:** compliance@truevow.law  
**Website:** https://truevow.law/bar-compliance

