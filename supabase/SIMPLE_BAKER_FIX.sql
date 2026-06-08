-- Simple direct fix for Baker County
UPDATE web_availability_county
SET total_seats = 2,
    premium_total = 0,
    standard_total = 2,
    filled = 0,
    premium_remaining = 0,
    standard_remaining = 2
WHERE county_slug = 'baker' AND state_code = 'FL';

UPDATE web_availability_practice_area_seats
SET cap = CASE 
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
END
WHERE county_availability_id = (SELECT id FROM web_availability_county WHERE county_slug = 'baker' AND state_code = 'FL');

SELECT 'Baker County Fixed' as status, total_firms, total_seats FROM web_availability_county WHERE county_slug = 'baker' AND state_code = 'FL';

