-- Check if Texas practice areas exist
SELECT 
    COUNT(*) as total_records,
    COUNT(DISTINCT county_availability_id) as counties_with_practice_areas
FROM web_availability_practice_area_seats
WHERE county_availability_id IN (
    SELECT id FROM web_availability_county WHERE state_code = 'TX'
);

-- Check a specific county
SELECT 
    c.county_name,
    COUNT(pa.id) as practice_area_count
FROM web_availability_county c
LEFT JOIN web_availability_practice_area_seats pa ON pa.county_availability_id = c.id
WHERE c.state_code = 'TX' AND c.county_slug = 'harris'
GROUP BY c.id, c.county_name;

