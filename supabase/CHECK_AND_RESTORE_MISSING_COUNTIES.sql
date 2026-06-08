-- Check which Florida counties exist
SELECT 
    county_slug, 
    county_name, 
    total_firms, 
    total_seats, 
    is_active,
    CASE 
        WHEN total_seats = 72 THEN '❌ STILL 72'
        WHEN total_firms < 24 AND total_seats = GREATEST(2, ROUND(total_firms * 0.33)) THEN '✅ CORRECT'
        WHEN total_firms >= 24 AND total_seats = GREATEST(8, ROUND(total_firms * 0.33)) THEN '✅ CORRECT'
        ELSE '⚠️  CHECK'
    END AS status
FROM web_availability_county
WHERE state_code = 'FL'
ORDER BY county_name;

-- Count total
SELECT COUNT(*) as total_counties FROM web_availability_county WHERE state_code = 'FL';

-- Check specifically for Baker
SELECT * FROM web_availability_county WHERE state_code = 'FL' AND county_slug = 'baker';

