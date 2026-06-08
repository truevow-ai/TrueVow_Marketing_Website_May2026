-- ============================================
-- CRITICAL FIX: Ensure Total Seats Never Exceed Total Firms
-- This fixes the issue where small counties show 72 seats for 8 firms
-- ============================================

-- Step 1: Recalculate all practice area caps to ensure they're proportional
-- and total seats don't exceed total firms

DO $$
DECLARE
    county_record RECORD;
    total_firms INTEGER;
    max_total_seats INTEGER;
    current_total_seats INTEGER;
    scale_factor NUMERIC;
    practice_area_record RECORD;
    new_cap INTEGER;
    new_premium INTEGER;
    new_standard INTEGER;
BEGIN
    -- Loop through each county
    FOR county_record IN 
        SELECT id, total_firms, state_code, county_name
        FROM web_availability_county
        WHERE is_active = true
    LOOP
        total_firms := county_record.total_firms;
        
        -- Calculate maximum total seats (33% of total firms, minimum 8)
        max_total_seats := GREATEST(8, ROUND(total_firms * 0.33));
        
        -- Get current total seats from practice areas
        SELECT COALESCE(SUM(cap), 0) INTO current_total_seats
        FROM web_availability_practice_area_seats
        WHERE county_availability_id = county_record.id AND is_active = true;
        
        -- If current total exceeds max, we need to scale down
        IF current_total_seats > max_total_seats THEN
            scale_factor := max_total_seats::NUMERIC / current_total_seats::NUMERIC;
            
            -- Update each practice area proportionally
            FOR practice_area_record IN
                SELECT id, cap, total_firms, practice_area_slug
                FROM web_availability_practice_area_seats
                WHERE county_availability_id = county_record.id AND is_active = true
            LOOP
                -- Scale down the cap
                new_cap := GREATEST(1, ROUND(practice_area_record.cap * scale_factor));
                
                -- Ensure cap doesn't exceed the practice area's firms (33% of those firms)
                new_cap := LEAST(new_cap, GREATEST(1, ROUND(practice_area_record.total_firms * 0.33)));
                
                -- Recalculate premium and standard
                new_premium := CASE 
                    WHEN new_cap >= 5 THEN GREATEST(1, ROUND(new_cap * 0.21))
                    ELSE 0
                END;
                new_standard := new_cap - new_premium;
                
                -- Update the practice area
                UPDATE web_availability_practice_area_seats
                SET 
                    cap = new_cap,
                    premium = new_premium,
                    standard = new_standard,
                    filled = GREATEST(0, ROUND(new_cap * 0.12)),
                    premium_remaining = CASE 
                        WHEN new_premium > 0 THEN GREATEST(0, new_premium - ROUND(new_premium * 0.12))
                        ELSE 0
                    END,
                    standard_remaining = GREATEST(0, new_standard - ROUND(new_standard * 0.12)),
                    updated_at = NOW()
                WHERE id = practice_area_record.id;
            END LOOP;
        END IF;
        
        -- Final check: Ensure total seats don't exceed total firms
        -- If they still do, apply more aggressive scaling
        SELECT COALESCE(SUM(cap), 0) INTO current_total_seats
        FROM web_availability_practice_area_seats
        WHERE county_availability_id = county_record.id AND is_active = true;
        
        IF current_total_seats > total_firms THEN
            -- Emergency fix: Scale down to ensure total seats <= total firms
            scale_factor := total_firms::NUMERIC / current_total_seats::NUMERIC;
            
            FOR practice_area_record IN
                SELECT id, cap
                FROM web_availability_practice_area_seats
                WHERE county_availability_id = county_record.id AND is_active = true
            LOOP
                new_cap := GREATEST(1, ROUND(practice_area_record.cap * scale_factor));
                new_premium := CASE 
                    WHEN new_cap >= 5 THEN GREATEST(1, ROUND(new_cap * 0.21))
                    ELSE 0
                END;
                new_standard := new_cap - new_premium;
                
                UPDATE web_availability_practice_area_seats
                SET 
                    cap = new_cap,
                    premium = new_premium,
                    standard = new_standard,
                    filled = GREATEST(0, ROUND(new_cap * 0.12)),
                    premium_remaining = CASE 
                        WHEN new_premium > 0 THEN GREATEST(0, new_premium - ROUND(new_premium * 0.12))
                        ELSE 0
                    END,
                    standard_remaining = GREATEST(0, new_standard - ROUND(new_standard * 0.12)),
                    updated_at = NOW()
                WHERE id = practice_area_record.id;
            END LOOP;
        END IF;
        
        -- Update county totals
        UPDATE web_availability_county
        SET 
            total_seats = (
                SELECT COALESCE(SUM(cap), 0)
                FROM web_availability_practice_area_seats
                WHERE county_availability_id = county_record.id AND is_active = true
            ),
            premium_total = (
                SELECT COALESCE(SUM(premium), 0)
                FROM web_availability_practice_area_seats
                WHERE county_availability_id = county_record.id AND is_active = true
            ),
            standard_total = (
                SELECT COALESCE(SUM(standard), 0)
                FROM web_availability_practice_area_seats
                WHERE county_availability_id = county_record.id AND is_active = true
            ),
            filled = (
                SELECT COALESCE(SUM(filled), 0)
                FROM web_availability_practice_area_seats
                WHERE county_availability_id = county_record.id AND is_active = true
            ),
            premium_remaining = (
                SELECT COALESCE(SUM(premium_remaining), 0)
                FROM web_availability_practice_area_seats
                WHERE county_availability_id = county_record.id AND is_active = true
            ),
            standard_remaining = (
                SELECT COALESCE(SUM(standard_remaining), 0)
                FROM web_availability_practice_area_seats
                WHERE county_availability_id = county_record.id AND is_active = true
            ),
            updated_at = NOW()
        WHERE id = county_record.id;
        
    END LOOP;
END $$;

-- Verify the fix
SELECT 
    c.county_name,
    c.state_code,
    c.total_firms,
    c.total_seats,
    CASE 
        WHEN c.total_seats > c.total_firms THEN '❌ EXCEEDS FIRMS'
        WHEN c.total_seats > ROUND(c.total_firms * 0.33) + 1 THEN '⚠️  EXCEEDS 33%'
        ELSE '✅ OK'
    END as status,
    ROUND((c.total_seats::NUMERIC / NULLIF(c.total_firms, 0)) * 100, 1) as seats_percent
FROM web_availability_county c
WHERE c.is_active = true
ORDER BY 
    CASE 
        WHEN c.total_seats > c.total_firms THEN 1
        WHEN c.total_seats > ROUND(c.total_firms * 0.33) + 1 THEN 2
        ELSE 3
    END,
    c.state_code,
    c.county_name
LIMIT 50;

