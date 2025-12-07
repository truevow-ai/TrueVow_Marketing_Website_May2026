-- ============================================
-- RENAME ALL FIRM_* TABLES TO WEB_* PREFIX
-- Marketing Website Database
-- ============================================
-- This script renames all tables with firm_* prefix to web_* prefix
-- to align with marketing website naming conventions

-- ============================================
-- STEP 1: RENAME FIRM_APPLICATIONS TO WEB_APPLICATIONS
-- ============================================

-- Check if table exists before renaming
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables 
               WHERE table_schema = 'public' 
               AND table_name = 'firm_applications') THEN
        
        -- Rename the table
        ALTER TABLE firm_applications RENAME TO web_applications;
        
        RAISE NOTICE '✅ Renamed firm_applications → web_applications';
    ELSE
        RAISE NOTICE '⚠️  Table firm_applications does not exist (may already be renamed)';
    END IF;
END $$;

-- ============================================
-- STEP 2: RENAME FIRM_AVAILABILITY_COUNTY TO WEB_AVAILABILITY_COUNTY
-- ============================================

DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables 
               WHERE table_schema = 'public' 
               AND table_name = 'firm_availability_county') THEN
        
        -- Rename the table
        ALTER TABLE firm_availability_county RENAME TO web_availability_county;
        
        RAISE NOTICE '✅ Renamed firm_availability_county → web_availability_county';
    ELSE
        RAISE NOTICE '⚠️  Table firm_availability_county does not exist (may already be renamed)';
    END IF;
END $$;

-- ============================================
-- STEP 3: RENAME FIRM_AVAILABILITY_PRACTICE_AREA_SEATS TO WEB_AVAILABILITY_PRACTICE_AREA_SEATS
-- ============================================

DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables 
               WHERE table_schema = 'public' 
               AND table_name = 'firm_availability_practice_area_seats') THEN
        
        -- Rename the table
        ALTER TABLE firm_availability_practice_area_seats RENAME TO web_availability_practice_area_seats;
        
        RAISE NOTICE '✅ Renamed firm_availability_practice_area_seats → web_availability_practice_area_seats';
    ELSE
        RAISE NOTICE '⚠️  Table firm_availability_practice_area_seats does not exist (may already be renamed)';
    END IF;
END $$;

-- ============================================
-- STEP 4: UPDATE FOREIGN KEY REFERENCES
-- ============================================

-- Update foreign key in web_availability_practice_area_seats
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.table_constraints 
               WHERE constraint_name LIKE '%firm_availability_county%'
               AND table_name = 'web_availability_practice_area_seats') THEN
        
        -- Drop old foreign key constraint
        ALTER TABLE web_availability_practice_area_seats 
        DROP CONSTRAINT IF EXISTS firm_availability_practice_area_seats_county_availability_id_fkey;
        
        -- Add new foreign key constraint
        ALTER TABLE web_availability_practice_area_seats 
        ADD CONSTRAINT web_availability_practice_area_seats_county_availability_id_fkey
        FOREIGN KEY (county_availability_id) 
        REFERENCES web_availability_county(id) 
        ON DELETE CASCADE;
        
        RAISE NOTICE '✅ Updated foreign key reference';
    END IF;
END $$;

-- ============================================
-- STEP 5: RENAME INDEXES
-- ============================================

-- Rename indexes for web_availability_county
DO $$
DECLARE
    idx_record RECORD;
BEGIN
    FOR idx_record IN 
        SELECT indexname 
        FROM pg_indexes 
        WHERE schemaname = 'public' 
        AND indexname LIKE 'idx_firm_availability_county%'
    LOOP
        EXECUTE format('ALTER INDEX %I RENAME TO %I', 
            idx_record.indexname, 
            REPLACE(idx_record.indexname, 'firm_', 'web_'));
        RAISE NOTICE '✅ Renamed index: % → %', idx_record.indexname, REPLACE(idx_record.indexname, 'firm_', 'web_');
    END LOOP;
