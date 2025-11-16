-- ============================================
-- ADD ALL COLUMNS BACK (After nuclear reset)
-- Run this AFTER Step 2 works
-- ============================================

-- Add all columns (one by one, safe)
ALTER TABLE firm_applications 
    ADD COLUMN IF NOT EXISTS first_name VARCHAR(255),
    ADD COLUMN IF NOT EXISTS last_name VARCHAR(255),
    ADD COLUMN IF NOT EXISTS phone VARCHAR(50),
    ADD COLUMN IF NOT EXISTS firm_name VARCHAR(255),
    ADD COLUMN IF NOT EXISTS practice_area VARCHAR(255),
    ADD COLUMN IF NOT EXISTS state VARCHAR(50),
    ADD COLUMN IF NOT EXISTS desired_county VARCHAR(255),
    ADD COLUMN IF NOT EXISTS firm_size VARCHAR(50),
    ADD COLUMN IF NOT EXISTS monthly_calls VARCHAR(50),
    ADD COLUMN IF NOT EXISTS referral_source VARCHAR(255),
    ADD COLUMN IF NOT EXISTS bar_number VARCHAR(100),
    ADD COLUMN IF NOT EXISTS firm_website VARCHAR(255),
    ADD COLUMN IF NOT EXISTS primary_contact_name VARCHAR(255),
    ADD COLUMN IF NOT EXISTS eligibility_1 BOOLEAN DEFAULT false,
    ADD COLUMN IF NOT EXISTS eligibility_2 BOOLEAN DEFAULT false,
    ADD COLUMN IF NOT EXISTS eligibility_3 BOOLEAN DEFAULT false,
    ADD COLUMN IF NOT EXISTS eligibility_4 BOOLEAN DEFAULT false,
    ADD COLUMN IF NOT EXISTS founding_member_interest BOOLEAN DEFAULT false,
    ADD COLUMN IF NOT EXISTS settle_interest BOOLEAN DEFAULT false,
    ADD COLUMN IF NOT EXISTS terms_agree BOOLEAN DEFAULT false,
    ADD COLUMN IF NOT EXISTS consider_founding_member_future BOOLEAN DEFAULT false,
    ADD COLUMN IF NOT EXISTS early_access_settle BOOLEAN DEFAULT false,
    ADD COLUMN IF NOT EXISTS application_source VARCHAR(100) DEFAULT 'apply_page',
    ADD COLUMN IF NOT EXISTS status VARCHAR(50) DEFAULT 'pending',
    ADD COLUMN IF NOT EXISTS notes TEXT,
    ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT now();

-- Verify columns added
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'firm_applications'
ORDER BY ordinal_position;

SELECT '✅ All columns added! Form should work now.' as status;

