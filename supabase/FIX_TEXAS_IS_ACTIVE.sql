-- Fix Texas counties to ensure is_active = true
-- This is required for RLS policies to allow public read access

-- Update counties
UPDATE web_availability_county
SET is_active = true
WHERE state_code = 'TX' AND (is_active = false OR is_active IS NULL);

-- Update practice area seats
UPDATE web_availability_practice_area_seats
SET is_active = true
WHERE county_availability_id IN (
    SELECT id FROM web_availability_county WHERE state_code = 'TX'
) AND (is_active = false OR is_active IS NULL);

-- Verify
SELECT 
    COUNT(*) as total_counties,
    COUNT(*) FILTER (WHERE is_active = true) as active_counties
FROM web_availability_county
WHERE state_code = 'TX';

-- Show sample counties
SELECT 
    county_name,
    total_firms,
    total_seats,
    is_active
FROM web_availability_county
WHERE state_code = 'TX'
ORDER BY total_seats DESC
LIMIT 10;

