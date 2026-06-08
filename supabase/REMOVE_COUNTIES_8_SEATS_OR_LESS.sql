-- Remove all counties with ≤ 8 seats from all states
-- This ensures consistency with our policy: only counties with > 8 seats are viable markets
-- Generated: 2025-01-XX

BEGIN;

-- First, delete practice area data for counties with ≤ 8 seats
DELETE FROM web_availability_practice_area_seats 
WHERE county_availability_id IN (
    SELECT id 
    FROM web_availability_county 
    WHERE total_seats <= 8
);

-- Then, delete the counties themselves
DELETE FROM web_availability_county 
WHERE total_seats <= 8;

COMMIT;

-- Verification query: Check remaining counties
SELECT 
    state_code,
    COUNT(*) as county_count,
    MIN(total_seats) as min_seats,
    MAX(total_seats) as max_seats
FROM web_availability_county
WHERE is_active = true
GROUP BY state_code
ORDER BY state_code;

-- Show which counties were removed (if any still exist with ≤ 8)
SELECT 
    state_code,
    county_name,
    total_firms,
    total_seats
FROM web_availability_county
WHERE total_seats <= 8
ORDER BY state_code, county_name;

