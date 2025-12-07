-- ============================================
-- RENAME WEB_APPLICATIONS TO WEB_FIRM_APPLICATIONS
-- Marketing Website Database
-- ============================================

-- Rename the table
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables 
               WHERE table_schema = 'public' 
               AND table_name = 'web_applications') THEN
        
        ALTER TABLE web_applications RENAME TO web_firm_applications;
        
        RAISE NOTICE '✅ Renamed web_applications → web_firm_applications';
    ELSE
        RAISE NOTICE '⚠️  Table web_applications does not exist (may already be renamed)';
    END IF;
END $$;

-- Rename indexes
DO $$
DECLARE
    idx_record RECORD;
BEGIN
    FOR idx_record IN 
        SELECT indexname 
        FROM pg_indexes 
        WHERE schemaname = 'public' 
        AND indexname LIKE 'idx_web_applications%'
    LOOP
        EXECUTE format('ALTER INDEX %I RENAME TO %I', 
            idx_record.indexname, 
            REPLACE(idx_record.indexname, 'web_applications', 'web_firm_applications'));
        RAISE NOTICE '✅ Renamed index: % → %', idx_record.indexname, REPLACE(idx_record.indexname, 'web_applications', 'web_firm_applications');
    END LOOP;
END $$;

-- Update RLS policies
DO $$
BEGIN
    -- Drop old policies
    DROP POLICY IF EXISTS "Public can insert firm applications" ON web_firm_applications;
    DROP POLICY IF EXISTS "Public can insert web applications" ON web_firm_applications;
    DROP POLICY IF EXISTS "Allow public insert web applications" ON web_firm_applications;
    
    -- Recreate policy with new name
    CREATE POLICY "Allow public insert web firm applications"
        ON web_firm_applications
        FOR INSERT
        TO public
        WITH CHECK (TRUE);
    
    RAISE NOTICE '✅ Updated RLS policies';
END $$;

-- Verification
SELECT '✅ Rename complete!' AS status;

SELECT 
    table_name,
    CASE 
        WHEN table_name = 'web_firm_applications' THEN '✅ Correct name'
        WHEN table_name = 'web_applications' THEN '❌ Still needs renaming'
        ELSE 'ℹ️  Other table'
    END AS status
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND (table_name = 'web_applications' OR table_name = 'web_firm_applications')
ORDER BY table_name;

