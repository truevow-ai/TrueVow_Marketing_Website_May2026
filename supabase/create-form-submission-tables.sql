-- ============================================
-- Form Submission Tables for TrueVow Website
-- Creates tables for: Firm Applications, Partner Applications, Affiliate Applications
-- ============================================

-- ============================================
-- 1. FIRM_APPLICATIONS TABLE
-- ============================================
-- (May already exist, but ensuring it's complete)

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

-- Indexes for firm_applications
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
SELECT 'Form submission tables created successfully!' as status;

