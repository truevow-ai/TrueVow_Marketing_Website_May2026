-- ============================================
-- MAKE ALL COLUMNS NULLABLE (Except email)
-- This ensures form submissions work even if fields are missing
-- ============================================

-- Make all columns nullable (except email which is already required)
ALTER TABLE firm_applications 
    ALTER COLUMN firm_name DROP NOT NULL,
    ALTER COLUMN first_name DROP NOT NULL,
    ALTER COLUMN last_name DROP NOT NULL,
    ALTER COLUMN phone DROP NOT NULL,
    ALTER COLUMN practice_area DROP NOT NULL,
    ALTER COLUMN state DROP NOT NULL,
    ALTER COLUMN desired_county DROP NOT NULL,
    ALTER COLUMN firm_size DROP NOT NULL,
    ALTER COLUMN monthly_calls DROP NOT NULL,
    ALTER COLUMN referral_source DROP NOT NULL,
    ALTER COLUMN bar_number DROP NOT NULL,
    ALTER COLUMN firm_website DROP NOT NULL,
    ALTER COLUMN primary_contact_name DROP NOT NULL;

-- Verify all columns are nullable (except email)
SELECT 
    column_name,
    data_type,
    is_nullable,
    CASE 
        WHEN column_name = 'email' AND is_nullable = 'NO' THEN '✅ Required (correct)'
        WHEN column_name != 'email' AND is_nullable = 'YES' THEN '✅ Nullable (correct)'
        ELSE '❌ CHECK THIS'
    END as status
FROM information_schema.columns
WHERE table_name = 'firm_applications'
  AND column_name IN (
      'email', 'firm_name', 'first_name', 'last_name', 'phone',
      'practice_area', 'state', 'desired_county', 'firm_size',
      'monthly_calls', 'referral_source', 'bar_number', 'firm_website',
      'primary_contact_name'
  )
ORDER BY 
    CASE WHEN column_name = 'email' THEN 0 ELSE 1 END,
    column_name;

SELECT '✅ All columns (except email) are now nullable!' as status;

