# 🎛️ Admin Dashboard Toggle Reference

**Purpose:** Show exactly how the admin toggles work in the SaaS Admin dashboard

---

## 1️⃣ Account Status Toggle

### **What the Admin Sees:**

```
┌─────────────────────────────────────────────────┐
│ Tenant: Smith & Associates Law                 │
├─────────────────────────────────────────────────┤
│                                                 │
│ Account Status: [Trial ▼]                      │
│   Options:                                      │
│   • Onboarding                                  │
│   • Trial                                       │
│   • Active                                      │
│   • Suspended                                   │
│   • Cancelled                                   │
│                                                 │
│ Trial Expires: Nov 20, 2025 (14 days left)     │
│ Status Reason: [                              ] │
│                                                 │
│ [Save Changes]                                  │
└─────────────────────────────────────────────────┘
```

### **What Happens When Admin Changes Status:**

#### **Example: Trial → Active**

**Admin Action:**
1. Admin selects "Active" from dropdown
2. Enters reason: "Customer upgraded to Basic plan"
3. Clicks "Save Changes"

**Database Update:**
```sql
UPDATE tenant_accounts 
SET 
    account_status = 'active',
    account_status_reason = 'Customer upgraded to Basic plan',
    activated_at = NOW(),
    updated_by = 'admin-uuid'
WHERE tenant_id = 'smith-uuid';
```

**Effect on Tenant Application:**
```typescript
// Middleware in tenant's application
async function checkAccess(tenantId: string) {
  const { data: tenant } = await adminSupabase
    .from('tenant_accounts')
    .select('account_status, is_trial_expired')
    .eq('tenant_id', tenantId)
    .single()

  // Trial → Active: Customer can continue using app
  if (tenant.account_status === 'active') {
    return { allowed: true, message: 'Welcome back!' }
  }

  // If status was "suspended"
  if (tenant.account_status === 'suspended') {
    return { 
      allowed: false, 
      message: 'Account suspended. Please contact support.' 
    }
  }

  // If status was "cancelled"
  if (tenant.account_status === 'cancelled') {
    return { 
      allowed: false, 
      message: 'Account cancelled. Reactivate to continue.' 
    }
  }
}
```

**Result:**
- ✅ Customer can access application
- ✅ Same database (no switching)
- ✅ Billing starts (if not already started)
- ✅ Usage limits enforced based on plan

---

## 2️⃣ Module Access Toggle

### **What the Admin Sees:**

```
┌─────────────────────────────────────────────────┐
│ Modules Enabled                                 │
├─────────────────────────────────────────────────┤
│                                                 │
│ [✅] Intake                                     │
│     Status: Enabled (included in all plans)    │
│     Max Calls/Month: 500                       │
│                                                 │
│ [☐] Draft                                       │
│     Status: Disabled (requires Pro or higher)  │
│     [Enable for this tenant]                   │
│                                                 │
│ [☐] Settle                                      │
│     Status: Disabled (requires Enterprise)     │
│     [Enable for this tenant]                   │
│                                                 │
│ [☐] Connect                                     │
│     Status: Disabled (requires Enterprise)     │
│     [Enable for this tenant]                   │
│                                                 │
└─────────────────────────────────────────────────┘
```

### **What Happens When Admin Enables a Module:**

#### **Example: Enable "Draft" Module**

**Admin Action:**
1. Admin clicks "Enable for this tenant" next to Draft module
2. Modal opens: "This will upgrade tenant to Pro plan. Continue?"
3. Admin confirms

**Database Update Option A (Upgrade Plan):**
```sql
-- Find the Pro plan
SELECT plan_id FROM subscription_plans WHERE plan_slug = 'pro';

-- Update tenant's subscription
UPDATE subscription_tenants 
SET 
    plan_id = 'pro-plan-uuid',
    actual_price_monthly = 597.00,
    updated_at = NOW()
WHERE tenant_id = 'smith-uuid' AND status = 'active';
```

