-- Check for counties with < 4 seats in FL and CA
SELECT 
    state_code,
    county_name,
    total_firms,
    total_seats
FROM web_availability_county
WHERE state_code IN ('FL', 'CA') 
  AND total_seats < 4
ORDER BY state_code, county_name;

-- Summary by state
SELECT 
    state_code,
    COUNT(*) as total_counties,
    MIN(total_seats) as min_seats,
    MAX(total_seats) as max_seats
FROM web_availability_county
WHERE state_code IN ('FL', 'CA')
GROUP BY state_code
ORDER BY state_code;

