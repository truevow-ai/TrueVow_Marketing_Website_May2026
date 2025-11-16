-- ============================================
-- Fix bar_number Column in firm_applications
-- This script ensures the bar_number column exists
-- ============================================

-- Add bar_number column if it doesn't exist
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'firm_applications' 
        AND column_name = 'bar_number'
    ) THEN
        ALTER TABLE firm_applications ADD COLUMN bar_number VARCHAR(100);
        RAISE NOTICE 'Column bar_number added to firm_applications table';
    ELSE
        RAISE NOTICE 'Column bar_number already exists in firm_applications table';
    END IF;
END $$;

-- Verify the column exists
SELECT 
    column_name,
    data_type,
    character_maximum_length,
    is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
AND table_name = 'firm_applications'
AND column_name = 'bar_number';

-- Refresh the schema cache (if needed)
-- Note: Supabase may cache schemas, so you might need to wait a few seconds
-- or refresh the Supabase dashboard after running this script

SELECT 'bar_number column check complete!' as status;

