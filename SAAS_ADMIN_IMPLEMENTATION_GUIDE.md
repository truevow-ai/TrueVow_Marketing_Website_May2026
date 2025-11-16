# 🎛️ TrueVow SaaS Admin Database - Implementation Guide

**Created:** November 6, 2025  
**Database:** `TrueVow-Saas-Admin`  
**Purpose:** Centralized tenant management, billing, and system administration

---

## 📋 Table of Contents

1. [Schema Overview](#schema-overview)
2. [Naming Conventions](#naming-conventions)
3. [Standard Compliance Fields](#standard-compliance-fields)
4. [Table Categories](#table-categories)
5. [Implementation Workflow](#implementation-workflow)
6. [Admin Dashboard Features](#admin-dashboard-features)
7. [API Integration Examples](#api-integration-examples)
8. [Security & Access Control](#security--access-control)

---

## 🏗️ Schema Overview

### **Database Structure:**

```
TrueVow-Saas-Admin/
├── Tenant Management (8 tables)
│   ├── tenant_accounts          ← Core tenant registry
│   ├── tenant_users             ← Staff/attorneys at law firm
│   └── tenant_settings          ← Firm-specific configuration
│
├── Subscription Management (2 tables)
│   ├── subscription_plans       ← Product catalog
│   └── subscription_tenants     ← Active subscriptions
│
├── Billing & Payments (2 tables)
│   ├── billing_invoices         ← Customer invoices
│   └── billing_payments         ← Payment transactions
│
├── Usage Metering (1 table)
│   └── usage_metrics            ← Daily consumption tracking
│
├── System Administration (4 tables)
│   ├── system_admin_users       ← TrueVow staff
│   ├── system_audit_log         ← Compliance audit trail
│   ├── system_feature_flags     ← Gradual rollout control
│   └── system_health_checks     ← Uptime monitoring
│
└── Views (2 reporting views)
    ├── view_tenant_overview     ← Complete tenant snapshot
    └── view_revenue_metrics     ← MRR analytics
```

**Total Tables:** 17 tables + 2 views = **19 database objects**

---

## 📝 Naming Conventions

### **Prefix System:**

| Prefix | Category | Examples |
|--------|----------|----------|
| `tenant_*` | Tenant/firm data | `tenant_accounts`, `tenant_users`, `tenant_settings` |
| `subscription_*` | Subscription & plans | `subscription_plans`, `subscription_tenants` |
| `billing_*` | Invoicing & payments | `billing_invoices`, `billing_payments` |
| `usage_*` | Usage tracking | `usage_metrics` |
| `system_*` | Platform admin | `system_admin_users`, `system_audit_log` |
| `view_*` | Reporting views | `view_tenant_overview` |

### **Field Naming:**

- **Primary Keys:** `{entity}_id` (e.g., `tenant_id`, `plan_id`)
- **Foreign Keys:** Same as referenced PK (e.g., `tenant_id` references `tenant_accounts.tenant_id`)
- **Timestamps:** `*_at` for specific events (e.g., `created_at`, `cancelled_at`)
- **Dates:** `*_date` for date-only fields (e.g., `trial_end_date`, `due_date`)
- **Booleans:** `is_*` or `has_*` (e.g., `is_active`, `has_mfa_enabled`)
- **Arrays:** Plural form (e.g., `practice_areas`, `bar_associations`)

---

## 🔒 Standard Compliance Fields

**Every table includes these standard fields (from Phase 1 pattern):**

```sql
created_at TIMESTAMPTZ DEFAULT NOW(),
updated_at TIMESTAMPTZ DEFAULT NOW(),
created_by UUID,              -- Who created this record
updated_by UUID               -- Who last modified this record
```

**Auto-update trigger applied to all tables:**
```sql
CREATE TRIGGER trg_{table_name}_updated 
BEFORE UPDATE ON {table_name} 
FOR EACH ROW EXECUTE FUNCTION update_timestamp();
```

**Result:** Every update automatically sets `updated_at = NOW()`

---

## 📊 Table Categories Explained

### **1. TENANT MANAGEMENT**

#### **`tenant_accounts` (Master Registry)**

**Purpose:** One row per law firm customer

**Key Fields:**
- `account_status`: `onboarding` → `trial` → `active` → `suspended` / `cancelled`
- `trial_end_date`: Automatically checked via generated column `is_trial_expired`
- `tenant_database_url`: Points to their dedicated per-firm database
- `onboarding_step`: Track setup progress

**Example Row:**
```sql
INSERT INTO tenant_accounts (
    firm_name, firm_slug, primary_contact_email,
    account_status, trial_start_date, trial_end_date,
    tenant_database_url
) VALUES (
    'Smith & Associates Law', 
    'smith-associates',
    'john@smithlaw.com',
    'trial',
    '2025-11-06',
    '2025-11-20',
    'postgresql://supabase.co/truevow-smith-associates-app'
);
```

#### **`tenant_users` (Staff & Attorneys)**

**Purpose:** Staff members at each law firm

**Roles:**
- `owner`: Full admin (usually managing partner)
- `admin`: Can manage users
- `attorney`: Access all cases
- `paralegal`: Limited access
- `staff`: Basic access
- `readonly`: View-only

**Example:**
```sql
INSERT INTO tenant_users (
    tenant_id, email, first_name, last_name, role
) VALUES (
    'smith-uuid', 'jane@smithlaw.com', 'Jane', 'Doe', 'attorney'
);
```

---

### **2. SUBSCRIPTION MANAGEMENT**

#### **`subscription_plans` (Product Catalog)**

**Pre-populated with 4 plans:**

| Plan | Price/Month | Calls | Users | Storage | Modules |
|------|-------------|-------|-------|---------|---------|
| Free Trial | $0 | 100 | 3 | 10 GB | Intake only |
| Basic | $297 | 500 | 5 | 50 GB | Intake only |
| Pro | $597 | 2,000 | 15 | 200 GB | Intake + Draft |
| Enterprise | $997 | Unlimited | Unlimited | 1 TB | All modules |

**Module Flags:**
```sql
module_intake_enabled   BOOLEAN
module_draft_enabled    BOOLEAN
module_settle_enabled   BOOLEAN
module_connect_enabled  BOOLEAN
module_verify_enabled   BOOLEAN
```

#### **`subscription_tenants` (Active Subscriptions)**

**Links tenant to plan:**
```sql
INSERT INTO subscription_tenants (
    tenant_id, plan_id, status, 
    billing_cycle_start, billing_cycle_end,
    actual_price_monthly
) VALUES (
    'smith-uuid', 'basic-plan-uuid', 'active',
    '2025-11-06', '2025-12-06', 297.00
);
```

---

### **3. BILLING & PAYMENTS**

#### **`billing_invoices`**

**Auto-calculated fields:**
```sql
amount_due = total_amount - amount_paid  -- Computed automatically
```

**Status Flow:**
```
draft → sent → paid (or overdue → cancelled)
```

#### **`billing_payments`**

**Payment methods supported:**
- `credit_card`, `debit_card`
- `ach`, `wire_transfer`
- `stripe` (recommended)

**Stripe Integration Fields:**
```sql
stripe_payment_intent_id TEXT
stripe_charge_id TEXT
stripe_refund_id TEXT
```

---

### **4. USAGE METERING**

#### **`usage_metrics` (Daily Rollup)**

**Tracks consumption per tenant:**

**Metric Types:**
- `calls_intake`: Number of intake calls
- `calls_outbound`: Outbound follow-ups
- `api_requests`: API usage
- `storage_gb`: Database size
- `users_active`: Daily active users
- `documents_generated`: Draft module usage
- `sms_sent`, `emails_sent`: Communication costs

**Auto-check limits:**
```sql
limit_exceeded BOOLEAN GENERATED ALWAYS AS (
    CASE WHEN limit_value IS NOT NULL AND metric_value > limit_value 
    THEN TRUE ELSE FALSE END
) STORED
```

**Example Query:**
```sql
-- Check if tenant exceeded monthly call limit
SELECT * FROM usage_metrics
WHERE tenant_id = 'smith-uuid'
  AND metric_type = 'calls_intake'
  AND date >= DATE_TRUNC('month', CURRENT_DATE)
  AND limit_exceeded = TRUE;
```

---

### **5. SYSTEM ADMINISTRATION**

#### **`system_admin_users` (TrueVow Staff)**

**Roles:**
- `super_admin`: CEO, CTO (full access)
- `admin`: Senior engineers
- `support`: Customer support team
- `finance`: Billing department
- `readonly`: Auditors, investors

**Security:**
```sql
mfa_enabled BOOLEAN DEFAULT TRUE  -- Required for all admins
```

#### **`system_audit_log` (Compliance Trail)**

**Logs every important action:**

**Event Categories:**
- `authentication`: Logins, logouts
- `tenant_management`: Account changes
- `billing`: Payment events
- `subscription`: Plan changes
- `security`: Access violations
- `configuration`: Settings changes
- `data_access`: Sensitive data views

**Example Entry:**
```sql
INSERT INTO system_audit_log (
    event_type, event_category,
    actor_type, actor_email,
    target_type, target_id,
    old_value, new_value
) VALUES (
    'subscription_changed', 'subscription',
    'system_admin', 'yasha@truevow.law',
    'tenant', 'smith-uuid',
    '{"plan": "trial"}'::JSONB,
    '{"plan": "basic"}'::JSONB
);
```

#### **`system_feature_flags` (Gradual Rollout)**

**Control feature access:**

```sql
INSERT INTO system_feature_flags (
    flag_key, flag_name, 
    is_enabled_globally, 
    enabled_for_tiers
) VALUES (
    'draft_module_ai_assist', 
    'AI-powered drafting suggestions',
    FALSE,  -- Not globally enabled yet
    ARRAY['enterprise']  -- Only for enterprise customers
);
```

**Check if feature enabled for tenant:**
```typescript
// In your application
async function isFeatureEnabled(tenantId: string, flagKey: string) {
  const { data: flag } = await adminSupabase
    .from('system_feature_flags')
    .select('*')
    .eq('flag_key', flagKey)
    .single()
  
  if (!flag.is_active) return false
  if (flag.is_enabled_globally) return true
  if (flag.enabled_for_tenants?.includes(tenantId)) return true
  
  // Check tenant's subscription tier
  const { data: tenant } = await getTenantSubscription(tenantId)
  return flag.enabled_for_tiers?.includes(tenant.tier_name)
}
```

---

## 🚀 Implementation Workflow

### **Step 1: Deploy Schema to Supabase**

1. Open **Supabase Dashboard** → Your Project → **SQL Editor**
2. Copy contents of `003_saas_admin_schema.sql`
3. Paste and click **Run**
4. Verify: Check **Table Editor** to see all 17 tables created

---

### **Step 2: Configure Environment Variables**

Update your `2025-TrueVow-Website/.env.local`:

```bash
# Database 3: SaaS Admin
ADMIN_SUPABASE_URL=https://your-saas-admin-project.supabase.co
ADMIN_SUPABASE_ANON_KEY=your-anon-key-here
ADMIN_SUPABASE_SERVICE_KEY=your-service-role-key-here  # For server-side only
```

---

### **Step 3: Update Supabase Client**

Your `lib/supabaseClient.ts` already has the admin client configured:

```typescript
// Database 3: SaaS Admin (already configured)
const adminUrl = process.env.ADMIN_SUPABASE_URL!
const adminKey = process.env.ADMIN_SUPABASE_ANON_KEY!
export const adminSupabase = createClient(adminUrl, adminKey)
```

---

### **Step 4: Create Your First Tenant**

**Example script:** `scripts/create-tenant.ts`

```typescript
import { adminSupabase } from '../lib/supabaseClient'

async function createTenant() {
  // 1. Create tenant account
  const { data: tenant, error: tenantError } = await adminSupabase
    .from('tenant_accounts')
    .insert({
      firm_name: 'Smith & Associates Law',
      firm_slug: 'smith-associates',
      primary_contact_email: 'john@smithlaw.com',
      primary_contact_phone: '555-0100',
      account_status: 'trial',
      trial_start_date: new Date().toISOString().split('T')[0],
      trial_end_date: new Date(Date.now() + 14 * 24 * 60 * 60 * 1000)
        .toISOString().split('T')[0],
      tenant_database_url: 'postgresql://supabase.co/truevow-smith-associates-app',
      firm_type: 'small_firm',
      practice_areas: ['personal_injury', 'workers_compensation'],
      timezone: 'America/New_York'
    })
    .select()
    .single()

  console.log('✅ Tenant created:', tenant)

  // 2. Assign to Free Trial plan
  const { data: plans } = await adminSupabase
    .from('subscription_plans')
    .select('plan_id')
    .eq('plan_slug', 'free-trial')
    .single()

  const { data: subscription } = await adminSupabase
    .from('subscription_tenants')
    .insert({
      tenant_id: tenant.tenant_id,
      plan_id: plans.plan_id,
      status: 'active',
      billing_cycle_start: new Date().toISOString().split('T')[0],
      billing_cycle_end: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000)
        .toISOString().split('T')[0],
      actual_price_monthly: 0
    })
    .select()
    .single()

  console.log('✅ Subscription created:', subscription)

  // 3. Create owner user
  const { data: user } = await adminSupabase
    .from('tenant_users')
    .insert({
      tenant_id: tenant.tenant_id,
      email: 'john@smithlaw.com',
      first_name: 'John',
      last_name: 'Smith',
      title: 'Managing Partner',
      role: 'owner',
      is_active: true
    })
    .select()
    .single()

  console.log('✅ Owner user created:', user)

  // 4. Log audit trail
  await adminSupabase.from('system_audit_log').insert({
    event_type: 'tenant_created',
    event_category: 'tenant_management',
    actor_type: 'system_admin',
    actor_email: 'yasha@truevow.law',
    target_type: 'tenant',
    target_id: tenant.tenant_id,
    new_value: { firm_name: tenant.firm_name, plan: 'free-trial' }
  })

  return tenant
}

createTenant()
```

---

## 🎨 Admin Dashboard Features

### **Feature 1: Tenant Status Toggle**

**UI Component:**
```tsx
// components/admin/TenantStatusToggle.tsx
export function TenantStatusToggle({ tenant }) {
  const [status, setStatus] = useState(tenant.account_status)

  async function updateStatus(newStatus: string) {
    const { error } = await adminSupabase
      .from('tenant_accounts')
      .update({ 
        account_status: newStatus,
        account_status_reason: prompt('Reason for change:')
      })
      .eq('tenant_id', tenant.tenant_id)

    if (!error) {
      setStatus(newStatus)
      toast.success(`Account ${newStatus}`)
    }
  }

  return (
    <Select value={status} onChange={(e) => updateStatus(e.target.value)}>
      <option value="onboarding">Onboarding</option>
      <option value="trial">Trial</option>
      <option value="active">Active</option>
      <option value="suspended">Suspended</option>
      <option value="cancelled">Cancelled</option>
    </Select>
  )
}
```

---

### **Feature 2: Module Access Control**

**Toggle Features:**
```tsx
// Check tenant's plan to see which modules they can access
async function getTenantModules(tenantId: string) {
  const { data } = await adminSupabase
    .from('view_tenant_overview')
    .select('*')
    .eq('tenant_id', tenantId)
    .single()

  return {
    intake: data.module_intake_enabled,
    draft: data.module_draft_enabled,
    settle: data.module_settle_enabled,
    connect: data.module_connect_enabled
  }
}

// Enable a module for a tenant (admin override)
async function enableModuleOverride(tenantId: string, module: string) {
  // Get current subscription
  const { data: sub } = await adminSupabase
    .from('subscription_tenants')
    .select('plan_id')
    .eq('tenant_id', tenantId)
    .eq('status', 'active')
    .single()

  // Update plan to enable module
  await adminSupabase
    .from('subscription_plans')
    .update({ [`module_${module}_enabled`]: true })
    .eq('plan_id', sub.plan_id)

  // Log the change
  await adminSupabase.from('system_audit_log').insert({
    event_type: 'module_enabled',
    event_category: 'subscription',
    target_id: tenantId,
    new_value: { module, enabled: true }
  })
}
```

---

### **Feature 3: Usage Limits Dashboard**

**Real-time Usage:**
```tsx
// Get current month usage
async function getTenantUsage(tenantId: string) {
  const { data: metrics } = await adminSupabase
    .from('usage_metrics')
    .select('*')
    .eq('tenant_id', tenantId)
    .gte('date', new Date().toISOString().split('T')[0].slice(0, 7) + '-01')

  const usage = {
    calls: metrics
      .filter(m => m.metric_type === 'calls_intake')
      .reduce((sum, m) => sum + m.metric_value, 0),
    storage: Math.max(...metrics
      .filter(m => m.metric_type === 'storage_gb')
      .map(m => m.metric_value)),
    users: Math.max(...metrics
      .filter(m => m.metric_type === 'users_active')
      .map(m => m.metric_value))
  }

  // Get limits from subscription plan
  const { data: tenant } = await adminSupabase
    .from('view_tenant_overview')
    .select('*')
    .eq('tenant_id', tenantId)
    .single()

  return {
    calls: { used: usage.calls, limit: tenant.max_monthly_calls },
    storage: { used: usage.storage, limit: tenant.max_storage_gb },
    users: { used: usage.users, limit: tenant.max_users }
  }
}
```

---

## 🔐 Security & Access Control

### **Row Level Security (RLS)**

**Already enabled for:**
- ✅ `tenant_accounts`
- ✅ `tenant_users`
- ✅ `tenant_settings`
- ✅ `subscription_tenants`
- ✅ `billing_invoices`
- ✅ `billing_payments`
- ✅ `usage_metrics`

**Policies:**
```sql
-- System admins can access everything
CREATE POLICY admin_all_access ON tenant_accounts FOR ALL USING (TRUE);

-- Tenants can only see their own data (for future tenant-facing dashboard)
CREATE POLICY tenant_own_data ON tenant_accounts FOR SELECT 
    USING (tenant_id = current_setting('app.current_tenant_id')::UUID);
```

---

### **API Key Strategy**

**Three levels of access:**

1. **Public (Anon Key):** Used by marketing website
   - Can only read `subscription_plans` (for pricing page)

2. **Service Role Key:** Used by your backend
   - Full read/write access to all tables
   - Used for admin dashboard, automated billing, etc.

3. **Tenant API Keys:** Stored in `tenant_accounts.api_key_hash`
   - For future: Allow tenants to access their own data via API

---

## 📈 Reporting Queries

### **Query 1: Monthly Recurring Revenue (MRR)**

```sql
SELECT * FROM view_revenue_metrics
WHERE month = DATE_TRUNC('month', CURRENT_DATE)
ORDER BY tier_name;
```

### **Query 2: Trial Conversion Rate**

```sql
SELECT 
    COUNT(*) FILTER (WHERE account_status = 'trial') AS total_trials,
    COUNT(*) FILTER (WHERE account_status = 'active' 
                     AND activated_at > trial_end_date) AS converted,
    ROUND(100.0 * COUNT(*) FILTER (WHERE account_status = 'active' 
                                    AND activated_at > trial_end_date) 
          / NULLIF(COUNT(*) FILTER (WHERE account_status = 'trial'), 0), 2) AS conversion_rate
FROM tenant_accounts
WHERE trial_start_date >= DATE_TRUNC('month', CURRENT_DATE);
```

### **Query 3: Churn Analysis**

```sql
SELECT 
    DATE_TRUNC('month', cancelled_at) AS month,
    COUNT(*) AS churned_accounts,
    SUM(actual_price_monthly) AS lost_mrr
FROM subscription_tenants
WHERE status = 'cancelled'
  AND cancelled_at IS NOT NULL
GROUP BY DATE_TRUNC('month', cancelled_at)
ORDER BY month DESC;
```

---

## ✅ Implementation Checklist

- [ ] **Deploy schema** to Supabase SaaS Admin project
- [ ] **Configure `.env.local`** with admin database credentials
- [ ] **Test connection** using `scripts/test-db-connections.js`
- [ ] **Create first test tenant** using provided script
- [ ] **Build admin dashboard** UI (Tenant list, status toggles)
- [ ] **Integrate Stripe** for billing automation
- [ ] **Set up usage metering** cron jobs (daily rollup)
- [ ] **Configure RLS policies** for tenant isolation
- [ ] **Test module access control** (feature flags)
- [ ] **Set up monitoring** (system health checks)

---

## 🎯 Next Steps

1. **Deploy this schema** to your Supabase SaaS Admin database
2. **Test tenant creation** workflow
3. **Build admin dashboard** for managing tenants
4. **Integrate Stripe** for automated billing
5. **Set up usage metering** to track consumption

---

**Questions?** Refer to:
- `003_saas_admin_schema.sql` - Full schema definition
- `lib/supabaseClient.ts` - Database connection setup
- `MIGRATION_SUCCESS_REPORT.md` - Overall architecture

