-- ============================================
-- Add zipcode column to web_firm_applications table
-- ============================================

DO $$
BEGIN
    -- Add zipcode column if it doesn't exist
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'web_firm_applications' 
        AND column_name = 'zipcode'
    ) THEN
        ALTER TABLE web_firm_applications 
        ADD COLUMN zipcode VARCHAR(10);
        
        RAISE NOTICE '✅ Added zipcode column to web_firm_applications';
    ELSE
        RAISE NOTICE 'ℹ️  zipcode column already exists in web_firm_applications';
    END IF;
END $$;

-- Add index for zipcode lookups
CREATE INDEX IF NOT EXISTS idx_web_firm_applications_zipcode 
ON web_firm_applications(zipcode);

-- Add comment
COMMENT ON COLUMN web_firm_applications.zipcode IS 'ZIP/Postal code for auto-populating county';