**Database Update Option B (Manual Override - Custom Deal):**
```sql
-- Keep current plan but enable specific module
-- Create custom plan for this tenant
INSERT INTO subscription_plans (
    plan_name, plan_slug, 
    base_price_monthly, tier_name,
    module_intake_enabled, module_draft_enabled
) VALUES (
    'Custom - Smith & Associates', 'custom-smith',
    397.00, 'custom',  -- Custom price between Basic and Pro
    TRUE, TRUE  -- Enable both Intake and Draft
);

-- Update tenant to use custom plan
UPDATE subscription_tenants 
SET plan_id = 'custom-smith-plan-uuid'
WHERE tenant_id = 'smith-uuid';
```

**Effect on Tenant Application:**
```typescript
// In tenant's app navigation
async function getAvailableModules(tenantId: string) {
  const { data: modules } = await adminSupabase
    .from('view_tenant_overview')
    .select(`
      module_intake_enabled,
      module_draft_enabled,
      module_settle_enabled,
      module_connect_enabled
    `)
    .eq('tenant_id', tenantId)
    .single()

  return modules
}

// React component
export function AppNavigation() {
  const modules = useAvailableModules()

  return (
    <nav>
      {modules.module_intake_enabled && (
        <NavItem href="/intake">Intake</NavItem>
      )}
      {modules.module_draft_enabled && (  // ← Now visible!
        <NavItem href="/draft">Draft</NavItem>
      )}
      {modules.module_settle_enabled && (
        <NavItem href="/settle">Settle</NavItem>
      )}
      {modules.module_connect_enabled && (
        <NavItem href="/connect">Connect</NavItem>
      )}
    </nav>
  )
}
```

**Result:**
- ✅ "Draft" menu item appears in tenant's application
- ✅ Tenant can access `/draft` route
- ✅ Backend checks module access before allowing draft operations
- ✅ No database switch - just feature unlock
- ✅ Usage limits updated (if plan changed)

---

## 3️⃣ Usage Limits Control

### **What the Admin Sees:**

```
┌─────────────────────────────────────────────────┐
│ Usage This Month (November 2025)                │
├─────────────────────────────────────────────────┤
│                                                 │
│ Intake Calls:    47 / 500    [▓▓▓▓░░░░░░] 9%  │
│                                                 │
│ Active Users:     2 / 5      [▓▓▓▓░░░░░░] 40% │
│                                                 │
│ Storage:       2.4 / 50 GB   [▓░░░░░░░░░] 5%  │
│                                                 │
│ API Requests:  1,234 / 10,000  [▓░░░░░░░░] 12%│
│                                                 │
│ [ ] Override Limits (allows unlimited usage)   │
│                                                 │
└─────────────────────────────────────────────────┘
```

### **What Happens When Admin Adjusts Limits:**

#### **Example: Increase Call Limit**

**Admin Action:**
1. Admin clicks "Edit Limits"
2. Changes "Max Monthly Calls" from 500 to 1000
3. Saves changes

**Database Update:**
```sql
-- Update the tenant's subscription plan limits
-- Option 1: Modify the plan (affects all tenants on this plan)
UPDATE subscription_plans
SET max_monthly_calls = 1000
WHERE plan_id = (
    SELECT plan_id FROM subscription_tenants 
    WHERE tenant_id = 'smith-uuid' AND status = 'active'
);

-- Option 2: Create tenant-specific override
INSERT INTO tenant_settings (
    tenant_id, category, setting_key, setting_value, setting_type
) VALUES (
    'smith-uuid', 'usage', 'max_monthly_calls', 
    '1000'::JSONB, 'number'
)
ON CONFLICT (tenant_id, category, setting_key) 
DO UPDATE SET setting_value = '1000'::JSONB;
```

**Effect on Tenant Application:**
```typescript
// Check if tenant exceeded limits
async function checkUsageLimits(tenantId: string) {
  // Get this month's usage
  const { data: usage } = await adminSupabase
    .from('usage_metrics')
    .select('metric_value')
    .eq('tenant_id', tenantId)
    .eq('metric_type', 'calls_intake')
    .gte('date', startOfMonth())
    .sum('metric_value')

  // Get limit (check override first, then plan default)
  const { data: override } = await adminSupabase
    .from('tenant_settings')
    .select('setting_value')
    .eq('tenant_id', tenantId)
    .eq('setting_key', 'max_monthly_calls')
    .single()

  const limit = override?.setting_value || 
                subscription.max_monthly_calls

  if (usage >= limit) {
    return { 
      allowed: false, 
      message: `Monthly call limit reached (${limit}). Upgrade to continue.` 
    }
  }

  return { allowed: true }
}
```

