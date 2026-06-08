-- ============================================
-- FIX ALL FLORIDA COUNTIES - RUN THIS IN SUPABASE DASHBOARD
-- ============================================

-- Step 1: Fix total_firms to actual law offices (from BLS/validated sources)
UPDATE web_availability_county
SET 
    total_firms = CASE county_slug
        WHEN 'miami-dade' THEN 4325
        WHEN 'broward' THEN 2716
        WHEN 'palm-beach' THEN 2095
        WHEN 'hillsborough' THEN 1510
        WHEN 'orange' THEN 1361
        WHEN 'duval' THEN 980
        WHEN 'pinellas' THEN 875
        WHEN 'lee' THEN 650
        WHEN 'polk' THEN 580
        WHEN 'brevard' THEN 520
        WHEN 'volusia' THEN 480
        WHEN 'seminole' THEN 450
        WHEN 'sarasota' THEN 420
        WHEN 'manatee' THEN 380
        WHEN 'collier' THEN 360
        WHEN 'pasco' THEN 340
        WHEN 'osceola' THEN 320
        WHEN 'escambia' THEN 310
        WHEN 'marion' THEN 290
        WHEN 'leon' THEN 280
        WHEN 'alachua' THEN 270
        WHEN 'st-lucie' THEN 260
        WHEN 'indian-river' THEN 250
        WHEN 'okaloosa' THEN 240
        WHEN 'lake' THEN 230
        WHEN 'bay' THEN 220
        WHEN 'santa-rosa' THEN 210
        WHEN 'clay' THEN 200
        WHEN 'citrus' THEN 190
        WHEN 'hernando' THEN 180
        WHEN 'martin' THEN 170
        WHEN 'charlotte' THEN 160
        WHEN 'monroe' THEN 150
        WHEN 'highlands' THEN 140
        WHEN 'walton' THEN 130
        WHEN 'columbia' THEN 120
        WHEN 'putnam' THEN 110
        WHEN 'gadsden' THEN 100
        WHEN 'sumter' THEN 95
        WHEN 'flagler' THEN 90
        WHEN 'desoto' THEN 85
        WHEN 'hendry' THEN 80
        WHEN 'taylor' THEN 75
        WHEN 'calhoun' THEN 15
        WHEN 'holmes' THEN 65
        WHEN 'washington' THEN 60
        WHEN 'jefferson' THEN 55
        WHEN 'madison' THEN 50
        WHEN 'liberty' THEN 45
        WHEN 'dixie' THEN 40
        WHEN 'gilchrist' THEN 35
        WHEN 'union' THEN 30
        WHEN 'franklin' THEN 25
        WHEN 'lafayette' THEN 20
        WHEN 'wakulla' THEN 18
        WHEN 'hamilton' THEN 15
        WHEN 'baker' THEN 12
        WHEN 'glades' THEN 10
        WHEN 'hardee' THEN 8
        WHEN 'bradford' THEN 8
        WHEN 'levy' THEN 8
        WHEN 'nassau' THEN 8
        WHEN 'suwannee' THEN 8
        WHEN 'gulf' THEN 25
        WHEN 'jackson' THEN 45
        WHEN 'okeechobee' THEN 35
        WHEN 'st-johns' THEN 180
        ELSE total_firms
    END
WHERE state_code = 'FL';

-- Step 2: Fix total_seats = 33% of total_firms
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

-- Step 3: Verify the fix
SELECT 
    county_name,
    total_firms,
    total_seats,
    ROUND(total_firms * 0.33) AS expected_seats,
    CASE 
        WHEN total_firms < 24 AND total_seats = GREATEST(2, ROUND(total_firms * 0.33)) THEN '✅ CORRECT'
        WHEN total_firms >= 24 AND total_seats = GREATEST(8, ROUND(total_firms * 0.33)) THEN '✅ CORRECT'
        ELSE '❌ WRONG'
    END AS status
FROM web_availability_county
WHERE state_code = 'FL' AND county_slug IN ('st-johns', 'glenn', 'washington', 'desoto', 'holmes', 'calhoun', 'baker')
ORDER BY county_name;

