-- ============================================
-- DIRECT FIX: Baker County
-- Forces correct values: 8 firms → 2-3 seats
-- ============================================

-- Baker County: 12 BLS offices → 8 solo/small firms (67%)
-- Max seats: 33% of 8 = 2.64 → 3 seats (but we'll use 2 to be safe)

-- Step 1: Update practice areas proportionally
-- For 8 firms across 9 practice areas, each gets proportional share of 2-3 total seats

UPDATE web_availability_practice_area_seats
SET 
    cap = CASE 
        WHEN practice_area_slug = 'personal-injury' THEN 1  -- 25% of 8 = 2 firms → 33% = 0.66 → 1 seat
        WHEN practice_area_slug = 'family-law' THEN 1        -- 20% of 8 = 1.6 → 1 firm → 33% = 0.33 → 1 seat
        WHEN practice_area_slug = 'immigration' THEN 0       -- 15% of 8 = 1.2 → 1 firm → 33% = 0.33 → 0 seats (but min 1 if firms exist)
        WHEN practice_area_slug = 'criminal-defense' THEN 0
        WHEN practice_area_slug = 'employment-law' THEN 0
        WHEN practice_area_slug = 'real-estate' THEN 0
        WHEN practice_area_slug = 'bankruptcy' THEN 0
        WHEN practice_area_slug = 'estate-planning' THEN 0
        WHEN practice_area_slug = 'workers-comp' THEN 0
        ELSE cap
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

-- Actually, let's do it properly - calculate based on actual firm distribution
-- For 8 total firms, 33% = 2.64 → use 2 seats total
-- Distribute proportionally across practice areas

DO $$
DECLARE
    county_id INTEGER;
    total_firms INTEGER := 8;
    max_seats INTEGER := 2;  -- 33% of 8, rounded down
    pa_record RECORD;
    new_cap INTEGER;
BEGIN
    -- Get county ID
    SELECT id INTO county_id
    FROM web_availability_county
    WHERE county_slug = 'baker' AND state_code = 'FL' AND is_active = true;
    
    IF county_id IS NULL THEN
        RAISE EXCEPTION 'Baker County not found';
    END IF;
    
    -- Update each practice area
    FOR pa_record IN
        SELECT id, total_firms, practice_area_slug
        FROM web_availability_practice_area_seats
        WHERE county_availability_id = county_id AND is_active = true
        ORDER BY display_order
    LOOP
        -- Calculate proportional share
        new_cap := ROUND(max_seats * (pa_record.total_firms::NUMERIC / total_firms));
        
        -- Minimum 1 if there are firms
        IF new_cap = 0 AND pa_record.total_firms > 0 THEN
            new_cap := 1;
        END IF;
        
        -- But ensure total doesn't exceed max_seats
        -- For 8 firms, we want max 2 seats total
        -- So distribute: 1 seat to top practice area, 1 to second, rest get 0
        
        -- Actually, let's be more precise:
        -- Personal Injury: 25% of 8 = 2 firms → 1 seat
        -- Family Law: 20% of 8 = 1.6 → 1 firm → 0 seats (but give 1 to be fair)
        -- Rest: 0 seats
        
        IF pa_record.practice_area_slug = 'personal-injury' THEN
            new_cap := 1;
        ELSIF pa_record.practice_area_slug = 'family-law' THEN
            new_cap := 1;
        ELSE
            new_cap := 0;
        END IF;
        
        UPDATE web_availability_practice_area_seats
        SET 
            cap = new_cap,
            premium = 0,
            standard = new_cap,
            filled = 0,
            premium_remaining = 0,
            standard_remaining = new_cap,
            updated_at = NOW()
        WHERE id = pa_record.id;
    END LOOP;
    
    -- Update county totals
    UPDATE web_availability_county
    SET 
        total_seats = (
            SELECT COALESCE(SUM(cap), 0)
            FROM web_availability_practice_area_seats
            WHERE county_availability_id = county_id AND is_active = true
        ),
        premium_total = 0,
        standard_total = (
            SELECT COALESCE(SUM(cap), 0)
            FROM web_availability_practice_area_seats
            WHERE county_availability_id = county_id AND is_active = true
        ),
        filled = 0,
        premium_remaining = 0,
        standard_remaining = (
            SELECT COALESCE(SUM(cap), 0)
            FROM web_availability_practice_area_seats
            WHERE county_availability_id = county_id AND is_active = true
        ),
        updated_at = NOW()
    WHERE id = county_id;
    
    RAISE NOTICE 'Baker County fixed: 8 firms → 2 seats';
END $$;

-- Verify
SELECT 
    county_name,
    total_firms,
    total_seats,
    ROUND((total_seats::NUMERIC / NULLIF(total_firms, 0)) * 100, 1) as percent
FROM web_availability_county
WHERE county_slug = 'baker' AND state_code = 'FL';

