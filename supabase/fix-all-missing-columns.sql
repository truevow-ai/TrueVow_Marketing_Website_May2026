-- ============================================
-- Fix ALL Missing Columns in firm_applications
-- This script ensures ALL required columns exist
-- Run this if you're getting column not found errors
-- ============================================

-- Add ALL missing columns to existing firm_applications table
DO $$
BEGIN
    -- Basic contact information
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'first_name') THEN
        ALTER TABLE firm_applications ADD COLUMN first_name VARCHAR(255);
        RAISE NOTICE 'Added column: first_name';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'last_name') THEN
        ALTER TABLE firm_applications ADD COLUMN last_name VARCHAR(255);
        RAISE NOTICE 'Added column: last_name';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'email') THEN
        ALTER TABLE firm_applications ADD COLUMN email VARCHAR(255);
        RAISE NOTICE 'Added column: email';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'phone') THEN
        ALTER TABLE firm_applications ADD COLUMN phone VARCHAR(50);
        RAISE NOTICE 'Added column: phone';
    END IF;
    
    -- Firm information
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'firm_name') THEN
        ALTER TABLE firm_applications ADD COLUMN firm_name VARCHAR(255);
        RAISE NOTICE 'Added column: firm_name';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'practice_area') THEN
        ALTER TABLE firm_applications ADD COLUMN practice_area VARCHAR(255);
        RAISE NOTICE 'Added column: practice_area';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'state') THEN
        ALTER TABLE firm_applications ADD COLUMN state VARCHAR(50);
        RAISE NOTICE 'Added column: state';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'desired_county') THEN
        ALTER TABLE firm_applications ADD COLUMN desired_county VARCHAR(255);
        RAISE NOTICE 'Added column: desired_county';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'firm_size') THEN
        ALTER TABLE firm_applications ADD COLUMN firm_size VARCHAR(50);
        RAISE NOTICE 'Added column: firm_size';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'monthly_calls') THEN
        ALTER TABLE firm_applications ADD COLUMN monthly_calls VARCHAR(50);
        RAISE NOTICE 'Added column: monthly_calls';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'referral_source') THEN
        ALTER TABLE firm_applications ADD COLUMN referral_source VARCHAR(255);
        RAISE NOTICE 'Added column: referral_source';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'bar_number') THEN
        ALTER TABLE firm_applications ADD COLUMN bar_number VARCHAR(100);
        RAISE NOTICE 'Added column: bar_number';
    END IF;
    
    -- Eligibility checkboxes
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'eligibility_1') THEN
        ALTER TABLE firm_applications ADD COLUMN eligibility_1 BOOLEAN DEFAULT false;
        RAISE NOTICE 'Added column: eligibility_1';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'eligibility_2') THEN
        ALTER TABLE firm_applications ADD COLUMN eligibility_2 BOOLEAN DEFAULT false;
        RAISE NOTICE 'Added column: eligibility_2';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'eligibility_3') THEN
        ALTER TABLE firm_applications ADD COLUMN eligibility_3 BOOLEAN DEFAULT false;
        RAISE NOTICE 'Added column: eligibility_3';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'eligibility_4') THEN
        ALTER TABLE firm_applications ADD COLUMN eligibility_4 BOOLEAN DEFAULT false;
        RAISE NOTICE 'Added column: eligibility_4';
    END IF;
    
    -- Interest checkboxes
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'founding_member_interest') THEN
        ALTER TABLE firm_applications ADD COLUMN founding_member_interest BOOLEAN DEFAULT false;
        RAISE NOTICE 'Added column: founding_member_interest';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'settle_interest') THEN
        ALTER TABLE firm_applications ADD COLUMN settle_interest BOOLEAN DEFAULT false;
        RAISE NOTICE 'Added column: settle_interest';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'terms_agree') THEN
        ALTER TABLE firm_applications ADD COLUMN terms_agree BOOLEAN DEFAULT false;
        RAISE NOTICE 'Added column: terms_agree';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'consider_founding_member_future') THEN
        ALTER TABLE firm_applications ADD COLUMN consider_founding_member_future BOOLEAN DEFAULT false;
        RAISE NOTICE 'Added column: consider_founding_member_future';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'early_access_settle') THEN
        ALTER TABLE firm_applications ADD COLUMN early_access_settle BOOLEAN DEFAULT false;
        RAISE NOTICE 'Added column: early_access_settle';
    END IF;
    
    -- Metadata
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'application_source') THEN
        ALTER TABLE firm_applications ADD COLUMN application_source VARCHAR(100) DEFAULT 'apply_page';
        RAISE NOTICE 'Added column: application_source';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'status') THEN
        ALTER TABLE firm_applications ADD COLUMN status VARCHAR(50) DEFAULT 'pending';
        RAISE NOTICE 'Added column: status';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'notes') THEN
        ALTER TABLE firm_applications ADD COLUMN notes TEXT;
        RAISE NOTICE 'Added column: notes';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'firm_website') THEN
        ALTER TABLE firm_applications ADD COLUMN firm_website VARCHAR(255);
        RAISE NOTICE 'Added column: firm_website';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'firm_applications' AND column_name = 'updated_at') THEN
        ALTER TABLE firm_applications ADD COLUMN updated_at TIMESTAMP DEFAULT NOW();
        RAISE NOTICE 'Added column: updated_at';
    END IF;
END $$;

-- Verify all columns exist
SELECT 
    column_name,
    data_type,
    character_maximum_length,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_schema = 'public'
AND table_name = 'firm_applications'
ORDER BY ordinal_position;

SELECT 'All columns check complete! If any columns were missing, they have been added.' as status;

