-- ============================================
-- TEMPORARY FIX: Disable RLS to Test
-- ONLY use this to verify RLS is the issue
-- Then run the proper fix script
-- ============================================

-- Temporarily disable RLS
ALTER TABLE firm_applications DISABLE ROW LEVEL SECURITY;

-- Verify it's disabled
SELECT 
    tablename,
    rowsecurity as rls_enabled
FROM pg_tables
WHERE tablename = 'firm_applications';

-- If rls_enabled is 'f', RLS is disabled
-- Try submitting the form now - if it works, RLS was the issue
-- If it still fails, the issue is something else (missing columns, etc.)

-- IMPORTANT: After testing, RE-ENABLE RLS and create proper policies:
-- ALTER TABLE firm_applications ENABLE ROW LEVEL SECURITY;
-- Then run: supabase/DIAGNOSE_AND_FIX.sql

