-- ============================================
-- CREATE WEB AVAILABILITY TABLES
-- Stores county and practice area seat availability data
-- Follows TrueVow naming conventions: web_* prefix, snake_case
-- ============================================

-- ============================================
-- 1. WEB_AVAILABILITY_COUNTY TABLE
-- ============================================
-- Stores overall county-level availability statistics

CREATE TABLE IF NOT EXISTS web_availability_county (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- County identification
    state_code VARCHAR(2) NOT NULL,  -- 'FL', 'CA', etc.
    county_slug VARCHAR(100) NOT NULL,  -- 'miami-dade', 'los-angeles', etc.
    county_name VARCHAR(255) NOT NULL,  -- 'Miami-Dade', 'Los Angeles', etc.
    
    -- Overall county statistics
    total_firms INTEGER NOT NULL DEFAULT 0,  -- Total solo & small law firms in county
    total_seats INTEGER NOT NULL DEFAULT 0,  -- Total seats available (33% cap)
    premium_total INTEGER NOT NULL DEFAULT 0,  -- Total premium tier seats
    standard_total INTEGER NOT NULL DEFAULT 0,  -- Total standard tier seats
    filled INTEGER NOT NULL DEFAULT 0,  -- Total filled seats
    premium_remaining INTEGER NOT NULL DEFAULT 0,  -- Premium seats remaining
    standard_remaining INTEGER NOT NULL DEFAULT 0,  -- Standard seats remaining
    
    -- Metadata
    is_active BOOLEAN DEFAULT TRUE,  -- Whether this county is currently accepting applications
    notes TEXT,  -- Internal notes
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    
    -- Unique constraint: one record per county
    UNIQUE(state_code, county_slug)
);

-- ============================================
-- 2. WEB_AVAILABILITY_PRACTICE_AREA_SEATS TABLE
-- ============================================
-- Stores practice area-specific seat allocations per county

CREATE TABLE IF NOT EXISTS web_availability_practice_area_seats (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- Foreign key to county
    county_availability_id UUID NOT NULL REFERENCES web_availability_county(id) ON DELETE CASCADE,
    
    -- Practice area identification
    practice_area_slug VARCHAR(100) NOT NULL,  -- 'personal-injury', 'family-law', etc.
    practice_area_name VARCHAR(255) NOT NULL,  -- 'Personal Injury', 'Family Law', etc.
    
    -- Practice area statistics
    total_firms INTEGER NOT NULL DEFAULT 0,  -- Total firms in this practice area (FL uses totalFirms, CA uses firms)
    cap INTEGER NOT NULL DEFAULT 0,  -- Total seats allocated (33% cap)
    premium INTEGER NOT NULL DEFAULT 0,  -- Premium tier seats
    standard INTEGER NOT NULL DEFAULT 0,  -- Standard tier seats
    filled INTEGER NOT NULL DEFAULT 0,  -- Filled seats
    premium_remaining INTEGER NOT NULL DEFAULT 0,  -- Premium seats remaining
    standard_remaining INTEGER NOT NULL DEFAULT 0,  -- Standard seats remaining
    
    -- Metadata
    display_order INTEGER DEFAULT 0,  -- Order for display in dropdown (1-9)
    is_active BOOLEAN DEFAULT TRUE,  -- Whether this practice area is active
    notes TEXT,  -- Internal notes
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    
    -- Unique constraint: one record per practice area per county
    UNIQUE(county_availability_id, practice_area_slug)
);

-- ============================================
-- 3. INDEXES
-- ============================================

-- County availability indexes
CREATE INDEX IF NOT EXISTS idx_web_availability_county_state_code ON web_availability_county(state_code);
CREATE INDEX IF NOT EXISTS idx_web_availability_county_county_slug ON web_availability_county(county_slug);
CREATE INDEX IF NOT EXISTS idx_web_availability_county_is_active ON web_availability_county(is_active);
CREATE INDEX IF NOT EXISTS idx_web_availability_county_created_at ON web_availability_county(created_at DESC);

-- Practice area seats indexes
CREATE INDEX IF NOT EXISTS idx_web_availability_practice_area_seats_county_id ON web_availability_practice_area_seats(county_availability_id);
CREATE INDEX IF NOT EXISTS idx_web_availability_practice_area_seats_practice_area_slug ON web_availability_practice_area_seats(practice_area_slug);
CREATE INDEX IF NOT EXISTS idx_web_availability_practice_area_seats_display_order ON web_availability_practice_area_seats(display_order);
CREATE INDEX IF NOT EXISTS idx_web_availability_practice_area_seats_is_active ON web_availability_practice_area_seats(is_active);

