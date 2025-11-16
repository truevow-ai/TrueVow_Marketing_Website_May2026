-- ============================================
-- Fix Teaser Check Constraint
-- Removes or updates the restrictive constraint on teaser column
-- ============================================

-- Drop the existing check constraint if it exists
ALTER TABLE blog_content 
DROP CONSTRAINT IF EXISTS blog_content_teaser_check;

-- Optional: Add a new, more lenient constraint if needed
-- For now, we'll rely on the TEXT type which allows unlimited length
-- and our form validation (500 chars recommended)
-- If you want to enforce a maximum, uncomment below:
-- ALTER TABLE blog_content 
-- ADD CONSTRAINT blog_content_teaser_check 
-- CHECK (char_length(teaser) <= 5000);

-- Verify the constraint was removed
SELECT 
    conname as constraint_name,
    pg_get_constraintdef(oid) as constraint_definition
FROM pg_constraint
WHERE conrelid = 'blog_content'::regclass
AND conname LIKE '%teaser%';

-- Verify teaser column type
SELECT 
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns
WHERE table_name = 'blog_content'
AND column_name = 'teaser';

