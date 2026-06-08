-- Check Baker County
SELECT 
    county_name,
    total_firms,
    total_seats,
    ROUND((total_seats::NUMERIC / NULLIF(total_firms, 0)) * 100, 1) as percent,
    ROUND(total_firms * 0.33) as expected_max
FROM web_availability_county
WHERE county_slug = 'baker' AND state_code = 'FL';

-- Check practice area breakdown
SELECT 
    pa.practice_area_name,
    pa.total_firms,
    pa.cap,
    pa.premium,
    pa.standard
FROM web_availability_practice_area_seats pa
JOIN web_availability_county c ON c.id = pa.county_availability_id
WHERE c.county_slug = 'baker' AND c.state_code = 'FL' AND pa.is_active = true
ORDER BY pa.display_order;

