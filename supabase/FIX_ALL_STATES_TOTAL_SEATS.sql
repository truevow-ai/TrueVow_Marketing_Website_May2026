-- FIX TOTAL_SEATS FOR ALL STATES
-- Formula: total_seats = 33% of total_firms
-- Minimum: 2 seats for small counties (< 24 firms), no minimum for larger counties

UPDATE web_availability_county
SET 
    total_seats = CASE 
        WHEN total_firms < 24 THEN GREATEST(2, ROUND(total_firms * 0.33))
        ELSE ROUND(total_firms * 0.33)
    END,
    updated_at = NOW();

-- Verify specific examples
SELECT 
    state_code,
    county_name,
    total_firms,
    total_seats,
    ROUND(total_firms * 0.33) AS calculated_33_percent,
    CASE 
        WHEN total_firms < 24 THEN GREATEST(2, ROUND(total_firms * 0.33))
        ELSE ROUND(total_firms * 0.33)
    END AS should_be,
    CASE 
        WHEN total_seats = CASE 
            WHEN total_firms < 24 THEN GREATEST(2, ROUND(total_firms * 0.33))
            ELSE ROUND(total_firms * 0.33)
        END THEN '✅ CORRECT'
        ELSE '❌ WRONG'
    END AS status
FROM web_availability_county
WHERE county_slug IN ('st-johns', 'glenn') OR (state_code = 'FL' AND county_slug IN ('washington', 'desoto', 'holmes'))
ORDER BY state_code, county_name;

