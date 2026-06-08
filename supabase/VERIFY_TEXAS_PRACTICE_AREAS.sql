-- Verify Texas practice areas are populated correctly

-- Check practice area count for Texas
SELECT 
    COUNT(*) as total_practice_area_records,
    COUNT(DISTINCT county_availability_id) as counties_with_practice_areas
FROM web_availability_practice_area_seats
WHERE county_availability_id IN (
    SELECT id FROM web_availability_county WHERE state_code = 'TX'
);

-- Show practice areas for Harris County (largest)
SELECT 
    c.county_name,
    pa.practice_area_name,
    pa.total_firms,
    pa.cap,
    pa.premium,
    pa.standard,
    pa.filled,
    pa.is_active
FROM web_availability_practice_area_seats pa
JOIN web_availability_county c ON pa.county_availability_id = c.id
WHERE c.state_code = 'TX' AND c.county_slug = 'harris'
ORDER BY pa.display_order;

-- Check if all Texas counties have practice areas
SELECT 
    c.county_name,
    c.total_seats,
    COUNT(pa.id) as practice_area_count
FROM web_availability_county c
LEFT JOIN web_availability_practice_area_seats pa ON pa.county_availability_id = c.id
WHERE c.state_code = 'TX' AND c.is_active = true
GROUP BY c.id, c.county_name, c.total_seats
ORDER BY c.total_seats DESC
LIMIT 10;

