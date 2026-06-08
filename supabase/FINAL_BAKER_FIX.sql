-- ============================================
-- FINAL FIX: Baker County - Force 2 Seats
-- ============================================

-- Baker County: 8 firms → MAX 2-3 seats (33% of 8 = 2.64)

-- Step 1: Set all practice areas to 0 except top 2
UPDATE web_availability_practice_area_seats
SET 
    cap = CASE 
        WHEN practice_area_slug = 'personal-injury' THEN 1
        WHEN practice_area_slug = 'family-law' THEN 1
        ELSE 0
    END,
    premium = 0,
    standard = CASE 
        WHEN practice_area_slug = 'personal-injury' THEN 1
        WHEN practice_area_slug = 'family-law' THEN 1
        ELSE 0
    END,
    filled = 0,
    premium_remaining = 0,
    standard_remaining = CASE 
        WHEN practice_area_slug = 'personal-injury' THEN 1
        WHEN practice_area_slug = 'family-law' THEN 1
        ELSE 0
    END,
    updated_at = NOW()
WHERE county_availability_id = (
    SELECT id FROM web_availability_county 
    WHERE county_slug = 'baker' AND state_code = 'FL' AND is_active = true
)
AND is_active = true;

-- Step 2: Update county totals
UPDATE web_availability_county
SET 
    total_seats = 2,
    premium_total = 0,
    standard_total = 2,
    filled = 0,
    premium_remaining = 0,
    standard_remaining = 2,
    updated_at = NOW()
WHERE county_slug = 'baker' AND state_code = 'FL' AND is_active = true;

-- Verify
SELECT 
    'County' as type,
    county_name as name,
    total_firms,
    total_seats,
    ROUND((total_seats::NUMERIC / NULLIF(total_firms, 0)) * 100, 1) as percent
FROM web_availability_county
WHERE county_slug = 'baker' AND state_code = 'FL'
UNION ALL
SELECT 
    'Practice Area' as type,
    practice_area_name as name,
    total_firms,
    cap as total_seats,
    ROUND((cap::NUMERIC / NULLIF(total_firms, 0)) * 100, 1) as percent
FROM web_availability_practice_area_seats pa
JOIN web_availability_county c ON c.id = pa.county_availability_id
WHERE c.county_slug = 'baker' AND c.state_code = 'FL' AND pa.is_active = true
ORDER BY type DESC, name;

