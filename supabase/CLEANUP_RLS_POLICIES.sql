-- ============================================
-- CLEANUP: Remove Duplicate/Conflicting RLS Policies
-- You have multiple INSERT policies which may conflict
-- This script removes duplicates and keeps only the working one
-- ============================================

-- Step 1: Drop ALL existing policies on firm_applications
-- This ensures a clean slate
DROP POLICY IF EXISTS "Anyone can submit firm application" ON firm_applications;
DROP POLICY IF EXISTS "Public can insert firm applications" ON firm_applications;
DROP POLICY IF EXISTS "Authenticated users can view all firm applications" ON firm_applications;
DROP POLICY IF EXISTS "Authenticated users can update firm applications" ON firm_applications;
DROP POLICY IF EXISTS "Authenticated users can view all applications" ON firm_applications;
DROP POLICY IF EXISTS "Authenticated users can update applications" ON firm_applications;

-- Step 2: Ensure RLS is enabled
ALTER TABLE firm_applications ENABLE ROW LEVEL SECURITY;

-- Step 3: Create ONLY the policies we need

-- Policy 1: Allow PUBLIC (anonymous) to INSERT (for form submissions)
-- This is CRITICAL - allows website visitors to submit forms
CREATE POLICY "Public can insert firm applications"
ON firm_applications
FOR INSERT
TO public
WITH CHECK (true);

-- Policy 2: Allow authenticated users to view all (for admin dashboard)
-- Note: This requires authentication, won't work with anon key
CREATE POLICY "Authenticated users can view all firm applications"
ON firm_applications
FOR SELECT
TO authenticated
USING (true);

-- Policy 3: Allow authenticated users to update (for admin dashboard)
CREATE POLICY "Authenticated users can update firm applications"
ON firm_applications
FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (true);

-- Step 4: Verify - you should see exactly 3 policies
SELECT 
    policyname,
    cmd as command,
    roles,
    with_check
FROM pg_policies
WHERE tablename = 'firm_applications'
ORDER BY policyname;

-- Expected result:
-- 1. "Authenticated users can update firm applications" - UPDATE
-- 2. "Authenticated users can view all firm applications" - SELECT  
-- 3. "Public can insert firm applications" - INSERT (with_check: true)

