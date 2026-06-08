-- Verify Texas counties were inserted
SELECT COUNT(*) as total_counties 
FROM web_availability_county 
WHERE state_code = 'TX';

-- Show first 10 counties
SELECT 
    county_name,
    county_slug,
    total_firms,
    total_seats,
    is_active
FROM web_availability_county 
WHERE state_code = 'TX'
ORDER BY total_seats DESC
LIMIT 10;

