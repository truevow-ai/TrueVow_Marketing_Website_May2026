-- Fix Baker County: Ensure total_seats does not exceed total_firms
-- Baker County has 8 firms, so total_seats should be max 3 (33% of 8 = 2.64, rounded to 3)
-- But we'll use 2 to be conservative (25% cap for very small counties)

UPDATE web_availability_county
SET 
    total_seats = 2,
    premium_total = 1,
    standard_total = 1,
    premium_remaining = 1,
    standard_remaining = 1
WHERE state_code = 'FL' AND county_slug = 'baker';

-- Update all practice area seats for Baker County
-- Scale down each practice area to ensure total doesn't exceed 2
UPDATE web_availability_practice_area_seats
SET 
    cap = 1,
    premium = 1,
    standard = 0,
    premium_remaining = 1,
    standard_remaining = 0
WHERE county_availability_id IN (
    SELECT id FROM web_availability_county 
    WHERE state_code = 'FL' AND county_slug = 'baker'
);

-- Verify the fix
SELECT 
    county_name,
    total_firms,
    total_seats,
    premium_total,
    standard_total,
    (SELECT COUNT(*) FROM web_availability_practice_area_seats WHERE county_availability_id = web_availability_county.id) as practice_area_count
FROM web_availability_county
WHERE state_code = 'FL' AND county_slug = 'baker';

