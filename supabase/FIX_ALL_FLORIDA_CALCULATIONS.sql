-- ============================================
-- FIX ALL FLORIDA COUNTY CALCULATIONS
-- Corrects total_seats to be 33% of total_firms
-- ============================================

-- Step 1: Update all Florida counties with correct total_seats calculation
-- Formula: total_seats = max(2, round(total_firms * 0.33)) for small counties
--          total_seats = max(8, round(total_firms * 0.33)) for larger counties

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
        WHEN total_firms < 24 THEN GREATEST(0, GREATEST(2, ROUND(total_firms * 0.33)) - GREATEST(1, ROUND(GREATEST(2, ROUND(total_firms * 0.33)) * 0.21)))
        ELSE GREATEST(0, GREATEST(8, ROUND(total_firms * 0.33)) - GREATEST(1, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21)))
    END,
    filled = CASE 
        WHEN total_firms < 24 THEN ROUND(GREATEST(2, ROUND(total_firms * 0.33)) * 0.12)
        ELSE ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.12)
    END,
    premium_remaining = CASE 
        WHEN total_firms < 24 THEN GREATEST(0, GREATEST(1, ROUND(GREATEST(2, ROUND(total_firms * 0.33)) * 0.21)) - ROUND(ROUND(GREATEST(2, ROUND(total_firms * 0.33)) * 0.12) * (GREATEST(1, ROUND(GREATEST(2, ROUND(total_firms * 0.33)) * 0.21)) / GREATEST(2, ROUND(total_firms * 0.33)))))
        ELSE GREATEST(0, GREATEST(1, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21)) - ROUND(ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.12) * (GREATEST(1, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21)) / GREATEST(8, ROUND(total_firms * 0.33)))))
    END,
    standard_remaining = CASE 
        WHEN total_firms < 24 THEN GREATEST(0, GREATEST(0, GREATEST(2, ROUND(total_firms * 0.33)) - GREATEST(1, ROUND(GREATEST(2, ROUND(total_firms * 0.33)) * 0.21))) - ROUND(ROUND(GREATEST(2, ROUND(total_firms * 0.33)) * 0.12) * (GREATEST(0, GREATEST(2, ROUND(total_firms * 0.33)) - GREATEST(1, ROUND(GREATEST(2, ROUND(total_firms * 0.33)) * 0.21))) / GREATEST(2, ROUND(total_firms * 0.33)))))
        ELSE GREATEST(0, GREATEST(0, GREATEST(8, ROUND(total_firms * 0.33)) - GREATEST(1, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21))) - ROUND(ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.12) * (GREATEST(0, GREATEST(8, ROUND(total_firms * 0.33)) - GREATEST(1, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21))) / GREATEST(8, ROUND(total_firms * 0.33)))))
    END,
    updated_at = NOW()
WHERE state_code = 'FL';

-- Step 2: Update practice area seats to match
-- For each practice area, calculate cap as proportional share of total_seats
-- Then calculate premium (21% of cap) and standard (remaining)

WITH county_totals AS (
    SELECT 
        id,
        total_seats,
        total_firms
    FROM web_availability_county
    WHERE state_code = 'FL'
),
practice_area_distribution AS (
    SELECT 
        pas.id,
        pas.county_availability_id,
        pas.practice_area_slug,
        CASE pas.practice_area_slug
            WHEN 'personal-injury' THEN 0.25
            WHEN 'family-law' THEN 0.20
            WHEN 'immigration' THEN 0.15
            WHEN 'criminal-defense' THEN 0.12
            WHEN 'employment-law' THEN 0.08
            WHEN 'real-estate' THEN 0.07
            WHEN 'bankruptcy' THEN 0.05
            WHEN 'estate-planning' THEN 0.04
            WHEN 'workers-comp' THEN 0.04
            ELSE 0
        END AS distribution_pct
    FROM web_availability_practice_area_seats pas
    INNER JOIN county_totals ct ON pas.county_availability_id = ct.id
),
calculated_caps AS (
    SELECT 
        pa.id,
        pa.county_availability_id,
        ct.total_seats,
        ct.total_firms,
        pa.distribution_pct,
        ROUND(ct.total_seats * pa.distribution_pct) AS calculated_cap
    FROM practice_area_distribution pa
    INNER JOIN county_totals ct ON pa.county_availability_id = ct.id
),
scaled_caps AS (
    SELECT 
        cc.id,
        cc.county_availability_id,
        cc.total_seats,
        SUM(cc.calculated_cap) OVER (PARTITION BY cc.county_availability_id) AS total_calculated,
        cc.calculated_cap,
        CASE 
            WHEN SUM(cc.calculated_cap) OVER (PARTITION BY cc.county_availability_id) > 0 
            THEN ROUND(cc.calculated_cap * (cc.total_seats::numeric / SUM(cc.calculated_cap) OVER (PARTITION BY cc.county_availability_id)))
            ELSE 0
        END AS scaled_cap
    FROM calculated_caps cc
),
final_caps AS (
    SELECT 
        sc.id,
        sc.county_availability_id,
        sc.total_seats,
        CASE 
            WHEN sc.scaled_cap = 0 AND sc.total_seats < 9 THEN 0
            WHEN sc.scaled_cap = 0 THEN 1
            ELSE sc.scaled_cap
        END AS final_cap
    FROM scaled_caps sc
)
UPDATE web_availability_practice_area_seats pas
SET 
    cap = fc.final_cap,
    premium = GREATEST(1, ROUND(fc.final_cap * 0.21)),
    standard = GREATEST(0, fc.final_cap - GREATEST(1, ROUND(fc.final_cap * 0.21))),
    filled = ROUND(fc.final_cap * 0.12),
    premium_remaining = GREATEST(0, GREATEST(1, ROUND(fc.final_cap * 0.21)) - ROUND(ROUND(fc.final_cap * 0.12) * (GREATEST(1, ROUND(fc.final_cap * 0.21))::numeric / NULLIF(fc.final_cap, 0)))),
    standard_remaining = GREATEST(0, GREATEST(0, fc.final_cap - GREATEST(1, ROUND(fc.final_cap * 0.21))) - ROUND(ROUND(fc.final_cap * 0.12) * (GREATEST(0, fc.final_cap - GREATEST(1, ROUND(fc.final_cap * 0.21)))::numeric / NULLIF(fc.final_cap, 0)))),
    updated_at = NOW()
FROM final_caps fc
WHERE pas.id = fc.id;

-- Step 3: Verify the fix
SELECT 
    county_name,
    total_firms,
    total_seats,
    ROUND(total_firms * 0.33) AS expected_seats,
    CASE 
        WHEN total_seats = ROUND(total_firms * 0.33) OR (total_firms < 24 AND total_seats = GREATEST(2, ROUND(total_firms * 0.33))) OR (total_firms >= 24 AND total_seats = GREATEST(8, ROUND(total_firms * 0.33)))
        THEN '✅ CORRECT'
        ELSE '❌ WRONG'
    END AS status
FROM web_availability_county
WHERE state_code = 'FL'
ORDER BY total_firms ASC
LIMIT 20;

