-- ============================================
-- Check and Create Form Submission Tables
-- This script checks existing tables and creates/updates them accordingly
-- ============================================

-- ============================================
-- 1. CHECK EXISTING firm_applications TABLE
-- ============================================

-- First, let's see what columns exist in firm_applications (if it exists)
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables WHERE table_name = 'firm_applications') THEN
        RAISE NOTICE 'Table firm_applications already exists. Checking columns...';
    ELSE
        RAISE NOTICE 'Table firm_applications does not exist. Creating it...';
        
        CREATE TABLE firm_applications (
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
    END IF;
END $$;

-- Add missing columns to existing firm_applications table (if it exists)
DO $$
BEGIN
    -- Add first_name if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'first_name') THEN
        ALTER TABLE firm_applications ADD COLUMN first_name VARCHAR(255);
    END IF;
    
    -- Add last_name if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'last_name') THEN
        ALTER TABLE firm_applications ADD COLUMN last_name VARCHAR(255);
    END IF;
    
    -- Ensure email exists (it should, but just in case)
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'email') THEN
        ALTER TABLE firm_applications ADD COLUMN email VARCHAR(255);
    END IF;
    
    -- Add phone if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'phone') THEN
        ALTER TABLE firm_applications ADD COLUMN phone VARCHAR(50);
    END IF;
    
    -- Add firm_name if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'firm_name') THEN
        ALTER TABLE firm_applications ADD COLUMN firm_name VARCHAR(255);
    END IF;
    
    -- Add practice_area if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'practice_area') THEN
        ALTER TABLE firm_applications ADD COLUMN practice_area VARCHAR(255);
    END IF;
    
    -- Add state if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'state') THEN
        ALTER TABLE firm_applications ADD COLUMN state VARCHAR(50);
    END IF;
    
    -- Add other new columns that might be missing
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'desired_county') THEN
        ALTER TABLE firm_applications ADD COLUMN desired_county VARCHAR(255);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'firm_size') THEN
        ALTER TABLE firm_applications ADD COLUMN firm_size VARCHAR(50);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'monthly_calls') THEN
        ALTER TABLE firm_applications ADD COLUMN monthly_calls VARCHAR(50);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'referral_source') THEN
        ALTER TABLE firm_applications ADD COLUMN referral_source VARCHAR(255);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'eligibility_1') THEN
        ALTER TABLE firm_applications ADD COLUMN eligibility_1 BOOLEAN DEFAULT false;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'eligibility_2') THEN
        ALTER TABLE firm_applications ADD COLUMN eligibility_2 BOOLEAN DEFAULT false;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'eligibility_3') THEN
        ALTER TABLE firm_applications ADD COLUMN eligibility_3 BOOLEAN DEFAULT false;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'eligibility_4') THEN
        ALTER TABLE firm_applications ADD COLUMN eligibility_4 BOOLEAN DEFAULT false;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'founding_member_interest') THEN
        ALTER TABLE firm_applications ADD COLUMN founding_member_interest BOOLEAN DEFAULT false;
    END IF;
    
    -- Add bar_number if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'bar_number') THEN
        ALTER TABLE firm_applications ADD COLUMN bar_number VARCHAR(100);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'settle_interest') THEN
        ALTER TABLE firm_applications ADD COLUMN settle_interest BOOLEAN DEFAULT false;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'terms_agree') THEN
        ALTER TABLE firm_applications ADD COLUMN terms_agree BOOLEAN DEFAULT false;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'consider_founding_member_future') THEN
        ALTER TABLE firm_applications ADD COLUMN consider_founding_member_future BOOLEAN DEFAULT false;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'early_access_settle') THEN
        ALTER TABLE firm_applications ADD COLUMN early_access_settle BOOLEAN DEFAULT false;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'firm_applications' AND column_name = 'application_source') THEN
        ALTER TABLE firm_applications ADD COLUMN application_source VARCHAR(100) DEFAULT 'apply_page';
    END IF;
END $$;

-- Create indexes (will skip if they already exist)
CREATE INDEX IF NOT EXISTS idx_firm_applications_email ON firm_applications(email);
CREATE INDEX IF NOT EXISTS idx_firm_applications_status ON firm_applications(status);
CREATE INDEX IF NOT EXISTS idx_firm_applications_created_at ON firm_applications(created_at);

-- RLS Policies for firm_applications
ALTER TABLE firm_applications ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Public can insert firm applications" ON firm_applications;
CREATE POLICY "Public can insert firm applications"
ON firm_applications
FOR INSERT
TO public
WITH CHECK (true);

-- ============================================
-- 2. PARTNER_APPLICATIONS TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS partner_applications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    firm_name VARCHAR(255),
    customer_status VARCHAR(100),
    status VARCHAR(50) DEFAULT 'pending',
    referral_code VARCHAR(50),
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Indexes for partner_applications
CREATE INDEX IF NOT EXISTS idx_partner_applications_email ON partner_applications(email);
CREATE INDEX IF NOT EXISTS idx_partner_applications_status ON partner_applications(status);
CREATE INDEX IF NOT EXISTS idx_partner_applications_created_at ON partner_applications(created_at);

-- RLS Policies for partner_applications
ALTER TABLE partner_applications ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Public can insert partner applications" ON partner_applications;
CREATE POLICY "Public can insert partner applications"
ON partner_applications
FOR INSERT
TO public
WITH CHECK (true);

-- ============================================
-- 3. AFFILIATE_APPLICATIONS TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS affiliate_applications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(50),
    question_1 TEXT,
    question_2 TEXT,
    question_3 TEXT,
    question_4 TEXT,
    status VARCHAR(50) DEFAULT 'pending',
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Indexes for affiliate_applications
CREATE INDEX IF NOT EXISTS idx_affiliate_applications_email ON affiliate_applications(email);
CREATE INDEX IF NOT EXISTS idx_affiliate_applications_status ON affiliate_applications(status);
CREATE INDEX IF NOT EXISTS idx_affiliate_applications_created_at ON affiliate_applications(created_at);

-- RLS Policies for affiliate_applications
ALTER TABLE affiliate_applications ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Public can insert affiliate applications" ON affiliate_applications;
CREATE POLICY "Public can insert affiliate applications"
ON affiliate_applications
FOR INSERT
TO public
WITH CHECK (true);

-- ============================================
-- VERIFICATION
-- ============================================
SELECT 'Form submission tables checked and created successfully!' as status;

