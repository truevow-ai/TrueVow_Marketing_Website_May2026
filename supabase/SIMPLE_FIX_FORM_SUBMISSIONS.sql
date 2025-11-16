-- ============================================
-- SIMPLE FIX: Form Submissions Database Setup
-- Run this in Supabase SQL Editor
-- If you get authorization errors, run each section separately
-- ============================================

-- ============================================
-- STEP 1: CREATE TABLE (if it doesn't exist)
-- ============================================
CREATE TABLE IF NOT EXISTS firm_applications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
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
-- STEP 2: ADD MISSING COLUMNS (Run separately if needed)
-- ============================================

-- Add first_name if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS first_name VARCHAR(255);

-- Add last_name if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS last_name VARCHAR(255);

-- Add phone if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS phone VARCHAR(50);

-- Add firm_name if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS firm_name VARCHAR(255);

-- Add practice_area if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS practice_area VARCHAR(255);

-- Add state if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS state VARCHAR(50);

-- Add desired_county if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS desired_county VARCHAR(255);

-- Add firm_size if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS firm_size VARCHAR(50);

-- Add monthly_calls if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS monthly_calls VARCHAR(50);

-- Add referral_source if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS referral_source VARCHAR(255);

-- Add bar_number if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS bar_number VARCHAR(100);

-- Add firm_website if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS firm_website VARCHAR(255);

-- Add eligibility_1 if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS eligibility_1 BOOLEAN DEFAULT false;

-- Add eligibility_2 if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS eligibility_2 BOOLEAN DEFAULT false;

-- Add eligibility_3 if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS eligibility_3 BOOLEAN DEFAULT false;

-- Add eligibility_4 if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS eligibility_4 BOOLEAN DEFAULT false;

-- Add founding_member_interest if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS founding_member_interest BOOLEAN DEFAULT false;

-- Add settle_interest if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS settle_interest BOOLEAN DEFAULT false;

-- Add terms_agree if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS terms_agree BOOLEAN DEFAULT false;

-- Add consider_founding_member_future if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS consider_founding_member_future BOOLEAN DEFAULT false;

-- Add early_access_settle if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS early_access_settle BOOLEAN DEFAULT false;

-- Add application_source if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS application_source VARCHAR(100) DEFAULT 'apply_page';

-- Add status if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS status VARCHAR(50) DEFAULT 'pending';

-- Add notes if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS notes TEXT;

-- Add created_at if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT NOW();

-- Add updated_at if missing
ALTER TABLE firm_applications ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT NOW();

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

-- Drop existing policy if it exists
DROP POLICY IF EXISTS "Public can insert firm applications" ON firm_applications;

-- Create policy to allow PUBLIC to INSERT (for form submissions)
CREATE POLICY "Public can insert firm applications"
ON firm_applications
FOR INSERT
TO public
WITH CHECK (true);

-- ============================================
-- STEP 5: VERIFICATION
-- ============================================

-- Verify all columns exist
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'firm_applications' 
ORDER BY ordinal_position;

-- Verify RLS is enabled
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE tablename = 'firm_applications';

-- Verify policy exists
SELECT policyname, cmd 
FROM pg_policies 
WHERE tablename = 'firm_applications';

