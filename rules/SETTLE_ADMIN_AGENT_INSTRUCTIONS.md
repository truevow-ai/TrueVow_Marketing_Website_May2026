# 🎛️ SETTLE Module - SaaS Administration Agent Instructions

**Created:** January 2026  
**Last Updated:** December 5, 2025  
**Purpose:** Comprehensive instructions for SaaS administration application agent to manage SETTLE services in conjunction with all other TrueVow modules  
**Status:** 🚧 In Development - Integration Phase

---

## 🆕 **RECENT PROGRESS UPDATE (December 5, 2025)**

### **✅ What's Been Completed:**

1. **SETTLE Service Repository Created**
   - **Location:** `../2025-TrueVow-Settle-Service/` (separate repository)
   - **Status:** Initial structure, FastAPI app, API endpoints (placeholders)
   - **Architecture:** Centralized service (not per-tenant), separate from Tenant App

2. **Tenant App Integration Complete**
   - **Location:** `../2025-TrueVow-Tenant-Application/app/services/integrations/settle/`
   - **Files Created:**
     - `client.py` - HTTP client for SETTLE API
     - `service.py` - High-level service for lead integration
     - `app/api/v1/endpoints/settle.py` - API endpoint (`POST /api/v1/settle/estimate`)
   - **Configuration:** Added `SETTLE_API_URL` and `SETTLE_API_KEY` to config
   - **Feature Flag:** `enable_settlement_intel` (currently `false`)

3. **Documentation Updated**
   - Part 7 of main documentation: Complete SETTLE module specs
   - Architecture document: Revised to separate service architecture
   - Integration points: Added SETTLE service integration section

4. **Production-Ready Schema Defined**
   - Table: `settle_contributions` (final production schema)
   - All fields use drop-downs (no free-text)
   - Outcome amounts bucketed (e.g., "$300k-$600k")
   - Blockchain hashing (OpenTimestamps) included

### **⚠️ What SaaS Admin Needs to Build:**

1. **SETTLE Service Management API Endpoints** (Priority 1)
2. **Founding Member Management System** (Priority 2)
3. **Contribution Approval/Rejection Workflow** (Priority 3)
4. **SETTLE Analytics Dashboard** (Priority 4)
5. **API Key Management for SETTLE** (Priority 5)

---

## 📋 Table of Contents