END $$;

-- Rename indexes for web_availability_practice_area_seats
DO $$
DECLARE
    idx_record RECORD;
BEGIN
    FOR idx_record IN 
        SELECT indexname 
        FROM pg_indexes 
        WHERE schemaname = 'public' 
        AND indexname LIKE 'idx_firm_availability_practice_area_seats%'
    LOOP
        EXECUTE format('ALTER INDEX %I RENAME TO %I', 
            idx_record.indexname, 
            REPLACE(idx_record.indexname, 'firm_', 'web_'));
        RAISE NOTICE '✅ Renamed index: % → %', idx_record.indexname, REPLACE(idx_record.indexname, 'firm_', 'web_');
    END LOOP;
END $$;

-- ============================================
-- STEP 6: UPDATE RLS POLICIES
-- ============================================

-- Drop old policies and recreate with new names
DO $$
BEGIN
    -- Drop old policies for firm_availability_county
    DROP POLICY IF EXISTS "Allow public read firm availability county" ON web_availability_county;
    DROP POLICY IF EXISTS "Allow authenticated manage firm availability county" ON web_availability_county;
    
    -- Drop old policies for firm_availability_practice_area_seats
    DROP POLICY IF EXISTS "Allow public read firm availability practice area seats" ON web_availability_practice_area_seats;
    DROP POLICY IF EXISTS "Allow authenticated manage firm availability practice area seats" ON web_availability_practice_area_seats;
    
    -- Recreate policies with new names
    CREATE POLICY "Allow public read web availability county"
        ON web_availability_county
        FOR SELECT
        TO public
        USING (is_active = TRUE);
    
    CREATE POLICY "Allow authenticated manage web availability county"
        ON web_availability_county
        FOR ALL
        TO authenticated
        USING (TRUE)
        WITH CHECK (TRUE);
    
    CREATE POLICY "Allow public read web availability practice area seats"
        ON web_availability_practice_area_seats
        FOR SELECT
        TO public
        USING (is_active = TRUE);
    
    CREATE POLICY "Allow authenticated manage web availability practice area seats"
        ON web_availability_practice_area_seats
        FOR ALL
        TO authenticated
        USING (TRUE)
        WITH CHECK (TRUE);
    
    RAISE NOTICE '✅ Updated RLS policies';
END $$;

-- ============================================
-- STEP 7: UPDATE TRIGGERS
-- ============================================

-- Rename triggers
DO $$
BEGIN
    -- Rename trigger for web_availability_county
    IF EXISTS (SELECT FROM pg_trigger WHERE tgname = 'update_firm_availability_county_updated_at') THEN
        ALTER TRIGGER update_firm_availability_county_updated_at 
        ON web_availability_county 
        RENAME TO update_web_availability_county_updated_at;
        RAISE NOTICE '✅ Renamed trigger for web_availability_county';
    END IF;
    
    -- Rename trigger for web_availability_practice_area_seats
    IF EXISTS (SELECT FROM pg_trigger WHERE tgname = 'update_firm_availability_practice_area_seats_updated_at') THEN
        ALTER TRIGGER update_firm_availability_practice_area_seats_updated_at 
        ON web_availability_practice_area_seats 
        RENAME TO update_web_availability_practice_area_seats_updated_at;
        RAISE NOTICE '✅ Renamed trigger for web_availability_practice_area_seats';
    END IF;
END $$;

-- ============================================
-- STEP 8: VERIFICATION
-- ============================================

SELECT '✅ Migration complete!' AS status;

SELECT 
    table_name,
    CASE 
        WHEN table_name LIKE 'web_%' THEN '✅ Correct prefix'
        WHEN table_name LIKE 'firm_%' THEN '❌ Still has firm_ prefix'
        ELSE 'ℹ️  Other table'
    END AS status
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND (table_name LIKE 'web_%' OR table_name LIKE 'firm_%')
ORDER BY table_name;

