-- ============================================
-- ADD CONSTRAINTS ONE BY ONE (Test After Each)
-- Run each section, test form, then move to next
-- ============================================

-- ============================================
-- STEP 1: Add NOT NULL to firm_name (most important)
-- ============================================
-- Test the form after this
ALTER TABLE firm_applications 
    ALTER COLUMN firm_name SET NOT NULL;

-- Verify
SELECT 
    column_name,
    is_nullable,
    'firm_name should be NOT NULL' as check
FROM information_schema.columns
WHERE table_name = 'firm_applications'
  AND column_name = 'firm_name';

SELECT '✅ Step 1 Complete - Test form submission NOW!' as status;
SELECT 'If form works, continue to Step 2. If not, rollback with:' as note;
SELECT 'ALTER TABLE firm_applications ALTER COLUMN firm_name DROP NOT NULL;' as rollback_command;


-- ============================================
-- STEP 2: Add NOT NULL to first_name
-- ============================================
-- Uncomment when ready to test:
-- ALTER TABLE firm_applications 
--     ALTER COLUMN first_name SET NOT NULL;
-- 
-- Verify:
-- SELECT column_name, is_nullable
-- FROM information_schema.columns
-- WHERE table_name = 'firm_applications'
--   AND column_name = 'first_name';


-- ============================================
-- STEP 3: Add NOT NULL to last_name
-- ============================================
-- Uncomment when ready to test:
-- ALTER TABLE firm_applications 
--     ALTER COLUMN last_name SET NOT NULL;


-- ============================================
-- STEP 4: Add NOT NULL to phone
-- ============================================
-- Uncomment when ready to test:
-- ALTER TABLE firm_applications 
--     ALTER COLUMN phone SET NOT NULL;


-- ============================================
-- STEP 5: Add NOT NULL to state
-- ============================================
-- Uncomment when ready to test:
-- ALTER TABLE firm_applications 
--     ALTER COLUMN state SET NOT NULL;


-- ============================================
-- STEP 6: Add NOT NULL to desired_county
-- ============================================
-- Uncomment when ready to test:
-- ALTER TABLE firm_applications 
--     ALTER COLUMN desired_county SET NOT NULL;


-- ============================================
-- ROLLBACK COMMAND (if any step fails):
-- ============================================
-- ALTER TABLE firm_applications 
--     ALTER COLUMN [column_name] DROP NOT NULL;

