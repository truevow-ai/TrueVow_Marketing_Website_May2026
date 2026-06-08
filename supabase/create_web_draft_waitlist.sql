-- ============================================
-- CREATE WEB_DRAFT_WAITLIST TABLE
-- For DRAFT Q2 2026 Launch Waitlist Signups
-- Includes verification fields to filter quality leads
-- ============================================

CREATE TABLE IF NOT EXISTS draft_waitlist (
    -- Primary Key
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- Contact Information (Required)
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    
    -- Verification Fields (Required for quality)
    firm VARCHAR(255), -- Optional but prioritized
    state VARCHAR(50) NOT NULL,
    
    -- Metadata
    source VARCHAR(100) DEFAULT 'draft_page',
    ip_addr VARCHAR(45),
    user_agent TEXT,
    referrer TEXT,
    
    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================

-- Email lookup (for duplicate prevention)
CREATE INDEX IF NOT EXISTS idx_draft_waitlist_email 
ON draft_waitlist(email);

-- State lookup (for geographic analysis)
CREATE INDEX IF NOT EXISTS idx_draft_waitlist_state 
ON draft_waitlist(state);

-- Created date (for signup tracking)
CREATE INDEX IF NOT EXISTS idx_draft_waitlist_created 
ON draft_waitlist(created_at DESC);

-- ============================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================

-- Enable RLS
ALTER TABLE draft_waitlist ENABLE ROW LEVEL SECURITY;

-- Policy 1: Public can INSERT (anyone can join waitlist)
DROP POLICY IF EXISTS "Public can insert DRAFT waitlist signups" ON draft_waitlist;
CREATE POLICY "Public can insert DRAFT waitlist signups"
ON draft_waitlist
FOR INSERT
TO anon
WITH CHECK (true);

-- Policy 2: Only authenticated users can SELECT (admin only)
DROP POLICY IF EXISTS "Authenticated users can view DRAFT waitlist" ON draft_waitlist;
CREATE POLICY "Authenticated users can view DRAFT waitlist"
ON draft_waitlist
FOR SELECT
TO authenticated
USING (true);

-- Policy 3: Only authenticated users can UPDATE (for verification)
DROP POLICY IF EXISTS "Authenticated users can update DRAFT waitlist" ON draft_waitlist;
CREATE POLICY "Authenticated users can update DRAFT waitlist"
ON draft_waitlist
FOR UPDATE
TO authenticated
USING (true);

-- ============================================
-- TRIGGER: Auto-update timestamp
-- ============================================

CREATE OR REPLACE FUNCTION update_draft_waitlist_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_draft_waitlist_updated_at_trigger ON draft_waitlist;
CREATE TRIGGER update_draft_waitlist_updated_at_trigger
    BEFORE UPDATE ON draft_waitlist
    FOR EACH ROW
    EXECUTE FUNCTION update_draft_waitlist_updated_at();

-- ============================================
-- VERIFICATION: Check for existing signups
-- ============================================

COMMENT ON TABLE draft_waitlist IS 'Waitlist for DRAFT Q2 2026 launch - zero-knowledge document validation for attorneys';

-- ============================================
-- SUCCESS MESSAGE
-- ============================================

DO $$
BEGIN
    RAISE NOTICE '✅ draft_waitlist table created successfully';
    RAISE NOTICE '✅ Indexes created for performance';
    RAISE NOTICE '✅ RLS policies enabled (public INSERT, authenticated SELECT/UPDATE)';
    RAISE NOTICE '✅ Auto-triggers enabled (updated_at)';
    RAISE NOTICE '';
    RAISE NOTICE '🎯 NEXT STEPS:';
    RAISE NOTICE '   1. Run this SQL in Supabase SQL Editor';
    RAISE NOTICE '   2. Test draft.html form submission';
    RAISE NOTICE '   3. Verify data is being stored correctly';
END $$;

