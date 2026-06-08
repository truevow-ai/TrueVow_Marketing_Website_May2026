-- Check Texas county data
SELECT 
    county_name,
    total_firms,
    total_seats,
    premium_total,
    standard_total
FROM web_availability_county
WHERE state_code = 'TX'
ORDER BY total_seats DESC
LIMIT 20;

-- Count total
SELECT COUNT(*) as total_counties
FROM web_availability_county
WHERE state_code = 'TX';

