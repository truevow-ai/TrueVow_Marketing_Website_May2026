-- Check Florida practice area structure to replicate for Texas
SELECT 
    pa.practice_area_slug,
    pa.practice_area_name,
    pa.total_firms,
    pa.cap,
    pa.premium,
    pa.standard,
    pa.filled,
    pa.is_active
FROM web_availability_practice_area_seats pa
JOIN web_availability_county c ON pa.county_availability_id = c.id
WHERE c.state_code = 'FL' AND c.county_slug = 'miami-dade'
ORDER BY pa.display_order
LIMIT 3;

