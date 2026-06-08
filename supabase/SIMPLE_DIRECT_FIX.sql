-- SIMPLE DIRECT FIX - Just calculate 33% of total_firms
-- No complex nested functions, just the basic formula

UPDATE web_availability_county
SET 
    total_seats = CASE 
        WHEN total_firms < 24 THEN GREATEST(2, ROUND(total_firms * 0.33))
        ELSE ROUND(total_firms * 0.33)
    END,
    updated_at = NOW()
WHERE state_code = 'FL';

-- Verify with examples
SELECT 
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
WHERE state_code = 'FL' AND county_slug IN ('st-johns', 'glenn', 'washington', 'desoto', 'holmes')
ORDER BY county_name;

