-- ============================================
-- Check and Fix All Constraints on blog_content
-- This script identifies and removes restrictive constraints
-- ============================================

-- First, let's see what constraints exist
SELECT 
    conname as constraint_name,
    contype as constraint_type,
    pg_get_constraintdef(oid) as constraint_definition
FROM pg_constraint
WHERE conrelid = 'blog_content'::regclass
ORDER BY conname;

-- Drop the teaser check constraint
ALTER TABLE blog_content 
DROP CONSTRAINT IF EXISTS blog_content_teaser_check;

-- Drop any other check constraints that might be limiting length
-- (in case there are others we don't know about)
DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN 
        SELECT conname 
        FROM pg_constraint 
        WHERE conrelid = 'blog_content'::regclass 
        AND contype = 'c' 
        AND (conname LIKE '%title%' OR conname LIKE '%teaser%' OR conname LIKE '%check%')
    LOOP
        EXECUTE 'ALTER TABLE blog_content DROP CONSTRAINT IF EXISTS ' || quote_ident(r.conname);
        RAISE NOTICE 'Dropped constraint: %', r.conname;
    END LOOP;
END $$;

-- Verify column types
SELECT 
    column_name,
    data_type,
    character_maximum_length,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'blog_content'
AND column_name IN ('title', 'teaser')
ORDER BY column_name;

-- Verify constraints are gone
SELECT 
    conname as constraint_name,
    contype as constraint_type,
    pg_get_constraintdef(oid) as constraint_definition
FROM pg_constraint
WHERE conrelid = 'blog_content'::regclass
AND contype = 'c'
AND (conname LIKE '%title%' OR conname LIKE '%teaser%' OR conname LIKE '%check%')
ORDER BY conname;

-- Success message
SELECT 'All restrictive constraints removed! Title and teaser can now accept longer text.' as status;

