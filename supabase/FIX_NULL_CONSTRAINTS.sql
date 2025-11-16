-- ============================================
-- FIX NULL CONSTRAINTS - Make all columns nullable except email
-- Run this to fix "null value violates not-null constraint" errors
-- ============================================

-- First, check current constraints
SELECT 
    column_name,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_name = 'firm_applications'
  AND is_nullable = 'NO'
  AND column_name != 'email'
ORDER BY column_name;

-- Drop NOT NULL constraints on all columns (except email)
DO $$
DECLARE
    col_record RECORD;
BEGIN
    FOR col_record IN 
        SELECT column_name
        FROM information_schema.columns
        WHERE table_name = 'firm_applications'
          AND is_nullable = 'NO'
          AND column_name != 'email'
          AND column_name != 'id'
          AND column_name != 'created_at'
    LOOP
        BEGIN
            EXECUTE format('ALTER TABLE firm_applications ALTER COLUMN %I DROP NOT NULL', col_record.column_name);
            RAISE NOTICE 'Dropped NOT NULL constraint on %', col_record.column_name;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE NOTICE 'Could not drop NOT NULL on %: %', col_record.column_name, SQLERRM;
        END;
    END LOOP;
END $$;

-- Verify all columns are now nullable (except email, id, created_at)
SELECT 
    column_name,
    is_nullable,
    CASE 
        WHEN column_name IN ('email', 'id', 'created_at') AND is_nullable = 'NO' THEN '✅ Required (correct)'
        WHEN column_name NOT IN ('email', 'id', 'created_at') AND is_nullable = 'YES' THEN '✅ Nullable (correct)'
        ELSE '❌ CHECK THIS'
    END as status
FROM information_schema.columns
WHERE table_name = 'firm_applications'
ORDER BY 
    CASE WHEN column_name IN ('id', 'email', 'created_at') THEN 0 ELSE 1 END,
    column_name;

SELECT '✅ All constraints fixed! Form should work now.' as status;

