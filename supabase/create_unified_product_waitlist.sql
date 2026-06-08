-- ============================================
-- CREATE UNIFIED PRODUCT_WAITLIST TABLE
-- For all TrueVow product waitlists (SETTLE, DRAFT, CONNECT, etc.)
-- Single table with product segregation
-- ============================================

CREATE TABLE IF NOT EXISTS product_waitlist (
    -- Primary Key
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- Product/Service (Required) - Which product they're signing up for
    product VARCHAR(50) NOT NULL, -- 'SETTLE', 'DRAFT', 'CONNECT', etc.
    
    -- Contact Information (Required)
    name VARCHAR(255) NOT NULL, -- Full name or first name (flexible)
    email VARCHAR(255) NOT NULL,
    
    -- Verification Fields (Optional - varies by product)
    firm_name VARCHAR(255), -- Optional but prioritized
    state VARCHAR(50), -- Required for some products, optional for others
    bar_number VARCHAR(100), -- Optional but prioritized
    
    -- Qualification Fields (Optional - varies by product)
    is_pi_attorney BOOLEAN DEFAULT false, -- For SETTLE (required), optional for others
    practice_area VARCHAR(100), -- Optional: 'personal_injury', 'medical_malpractice', etc.
    firm_size VARCHAR(50), -- Optional: 'solo', '2-5', '6-10', '11-20', '21+'
    
    -- Verification Status (Optional - for products that need verification)
    verification_status VARCHAR(50) DEFAULT 'pending', -- pending, verified, rejected, suspicious
    verified_at TIMESTAMPTZ,
    verification_notes TEXT,
    
    -- Metadata
    source VARCHAR(100), -- Which page they came from (e.g., 'settle_page', 'draft_page')
    ip_addr VARCHAR(45),
    user_agent TEXT,
    referrer TEXT,
    
    -- Priority Scoring (calculated - for products that need prioritization)
    priority_score INTEGER DEFAULT 0, -- Higher = more qualified
    
    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    
    -- Composite unique constraint: same email can sign up for multiple products
    CONSTRAINT unique_email_product UNIQUE (email, product)
);

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================

-- Product + Email lookup (for duplicate prevention per product)
CREATE INDEX IF NOT EXISTS idx_product_waitlist_product_email 
ON product_waitlist(product, email);

-- Product lookup (for filtering by product)
CREATE INDEX IF NOT EXISTS idx_product_waitlist_product 
ON product_waitlist(product);

-- Email lookup (for finding all products a user signed up for)
CREATE INDEX IF NOT EXISTS idx_product_waitlist_email 
ON product_waitlist(email);

-- State lookup (for geographic analysis)
CREATE INDEX IF NOT EXISTS idx_product_waitlist_state 
ON product_waitlist(state) 
WHERE state IS NOT NULL;

-- Product + State (for geographic analysis per product)
CREATE INDEX IF NOT EXISTS idx_product_waitlist_product_state 
ON product_waitlist(product, state) 
WHERE state IS NOT NULL;

-- Verification status (for admin filtering)
CREATE INDEX IF NOT EXISTS idx_product_waitlist_verification 
ON product_waitlist(verification_status) 
WHERE verification_status IS NOT NULL;

-- Priority scoring (for launch prioritization)
CREATE INDEX IF NOT EXISTS idx_product_waitlist_priority 
ON product_waitlist(product, priority_score DESC) 
WHERE priority_score > 0;

-- Created date (for signup tracking)
CREATE INDEX IF NOT EXISTS idx_product_waitlist_created 
ON product_waitlist(product, created_at DESC);

-- Bar number lookup (for verification)
CREATE INDEX IF NOT EXISTS idx_product_waitlist_bar_number 
ON product_waitlist(bar_number) 
WHERE bar_number IS NOT NULL;

-- ============================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================

-- Enable RLS
ALTER TABLE product_waitlist ENABLE ROW LEVEL SECURITY;

-- Policy 1: Public can INSERT (anyone can join any product waitlist)
DROP POLICY IF EXISTS "Public can insert product waitlist signups" ON product_waitlist;
CREATE POLICY "Public can insert product waitlist signups"
ON product_waitlist
FOR INSERT
TO anon
WITH CHECK (true);

-- Policy 2: Only authenticated users can SELECT (admin only)
DROP POLICY IF EXISTS "Authenticated users can view product waitlist" ON product_waitlist;
CREATE POLICY "Authenticated users can view product waitlist"
ON product_waitlist
FOR SELECT
TO authenticated
USING (true);

-- Policy 3: Only authenticated users can UPDATE (for verification)
DROP POLICY IF EXISTS "Authenticated users can update product waitlist" ON product_waitlist;
CREATE POLICY "Authenticated users can update product waitlist"
ON product_waitlist
FOR UPDATE
TO authenticated
USING (true);

-- ============================================
-- TRIGGER: Auto-update timestamp
-- ============================================

CREATE OR REPLACE FUNCTION update_product_waitlist_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_product_waitlist_updated_at_trigger ON product_waitlist;
CREATE TRIGGER update_product_waitlist_updated_at_trigger
    BEFORE UPDATE ON product_waitlist
    FOR EACH ROW
    EXECUTE FUNCTION update_product_waitlist_updated_at();

