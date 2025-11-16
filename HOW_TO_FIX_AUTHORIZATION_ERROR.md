# How to Fix Authorization Error in Supabase

## Error: "Failed to perform authorization check. Please try again later."

This error usually means one of the following:

### Solution 1: Run Scripts Separately

If the comprehensive script fails, try running smaller scripts:

1. **First, run `supabase/FIX_RLS_POLICY_ONLY.sql`** (just fixes the RLS policy)
2. **Then, run `supabase/SIMPLE_FIX_FORM_SUBMISSIONS.sql`** (adds columns)

### Solution 2: Use Supabase Table Editor (GUI Method)

If SQL scripts keep failing, use the Supabase Dashboard:

1. **Go to Supabase Dashboard** → Your Project
2. **Click "Table Editor"** (left sidebar)
3. **Find `firm_applications` table**
4. **If table doesn't exist, click "New Table"**:
   - Table name: `firm_applications`
   - Enable RLS: ✅ (checked)
   - Add columns (see list below)

5. **If table exists, click on it** and add missing columns:
   - Click "Add Column" for each missing column
   - Use the column list below

6. **Set up RLS Policy**:
   - Go to "Authentication" → "Policies"
   - Or go to "Table Editor" → `firm_applications` → "Policies" tab
   - Click "New Policy"
   - Name: "Public can insert firm applications"
   - Allowed operation: INSERT
   - Target roles: public
   - Policy definition: `true` (allow all)

### Solution 3: Check Your Permissions

1. **Make sure you're logged into Supabase**
2. **Verify you're the project owner** or have admin access
3. **Try refreshing the page** and running the script again

### Solution 4: Run Column Adds One at a Time

If bulk scripts fail, add columns one by one:

```sql
-- Run these one at a time, waiting for each to complete
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS phone VARCHAR(50);
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS bar_number VARCHAR(100);
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS first_name VARCHAR(255);
-- ... etc for each column
```

Then run the RLS policy script separately.

---

## Required Columns for firm_applications Table

Here's the complete list of columns you need:

### Contact Information
- `first_name` (VARCHAR(255))
- `last_name` (VARCHAR(255))
- `email` (VARCHAR(255), NOT NULL)
- `phone` (VARCHAR(50))

### Firm Information
- `firm_name` (VARCHAR(255))
- `practice_area` (VARCHAR(255))
- `state` (VARCHAR(50))
- `desired_county` (VARCHAR(255))
- `firm_size` (VARCHAR(50))
- `monthly_calls` (VARCHAR(50))
- `referral_source` (VARCHAR(255))
- `bar_number` (VARCHAR(100))
- `firm_website` (VARCHAR(255))

### Eligibility & Interest
- `eligibility_1` (BOOLEAN, default false)
- `eligibility_2` (BOOLEAN, default false)
- `eligibility_3` (BOOLEAN, default false)
- `eligibility_4` (BOOLEAN, default false)
- `founding_member_interest` (BOOLEAN, default false)
- `settle_interest` (BOOLEAN, default false)
- `terms_agree` (BOOLEAN, default false)
- `consider_founding_member_future` (BOOLEAN, default false)
- `early_access_settle` (BOOLEAN, default false)

### Metadata
- `application_source` (VARCHAR(100), default 'apply_page')
- `status` (VARCHAR(50), default 'pending')
- `notes` (TEXT)
- `created_at` (TIMESTAMP, default NOW())
- `updated_at` (TIMESTAMP, default NOW())
- `id` (UUID, primary key, auto-generated)

---

## Critical: RLS Policy Setup

**Without this policy, form submissions will fail with "row-level security policy" error.**

Policy Name: `Public can insert firm applications`
- Operation: INSERT
- Target: public
- Policy: `WITH CHECK (true)`

---

## Verification

After running scripts, verify:

```sql
-- Check columns exist
SELECT column_name FROM information_schema.columns 
WHERE table_name = 'firm_applications';

-- Check RLS is enabled
SELECT rowsecurity FROM pg_tables WHERE tablename = 'firm_applications';

-- Check policy exists
SELECT policyname FROM pg_policies WHERE tablename = 'firm_applications';
```

---

## Still Having Issues?

1. **Wait 30 seconds** and try again (Supabase cache might need to refresh)
2. **Check Supabase status page** (might be a temporary outage)
3. **Try using Supabase CLI** instead of web interface
4. **Contact Supabase support** if the issue persists

