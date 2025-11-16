# 🔧 SQL Error Fix - Column "email" Does Not Exist

## ❌ Problem
Error: `ERROR: 42703: column "email" does not exist`

**Cause:** The `firm_applications` table may already exist in your Supabase database with different column names than what the script expects.

## ✅ Solution

I've created a **new, safer SQL script** that:
1. ✅ Checks if tables exist before creating them
2. ✅ Adds missing columns to existing tables (doesn't break existing data)
3. ✅ Creates indexes only if they don't exist
4. ✅ Handles the `firm_applications` table properly

---

## 📋 Step-by-Step Instructions

### Step 1: Run the New SQL Script

1. Open **Supabase Dashboard**: https://supabase.com/dashboard
2. Select your project: **TrueVow-Marketing-Website**
3. Navigate to **SQL Editor**
4. Open the file: `supabase/check-and-create-form-tables.sql`
5. Copy the **entire script**
6. Paste it into the SQL Editor
7. Click **Run** to execute

### Step 2: Verify Success

After running the script, verify it worked by running this query:

```sql
-- Check if all tables exist
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name IN ('firm_applications', 'partner_applications', 'affiliate_applications');

-- Check columns in firm_applications
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'firm_applications' 
ORDER BY ordinal_position;
```

**Expected Result:** You should see all 3 tables and all columns listed.

---

## 🔍 What the New Script Does

### For `firm_applications` Table:
- ✅ Checks if table exists
- ✅ Creates it if it doesn't exist (with all new columns)
- ✅ If table exists, adds any missing columns (doesn't delete existing ones)
- ✅ Preserves all existing data
- ✅ Creates indexes safely (skips if they already exist)

### For `partner_applications` Table:
- ✅ Creates table if it doesn't exist
- ✅ Sets up RLS policies

### For `affiliate_applications` Table:
- ✅ Creates table if it doesn't exist
- ✅ Sets up RLS policies

---

## 📊 Tables That Will Be Created/Updated

1. **`firm_applications`** - Law firm application form submissions
2. **`partner_applications`** - Partner program referral code requests
3. **`affiliate_applications`** - Affiliate program applications

---

## ⚠️ If You Still Get Errors

If you encounter any errors, run this diagnostic query first:

```sql
-- Check what columns currently exist in firm_applications
SELECT column_name, data_type, is_nullable
FROM information_schema.columns 
WHERE table_name = 'firm_applications' 
ORDER BY ordinal_position;
```

Then share the output so we can adjust the script accordingly.

---

## ✅ Success Indicators

After running the script successfully, you should see:
- ✅ All 3 tables exist
- ✅ `firm_applications` has an `email` column
- ✅ All indexes created
- ✅ RLS policies enabled
- ✅ No error messages

**Then test your forms - they should now save data successfully!** 🎉