**Result:**
- ✅ Tenant can now make up to 1,000 calls/month instead of 500
- ✅ No interruption to service
- ✅ Change takes effect immediately
- ✅ Audit log records the change

---

## 4️⃣ Feature Flag Toggle

### **What the Admin Sees:**

```
┌─────────────────────────────────────────────────┐
│ Feature Flags                                   │
├─────────────────────────────────────────────────┤
│                                                 │
│ Draft AI Assistant (Beta)                      │
│   Status: [☐] Disabled Globally                │
│   Rollout: 0%                                   │
│   Enabled For: [Enterprise tier only]          │
│                                                 │
│   Specific Tenants:                            │
│   [+] Add tenant                               │
│                                                 │
│   [Enable for Smith & Associates]              │
│                                                 │
└─────────────────────────────────────────────────┘
```

### **What Happens When Admin Enables Feature:**

#### **Example: Enable Beta Feature for One Tenant**

**Admin Action:**
1. Admin clicks "Enable for Smith & Associates"
2. Feature flag updated to include this tenant

**Database Update:**
```sql
-- Add tenant to enabled list
UPDATE system_feature_flags
SET 
    enabled_for_tenants = array_append(enabled_for_tenants, 'smith-uuid'),
    updated_at = NOW(),
    updated_by = 'admin-uuid'
WHERE flag_key = 'draft_module_ai_assist';
```

**Effect on Tenant Application:**
```typescript
// Check if feature is enabled for tenant
async function isFeatureEnabled(
  tenantId: string, 
  flagKey: string
): Promise<boolean> {
  const { data: flag } = await adminSupabase
    .from('system_feature_flags')
    .select('*')
    .eq('flag_key', flagKey)
    .single()

  // Not active at all
  if (!flag.is_active) return false

  // Enabled globally
  if (flag.is_enabled_globally) return true

  // Explicitly enabled for this tenant
  if (flag.enabled_for_tenants?.includes(tenantId)) return true

  // Check if tenant's tier is enabled
  const { data: tenant } = await getTenantSubscription(tenantId)
  if (flag.enabled_for_tiers?.includes(tenant.tier_name)) return true

  return false
}

// In Draft module component
export function DraftEditor() {
  const tenantId = useTenantId()
  const hasAI = await isFeatureEnabled(tenantId, 'draft_module_ai_assist')

  return (
    <div>
      <textarea {...} />
      
      {hasAI && (  // ← Only shows if feature enabled
        <button onClick={getAISuggestions}>
          ✨ Get AI Suggestions (Beta)
        </button>
      )}
    </div>
  )
}
```

**Result:**
- ✅ Smith & Associates sees "AI Suggestions" button in Draft module
- ✅ Other customers on Basic/Pro don't see it
- ✅ No code deployment required - instant feature toggle
- ✅ Can be disabled just as easily

---

## 5️⃣ Complete Admin Dashboard UI Example

### **Full Tenant Management Page:**

