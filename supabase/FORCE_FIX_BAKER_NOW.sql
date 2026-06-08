-- FORCE FIX: Baker County total_seats from 72 to 2
UPDATE web_availability_county
SET 
    total_seats = 2,
    premium_total = 1,
    standard_total = 1,
    premium_remaining = 1,
    standard_remaining = 1,
    updated_at = NOW()
WHERE state_code = 'FL' AND county_slug = 'baker';

-- Fix all practice area seats
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
);

