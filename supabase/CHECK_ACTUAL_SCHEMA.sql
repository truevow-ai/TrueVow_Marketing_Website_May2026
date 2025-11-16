-- ============================================
-- CHECK ACTUAL TABLE SCHEMA
-- This will show what columns actually exist
-- ============================================

SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default,
    character_maximum_length
FROM information_schema.columns
WHERE table_schema = 'public'
AND table_name = 'firm_applications'
ORDER BY ordinal_position;

-- Also check constraints
SELECT 
    conname as constraint_name,
    contype as constraint_type,
    pg_get_constraintdef(oid) as constraint_definition
FROM pg_constraint
WHERE conrelid = 'firm_applications'::regclass
ORDER BY conname;

