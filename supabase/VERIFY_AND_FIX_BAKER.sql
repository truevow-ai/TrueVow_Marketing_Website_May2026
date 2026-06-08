-- Verify and fix Baker County
SELECT 
    'BEFORE FIX' as status,
    county_name,
    total_firms,
    total_seats
FROM web_availability_county
WHERE county_slug = 'baker' AND state_code = 'FL';

-- Force fix
UPDATE web_availability_county
SET 
    total_seats = 2,
    premium_total = 0,
    standard_total = 2,
    filled = 0,
    premium_remaining = 0,
    standard_remaining = 2,
    updated_at = NOW()
WHERE county_slug = 'baker' AND state_code = 'FL' AND is_active = true;

-- Update practice areas
UPDATE web_availability_practice_area_seats
SET 
    cap = CASE 
        WHEN practice_area_slug = 'personal-injury' THEN 1
        WHEN practice_area_slug = 'family-law' THEN 1
        ELSE 0
    END,
    premium = 0,
    standard = CASE 
        WHEN practice_area_slug = 'personal-injury' THEN 1
        WHEN practice_area_slug = 'family-law' THEN 1
        ELSE 0
    END,
    filled = 0,
    premium_remaining = 0,
    standard_remaining = CASE 
        WHEN practice_area_slug = 'personal-injury' THEN 1
        WHEN practice_area_slug = 'family-law' THEN 1
        ELSE 0
    END,
    updated_at = NOW()
WHERE county_availability_id = (
    SELECT id FROM web_availability_county 
    WHERE county_slug = 'baker' AND state_code = 'FL' AND is_active = true
)
AND is_active = true;

-- Verify after fix
SELECT 
    'AFTER FIX' as status,
    county_name,
    total_firms,
    total_seats,
    (SELECT SUM(cap) FROM web_availability_practice_area_seats WHERE county_availability_id = c.id AND is_active = true) as sum_pa_caps
FROM web_availability_county c
WHERE county_slug = 'baker' AND state_code = 'FL';

