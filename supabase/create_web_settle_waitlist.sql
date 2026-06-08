-- ============================================
-- CREATE WEB_SETTLE_WAITLIST TABLE
-- For SETTLE Q3 2026 Launch Waitlist Signups
-- Includes verification fields to filter quality leads
-- ============================================

CREATE TABLE IF NOT EXISTS web_settle_waitlist (
    -- Primary Key
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- Contact Information (Required)
    first_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    
    -- Verification Fields (Required for quality)
    firm_name VARCHAR(255) NOT NULL,
    state VARCHAR(50) NOT NULL,
    bar_number VARCHAR(100), -- Optional but prioritized
    
    -- Qualification Fields
    is_pi_attorney BOOLEAN DEFAULT false NOT NULL, -- Attestation checkbox
    practice_area VARCHAR(100), -- Optional: 'personal_injury', 'medical_malpractice', etc.
    firm_size VARCHAR(50), -- Optional: 'solo', '2-5', '6-10', '11-20', '21+'
    
    -- Verification Status
    verification_status VARCHAR(50) DEFAULT 'pending', -- pending, verified, rejected, suspicious
    verified_at TIMESTAMPTZ,
    verification_notes TEXT,
    
    -- Metadata
    source VARCHAR(100) DEFAULT 'settle_page',
    ip_addr VARCHAR(45),
    user_agent TEXT,
    referrer TEXT,
    
    -- Priority Scoring (calculated)
    priority_score INTEGER DEFAULT 0, -- Higher = more qualified (has bar number, etc.)
    
    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================

-- Email lookup (for duplicate prevention)
CREATE INDEX IF NOT EXISTS idx_web_settle_waitlist_email 
ON web_settle_waitlist(email);

-- State lookup (for geographic analysis)
CREATE INDEX IF NOT EXISTS idx_web_settle_waitlist_state 
ON web_settle_waitlist(state);

-- Verification status (for admin filtering)
CREATE INDEX IF NOT EXISTS idx_web_settle_waitlist_verification 
ON web_settle_waitlist(verification_status);

-- Priority scoring (for launch prioritization)
CREATE INDEX IF NOT EXISTS idx_web_settle_waitlist_priority 
ON web_settle_waitlist(priority_score DESC);

-- Created date (for signup tracking)
CREATE INDEX IF NOT EXISTS idx_web_settle_waitlist_created 
ON web_settle_waitlist(created_at DESC);

-- Bar number lookup (for verification)
CREATE INDEX IF NOT EXISTS idx_web_settle_waitlist_bar_number 
ON web_settle_waitlist(bar_number) 
WHERE bar_number IS NOT NULL;

-- ============================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================

-- Enable RLS
ALTER TABLE web_settle_waitlist ENABLE ROW LEVEL SECURITY;

-- Policy 1: Public can INSERT (anyone can join waitlist)
DROP POLICY IF EXISTS "Public can insert SETTLE waitlist signups" ON web_settle_waitlist;
CREATE POLICY "Public can insert SETTLE waitlist signups"
ON web_settle_waitlist
FOR INSERT
TO anon
WITH CHECK (true);

-- Policy 2: Only authenticated users can SELECT (admin only)
DROP POLICY IF EXISTS "Authenticated users can view SETTLE waitlist" ON web_settle_waitlist;
CREATE POLICY "Authenticated users can view SETTLE waitlist"
ON web_settle_waitlist
FOR SELECT
TO authenticated
USING (true);

-- Policy 3: Only authenticated users can UPDATE (for verification)
DROP POLICY IF EXISTS "Authenticated users can update SETTLE waitlist" ON web_settle_waitlist;
CREATE POLICY "Authenticated users can update SETTLE waitlist"
ON web_settle_waitlist
FOR UPDATE
TO authenticated
USING (true);

-- ============================================
-- TRIGGER: Auto-update timestamp
-- ============================================

CREATE OR REPLACE FUNCTION update_web_settle_waitlist_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_web_settle_waitlist_updated_at_trigger ON web_settle_waitlist;
CREATE TRIGGER update_web_settle_waitlist_updated_at_trigger
    BEFORE UPDATE ON web_settle_waitlist
    FOR EACH ROW
    EXECUTE FUNCTION update_web_settle_waitlist_updated_at();

-- ============================================
-- TRIGGER: Auto-calculate priority score
-- ============================================

CREATE OR REPLACE FUNCTION calculate_settle_waitlist_priority()
RETURNS TRIGGER AS $$
BEGIN
    -- Base score: 0
    NEW.priority_score = 0;
    
    -- +50 points: Has bar number (gold standard verification)
    IF NEW.bar_number IS NOT NULL AND NEW.bar_number != '' THEN
        NEW.priority_score = NEW.priority_score + 50;
    END IF;
    
    -- +30 points: Is PI attorney (checked attestation)
    IF NEW.is_pi_attorney = true THEN
        NEW.priority_score = NEW.priority_score + 30;
    END IF;
    
    -- +20 points: Has firm name (not just personal name)
    IF NEW.firm_name IS NOT NULL AND NEW.firm_name != '' THEN
        NEW.priority_score = NEW.priority_score + 20;
    END IF;
    
    -- +10 points: Professional email domain (not Gmail/Yahoo)
    IF NEW.email NOT ILIKE '%@gmail.com' 
       AND NEW.email NOT ILIKE '%@yahoo.com' 
       AND NEW.email NOT ILIKE '%@hotmail.com'
       AND NEW.email NOT ILIKE '%@outlook.com' THEN
        NEW.priority_score = NEW.priority_score + 10;
    END IF;
    
    -- Bonus: Small firm size (if provided)
    IF NEW.firm_size IN ('solo', '2-5', '6-10', '11-20') THEN
        NEW.priority_score = NEW.priority_score + 10;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS calculate_settle_waitlist_priority_trigger ON web_settle_waitlist;
CREATE TRIGGER calculate_settle_waitlist_priority_trigger
    BEFORE INSERT OR UPDATE ON web_settle_waitlist
    FOR EACH ROW
    EXECUTE FUNCTION calculate_settle_waitlist_priority();

-- ============================================
-- VERIFICATION: Check for existing signups
-- ============================================

COMMENT ON TABLE web_settle_waitlist IS 'Waitlist for SETTLE Q3 2026 launch - includes verification fields to filter quality leads (PI attorneys at small firms)';
COMMENT ON COLUMN web_settle_waitlist.priority_score IS 'Auto-calculated: Higher score = more qualified (has bar number, professional email, PI attorney, etc.)';
COMMENT ON COLUMN web_settle_waitlist.verification_status IS 'pending = needs review, verified = bar-checked, rejected = not qualified, suspicious = potential fraud';

-- ============================================
-- SUCCESS MESSAGE
-- ============================================

DO $$
BEGIN
    RAISE NOTICE '✅ web_settle_waitlist table created successfully';
    RAISE NOTICE '✅ Indexes created for performance';
    RAISE NOTICE '✅ RLS policies enabled (public INSERT, authenticated SELECT/UPDATE)';
    RAISE NOTICE '✅ Auto-triggers enabled (priority scoring, updated_at)';
    RAISE NOTICE '';
    RAISE NOTICE '📊 PRIORITY SCORING:';
    RAISE NOTICE '   +50 pts: Has bar number';
    RAISE NOTICE '   +30 pts: Checked "I am a PI attorney"';
    RAISE NOTICE '   +20 pts: Has firm name';
    RAISE NOTICE '   +10 pts: Professional email (not Gmail/Yahoo)';
    RAISE NOTICE '   +10 pts: Small firm size (≤20 attorneys)';
    RAISE NOTICE '   MAX: 120 points (highest priority at launch)';
    RAISE NOTICE '';
    RAISE NOTICE '🎯 NEXT STEPS:';
    RAISE NOTICE '   1. Run this SQL in Supabase SQL Editor';
    RAISE NOTICE '   2. Update settle.html form with new fields';
    RAISE NOTICE '   3. Add JavaScript to submit to this table';
    RAISE NOTICE '   4. Test with real signups';
END $$;

