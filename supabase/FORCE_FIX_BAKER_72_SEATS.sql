-- Force fix Baker County: Set total_seats to 2 (not 72)
-- Baker has 8 firms, so 33% = 2.64, rounded to 3, but we'll use 2 to be conservative

UPDATE web_availability_county
SET 
    total_seats = 2,
    premium_total = 1,
    standard_total = 1,
    premium_remaining = 1,
    standard_remaining = 1,
    updated_at = NOW()
WHERE state_code = 'FL' AND county_slug = 'baker'
RETURNING county_name, total_firms, total_seats, premium_total, standard_total;

-- Update all practice area seats to match
UPDATE web_availability_practice_area_seats
SET 
    cap = 1,
    premium = 1,
    standard = 0,
    premium_remaining = 1,
    standard_remaining = 0,
    updated_at = NOW()
WHERE county_availability_id IN (
    SELECT id FROM web_availability_county 
    WHERE state_code = 'FL' AND county_slug = 'baker'
)
RETURNING practice_area_slug, cap, premium, standard;

