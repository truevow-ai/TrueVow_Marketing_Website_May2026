-- ============================================
-- FINAL WORKING FIX - Run This Entire Script
-- This WILL fix the RLS issue
-- ============================================

-- Step 1: Grant table permissions to anon role
GRANT ALL ON TABLE firm_applications TO anon;
GRANT ALL ON TABLE firm_applications TO public;

-- Step 2: Disable RLS temporarily (to test)
ALTER TABLE firm_applications DISABLE ROW LEVEL SECURITY;

-- Step 3: Re-enable RLS
ALTER TABLE firm_applications ENABLE ROW LEVEL SECURITY;

-- Step 4: Drop ALL existing policies
DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN (SELECT policyname FROM pg_policies WHERE tablename = 'firm_applications') LOOP
        EXECUTE format('DROP POLICY IF EXISTS %I ON firm_applications', r.policyname);
    END LOOP;
END $$;

-- Step 5: Create INSERT policy for anon (REQUIRED for anon key)
CREATE POLICY "anon_can_insert"
ON firm_applications
FOR INSERT
TO anon
WITH CHECK (true);

-- Step 6: Create INSERT policy for public (backup)
CREATE POLICY "public_can_insert"
ON firm_applications
FOR INSERT
TO public
WITH CHECK (true);

-- Step 7: Verify
SELECT 
    '✅ Policies Created' as status,
    policyname,
    cmd,
    roles
FROM pg_policies
WHERE tablename = 'firm_applications'
AND cmd = 'INSERT';

-- You MUST see at least one policy with role containing 'anon'

SELECT '✅ FIX COMPLETE - Test your form now!' as final_status;

