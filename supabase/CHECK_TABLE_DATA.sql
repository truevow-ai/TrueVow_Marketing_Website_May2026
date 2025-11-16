-- ============================================
-- CHECK IF TABLE HAS DATA
-- Run this to verify form submissions are working
-- ============================================

-- Count total records
SELECT 
    COUNT(*) as total_applications,
    COUNT(DISTINCT email) as unique_emails,
    MIN(created_at) as first_submission,
    MAX(created_at) as latest_submission
FROM firm_applications;

-- Show latest 5 applications
SELECT 
    id,
    email,
    first_name,
    last_name,
    firm_name,
    phone,
    state,
    desired_county,
    status,
    application_source,
    created_at
FROM firm_applications
ORDER BY created_at DESC
LIMIT 5;

-- Show all columns for the most recent submission
SELECT *
FROM firm_applications
ORDER BY created_at DESC
LIMIT 1;

