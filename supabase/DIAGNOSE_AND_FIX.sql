-- ============================================
-- COMPLETE DIAGNOSTIC AND FIX
-- This will diagnose the issue and fix it
-- ============================================

-- Step 1: Check current RLS status
SELECT 
    'RLS Status' as check_type,
    tablename,
    rowsecurity as rls_enabled
FROM pg_tables
WHERE schemaname = 'public'
AND tablename = 'firm_applications';

-- Step 2: List ALL current policies
SELECT 
    'Current Policies' as check_type,
    policyname,
    cmd as command,
    roles,
    qual,
    with_check
FROM pg_policies
WHERE tablename = 'firm_applications';

-- Step 3: Check if table exists and has columns
SELECT 
    'Table Columns' as check_type,
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
AND table_name = 'firm_applications'
ORDER BY ordinal_position;

-- Step 4: TEMPORARILY DISABLE RLS (to test if RLS is the issue)
-- WARNING: This makes the table accessible to everyone
-- We'll re-enable it after testing
ALTER TABLE firm_applications DISABLE ROW LEVEL SECURITY;

-- Step 5: Try to insert a test row (this should work now)
-- If this fails, the issue is NOT RLS - it's something else
INSERT INTO firm_applications (
    email, first_name, last_name, phone, firm_name
) VALUES (
    'test-rls-diagnosis@example.com',
    'Test',
    'User',
    '5551234567',
    'Test Firm'
) ON CONFLICT DO NOTHING;

-- Step 6: Check if the insert worked
SELECT 
    'Test Insert Result' as check_type,
    COUNT(*) as rows_inserted
FROM firm_applications
WHERE email = 'test-rls-diagnosis@example.com';

-- Step 7: RE-ENABLE RLS
ALTER TABLE firm_applications ENABLE ROW LEVEL SECURITY;

-- Step 8: Drop ALL existing policies
DROP POLICY IF EXISTS "Anyone can submit firm application" ON firm_applications;
DROP POLICY IF EXISTS "Public can insert firm applications" ON firm_applications;
DROP POLICY IF EXISTS "anon_insert_firm_applications" ON firm_applications;
DROP POLICY IF EXISTS "public_insert_firm_applications" ON firm_applications;
DROP POLICY IF EXISTS "Authenticated users can view all firm applications" ON firm_applications;
DROP POLICY IF EXISTS "Authenticated users can update firm applications" ON firm_applications;
DROP POLICY IF EXISTS "Authenticated users can view all applications" ON firm_applications;
DROP POLICY IF EXISTS "Authenticated users can update applications" ON firm_applications;

-- Step 9: Create a PERMISSIVE policy (allows everything)
-- Using PERMISSIVE (default) and WITH CHECK (true) - most permissive possible
CREATE POLICY "Allow all inserts for anon"
ON firm_applications
AS PERMISSIVE
FOR INSERT
TO anon
WITH CHECK (true);

-- Step 10: Also create for authenticated role (in case)
CREATE POLICY "Allow all inserts for authenticated"
ON firm_applications
AS PERMISSIVE
FOR INSERT
TO authenticated
WITH CHECK (true);

-- Step 11: Create for public role too
CREATE POLICY "Allow all inserts for public"
ON firm_applications
AS PERMISSIVE
FOR INSERT
TO public
WITH CHECK (true);

-- Step 12: Verify final state
SELECT 
    'Final Policies' as check_type,
    policyname,
    cmd as command,
    permissive,
    roles,
    with_check
FROM pg_policies
WHERE tablename = 'firm_applications'
ORDER BY policyname;

-- You should see 3 INSERT policies, one for each role (anon, authenticated, public)
-- All should have with_check = 'true'

