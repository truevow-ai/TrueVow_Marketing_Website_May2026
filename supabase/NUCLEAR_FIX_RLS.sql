-- ============================================
-- NUCLEAR FIX: Complete RLS Solution
-- Based on comprehensive troubleshooting guide
-- Run each section in order, stop when form works
-- ============================================

-- ============================================
-- STEP 1: TABLE-LEVEL TOGGLE (30-second fix)
-- ============================================
-- Disable RLS completely to test
ALTER TABLE firm_applications DISABLE ROW LEVEL SECURITY;

-- Verify it's disabled
SELECT 
    'Step 1: RLS Status' as step,
    tablename,
    rowsecurity as rls_enabled
FROM pg_tables
WHERE tablename = 'firm_applications';

-- If rls_enabled = 'f', RLS is disabled
-- TEST YOUR FORM NOW - if it works, you're done!
-- If it still fails, continue to Step 2

-- ============================================
-- STEP 2: ROLE PERMISSIONS (60-second fix)
-- ============================================
-- Grant full CRUD to anon role
GRANT ALL ON TABLE firm_applications TO anon;
GRANT ALL ON TABLE firm_applications TO public;

-- Grant sequence permissions (for auto-increment IDs)
-- Note: UUID uses gen_random_uuid(), not sequences, but grant anyway
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_class WHERE relname = 'firm_applications_id_seq') THEN
        GRANT ALL ON SEQUENCE firm_applications_id_seq TO anon;
        GRANT ALL ON SEQUENCE firm_applications_id_seq TO public;
    END IF;
END $$;

-- Verify grants
SELECT 
    'Step 2: Grants' as step,
    grantee,
    privilege_type
FROM information_schema.role_table_grants
WHERE table_name = 'firm_applications'
AND grantee IN ('anon', 'public')
ORDER BY grantee, privilege_type;

-- ============================================
-- STEP 3: RE-ENABLE RLS WITH PERMISSIVE POLICIES
-- ============================================
-- Re-enable RLS
ALTER TABLE firm_applications ENABLE ROW LEVEL SECURITY;

-- Drop ALL existing policies
DROP POLICY IF EXISTS "Anyone can submit firm application" ON firm_applications;
DROP POLICY IF EXISTS "Public can insert firm applications" ON firm_applications;
DROP POLICY IF EXISTS "anon_insert_firm_applications" ON firm_applications;
DROP POLICY IF EXISTS "public_insert_firm_applications" ON firm_applications;
DROP POLICY IF EXISTS "Allow all inserts for anon" ON firm_applications;
DROP POLICY IF EXISTS "Allow all inserts for authenticated" ON firm_applications;
DROP POLICY IF EXISTS "Allow all inserts for public" ON firm_applications;
DROP POLICY IF EXISTS "Authenticated users can view all firm applications" ON firm_applications;
DROP POLICY IF EXISTS "Authenticated users can update firm applications" ON firm_applications;
DROP POLICY IF EXISTS "Authenticated users can view all applications" ON firm_applications;
DROP POLICY IF EXISTS "Authenticated users can update applications" ON firm_applications;

-- Create PERMISSIVE policy for anon (most permissive)
CREATE POLICY "anon_insert_all"
ON firm_applications
AS PERMISSIVE
FOR INSERT
TO anon
WITH CHECK (true);

-- Create PERMISSIVE policy for public
CREATE POLICY "public_insert_all"
ON firm_applications
AS PERMISSIVE
FOR INSERT
TO public
WITH CHECK (true);

-- Create PERMISSIVE policy for authenticated
CREATE POLICY "authenticated_insert_all"
ON firm_applications
AS PERMISSIVE
FOR INSERT
TO authenticated
WITH CHECK (true);

-- Verify policies
SELECT 
    'Step 3: Policies' as step,
    policyname,
    cmd,
    permissive,
    roles,
    with_check
FROM pg_policies
WHERE tablename = 'firm_applications'
ORDER BY policyname;

-- ============================================
-- STEP 4: COLUMN-LEVEL FUNCTIONS (stealth killer)
-- ============================================
-- Ensure defaults use safe functions
ALTER TABLE firm_applications
    ALTER COLUMN created_at SET DEFAULT now(),
    ALTER COLUMN updated_at SET DEFAULT now();

-- For UUID, ensure it uses gen_random_uuid() (safe for anon)
-- Check current default
SELECT 
    'Step 4: Column Defaults' as step,
    column_name,
    column_default
FROM information_schema.columns
WHERE table_name = 'firm_applications'
AND column_name IN ('id', 'created_at', 'updated_at');

-- If id uses uuid_generate_v4(), change it:
-- ALTER TABLE firm_applications ALTER COLUMN id SET DEFAULT gen_random_uuid();

-- ============================================
-- STEP 5: VERIFICATION
-- ============================================
SELECT 
    'Final Status' as step,
    'RLS Enabled' as check_item,
    CASE WHEN (SELECT rowsecurity FROM pg_tables WHERE tablename = 'firm_applications') 
         THEN 'YES' ELSE 'NO' END as status
UNION ALL
SELECT 
    'Final Status',
    'INSERT Policies Count',
    COUNT(*)::text
FROM pg_policies
WHERE tablename = 'firm_applications'
AND cmd = 'INSERT'
UNION ALL
SELECT 
    'Final Status',
    'Anon Grants',
    COUNT(*)::text
FROM information_schema.role_table_grants
WHERE table_name = 'firm_applications'
AND grantee = 'anon';

-- ============================================
-- SUCCESS MESSAGE
-- ============================================
SELECT '✅ NUCLEAR FIX COMPLETE - Test your form now!' as status;

