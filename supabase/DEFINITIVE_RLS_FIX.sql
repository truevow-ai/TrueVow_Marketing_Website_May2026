-- ============================================
-- DEFINITIVE RLS FIX - Run This Now
-- This explicitly fixes the RLS policy issue
-- ============================================

-- Step 1: Check current state
SELECT 
    'Current Policies' as status,
    policyname,
    cmd,
    roles,
    with_check
FROM pg_policies
WHERE tablename = 'firm_applications';

-- Step 2: Drop ALL existing policies (clean slate)
DROP POLICY IF EXISTS "Anyone can submit firm application" ON firm_applications;
DROP POLICY IF EXISTS "Public can insert firm applications" ON firm_applications;
DROP POLICY IF EXISTS "Authenticated users can view all firm applications" ON firm_applications;
DROP POLICY IF EXISTS "Authenticated users can update firm applications" ON firm_applications;
DROP POLICY IF EXISTS "Authenticated users can view all applications" ON firm_applications;
DROP POLICY IF EXISTS "Authenticated users can update applications" ON firm_applications;

-- Step 3: Ensure RLS is enabled
ALTER TABLE firm_applications ENABLE ROW LEVEL SECURITY;

-- Step 4: Create policy for ANON role (Supabase's anonymous user)
-- This is what the anon key uses
CREATE POLICY "anon_insert_firm_applications"
ON firm_applications
FOR INSERT
TO anon
WITH CHECK (true);

-- Step 5: Also create for public role (belt and suspenders)
CREATE POLICY "public_insert_firm_applications"
ON firm_applications
FOR INSERT
TO public
WITH CHECK (true);

-- Step 6: Verify policies were created
SELECT 
    'After Fix' as status,
    policyname,
    cmd,
    roles,
    with_check
FROM pg_policies
WHERE tablename = 'firm_applications'
ORDER BY policyname;

-- You should see TWO INSERT policies:
-- 1. "anon_insert_firm_applications" for role "anon"
-- 2. "public_insert_firm_applications" for role "public"

