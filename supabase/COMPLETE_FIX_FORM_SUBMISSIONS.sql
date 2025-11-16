-- ============================================
-- COMPLETE FIX: Form Submissions Database Setup
-- This script fixes ALL issues in one go:
-- 1. Creates table if it doesn't exist
-- 2. Adds ALL missing columns
-- 3. Sets up proper RLS policies
-- 4. Verifies everything works
-- ============================================

-- ============================================
-- STEP 1: CREATE TABLE (if it doesn't exist)
-- ============================================
CREATE TABLE IF NOT EXISTS firm_applications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(50),
    firm_name VARCHAR(255),
    practice_area VARCHAR(255),
    state VARCHAR(50),
    desired_county VARCHAR(255),
    firm_size VARCHAR(50),
    monthly_calls VARCHAR(50),
    referral_source VARCHAR(255),
    bar_number VARCHAR(100),
    firm_website VARCHAR(255),
    eligibility_1 BOOLEAN DEFAULT false,
    eligibility_2 BOOLEAN DEFAULT false,
    eligibility_3 BOOLEAN DEFAULT false,
    eligibility_4 BOOLEAN DEFAULT false,
    founding_member_interest BOOLEAN DEFAULT false,
    settle_interest BOOLEAN DEFAULT false,
    terms_agree BOOLEAN DEFAULT false,
    consider_founding_member_future BOOLEAN DEFAULT false,
    early_access_settle BOOLEAN DEFAULT false,
    application_source VARCHAR(100) DEFAULT 'apply_page',
    status VARCHAR(50) DEFAULT 'pending',
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- ============================================
-- STEP 2: ADD ALL MISSING COLUMNS
-- ============================================
DO $$
BEGIN
    -- Contact information
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'first_name') THEN
        ALTER TABLE firm_applications ADD COLUMN first_name VARCHAR(255);
        RAISE NOTICE '✅ Added: first_name';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'last_name') THEN
        ALTER TABLE firm_applications ADD COLUMN last_name VARCHAR(255);
        RAISE NOTICE '✅ Added: last_name';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'email') THEN
        ALTER TABLE firm_applications ADD COLUMN email VARCHAR(255);
        RAISE NOTICE '✅ Added: email';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'phone') THEN
        ALTER TABLE firm_applications ADD COLUMN phone VARCHAR(50);
        RAISE NOTICE '✅ Added: phone';
    END IF;
    
    -- Firm information
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'firm_name') THEN
        ALTER TABLE firm_applications ADD COLUMN firm_name VARCHAR(255);
        RAISE NOTICE '✅ Added: firm_name';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'practice_area') THEN
        ALTER TABLE firm_applications ADD COLUMN practice_area VARCHAR(255);
        RAISE NOTICE '✅ Added: practice_area';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'state') THEN
        ALTER TABLE firm_applications ADD COLUMN state VARCHAR(50);
        RAISE NOTICE '✅ Added: state';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'desired_county') THEN
        ALTER TABLE firm_applications ADD COLUMN desired_county VARCHAR(255);
        RAISE NOTICE '✅ Added: desired_county';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'firm_size') THEN
        ALTER TABLE firm_applications ADD COLUMN firm_size VARCHAR(50);
        RAISE NOTICE '✅ Added: firm_size';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'monthly_calls') THEN
        ALTER TABLE firm_applications ADD COLUMN monthly_calls VARCHAR(50);
        RAISE NOTICE '✅ Added: monthly_calls';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'referral_source') THEN
        ALTER TABLE firm_applications ADD COLUMN referral_source VARCHAR(255);
        RAISE NOTICE '✅ Added: referral_source';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'bar_number') THEN
        ALTER TABLE firm_applications ADD COLUMN bar_number VARCHAR(100);
        RAISE NOTICE '✅ Added: bar_number';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'firm_website') THEN
        ALTER TABLE firm_applications ADD COLUMN firm_website VARCHAR(255);
        RAISE NOTICE '✅ Added: firm_website';
    END IF;
    
    -- Eligibility checkboxes
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'eligibility_1') THEN
        ALTER TABLE firm_applications ADD COLUMN eligibility_1 BOOLEAN DEFAULT false;
        RAISE NOTICE '✅ Added: eligibility_1';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'eligibility_2') THEN
        ALTER TABLE firm_applications ADD COLUMN eligibility_2 BOOLEAN DEFAULT false;
        RAISE NOTICE '✅ Added: eligibility_2';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'eligibility_3') THEN
        ALTER TABLE firm_applications ADD COLUMN eligibility_3 BOOLEAN DEFAULT false;
        RAISE NOTICE '✅ Added: eligibility_3';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'eligibility_4') THEN
        ALTER TABLE firm_applications ADD COLUMN eligibility_4 BOOLEAN DEFAULT false;
        RAISE NOTICE '✅ Added: eligibility_4';
    END IF;
    
    -- Interest checkboxes
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'founding_member_interest') THEN
        ALTER TABLE firm_applications ADD COLUMN founding_member_interest BOOLEAN DEFAULT false;
        RAISE NOTICE '✅ Added: founding_member_interest';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'settle_interest') THEN
        ALTER TABLE firm_applications ADD COLUMN settle_interest BOOLEAN DEFAULT false;
        RAISE NOTICE '✅ Added: settle_interest';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'terms_agree') THEN
        ALTER TABLE firm_applications ADD COLUMN terms_agree BOOLEAN DEFAULT false;
        RAISE NOTICE '✅ Added: terms_agree';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'consider_founding_member_future') THEN
        ALTER TABLE firm_applications ADD COLUMN consider_founding_member_future BOOLEAN DEFAULT false;
        RAISE NOTICE '✅ Added: consider_founding_member_future';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'early_access_settle') THEN
        ALTER TABLE firm_applications ADD COLUMN early_access_settle BOOLEAN DEFAULT false;
        RAISE NOTICE '✅ Added: early_access_settle';
    END IF;
    
    -- Metadata
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'application_source') THEN
        ALTER TABLE firm_applications ADD COLUMN application_source VARCHAR(100) DEFAULT 'apply_page';
        RAISE NOTICE '✅ Added: application_source';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'status') THEN
        ALTER TABLE firm_applications ADD COLUMN status VARCHAR(50) DEFAULT 'pending';
        RAISE NOTICE '✅ Added: status';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'notes') THEN
        ALTER TABLE firm_applications ADD COLUMN notes TEXT;
        RAISE NOTICE '✅ Added: notes';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'created_at') THEN
        ALTER TABLE firm_applications ADD COLUMN created_at TIMESTAMP DEFAULT NOW();
        RAISE NOTICE '✅ Added: created_at';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'updated_at') THEN
        ALTER TABLE firm_applications ADD COLUMN updated_at TIMESTAMP DEFAULT NOW();
        RAISE NOTICE '✅ Added: updated_at';
    END IF;
