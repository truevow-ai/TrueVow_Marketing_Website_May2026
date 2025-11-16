-- ============================================
-- ADD ALL REQUIRED CONSTRAINTS (Based on Form)
-- Based on required fields in marketing/apply.html
-- Run this script to add all NOT NULL constraints at once
-- ============================================

-- Required fields from the form (marked with <span class="required">*</span>):
-- 1. email (already NOT NULL)
-- 2. first_name (required)
-- 3. last_name (required)
-- 4. phone (required)
-- 5. firm_name (required)
-- 6. practice_area (required)
-- 7. state (required)
-- 8. desired_county (required)
-- 9. firm_size (required)
-- 10. monthly_calls (required)
-- 11. bar_number (required)
-- Note: eligibility_1-4 and terms_agree are checkboxes (boolean with default false, so OK)

-- ============================================
-- ADD ALL CONSTRAINTS IN ONE GO
-- ============================================
ALTER TABLE firm_applications 
    ALTER COLUMN first_name SET NOT NULL,
    ALTER COLUMN last_name SET NOT NULL,
    ALTER COLUMN phone SET NOT NULL,
    ALTER COLUMN firm_name SET NOT NULL,
    ALTER COLUMN practice_area SET NOT NULL,
    ALTER COLUMN state SET NOT NULL,
    ALTER COLUMN desired_county SET NOT NULL,
    ALTER COLUMN firm_size SET NOT NULL,
    ALTER COLUMN monthly_calls SET NOT NULL,
    ALTER COLUMN bar_number SET NOT NULL;

SELECT '✅ ALL REQUIRED CONSTRAINTS ADDED!' as status;

-- ============================================
-- VERIFY ALL CONSTRAINTS
-- ============================================
SELECT 
    column_name,
    data_type,
    is_nullable,
    CASE 
        WHEN column_name IN ('email', 'firm_name', 'first_name', 'last_name', 'phone', 
                            'state', 'desired_county', 'practice_area', 'firm_size', 
                            'monthly_calls', 'bar_number') 
             AND is_nullable = 'NO' THEN '✅ Required (correct)'
        WHEN column_name NOT IN ('email', 'firm_name', 'first_name', 'last_name', 'phone', 
                                'state', 'desired_county', 'practice_area', 'firm_size', 
                                'monthly_calls', 'bar_number', 'id', 'created_at', 'updated_at')
             AND is_nullable = 'YES' THEN '✅ Optional (correct)'
        ELSE '❌ CHECK THIS'
    END as status
FROM information_schema.columns
WHERE table_name = 'firm_applications'
ORDER BY 
    CASE WHEN is_nullable = 'NO' THEN 0 ELSE 1 END,
    column_name;

SELECT '✅ ALL CONSTRAINTS ADDED - Final test of form submission!' as final_status;

-- ============================================
-- ROLLBACK COMMANDS (if any step fails):
-- ============================================
-- ALTER TABLE firm_applications ALTER COLUMN firm_name DROP NOT NULL;
-- ALTER TABLE firm_applications ALTER COLUMN first_name DROP NOT NULL;
-- ALTER TABLE firm_applications ALTER COLUMN last_name DROP NOT NULL;
-- ALTER TABLE firm_applications ALTER COLUMN phone DROP NOT NULL;
-- ALTER TABLE firm_applications ALTER COLUMN state DROP NOT NULL;
-- ALTER TABLE firm_applications ALTER COLUMN desired_county DROP NOT NULL;
-- ALTER TABLE firm_applications ALTER COLUMN practice_area DROP NOT NULL;
-- ALTER TABLE firm_applications ALTER COLUMN firm_size DROP NOT NULL;
-- ALTER TABLE firm_applications ALTER COLUMN monthly_calls DROP NOT NULL;
-- ALTER TABLE firm_applications ALTER COLUMN bar_number DROP NOT NULL;

