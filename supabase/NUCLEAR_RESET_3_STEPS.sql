-- ============================================
-- NUCLEAR OPTION - 3-COMMAND TOTAL RESET
-- Scorched-earth fix - removes every possible gate
-- Run each step separately, test after Step 2
-- ============================================

-- ============================================
-- STEP 1: KILL THE TABLE + POLICIES + ROLES
-- ============================================
DROP TABLE IF EXISTS firm_applications CASCADE;

DROP POLICY IF EXISTS "allow_all" ON firm_applications;
DROP POLICY IF EXISTS "Anyone can submit firm application" ON firm_applications;
DROP POLICY IF EXISTS "Public can insert firm applications" ON firm_applications;
DROP POLICY IF EXISTS "anon_insert_firm_applications" ON firm_applications;
DROP POLICY IF EXISTS "public_insert_firm_applications" ON firm_applications;
DROP POLICY IF EXISTS "anon_can_insert" ON firm_applications;
DROP POLICY IF EXISTS "public_can_insert" ON firm_applications;
DROP POLICY IF EXISTS "anon_insert_all" ON firm_applications;
DROP POLICY IF EXISTS "public_insert_all" ON firm_applications;
DROP POLICY IF EXISTS "authenticated_insert_all" ON firm_applications;

REVOKE ALL ON SCHEMA public FROM anon, authenticated, service_role;

-- ============================================
-- STEP 2: RECREATE SKELETON (NO RLS, NO DEFAULTS, NO FUNCTIONS)
-- ============================================
CREATE TABLE firm_applications (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email       TEXT NOT NULL,
    created_at  TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE firm_applications DISABLE ROW LEVEL SECURITY;

GRANT ALL ON TABLE firm_applications TO anon;
GRANT ALL ON TABLE firm_applications TO public;

-- Note: UUID uses gen_random_uuid(), not sequences, but grant anyway if sequence exists
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_class WHERE relname = 'firm_applications_id_seq') THEN
        GRANT ALL ON SEQUENCE firm_applications_id_seq TO anon;
        GRANT ALL ON SEQUENCE firm_applications_id_seq TO public;
    END IF;
END $$;

-- Verify table exists and RLS is disabled
SELECT 
    'Step 2 Complete' as status,
    tablename,
    rowsecurity as rls_enabled
FROM pg_tables
WHERE tablename = 'firm_applications';

-- RLS should be disabled (rowsecurity = 'f')

-- ============================================
-- STEP 3: TEST INSERT (Run this to verify)
-- ============================================
INSERT INTO firm_applications (email) VALUES ('nuke@test.com');

SELECT * FROM firm_applications WHERE email = 'nuke@test.com';

-- If you see a row, the table works!
-- Now test with curl or the form