```typescript
// pages/admin/tenants/[tenantId].tsx
export default function TenantDetailPage({ tenantId }) {
  const { data: tenant } = useTenant(tenantId)
  const { data: usage } = useUsageMetrics(tenantId)
  const { data: modules } = useModuleAccess(tenantId)

  return (
    <AdminLayout>
      <PageHeader>
        <h1>{tenant.firm_name}</h1>
        <Badge status={tenant.account_status} />
      </PageHeader>

      {/* Section 1: Account Status */}
      <Card>
        <CardHeader>Account Status</CardHeader>
        <CardBody>
          <Select 
            value={tenant.account_status}
            onChange={handleStatusChange}
          >
            <option value="onboarding">Onboarding</option>
            <option value="trial">Trial</option>
            <option value="active">Active</option>
            <option value="suspended">Suspended</option>
            <option value="cancelled">Cancelled</option>
          </Select>

          {tenant.account_status === 'trial' && (
            <Alert>
              Trial expires in {daysUntil(tenant.trial_end_date)} days
            </Alert>
          )}
        </CardBody>
      </Card>

      {/* Section 2: Subscription & Modules */}
      <Card>
        <CardHeader>Subscription & Modules</CardHeader>
        <CardBody>
          <div>
            <strong>Plan:</strong> {tenant.plan_name}
            <Button onClick={handleChangePlan}>Change Plan</Button>
          </div>

          <ModuleToggles>
            <ModuleToggle 
              name="Intake" 
              enabled={modules.module_intake_enabled}
              disabled={true}  // Always enabled
            />
            <ModuleToggle 
              name="Draft" 
              enabled={modules.module_draft_enabled}
              onToggle={() => handleModuleToggle('draft')}
            />
            <ModuleToggle 
              name="Settle" 
              enabled={modules.module_settle_enabled}
              onToggle={() => handleModuleToggle('settle')}
            />
          </ModuleToggles>
        </CardBody>
      </Card>

      {/* Section 3: Usage Stats */}
      <Card>
        <CardHeader>Usage This Month</CardHeader>
        <CardBody>
          <UsageBar 
            label="Intake Calls"
            used={usage.calls}
            limit={tenant.max_monthly_calls}
          />
          <UsageBar 
            label="Active Users"
            used={usage.users}
            limit={tenant.max_users}
          />
          <UsageBar 
            label="Storage"
            used={usage.storage}
            limit={tenant.max_storage_gb}
            unit="GB"
          />
        </CardBody>
      </Card>

      {/* Section 4: Quick Actions */}
      <Card>
        <CardHeader>Quick Actions</CardHeader>
        <CardBody>
          <Button onClick={handleSuspendAccount}>
            Suspend Account
          </Button>
          <Button onClick={handleResetLimits}>
            Reset Usage Limits
          </Button>
          <Button onClick={handleViewAuditLog}>
            View Audit Log
          </Button>
        </CardBody>
      </Card>
    </AdminLayout>
  )
}

// Handler functions
async function handleStatusChange(newStatus: string) {
  const reason = prompt('Reason for change:')
  
  await adminSupabase
    .from('tenant_accounts')
    .update({ 
      account_status: newStatus,
      account_status_reason: reason
    })
    .eq('tenant_id', tenantId)

  // Log audit trail
  await adminSupabase.from('system_audit_log').insert({
    event_type: 'account_status_changed',
    event_category: 'tenant_management',
    actor_email: session.user.email,
    target_id: tenantId,
    old_value: { status: tenant.account_status },
    new_value: { status: newStatus, reason }
  })

  toast.success(`Account ${newStatus}`)
  revalidate()
}

async function handleModuleToggle(moduleName: string) {
  // Determine which plan includes this module
  const requiredPlan = moduleName === 'draft' ? 'pro' : 'enterprise'
  
  const confirm = window.confirm(
    `Enabling ${moduleName} requires upgrading to ${requiredPlan}. Continue?`
  )
  
  if (confirm) {
    await upgradeTenantPlan(tenantId, requiredPlan)
    toast.success(`${moduleName} module enabled`)
  }
}
```

---

## 🎯 Key Takeaways

### ✅ **What We Built:**
- Account status toggle (no database switch)
- Module access control (feature flags)
- Usage limit management (real-time enforcement)
- Feature flag system (gradual rollout)

### ✅ **What We Did NOT Build:**
- ❌ "Testing mode" / "Production mode" database switch
- ❌ Sandbox environment toggle (too expensive)
- ❌ Multiple databases per tenant (wasteful)

### ✅ **Why This Approach Works:**
1. **Lower Cost:** One database per tenant
2. **Simpler:** No database switching logic
3. **Safer:** No risk of connecting to wrong DB
4. **Faster:** Instant feature toggles
5. **Industry Standard:** How SaaS companies work

---

**Questions?** See:
- `003_saas_admin_schema.sql` - Full schema
- `SAAS_ADMIN_IMPLEMENTATION_GUIDE.md` - Complete guide
- `lib/supabaseClient.ts` - Database connections

**Deploy:** Copy schema to Supabase SQL Editor → Run → Done! ✅

