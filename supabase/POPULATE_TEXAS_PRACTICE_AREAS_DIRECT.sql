-- Delete existing Texas practice areas
DELETE FROM web_availability_practice_area_seats
WHERE county_availability_id IN (
    SELECT id FROM web_availability_county WHERE state_code = 'TX'
);

-- Insert practice areas for Harris County (sample)
-- This uses the EXACT same structure as Florida
INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    c.id,
    'personal-injury',
    'Personal Injury',
    ROUND(c.total_firms * 0.25),
    ROUND(c.total_seats * 0.25),
    ROUND(c.total_seats * 0.25 * 0.21),
    ROUND(c.total_seats * 0.25 * 0.79),
    ROUND(c.total_seats * 0.25 * 0.12),
    ROUND(c.total_seats * 0.25 * 0.21 * 0.88),
    ROUND(c.total_seats * 0.25 * 0.79 * 0.88),
    1,
    true
FROM web_availability_county c
WHERE c.state_code = 'TX' AND c.county_slug = 'harris';

-- Check result
SELECT 
    c.county_name,
    pa.practice_area_name,
    pa.cap,
    pa.premium,
    pa.standard
FROM web_availability_county c
JOIN web_availability_practice_area_seats pa ON pa.county_availability_id = c.id
WHERE c.state_code = 'TX' AND c.county_slug = 'harris';

