-- Check if Texas counties have is_active = true
SELECT 
    county_name,
    county_slug,
    total_firms,
    total_seats,
    is_active
FROM web_availability_county
WHERE state_code = 'TX'
ORDER BY county_name
LIMIT 30;

-- Count active vs inactive
SELECT 
    is_active,
    COUNT(*) as count
FROM web_availability_county
WHERE state_code = 'TX'
GROUP BY is_active;