-- ============================================
-- 4. ROW LEVEL SECURITY (RLS)
-- ============================================

-- Enable RLS
ALTER TABLE web_availability_county ENABLE ROW LEVEL SECURITY;
ALTER TABLE web_availability_practice_area_seats ENABLE ROW LEVEL SECURITY;

-- Drop existing policies to avoid duplicates (both old and new names)
DO $$
BEGIN
    -- Drop all possible policy names for web_availability_county
    DROP POLICY IF EXISTS "Allow public read firm availability county" ON web_availability_county;
    DROP POLICY IF EXISTS "Allow authenticated manage firm availability county" ON web_availability_county;
    DROP POLICY IF EXISTS "Allow public read web availability county" ON web_availability_county;
    DROP POLICY IF EXISTS "Allow authenticated manage web availability county" ON web_availability_county;
    
    -- Drop all possible policy names for web_availability_practice_area_seats
    DROP POLICY IF EXISTS "Allow public read firm availability practice area seats" ON web_availability_practice_area_seats;
    DROP POLICY IF EXISTS "Allow authenticated manage firm availability practice area seats" ON web_availability_practice_area_seats;
    DROP POLICY IF EXISTS "Allow public read web availability practice area seats" ON web_availability_practice_area_seats;
    DROP POLICY IF EXISTS "Allow authenticated manage web availability practice area seats" ON web_availability_practice_area_seats;
EXCEPTION
    WHEN undefined_table THEN
        -- Tables don't exist yet, skip policy drops
        NULL;
END $$;

-- Public read access (for marketing site)
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' 
        AND tablename = 'web_availability_county' 
        AND policyname = 'Allow public read web availability county'
    ) THEN
        CREATE POLICY "Allow public read web availability county"
            ON web_availability_county
            FOR SELECT
            TO public
            USING (is_active = TRUE);
    END IF;
    
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' 
        AND tablename = 'web_availability_practice_area_seats' 
        AND policyname = 'Allow public read web availability practice area seats'
    ) THEN
        CREATE POLICY "Allow public read web availability practice area seats"
            ON web_availability_practice_area_seats
            FOR SELECT
            TO public
            USING (is_active = TRUE);
    END IF;
END $$;

-- Authenticated users can manage (admin)
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' 
        AND tablename = 'web_availability_county' 
        AND policyname = 'Allow authenticated manage web availability county'
    ) THEN
        CREATE POLICY "Allow authenticated manage web availability county"
            ON web_availability_county
            FOR ALL
            TO authenticated
            USING (TRUE)
            WITH CHECK (TRUE);
    END IF;
    
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE schemaname = 'public' 
        AND tablename = 'web_availability_practice_area_seats' 
        AND policyname = 'Allow authenticated manage web availability practice area seats'
    ) THEN
        CREATE POLICY "Allow authenticated manage web availability practice area seats"
            ON web_availability_practice_area_seats
            FOR ALL
            TO authenticated
            USING (TRUE)
            WITH CHECK (TRUE);
    END IF;
END $$;

-- ============================================
-- 5. GRANTS
-- ============================================

-- Public can read
GRANT SELECT ON TABLE web_availability_county TO public;
GRANT SELECT ON TABLE web_availability_practice_area_seats TO public;

-- Authenticated can manage
GRANT ALL ON TABLE web_availability_county TO authenticated;
GRANT ALL ON TABLE web_availability_practice_area_seats TO authenticated;

-- ============================================
-- 6. TRIGGERS (for updated_at)
-- ============================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers for updated_at
DROP TRIGGER IF EXISTS update_web_availability_county_updated_at ON web_availability_county;
CREATE TRIGGER update_web_availability_county_updated_at
    BEFORE UPDATE ON web_availability_county
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_web_availability_practice_area_seats_updated_at ON web_availability_practice_area_seats;
CREATE TRIGGER update_web_availability_practice_area_seats_updated_at
    BEFORE UPDATE ON web_availability_practice_area_seats
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- 7. VERIFICATION
-- ============================================

SELECT '✅ web_availability_county table created' AS status,
       (SELECT COUNT(*) FROM web_availability_county) AS current_rows;

SELECT '✅ web_availability_practice_area_seats table created' AS status,
       (SELECT COUNT(*) FROM web_availability_practice_area_seats) AS current_rows;