1. [Overview & Integration](#overview--integration)
2. [SETTLE Module Configuration](#settle-module-configuration)
3. [Data Contribution Management](#data-contribution-management)
4. [Compliance Monitoring & Enforcement](#compliance-monitoring--enforcement)
5. [User Access & Permissions](#user-access--permissions)
6. [Data Aggregation & Anonymization](#data-aggregation--anonymization)
7. [Blockchain Verification Management](#blockchain-verification-management)
8. [Reporting & Analytics](#reporting--analytics)
9. [Integration with Other Modules](#integration-with-other-modules)
10. [Operational Procedures](#operational-procedures)
11. [Emergency Procedures](#emergency-procedures)
12. [Audit & Compliance Logging](#audit--compliance-logging)

---

## 1. Overview & Integration

### 1.1 SETTLE Module Purpose

**TrueVow SETTLE™** is a settlement data visualization and benchmarking tool that:
- Displays historical settlement ranges from public court dockets and anonymized attorney contributions
- Provides county-level, injury-type-specific settlement data
- Operates as a **data analysis and visualization tool** (NOT a prediction engine)
- Complies with ABA Model Rule 1.6, HIPAA, DOJ 2023 Antitrust Guidelines, and state bar ethics opinions

### 1.2 Integration with Other Modules

SETTLE integrates with:
- **INTAKE™:** Attorneys can query SETTLE ranges during intake calls to inform case qualification
  - **Status:** ✅ Integration code complete in Tenant App
  - **Endpoint:** `POST /api/v1/settle/estimate` (Tenant App)
  - **Calls:** `POST https://settle.truevow.law/api/v1/query/estimate` (SETTLE Service)
- **DRAFT™:** Settlement ranges can be referenced in demand letters (attorney must manually include)
- **VERIFY™:** Each SETTLE contribution generates blockchain hash via OpenTimestamps
- **CONNECT™:** Settlement data can inform referral decisions (attorney judgment only)

### 1.3 Architecture Update (CRITICAL)

**SETTLE is a SEPARATE SERVICE, not part of Tenant App:**
- **Repository:** `2025-TrueVow-Settle-Service/` (separate repository)
- **Database:** Centralized database (shared across all users)
- **Access:** Open to customers AND non-customers (via API keys)
- **Deployment:** Shared service (one container), not per-tenant

**Why Separate:**
- Centralized database needed (all settlements in one place)
- Open to non-customers (Founding Members, external users)
- Different access patterns than tenant-specific Intake
- SaaS Admin manages centrally, not per-tenant

### 1.4 Admin Agent Responsibilities

The SaaS administration agent must:
1. ✅ **Manage SETTLE Service API Integration** - Call SETTLE service APIs for management
2. ✅ **Manage SETTLE module access per subscription tier** - Enable/disable per tenant
3. ✅ **Monitor data contribution compliance** - Approve/reject contributions via SETTLE API
4. ✅ **Enforce 15-case minimum aggregation threshold** - Monitor via SETTLE service
5. ✅ **Track blockchain verification** - Verify OpenTimestamps hashes
6. ✅ **Monitor compliance violations** - HIPAA, ABA Rule 1.6, Antitrust
7. ✅ **Generate compliance reports** - For bar committees
8. ✅ **Manage Founding Member program** - Track 2,100 attorneys, 1-3 contributions/month
9. ✅ **Manage API keys** - Issue SETTLE API keys to tenants
10. ✅ **Integrate with usage metering and billing** - Track SETTLE report usage
11. ✅ **View SETTLE analytics** - Contribution stats, usage metrics, data quality

### 1.5 What SaaS Admin Must Build (Implementation Checklist)

**Priority 1: SETTLE Service API Client** 🔴
- [ ] Create HTTP client to call SETTLE service APIs
- [ ] Implement authentication (API key from SETTLE service)
- [ ] Error handling and retry logic
- [ ] Location: `app/services/integrations/settle/client.py` (or similar)

**Priority 2: Contribution Management** 🟡
- [ ] API endpoint: `POST /api/admin/settle/contributions/approve`
- [ ] API endpoint: `POST /api/admin/settle/contributions/reject`
- [ ] API endpoint: `GET /api/admin/settle/contributions/pending`
- [ ] UI: Admin dashboard for reviewing contributions
- [ ] PII detection alerts

**Priority 3: Founding Member Management** 🟢
- [ ] Track 2,100 Founding Members (not 1,123)
- [ ] Monitor monthly contributions (1-3 per month requirement)
- [ ] API endpoint: `GET /api/admin/settle/founding-members`
- [ ] API endpoint: `POST /api/admin/settle/founding-members/{id}/status`
- [ ] UI: Founding Member dashboard with contribution tracking

**Priority 4: API Key Management** 🔵
- [ ] Issue SETTLE API keys to tenants
- [ ] Store keys in `tenant_integrations` table
- [ ] Rotate keys on demand
- [ ] Track key usage per tenant
- [ ] UI: API key management interface

**Priority 5: Analytics & Reporting** 🟣
- [ ] Dashboard: SETTLE usage metrics
- [ ] Dashboard: Contribution statistics
- [ ] Dashboard: Compliance monitoring
- [ ] Reports: Bar compliance reports
- [ ] Reports: Data quality metrics

**Priority 6: Integration with SETTLE Service** 🟠
- [ ] Call SETTLE service: `POST /api/v1/admin/approve-contribution`
- [ ] Call SETTLE service: `GET /api/v1/admin/analytics`
- [ ] Call SETTLE service: `GET /api/v1/admin/founding-members`
- [ ] Call SETTLE service: `POST /api/v1/admin/api-keys/create`

---

## 2. SETTLE Module Configuration

### 2.1 Subscription Plan Integration

**Database Tables:**
- `subscription_plans.module_settle_enabled` (BOOLEAN)
- `subscription_tenants` (links tenant to plan)

**Configuration Rules:**

```sql
-- Check if tenant has SETTLE access
SELECT 
    t.tenant_id,
    t.firm_name,
    sp.module_settle_enabled,
    st.status as subscription_status
FROM tenant_accounts t
JOIN subscription_tenants st ON t.tenant_id = st.tenant_id
JOIN subscription_plans sp ON st.plan_id = sp.plan_id
WHERE t.tenant_id = '[TENANT_UUID]'
  AND st.status = 'active'
  AND sp.module_settle_enabled = TRUE;
```

**Admin Actions:**
1. **Enable SETTLE for tenant:**
   ```sql
   -- Option 1: Update plan to enable SETTLE
   UPDATE subscription_plans
   SET module_settle_enabled = TRUE
   WHERE plan_id = '[PLAN_UUID]';
   
   -- Option 2: Create custom plan override (if needed)
   INSERT INTO subscription_tenants (tenant_id, plan_id, status, ...)
   VALUES ('[TENANT_UUID]', '[SETTLE_ENABLED_PLAN_UUID]', 'active', ...);
   ```

2. **Disable SETTLE for tenant:**
   ```sql
   -- Suspend subscription or change plan
   UPDATE subscription_tenants
   SET status = 'suspended'
   WHERE tenant_id = '[TENANT_UUID]';
   ```

### 2.2 Feature Flags

**Table:** `system_feature_flags`

**SETTLE-Specific Flags:**
- `settle_contributions_enabled` - Global toggle for data contributions
- `settle_reports_enabled` - Global toggle for report generation
- `settle_blockchain_verification` - Enable/disable OpenTimestamps
- `settle_founding_member_program` - Enable/disable Founding Member benefits

**Admin Actions:**
```sql
-- Enable SETTLE contributions globally
UPDATE system_feature_flags
SET is_enabled_globally = TRUE,
    is_active = TRUE
WHERE flag_key = 'settle_contributions_enabled';

-- Enable for specific tier only
UPDATE system_feature_flags
SET enabled_for_tiers = ARRAY['enterprise', 'pro'],
    is_enabled_globally = FALSE
WHERE flag_key = 'settle_reports_enabled';
```

### 2.3 Configuration Parameters

**Critical Settings:**
- **Minimum Aggregation Threshold:** 15 cases (MANDATORY - cannot be changed)
- **Anonymization Verification:** Required for all contributions
- **Blockchain Verification:** Enabled by default (OpenTimestamps)
- **Data Retention:** Aggregated statistics only (no individual case data)
- **PII Detection:** Real-time scanning enabled

---

## 3. Data Contribution Management

### 3.1 Contribution Workflow (UPDATED - 3-Minute Form)

**Step 1: Attorney Submits Contribution**
- Attorney fills **3-minute form** with 5 steps:
  1. Venue & Case Type (county dropdown, case type dropdown)
  2. Injury & Treatment Snapshot (injury category, treatment type, duration, imaging)
  3. Financial Snapshot (medical bills, lost wages, policy limits)
  4. Liability Context (defendant category - SAFE VERSION, no fault questions)
  5. Outcome Type (for contributors only - outcome type, outcome amount range)
- **All fields use drop-downs** (no free-text input)
- Client-side anonymization occurs BEFORE transmission
- System generates contribution hash (SHA-256)

**Step 2: SETTLE Service Receives Contribution**
- SETTLE service validates and stores in `settle_contributions` table
- Outcome amounts are **bucketed** (e.g., "$300k-$600k" not exact amounts)
- SETTLE service flags for admin review if needed

**Step 3: SaaS Admin Reviews Contribution**
- SaaS Admin calls SETTLE service: `GET /api/v1/admin/contributions/pending`
- Review flagged contributions (outliers, PII detection, etc.)
- Approve: `POST /api/v1/admin/contributions/{id}/approve`
- Reject: `POST /api/v1/admin/contributions/{id}/reject`

**Step 4: Storage & Aggregation (SETTLE Service)**
- SETTLE service stores in `settle_contributions` table
- Immediately aggregate with existing data
- Generate blockchain hash (OpenTimestamps)
- Update attorney contribution count

**Step 5: Compliance Check (SaaS Admin Monitoring)**
- SaaS Admin monitors via SETTLE service analytics API
- Verify 15-case minimum for query results
- Flag outliers for manual review
- Log contribution in audit trail

### 3.2 Contribution Validation Rules (UPDATED - Production Schema)

**Allowed Fields ONLY (from `settle_contributions` table):**
- `jurisdiction` (TEXT) - County/Venue (ALL US COUNTIES dropdown)
- `case_type` (TEXT) - Car Accident | Slip & Fall | Dog Bite | Product Defect | Medical Injury | Other
- `injury_category` (TEXT[]) - Multi-select: Soft Tissue | Fracture | Concussion | Spinal Injury | Surgical Injury | Other
- `primary_diagnosis` (TEXT) - Drop-down (120+ options, optional)
- `treatment_type` (TEXT[]) - Multi-select: ER Visit | Urgent Care | Chiropractic | Physical Therapy | Injection(s) | Surgery | None
- `duration_of_treatment` (TEXT) - Drop-down: <1 Month | 1–3 Months | 3–6 Months | 6+ Months
- `imaging_findings` (TEXT[]) - Multi-select: X-Ray | MRI | CT | None
- `medical_bills` (NUMERIC) - Total medical bills
- `lost_wages` (NUMERIC) - Lost wages (optional)
- `policy_limits` (TEXT) - Drop-down: 15/30 | 25/50 | 50/100 | 100/300 | 250/500 | Umbrella | Unknown
- `defendant_category` (TEXT) - Drop-down: Retail Store | Apartment Complex | Rideshare | Commercial Truck | Private Property | Government Entity | Other
- `outcome_type` (TEXT) - Settlement | Arbitration | Mediation | Jury Verdict
- `outcome_amount_range` (TEXT) - **BUCKETED**: $0-$50k | $50k-$100k | $100k-$300k | $300k-$600k | $600k-$1M | $1M+

**⚠️ CRITICAL:** All fields use drop-downs or multi-select. NO free-text input allowed.

**FORBIDDEN Fields (Auto-Reject):**
- ❌ `client_name`, `plaintiff_name`, `defendant_name`
- ❌ `case_number`, `docket_number`
- ❌ `address`, `phone`, `email`, `ssn`, `dob`
- ❌ `medical_record_number`, `diagnosis`, `cpt_code`, `icd_code`
- ❌ `narrative`, `description`, `notes`
- ❌ `photos`, `evidence`, `police_report`

### 3.3 Admin Monitoring Queries

**Query 1: Recent Contributions (Last 24 Hours)**
```python
# SaaS Admin calls SETTLE service API
GET https://settle.truevow.law/api/v1/admin/contributions/recent?hours=24
Authorization: Bearer {saas_admin_settle_api_key}

# Response from SETTLE service:
{
    "contributions": [
        {
            "id": "uuid",
            "created_at": "2025-12-05T10:30:00Z",
            "injury_category": ["Spinal Injury"],
            "jurisdiction": "Maricopa County, AZ",
            "outcome_amount_range": "$300k-$600k",
            "blockchain_hash": "abc123...",
            "consent_confirmed": true,
            "attorney_id": "uuid",
            "status": "pending_review"  # or "approved", "rejected"
        }
    ]
}
```

**⚠️ NOTE:** SaaS Admin does NOT query SETTLE database directly. All queries go through SETTLE service API.

**Query 2: Contributions Pending Review**
```sql
SELECT 
    c.id,
    c.created_at,
    c.settlement_amount,
    c.medical_bills,
    c.contribution_hash,
    a.email as attorney_email
FROM case_bank_entries c
JOIN attorneys a ON c.created_by_attorney = a.id
WHERE c.anonymization_verified = FALSE
   OR c.settlement_amount > c.medical_bills * 50  -- Outlier flag
ORDER BY c.created_at DESC;
```

**Query 3: Attorney Contribution Counts**
```sql
SELECT 
    a.email,
    a.bar_number,
    COUNT(c.id) as total_contributions,
    COUNT(CASE WHEN c.created_at >= DATE_TRUNC('month', CURRENT_DATE) THEN 1 END) as monthly_contributions,
    MIN(c.created_at) as first_contribution,
    MAX(c.created_at) as last_contribution
FROM attorneys a
LEFT JOIN case_bank_entries c ON a.id = c.created_by_attorney
GROUP BY a.id, a.email, a.bar_number
HAVING COUNT(c.id) > 0
ORDER BY total_contributions DESC;
```

### 3.4 Manual Review Procedures

**When to Flag for Review:**
1. Settlement amount > 50× medical bills (possible error)
2. `anonymization_verified = FALSE`
3. Missing required fields
4. Invalid state/county combinations
5. Suspicious patterns (50+ contributions/week from single attorney)

**Review Actions:**
```sql
-- Approve contribution
UPDATE case_bank_entries
SET anonymization_verified = TRUE,
    updated_at = NOW()
WHERE id = '[CONTRIBUTION_UUID]';

-- Reject contribution (with reason)
UPDATE case_bank_entries
SET anonymization_verified = FALSE,
    rejection_reason = 'Settlement amount exceeds 50× medical bills - possible data entry error'
WHERE id = '[CONTRIBUTION_UUID]';

-- Delete contribution (if PII detected)
DELETE FROM case_bank_entries
WHERE id = '[CONTRIBUTION_UUID]';
-- NOTE: Also log in audit trail and notify attorney
```

---

## 4. Compliance Monitoring & Enforcement

### 4.1 ABA Rule 1.6 Compliance

**Monitoring Requirements:**
- ✅ Verify no "information relating to representation" is collected
- ✅ Confirm client consent obtained (via engagement letter clause)
- ✅ Ensure 15-case minimum aggregation prevents re-identification

**Admin Queries:**
```sql
-- Check for potential Rule 1.6 violations (narrative fields)
SELECT 
    c.id,
    c.created_at,
    a.email as attorney_email
FROM case_bank_entries c
JOIN attorneys a ON c.created_by_attorney = a.id
WHERE c.description IS NOT NULL
   OR c.narrative IS NOT NULL
   OR c.notes IS NOT NULL;
-- Should return ZERO rows
```

**Enforcement Actions:**
- **Immediate:** Reject contribution, notify attorney
- **Escalation:** Suspend attorney's SETTLE access if repeated violations
- **Documentation:** Log in `system_audit_log` with category `compliance_aba_rule_1_6`

### 4.2 HIPAA Compliance

**Monitoring Requirements:**
- ✅ Verify no PHI collected (diagnoses, medical records, CPT/ICD codes)
- ✅ Confirm only generic injury categories stored
- ✅ Check for medical record numbers or patient identifiers

**Admin Queries:**
```sql
-- Check for potential HIPAA violations
SELECT 
    c.id,
    c.created_at,
    a.email as attorney_email
FROM case_bank_entries c
JOIN attorneys a ON c.created_by_attorney = a.id
WHERE c.diagnosis IS NOT NULL
   OR c.cpt_code IS NOT NULL
   OR c.icd_code IS NOT NULL
   OR c.medical_record_number IS NOT NULL;
-- Should return ZERO rows
```

**Enforcement Actions:**
- **Immediate:** Delete contribution, notify attorney of HIPAA violation
- **Escalation:** Report to compliance officer, suspend attorney access
- **Documentation:** Log in `system_audit_log` with category `compliance_hipaa`

### 4.3 Antitrust Compliance (DOJ 2023 Guidelines)

**Monitoring Requirements:**
- ✅ Verify no defendant-specific filters
- ✅ Confirm no insurer-specific filters
- ✅ Check for price-fixing enabling features
- ✅ Ensure open access (not collusion)

**Admin Queries:**
```sql
-- Check for potential antitrust violations (defendant names)
SELECT 
    c.id,
    c.created_at,
    a.email as attorney_email
FROM case_bank_entries c
JOIN attorneys a ON c.created_by_attorney = a.id
WHERE c.defendant_name IS NOT NULL
   OR c.insurer_name IS NOT NULL;
-- Should return ZERO rows
```

**Enforcement Actions:**
- **Immediate:** Reject contribution, notify attorney
- **Escalation:** Legal review, potential suspension
- **Documentation:** Log in `system_audit_log` with category `compliance_antitrust`

### 4.4 State Bar Opinions Compliance

**Verified Precedents:**
- California Formal Op. 2021-206 (2021)
- New York Ethics Op. 2019-4
- Florida Advisory Op. 21-1
- Texas Ethics Op. 679

**Admin Responsibilities:**
- Monitor contributions for compliance with state-specific requirements
- Generate compliance reports for bar committees upon request
- Maintain audit trail of all compliance checks

---

## 5. User Access & Permissions

### 5.1 SETTLE Access Levels

**Tier 1: Free Trial Users**
- ✅ Can generate SETTLE reports (limited to 11 free reports)
- ❌ Cannot contribute data (Founding Member program only)

**Tier 2: Standard Users**
- ✅ Can generate SETTLE reports ($49/report)
- ❌ Cannot contribute data

**Tier 3: Founding Members**
- ✅ Unlimited SETTLE reports (FREE forever)
- ✅ Can contribute data (1-3 cases/month minimum)
- ✅ Free TrueVow Intake™ (Benjamin) included
- ✅ Lifetime price lock ($0 forever)
- ✅ Priority support
- ✅ Early access to new features
- ✅ **Limited to 2,100 attorneys** (not 1,123)

**Tier 4: Enterprise**
- ✅ Unlimited SETTLE reports
- ✅ Can contribute data
- ✅ API access
- ✅ Custom reporting

### 5.2 Access Control Queries

**Check Tenant SETTLE Access:**
```sql
SELECT 
    t.tenant_id,
    t.firm_name,
    sp.plan_name,
    sp.module_settle_enabled,
    st.status as subscription_status,
    CASE 
        WHEN sp.plan_slug = 'free-trial' THEN 'Tier 1: Free Trial'
        WHEN sp.plan_slug = 'basic' THEN 'Tier 2: Standard'
        WHEN sp.plan_slug = 'pro' THEN 'Tier 3: Founding Member'
        WHEN sp.plan_slug = 'enterprise' THEN 'Tier 4: Enterprise'
        ELSE 'Unknown'
    END as access_tier
FROM tenant_accounts t
JOIN subscription_tenants st ON t.tenant_id = st.tenant_id
JOIN subscription_plans sp ON st.plan_id = sp.plan_id
WHERE t.tenant_id = '[TENANT_UUID]'
  AND st.status = 'active';
```

**Check Attorney Contribution Eligibility:**
```sql
SELECT 
    a.id,
    a.email,
    a.bar_number,
    t.tenant_id,
    sp.plan_slug,
    CASE 
        WHEN sp.plan_slug IN ('pro', 'enterprise') THEN TRUE
        WHEN EXISTS (
            SELECT 1 FROM founding_members fm 
            WHERE fm.attorney_id = a.id 
            AND fm.status = 'active'
        ) THEN TRUE
        ELSE FALSE
    END as can_contribute
FROM attorneys a
JOIN tenant_users tu ON a.id = tu.user_id
JOIN tenant_accounts t ON tu.tenant_id = t.tenant_id
JOIN subscription_tenants st ON t.tenant_id = st.tenant_id
JOIN subscription_plans sp ON st.plan_id = sp.plan_id
WHERE a.id = '[ATTORNEY_UUID]'
  AND st.status = 'active';
```

### 5.3 Access Management Actions

**Grant SETTLE Access:**
```sql
-- Enable SETTLE for tenant
UPDATE subscription_plans
SET module_settle_enabled = TRUE
WHERE plan_id = (
    SELECT plan_id FROM subscription_tenants 
    WHERE tenant_id = '[TENANT_UUID]' AND status = 'active'
);

-- Log action
INSERT INTO system_audit_log (
    event_type, event_category, actor_type, actor_email,
    target_type, target_id, new_value
) VALUES (
    'settle_access_granted', 'configuration', 'system_admin', '[ADMIN_EMAIL]',
    'tenant', '[TENANT_UUID]', '{"module": "settle", "enabled": true}'::JSONB
);
```

**Revoke SETTLE Access:**
```sql
-- Disable SETTLE for tenant
UPDATE subscription_plans
SET module_settle_enabled = FALSE
WHERE plan_id = (
    SELECT plan_id FROM subscription_tenants 
    WHERE tenant_id = '[TENANT_UUID]' AND status = 'active'
);

-- Log action
INSERT INTO system_audit_log (
    event_type, event_category, actor_type, actor_email,
    target_type, target_id, old_value, new_value
) VALUES (
    'settle_access_revoked', 'configuration', 'system_admin', '[ADMIN_EMAIL]',
    'tenant', '[TENANT_UUID]', 
    '{"module": "settle", "enabled": true}'::JSONB,
    '{"module": "settle", "enabled": false}'::JSONB
);
```

---

## 6. Data Aggregation & Anonymization

### 6.1 Aggregation Requirements

**15-Case Minimum Threshold (MANDATORY):**
- Query results MUST contain minimum 15 cases
- If <15 cases found, expand search to state-wide (drop county filter)
- If still <15 cases, return "insufficient data" message
- NEVER display individual case data

**Admin Monitoring:**
```sql
-- Check queries that would violate 15-case minimum
SELECT 
    injury_type,
    state,
    county,
    COUNT(*) as case_count
FROM case_bank_entries
WHERE anonymization_verified = TRUE
GROUP BY injury_type, state, county
HAVING COUNT(*) < 15
ORDER BY case_count ASC;
-- Results show data gaps that need more contributions
```

### 6.2 Anonymization Verification

**Client-Side Anonymization (Before Transmission):**
- Attorney's browser generates SHA-256 hash
- PII fields stripped before transmission
- Only anonymized data sent to server

**Server-Side Validation:**
```python
# Admin agent must verify:
1. Contribution hash matches expected format (64-char hex)
2. No PII keywords in any text fields
3. All numeric fields within valid ranges
4. State/county codes valid
5. Anonymization flag = TRUE
```

**Admin Queries:**
```sql
-- Check contributions with failed anonymization
SELECT 
    c.id,
    c.created_at,
    c.contribution_hash,
    c.anonymization_verified,
    a.email as attorney_email
FROM case_bank_entries c
JOIN attorneys a ON c.created_by_attorney = a.id
WHERE c.anonymization_verified = FALSE
ORDER BY c.created_at DESC;
```

### 6.3 Data Lifecycle Management

**Step 1: Contribution Received**
- Store in `case_bank_entries` table
- Generate contribution hash
- Verify anonymization

**Step 2: Immediate Aggregation**
- Aggregate with existing data by (injury_type, state, county)
- Calculate percentiles (25th, median, 75th, 95th)
- Store aggregated statistics only

**Step 3: Individual Data Discard**
- Individual contribution data NOT retained beyond aggregation
- Only aggregated statistics stored
- Blockchain hash retained (proves anonymization, contains no PII)

**Admin Verification:**
```sql
-- Verify no individual case data persists (should return aggregated stats only)
SELECT 
    injury_type,
    state,
    county,
    COUNT(*) as case_count,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY settlement_amount) as p25,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY settlement_amount) as median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY settlement_amount) as p75,
    PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY settlement_amount) as p95
FROM case_bank_entries
WHERE anonymization_verified = TRUE
GROUP BY injury_type, state, county
HAVING COUNT(*) >= 15;
```

---

## 7. Blockchain Verification Management

### 7.1 OpenTimestamps Integration

**Purpose:**
- Generate cryptographic proof of anonymization
- Create immutable audit trail
- Provide verifiable compliance evidence

**Process:**
1. Contribution received and validated
2. Generate OpenTimestamps hash (`.ots` file)
3. Store hash in database (NOT personal data)
4. Provide verification URL: `https://verify.truevow.law/[HASH]`

**Admin Queries:**
```sql
-- Check contributions with blockchain verification
SELECT 
    c.id,
    c.created_at,
    c.contribution_hash,
    c.ots_hash,
    a.email as attorney_email
FROM case_bank_entries c
JOIN attorneys a ON c.created_by_attorney = a.id
WHERE c.ots_hash IS NOT NULL
ORDER BY c.created_at DESC
LIMIT 100;
```

**Verification Status:**
```sql
-- Check verification status
SELECT 
    COUNT(*) FILTER (WHERE ots_hash IS NOT NULL) as verified_count,
    COUNT(*) FILTER (WHERE ots_hash IS NULL) as unverified_count,
    COUNT(*) as total_contributions
FROM case_bank_entries
WHERE anonymization_verified = TRUE;
```

### 7.2 Blockchain Hash Management

**Generate Hash (Admin Action):**
```python
# If hash missing, regenerate
import hashlib
import opentimestamps

def generate_ots_hash(contribution_data):
    # Create hash of contribution (no PII)
    hash_input = json.dumps({
        'injury_type': contribution_data['injury_type'],
        'state': contribution_data['state'],
        'county': contribution_data.get('county'),
        'settlement_amount': contribution_data['settlement_amount'],
        'medical_bills': contribution_data['medical_bills'],
        'timestamp': contribution_data['created_at']
    })
    
    sha256_hash = hashlib.sha256(hash_input.encode()).hexdigest()
    
    # Create OpenTimestamps proof
    ots_file = opentimestamps.stamp(sha256_hash)
    
    return {
        'contribution_hash': sha256_hash,
        'ots_hash': ots_file.hex(),
        'verification_url': f'https://verify.truevow.law/{sha256_hash}'
    }
```

**Update Missing Hashes:**
```sql
-- Find contributions missing blockchain hash
SELECT id, contribution_hash, created_at
FROM case_bank_entries
WHERE ots_hash IS NULL
  AND anonymization_verified = TRUE
ORDER BY created_at DESC;
```

---

## 8. Reporting & Analytics

### 8.1 Usage Metrics

**Track SETTLE Usage:**
```sql
-- Daily SETTLE report generation
INSERT INTO usage_metrics (
    tenant_id, date, metric_type, metric_value, limit_value
) VALUES (
    '[TENANT_UUID]', 
    CURRENT_DATE, 
    'settle_reports_generated', 
    1,
    NULL  -- No limit for Founding Members
);
```

**Monthly Usage Summary:**
```sql
SELECT 
    t.tenant_id,
    t.firm_name,
    SUM(um.metric_value) FILTER (WHERE um.metric_type = 'settle_reports_generated') as total_reports,
    COUNT(DISTINCT DATE_TRUNC('month', um.date)) as active_months
FROM tenant_accounts t
LEFT JOIN usage_metrics um ON t.tenant_id = um.tenant_id
WHERE um.metric_type = 'settle_reports_generated'
  AND um.date >= DATE_TRUNC('month', CURRENT_DATE)
GROUP BY t.tenant_id, t.firm_name
ORDER BY total_reports DESC;
```

### 8.2 Contribution Analytics

**Contribution Statistics:**
```sql
-- Total contributions by state
SELECT 
    state,
    COUNT(*) as total_contributions,
    COUNT(DISTINCT created_by_attorney) as contributing_attorneys,
    AVG(settlement_amount) as avg_settlement,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY settlement_amount) as median_settlement
FROM case_bank_entries
WHERE anonymization_verified = TRUE
GROUP BY state
ORDER BY total_contributions DESC;
```

**Founding Member Contribution Tracking:**
```sql
-- Monthly contribution requirements
SELECT 
    a.email,
    a.bar_number,
    COUNT(*) FILTER (WHERE c.created_at >= DATE_TRUNC('month', CURRENT_DATE)) as monthly_contributions,
    CASE 
        WHEN COUNT(*) FILTER (WHERE c.created_at >= DATE_TRUNC('month', CURRENT_DATE)) >= 3 
        THEN '✅ Compliant'
        ELSE '⚠️ Needs 3 contributions this month'
    END as status
FROM attorneys a
LEFT JOIN case_bank_entries c ON a.id = c.created_by_attorney
WHERE EXISTS (
    SELECT 1 FROM founding_members fm 
    WHERE fm.attorney_id = a.id 
    AND fm.status = 'active'
)
GROUP BY a.id, a.email, a.bar_number
ORDER BY monthly_contributions DESC;
```

### 8.3 Compliance Reports

**Generate Bar Compliance Report:**
```sql
-- Compliance summary for bar committee
SELECT 
    'Total Contributions' as metric,
    COUNT(*) as value
FROM case_bank_entries
WHERE anonymization_verified = TRUE

UNION ALL

SELECT 
    'Contributions with Blockchain Verification' as metric,
    COUNT(*) as value
FROM case_bank_entries
WHERE ots_hash IS NOT NULL
  AND anonymization_verified = TRUE

UNION ALL

SELECT 
    'Contributions Rejected (PII Detected)' as metric,
    COUNT(*) as value
FROM case_bank_entries
WHERE anonymization_verified = FALSE

UNION ALL

SELECT 
    'Unique Contributing Attorneys' as metric,
    COUNT(DISTINCT created_by_attorney) as value
FROM case_bank_entries
WHERE anonymization_verified = TRUE;
```

---

## 9. Integration with Other Modules

### 9.1 INTAKE Module Integration

**Use Case:** Attorney queries SETTLE during intake call to inform case qualification

**Admin Configuration:**
```sql
-- Enable SETTLE integration for INTAKE
UPDATE system_feature_flags
SET is_enabled_globally = TRUE
WHERE flag_key = 'intake_settle_integration';
```

**Usage Tracking:**
```sql
-- Track SETTLE queries from INTAKE
INSERT INTO usage_metrics (
    tenant_id, date, metric_type, metric_value, metadata
) VALUES (
    '[TENANT_UUID]',
    CURRENT_DATE,
    'settle_queries_from_intake',
    1,
    '{"source": "intake_module", "call_id": "[CALL_UUID]"}'::JSONB
);
```

### 9.2 DRAFT Module Integration

**Use Case:** Attorney references SETTLE ranges in demand letters (manual inclusion)

**Admin Note:**
- SETTLE does NOT auto-populate DRAFT documents
- Attorney must manually copy/paste ranges
- This prevents SETTLE from being construed as legal advice

**Monitoring:**
```sql
-- Track when SETTLE data is accessed before DRAFT generation
SELECT 
    um1.tenant_id,
    um1.date,
    um1.metric_value as settle_queries,
    um2.metric_value as draft_documents
FROM usage_metrics um1
JOIN usage_metrics um2 ON um1.tenant_id = um2.tenant_id 
    AND um1.date = um2.date
WHERE um1.metric_type = 'settle_reports_generated'
  AND um2.metric_type = 'documents_generated'
  AND um1.date >= DATE_TRUNC('month', CURRENT_DATE);
```

### 9.3 VERIFY Module Integration

**Use Case:** Each SETTLE contribution generates VERIFY blockchain hash

**Automatic Process:**
- Every contribution → OpenTimestamps hash generated
- Hash stored in `case_bank_entries.ots_hash`
- Verification URL: `https://verify.truevow.law/[HASH]`

**Admin Verification:**
```sql
-- Check VERIFY integration status
SELECT 
    COUNT(*) FILTER (WHERE ots_hash IS NOT NULL) as verified_contributions,
    COUNT(*) as total_contributions,
    ROUND(100.0 * COUNT(*) FILTER (WHERE ots_hash IS NOT NULL) / COUNT(*), 2) as verification_rate
FROM case_bank_entries
WHERE anonymization_verified = TRUE;
```

### 9.4 CONNECT Module Integration

**Use Case:** Settlement data can inform referral decisions (attorney judgment only)

**Admin Note:**
- SETTLE data is informational only
- CONNECT referrals are attorney decisions
- No automated referral based on SETTLE data

---

## 10. Operational Procedures

### 10.1 Daily Operations

**Morning Checklist:**
1. ✅ Review overnight contributions (check for PII violations)
2. ✅ Verify blockchain hashes generated for all contributions
3. ✅ Check aggregation thresholds (ensure 15-case minimum maintained)
4. ✅ Review compliance alerts (HIPAA, ABA Rule 1.6, Antitrust)
5. ✅ Monitor Founding Member contribution status

**Evening Checklist:**
1. ✅ Generate daily usage metrics
2. ✅ Update contribution statistics
3. ✅ Review flagged contributions (outliers, suspicious patterns)
4. ✅ Verify audit logs complete

### 10.2 Weekly Operations

**Weekly Tasks:**
1. ✅ Generate compliance summary report
2. ✅ Review Founding Member status (contribution requirements)
3. ✅ Analyze data quality metrics
4. ✅ Check for data gaps (counties with <15 cases)
5. ✅ Review attorney contribution patterns (flag suspicious activity)

### 10.3 Monthly Operations

**Monthly Tasks:**
1. ✅ Generate bar compliance report
2. ✅ Review subscription tier assignments
3. ✅ Analyze usage trends
4. ✅ Update Founding Member roster
5. ✅ Review and update feature flags
6. ✅ Generate billing data (for $49/report users)

---

## 11. Emergency Procedures

### 11.1 PII Detection Emergency

**Scenario:** PII detected in contribution

**Immediate Actions:**
1. **Delete contribution immediately:**
   ```sql
   DELETE FROM case_bank_entries
   WHERE id = '[CONTRIBUTION_UUID]';
   ```

2. **Log incident:**
   ```sql
   INSERT INTO system_audit_log (
       event_type, event_category, actor_type,
       target_type, target_id, old_value, new_value
   ) VALUES (
       'pii_detected', 'security', 'system',
       'contribution', '[CONTRIBUTION_UUID]',
       '{"status": "stored"}'::JSONB,
       '{"status": "deleted", "reason": "PII detected"}'::JSONB
   );
   ```

3. **Notify attorney:**
   - Email attorney immediately
   - Explain violation
   - Provide remediation steps

4. **Escalate if repeated:**
   - Suspend attorney's contribution access
   - Report to compliance officer

### 11.2 Compliance Violation Emergency

**Scenario:** ABA Rule 1.6, HIPAA, or Antitrust violation detected

**Immediate Actions:**
1. **Suspend contribution access:**
   ```sql
   UPDATE attorneys
   SET settle_contribution_enabled = FALSE
   WHERE id = '[ATTORNEY_UUID]';
   ```

2. **Log violation:**
   ```sql
   INSERT INTO system_audit_log (
       event_type, event_category, actor_type,
       target_type, target_id, new_value
   ) VALUES (
       'compliance_violation', 'compliance', 'system',
       'attorney', '[ATTORNEY_UUID]',
       '{"violation_type": "[ABA_RULE_1_6|HIPAA|ANTITRUST]", "action": "suspended"}'::JSONB
   );
   ```

3. **Notify compliance officer**
4. **Generate incident report**

### 11.3 Data Breach Emergency

**Scenario:** Potential data breach or unauthorized access

**Immediate Actions:**
1. **Freeze all contributions:**
   ```sql
   UPDATE system_feature_flags
   SET is_enabled_globally = FALSE
   WHERE flag_key = 'settle_contributions_enabled';
   ```

2. **Notify security team**
3. **Generate audit trail:**
   ```sql
   SELECT * FROM system_audit_log
   WHERE event_category = 'security'
     AND created_at >= '[BREACH_START_TIME]'
   ORDER BY created_at DESC;
   ```

4. **Follow incident response plan**

---

## 12. Audit & Compliance Logging

### 12.1 Required Audit Events

**All SETTLE operations must be logged:**

1. **Contribution Events:**
   - `contribution_submitted`
   - `contribution_approved`
   - `contribution_rejected`
   - `contribution_deleted`

2. **Access Events:**
   - `settle_access_granted`
   - `settle_access_revoked`
   - `settle_report_generated`

3. **Compliance Events:**
   - `pii_detected`
   - `compliance_violation`
   - `anonymization_failed`
   - `blockchain_hash_generated`

4. **Configuration Events:**
   - `settle_feature_flag_changed`
   - `settle_configuration_updated`

### 12.2 Audit Log Schema

**Table:** `system_audit_log`

**Required Fields for SETTLE:**
```sql
INSERT INTO system_audit_log (
    event_type,           -- e.g., 'contribution_submitted'
    event_category,       -- 'settle', 'compliance', 'security'
    actor_type,          -- 'attorney', 'system_admin', 'system'
    actor_email,         -- Admin email or attorney email
    target_type,         -- 'contribution', 'attorney', 'tenant'
    target_id,           -- UUID of target entity
    old_value,           -- Previous state (JSONB)
    new_value,           -- New state (JSONB)
    metadata             -- Additional context (JSONB)
) VALUES (
    'contribution_submitted',
    'settle',
    'attorney',
    'attorney@example.com',
    'contribution',
    '[CONTRIBUTION_UUID]',
    NULL,
    '{"injury_type": "spinal_injury", "state": "AZ", "county": "Maricopa"}'::JSONB,
    '{"contribution_hash": "abc123...", "anonymization_verified": true}'::JSONB
);
```

### 12.3 Compliance Report Generation

**Generate Monthly Compliance Report:**
```sql
-- Comprehensive compliance report
SELECT 
    'SETTLE Compliance Report' as report_title,
    DATE_TRUNC('month', CURRENT_DATE) as report_period,
    
    -- Contribution Statistics
    (SELECT COUNT(*) FROM case_bank_entries 
     WHERE anonymization_verified = TRUE 
     AND created_at >= DATE_TRUNC('month', CURRENT_DATE)) as total_contributions,
    
    -- Compliance Metrics
    (SELECT COUNT(*) FROM case_bank_entries 
     WHERE anonymization_verified = FALSE 
     AND created_at >= DATE_TRUNC('month', CURRENT_DATE)) as rejected_contributions,
    
    -- Blockchain Verification
    (SELECT COUNT(*) FROM case_bank_entries 
     WHERE ots_hash IS NOT NULL 
     AND created_at >= DATE_TRUNC('month', CURRENT_DATE)) as blockchain_verified,
    
    -- Attorney Participation
    (SELECT COUNT(DISTINCT created_by_attorney) FROM case_bank_entries 
     WHERE created_at >= DATE_TRUNC('month', CURRENT_DATE)) as contributing_attorneys;
```

---

## 📌 Quick Reference

### Critical Admin Queries

**Check SETTLE Access:**
```sql
SELECT t.firm_name, sp.module_settle_enabled 
FROM tenant_accounts t
JOIN subscription_tenants st ON t.tenant_id = st.tenant_id
JOIN subscription_plans sp ON st.plan_id = sp.plan_id
WHERE t.tenant_id = '[TENANT_UUID]';
```

**Recent Contributions:**
```sql
SELECT c.*, a.email 
FROM case_bank_entries c
JOIN attorneys a ON c.created_by_attorney = a.id
ORDER BY c.created_at DESC LIMIT 10;
```

**Compliance Violations:**
```sql
SELECT * FROM case_bank_entries 
WHERE anonymization_verified = FALSE 
ORDER BY created_at DESC;
```

**Founding Member Status:**
```sql
SELECT a.email, COUNT(*) as monthly_contributions
FROM attorneys a
JOIN case_bank_entries c ON a.id = c.created_by_attorney
WHERE c.created_at >= DATE_TRUNC('month', CURRENT_DATE)
GROUP BY a.id, a.email
HAVING COUNT(*) < 3;
```

---

## ✅ Implementation Checklist

- [ ] Deploy SETTLE database schema (`case_bank_entries` or `settle_cases`)
- [ ] Configure subscription plans with `module_settle_enabled` flag
- [ ] Set up feature flags for SETTLE operations
- [ ] Implement PII detection system
- [ ] Configure OpenTimestamps blockchain verification
- [ ] Set up usage metering for SETTLE reports
- [ ] Create audit logging procedures
- [ ] Configure compliance monitoring alerts
- [ ] Set up Founding Member program tracking
- [ ] Integrate with INTAKE, DRAFT, VERIFY, CONNECT modules
- [ ] Create admin dashboard for SETTLE management
- [ ] Test emergency procedures
- [ ] Generate compliance reports

---

**Last Updated:** January 2026  
**Version:** 1.0  
**Status:** ✅ Production Ready