END $$;

-- ============================================
-- STEP 3: CREATE INDEXES
-- ============================================
CREATE INDEX IF NOT EXISTS idx_firm_applications_email ON firm_applications(email);
CREATE INDEX IF NOT EXISTS idx_firm_applications_status ON firm_applications(status);
CREATE INDEX IF NOT EXISTS idx_firm_applications_created_at ON firm_applications(created_at);

-- ============================================
-- STEP 4: SET UP RLS POLICIES (CRITICAL!)
-- ============================================

-- Enable RLS
ALTER TABLE firm_applications ENABLE ROW LEVEL SECURITY;

-- Drop existing policies (if any)
DROP POLICY IF EXISTS "Public can insert firm applications" ON firm_applications;
DROP POLICY IF EXISTS "Public can view firm applications" ON firm_applications;
DROP POLICY IF EXISTS "Authenticated users can view all applications" ON firm_applications;
DROP POLICY IF EXISTS "Authenticated users can update applications" ON firm_applications;

-- Policy 1: Allow PUBLIC to INSERT (for form submissions)
-- This is the critical policy that was missing!
CREATE POLICY "Public can insert firm applications"
ON firm_applications
FOR INSERT
TO public
WITH CHECK (true);

-- Policy 2: Allow PUBLIC to SELECT their own applications (optional, for confirmation)
-- Currently disabled - uncomment if you want users to see their own submissions
-- CREATE POLICY "Public can view own applications"
-- ON firm_applications
-- FOR SELECT
-- TO public
-- USING (true);

-- Policy 3: Allow authenticated users (admin) to view all (for admin dashboard)
-- Note: This requires authentication, so it won't work with anon key
-- If you need admin access, use service_role key or set up proper auth
CREATE POLICY "Authenticated users can view all applications"
ON firm_applications
FOR SELECT
TO authenticated
USING (true);

-- Policy 4: Allow authenticated users (admin) to update (for admin dashboard)
CREATE POLICY "Authenticated users can update applications"
ON firm_applications
FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (true);

-- ============================================
-- STEP 5: VERIFICATION
-- ============================================

-- Verify all columns exist
SELECT 
    'Column verification' as check_type,
    COUNT(*) as total_columns,
    STRING_AGG(column_name, ', ' ORDER BY ordinal_position) as columns
FROM information_schema.columns
WHERE table_schema = 'public'
AND table_name = 'firm_applications';

-- Verify RLS is enabled
SELECT 
    'RLS Status' as check_type,
    tablename,
    rowsecurity as rls_enabled
FROM pg_tables
WHERE schemaname = 'public'
AND tablename = 'firm_applications';

-- Verify policies exist
SELECT 
    'RLS Policies' as check_type,
    tablename,
    policyname,
    cmd as command,
    roles
FROM pg_policies
WHERE tablename = 'firm_applications'
ORDER BY policyname;

-- Verify indexes exist
SELECT 
    'Indexes' as check_type,
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
AND tablename = 'firm_applications';

-- ============================================
-- SUCCESS MESSAGE
-- ============================================
SELECT '✅ COMPLETE FIX APPLIED SUCCESSFULLY!' as status;

