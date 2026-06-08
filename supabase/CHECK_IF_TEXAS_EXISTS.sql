-- Check if ANY Texas data exists (bypassing RLS for admin check)
SELECT COUNT(*) as total_texas_counties
FROM web_availability_county
WHERE state_code = 'TX';

-- If count is 0, the data wasn't inserted
-- If count > 0, check is_active status
SELECT 
    county_name,
    is_active,
    total_firms,
    total_seats
FROM web_availability_county
WHERE state_code = 'TX'
ORDER BY county_name
LIMIT 20;

