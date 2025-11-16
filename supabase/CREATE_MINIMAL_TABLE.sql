-- ============================================
-- CREATE MINIMAL TABLE (If it doesn't exist)
-- Run this if you get "relation does not exist" error
-- ============================================

-- Create the minimal table (email only, NO RLS)
CREATE TABLE IF NOT EXISTS firm_applications (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email       TEXT NOT NULL,
    created_at  TIMESTAMPTZ DEFAULT now()
);

-- Disable RLS (critical - this allows inserts)
ALTER TABLE firm_applications DISABLE ROW LEVEL SECURITY;

-- Grant permissions to anon and public
GRANT ALL ON TABLE firm_applications TO anon;
GRANT ALL ON TABLE firm_applications TO public;

-- Verify table exists and RLS is disabled
SELECT 
    'Table Status' as check_type,
    tablename,
    rowsecurity as rls_enabled,
    CASE WHEN rowsecurity THEN 'RLS ENABLED (BAD)' ELSE 'RLS DISABLED (GOOD)' END as status
FROM pg_tables
WHERE tablename = 'firm_applications';

-- Verify grants
SELECT 
    'Grants' as check_type,
    grantee,
    privilege_type
FROM information_schema.role_table_grants
WHERE table_name = 'firm_applications'
AND grantee IN ('anon', 'public')
ORDER BY grantee, privilege_type;

-- Test insert
INSERT INTO firm_applications (email) 
VALUES ('test-minimal@example.com')
ON CONFLICT DO NOTHING;

-- Verify insert worked
SELECT 
    'Test Result' as check_type,
    COUNT(*) as rows_inserted,
    'If you see 1, the table works!' as message
FROM firm_applications
WHERE email = 'test-minimal@example.com';

SELECT '✅ MINIMAL TABLE CREATED - Test your form now!' as final_status;

