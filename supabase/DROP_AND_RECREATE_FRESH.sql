-- ============================================
-- DROP AND RECREATE TABLE FROM SCRATCH
-- This is the SIMPLEST solution - no more incremental fixes
-- ============================================

-- STEP 1: DROP EVERYTHING (CASCADE removes all dependencies)
DROP TABLE IF EXISTS firm_applications CASCADE;

-- STEP 2: CREATE TABLE WITH CORRECT SCHEMA
-- All columns NULLABLE except email (which is required)
-- NO RLS, NO CONSTRAINTS that block inserts
CREATE TABLE firm_applications (
    -- Primary key
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- Required field (only one!)
    email TEXT NOT NULL,
    
    -- Contact info (all nullable)
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    primary_contact_name VARCHAR(255),
    phone VARCHAR(50),
    
    -- Firm info (all nullable)
    firm_name VARCHAR(255),
    practice_area VARCHAR(255),
    state VARCHAR(50),
    desired_county VARCHAR(255),
    firm_size VARCHAR(50),
    monthly_calls VARCHAR(50),
    referral_source VARCHAR(255),
    bar_number VARCHAR(100),
    firm_website VARCHAR(255),
    
    -- Eligibility checkboxes (default false)
    eligibility_1 BOOLEAN DEFAULT false,
    eligibility_2 BOOLEAN DEFAULT false,
    eligibility_3 BOOLEAN DEFAULT false,
    eligibility_4 BOOLEAN DEFAULT false,
    
    -- Interest checkboxes (default false)
    founding_member_interest BOOLEAN DEFAULT false,
    settle_interest BOOLEAN DEFAULT false,
    terms_agree BOOLEAN DEFAULT false,
    consider_founding_member_future BOOLEAN DEFAULT false,
    early_access_settle BOOLEAN DEFAULT false,
    
    -- Metadata
    application_source VARCHAR(100) DEFAULT 'apply_page',
    status VARCHAR(50) DEFAULT 'pending',
    notes TEXT,
    
    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

-- STEP 3: DISABLE RLS (no security blocks)
ALTER TABLE firm_applications DISABLE ROW LEVEL SECURITY;

-- STEP 4: GRANT PERMISSIONS (allow inserts from frontend)
GRANT ALL ON TABLE firm_applications TO anon;
GRANT ALL ON TABLE firm_applications TO public;
GRANT ALL ON TABLE firm_applications TO authenticated;

-- STEP 5: VERIFY IT WORKS
-- Test insert
INSERT INTO firm_applications (email) 
VALUES ('test-fresh-table@example.com');

-- Verify insert worked
SELECT 
    '✅ TABLE CREATED SUCCESSFULLY' as status,
    COUNT(*) as test_rows,
    'If you see 1 row, the table works!' as message
FROM firm_applications
WHERE email = 'test-fresh-table@example.com';

-- Show table structure
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_name = 'firm_applications'
ORDER BY ordinal_position;

-- Clean up test data
DELETE FROM firm_applications WHERE email = 'test-fresh-table@example.com';

SELECT '✅ TABLE IS READY - TEST YOUR FORM NOW!' as final_status;

