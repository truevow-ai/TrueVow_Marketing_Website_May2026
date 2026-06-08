-- SIMPLE FIX: Correct total_seats for all Florida counties
-- Formula: total_seats = 33% of total_firms (min 2 for small, min 8 for larger)

UPDATE web_availability_county
SET 
    total_seats = CASE 
        WHEN total_firms < 24 THEN GREATEST(2, ROUND(total_firms * 0.33))
        ELSE GREATEST(8, ROUND(total_firms * 0.33))
    END,
    premium_total = CASE 
        WHEN total_firms < 24 THEN GREATEST(1, ROUND(GREATEST(2, ROUND(total_firms * 0.33)) * 0.21))
        ELSE GREATEST(1, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21))
    END,
    standard_total = CASE 
        WHEN total_firms < 24 THEN (GREATEST(2, ROUND(total_firms * 0.33)) - GREATEST(1, ROUND(GREATEST(2, ROUND(total_firms * 0.33)) * 0.21)))
        ELSE (GREATEST(8, ROUND(total_firms * 0.33)) - GREATEST(1, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21)))
    END,
    filled = CASE 
        WHEN total_firms < 24 THEN ROUND(GREATEST(2, ROUND(total_firms * 0.33)) * 0.12)
        ELSE ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.12)
    END,
    premium_remaining = CASE 
        WHEN total_firms < 24 THEN (GREATEST(1, ROUND(GREATEST(2, ROUND(total_firms * 0.33)) * 0.21)) - ROUND(ROUND(GREATEST(2, ROUND(total_firms * 0.33)) * 0.12) * 0.21))
        ELSE (GREATEST(1, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21)) - ROUND(ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.12) * 0.21))
    END,
    standard_remaining = CASE 
        WHEN total_firms < 24 THEN ((GREATEST(2, ROUND(total_firms * 0.33)) - GREATEST(1, ROUND(GREATEST(2, ROUND(total_firms * 0.33)) * 0.21))) - ROUND(ROUND(GREATEST(2, ROUND(total_firms * 0.33)) * 0.12) * 0.79))
        ELSE ((GREATEST(8, ROUND(total_firms * 0.33)) - GREATEST(1, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21))) - ROUND(ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.12) * 0.79))
    END,
    updated_at = NOW()
WHERE state_code = 'FL';

-- Verify Baker County specifically
SELECT 
    county_name,
    total_firms,
    total_seats,
    ROUND(total_firms * 0.33) AS expected_33_percent,
    CASE 
        WHEN total_firms < 24 AND total_seats = GREATEST(2, ROUND(total_firms * 0.33)) THEN '✅ CORRECT'
        WHEN total_firms >= 24 AND total_seats = GREATEST(8, ROUND(total_firms * 0.33)) THEN '✅ CORRECT'
        ELSE '❌ WRONG'
    END AS status
FROM web_availability_county
WHERE state_code = 'FL' AND county_slug IN ('baker', 'calhoun', 'hardee', 'glades', 'suwannee')
ORDER BY county_name;

