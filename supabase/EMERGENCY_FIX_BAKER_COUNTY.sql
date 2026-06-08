-- ============================================
-- EMERGENCY FIX: Baker County (and all small counties)
-- Fixes the critical issue where total seats exceed total firms
-- ============================================

-- For Baker County specifically: 8 firms should have MAX 2-3 seats, not 72!

-- Step 1: Recalculate ALL practice areas for ALL counties to ensure they're correct
DO $$
DECLARE
    county_record RECORD;
    total_firms INTEGER;
    max_total_seats INTEGER;
    practice_area_record RECORD;
    new_cap INTEGER;
    new_premium INTEGER;
    new_standard INTEGER;
    practice_area_total INTEGER;
    practice_area_percentage NUMERIC;
    total_calculated_caps INTEGER;
    scale_factor NUMERIC;
    final_total_cap INTEGER;
BEGIN
    -- Loop through each county
    FOR county_record IN 
        SELECT id, total_firms, state_code, county_name, county_slug
        FROM web_availability_county
        WHERE is_active = true
        ORDER BY total_firms
    LOOP
        total_firms := county_record.total_firms;
        
        -- Calculate maximum total seats (33% of total firms, minimum 8)
        max_total_seats := GREATEST(8, ROUND(total_firms * 0.33));
        
        -- CRITICAL: For very small counties, max_total_seats should be much smaller
        -- If total_firms < 24, we need to be more conservative
        IF total_firms < 24 THEN
            -- For very small counties, max seats should be proportional to firms
            -- But still respect the 33% rule
            max_total_seats := GREATEST(2, ROUND(total_firms * 0.33));
        END IF;
        
        -- Get all practice areas for this county
        SELECT 
            COUNT(*),
            COALESCE(SUM(cap), 0)
        INTO practice_area_total, total_calculated_caps
        FROM web_availability_practice_area_seats
        WHERE county_availability_id = county_record.id AND is_active = true;
        
        -- If we have practice areas, recalculate them
        IF practice_area_total > 0 THEN
            -- Calculate scale factor if current total exceeds max
            scale_factor := 1.0;
            IF total_calculated_caps > max_total_seats THEN
                scale_factor := max_total_seats::NUMERIC / total_calculated_caps::NUMERIC;
            END IF;
            
            -- Update each practice area
            FOR practice_area_record IN
                SELECT 
                    id, 
                    total_firms as pa_firms,
                    practice_area_slug,
                    display_order
                FROM web_availability_practice_area_seats
                WHERE county_availability_id = county_record.id AND is_active = true
                ORDER BY display_order
            LOOP
                -- Calculate what the cap SHOULD be (33% of practice area firms)
                new_cap := GREATEST(1, ROUND(practice_area_record.pa_firms * 0.33));
                
                -- Apply scale factor if needed
                new_cap := ROUND(new_cap * scale_factor);
                
                -- Ensure minimum of 1 seat if there are firms
                IF new_cap = 0 AND practice_area_record.pa_firms > 0 THEN
                    new_cap := 1;
                END IF;
                
                -- For very small counties, ensure caps are realistic
                IF total_firms < 24 THEN
                    -- Distribute max_total_seats proportionally across practice areas
                    -- Each practice area gets a share based on its percentage of total
                    practice_area_percentage := practice_area_record.pa_firms::NUMERIC / NULLIF(total_firms, 0);
                    new_cap := GREATEST(1, ROUND(max_total_seats * practice_area_percentage));
                END IF;
                
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
        
        -- Recalculate and update county totals
        SELECT COALESCE(SUM(cap), 0) INTO final_total_cap
        FROM web_availability_practice_area_seats
        WHERE county_availability_id = county_record.id AND is_active = true;
        
        -- CRITICAL FIX: Ensure final_total_cap never exceeds total_firms
        IF final_total_cap > total_firms THEN
            -- Emergency correction: scale everything down
            scale_factor := total_firms::NUMERIC / final_total_cap::NUMERIC;
            
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
            
            -- Recalculate final total
            SELECT COALESCE(SUM(cap), 0) INTO final_total_cap
            FROM web_availability_practice_area_seats
            WHERE county_availability_id = county_record.id AND is_active = true;
        END IF;
        
        -- Update county totals
        UPDATE web_availability_county
        SET 
            total_seats = final_total_cap,
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
        
        -- Log fix for small counties
        IF total_firms < 24 AND final_total_cap > total_firms THEN
            RAISE NOTICE '⚠️  % County still has issue: % seats for % firms', 
                county_record.county_name, final_total_cap, total_firms;
        END IF;
    END LOOP;
END $$;

-- Verify the fix
SELECT 
    c.county_name,
    c.state_code,
    c.total_firms,
    c.total_seats,
    CASE 
        WHEN c.total_seats > c.total_firms THEN '❌ STILL BROKEN'
        WHEN c.total_seats > ROUND(c.total_firms * 0.33) + 1 THEN '⚠️  EXCEEDS 33%'
        ELSE '✅ FIXED'
    END as status,
    ROUND((c.total_seats::NUMERIC / NULLIF(c.total_firms, 0)) * 100, 1) as seats_percent,
    ROUND(c.total_firms * 0.33) as expected_max_seats
FROM web_availability_county c
WHERE c.is_active = true
    AND (c.total_seats > c.total_firms OR c.total_seats > ROUND(c.total_firms * 0.33) + 1)
ORDER BY 
    CASE 
        WHEN c.total_seats > c.total_firms THEN 1
        ELSE 2
    END,
    c.total_seats DESC
LIMIT 20;