-- ============================================
-- TRIGGER: Auto-calculate priority score (for products that need it)
-- ============================================

CREATE OR REPLACE FUNCTION calculate_product_waitlist_priority()
RETURNS TRIGGER AS $$
BEGIN
    -- Base score: 0
    NEW.priority_score = 0;
    
    -- Only calculate priority for products that need it (SETTLE, etc.)
    -- For simpler products (DRAFT), leave at 0
    
    IF NEW.product = 'SETTLE' THEN
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
    END IF;
    
    -- For DRAFT and other products, you can add product-specific logic here
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS calculate_product_waitlist_priority_trigger ON product_waitlist;
CREATE TRIGGER calculate_product_waitlist_priority_trigger
    BEFORE INSERT OR UPDATE ON product_waitlist
    FOR EACH ROW
    EXECUTE FUNCTION calculate_product_waitlist_priority();

-- ============================================
-- COMMENTS & DOCUMENTATION
-- ============================================

COMMENT ON TABLE product_waitlist IS 'Unified waitlist for all TrueVow products (SETTLE, DRAFT, CONNECT, etc.) - single table with product segregation';
COMMENT ON COLUMN product_waitlist.product IS 'Product name: SETTLE, DRAFT, CONNECT, etc.';
COMMENT ON COLUMN product_waitlist.priority_score IS 'Auto-calculated for products that need prioritization (SETTLE). Higher score = more qualified';
COMMENT ON COLUMN product_waitlist.verification_status IS 'pending = needs review, verified = bar-checked, rejected = not qualified, suspicious = potential fraud';
COMMENT ON CONSTRAINT unique_email_product ON product_waitlist IS 'Same email can sign up for multiple products, but only once per product';

-- ============================================
-- MIGRATION NOTES
-- ============================================

-- If you have existing separate tables (web_settle_waitlist, draft_waitlist), 
-- you can migrate them with:
--
-- INSERT INTO product_waitlist (product, name, email, firm_name, state, bar_number, is_pi_attorney, practice_area, firm_size, verification_status, source, priority_score, created_at, updated_at)
-- SELECT 'SETTLE', first_name, email, firm_name, state, bar_number, is_pi_attorney, practice_area, firm_size, verification_status, source, priority_score, created_at, updated_at
-- FROM web_settle_waitlist;
--
-- INSERT INTO product_waitlist (product, name, email, firm_name, state, source, created_at, updated_at)
-- SELECT 'DRAFT', name, email, firm, state, source, created_at, updated_at
-- FROM draft_waitlist;

-- ============================================
-- SUCCESS MESSAGE
-- ============================================

DO $$
BEGIN
    RAISE NOTICE '✅ product_waitlist table created successfully';
    RAISE NOTICE '✅ Unified table for all products (SETTLE, DRAFT, CONNECT, etc.)';
    RAISE NOTICE '✅ Composite unique constraint: (email, product) - allows multiple product signups';
    RAISE NOTICE '✅ Indexes created for performance (product, email, state, priority, etc.)';
    RAISE NOTICE '✅ RLS policies enabled (public INSERT, authenticated SELECT/UPDATE)';
    RAISE NOTICE '✅ Auto-triggers enabled (priority scoring for SETTLE, updated_at)';
    RAISE NOTICE '';
    RAISE NOTICE '📊 PRIORITY SCORING (SETTLE only):';
    RAISE NOTICE '   +50 pts: Has bar number';
    RAISE NOTICE '   +30 pts: Checked "I am a PI attorney"';
    RAISE NOTICE '   +20 pts: Has firm name';
    RAISE NOTICE '   +10 pts: Professional email (not Gmail/Yahoo)';
    RAISE NOTICE '   +10 pts: Small firm size (≤20 attorneys)';
    RAISE NOTICE '   MAX: 120 points (highest priority at launch)';
    RAISE NOTICE '';
    RAISE NOTICE '🎯 USAGE EXAMPLES:';
    RAISE NOTICE '   - Query all SETTLE signups: SELECT * FROM product_waitlist WHERE product = ''SETTLE'';';
    RAISE NOTICE '   - Query all DRAFT signups: SELECT * FROM product_waitlist WHERE product = ''DRAFT'';';
    RAISE NOTICE '   - Find user''s all signups: SELECT * FROM product_waitlist WHERE email = ''user@example.com'';';
    RAISE NOTICE '   - Top priority SETTLE signups: SELECT * FROM product_waitlist WHERE product = ''SETTLE'' ORDER BY priority_score DESC;';
    RAISE NOTICE '';
    RAISE NOTICE '🔄 NEXT STEPS:';
    RAISE NOTICE '   1. Run this SQL in Supabase SQL Editor';
    RAISE NOTICE '   2. Update settle.html form to use product_waitlist (product = ''SETTLE'')';
    RAISE NOTICE '   3. Update draft.html form to use product_waitlist (product = ''DRAFT'')';
    RAISE NOTICE '   4. Migrate existing data from separate tables if needed';
    RAISE NOTICE '   5. Test form submissions';
END $$;

