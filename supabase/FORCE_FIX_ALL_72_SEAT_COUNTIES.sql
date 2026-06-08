-- ============================================
-- FORCE FIX: All Counties with 72 Seats
-- Directly fixes the calculation for all affected counties
-- ============================================

-- This script forces the correct calculation for ALL counties
-- It recalculates total_seats as 33% of total_firms (capped appropriately)

DO $$
DECLARE
    county_record RECORD;
    total_firms INTEGER;
    max_total_seats INTEGER;
    practice_area_record RECORD;
    new_cap INTEGER;
    new_premium INTEGER;
    new_standard INTEGER;
    practice_area_percentage NUMERIC;
    total_practice_area_firms INTEGER;
    final_total_cap INTEGER;
    scale_factor NUMERIC;
BEGIN
    RAISE NOTICE 'Starting force fix for all counties...';
    
    -- Loop through EVERY county
    FOR county_record IN 
        SELECT id, total_firms, state_code, county_name, county_slug, total_seats
        FROM web_availability_county
        WHERE is_active = true
        ORDER BY total_firms
    LOOP
        total_firms := county_record.total_firms;
        
        -- Calculate MAXIMUM total seats (33% of total firms)
        -- For small counties, minimum 2 seats
        IF total_firms < 24 THEN
            max_total_seats := GREATEST(2, ROUND(total_firms * 0.33));
        ELSE
            max_total_seats := GREATEST(8, ROUND(total_firms * 0.33));
        END IF;
        
        -- Get total practice area firms
        SELECT COALESCE(SUM(total_firms), 0)
        INTO total_practice_area_firms
        FROM web_availability_practice_area_seats
        WHERE county_availability_id = county_record.id AND is_active = true;
        
        -- If no practice areas, skip
        IF total_practice_area_firms = 0 THEN
            CONTINUE;
        END IF;
        
        -- Recalculate each practice area proportionally
        FOR practice_area_record IN
            SELECT 
                id, 
                total_firms as pa_firms,
                practice_area_slug
            FROM web_availability_practice_area_seats
            WHERE county_availability_id = county_record.id AND is_active = true
            ORDER BY display_order
        LOOP
            -- Calculate percentage of total firms
            practice_area_percentage := practice_area_record.pa_firms::NUMERIC / NULLIF(total_firms, 0);
            
            -- Calculate cap as proportional share
            new_cap := ROUND(max_total_seats * practice_area_percentage);
            
            -- Minimum 1 seat if there are firms
            IF new_cap = 0 AND practice_area_record.pa_firms > 0 THEN
                new_cap := 1;
            END IF;
            
            -- Calculate premium and standard
            new_premium := CASE 
                WHEN new_cap >= 5 THEN GREATEST(1, ROUND(new_cap * 0.21))
                ELSE 0
            END;
            new_standard := new_cap - new_premium;
            
            -- Update practice area
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
        
        -- Calculate actual total
        SELECT COALESCE(SUM(cap), 0) INTO final_total_cap
        FROM web_availability_practice_area_seats
        WHERE county_availability_id = county_record.id AND is_active = true;
        
        -- Final correction: ensure total doesn't exceed max_total_seats or total_firms
        IF final_total_cap > max_total_seats OR final_total_cap > total_firms THEN
            scale_factor := LEAST(max_total_seats, total_firms)::NUMERIC / final_total_cap::NUMERIC;
            
            -- Scale all practice areas
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
            
            -- Recalculate total
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
        
        -- Log if it was fixed
        IF county_record.total_seats != final_total_cap THEN
            RAISE NOTICE 'Fixed % County, %: % → % seats', 
                county_record.county_name, county_record.state_code, county_record.total_seats, final_total_cap;
        END IF;
    END LOOP;
    
    RAISE NOTICE 'Force fix complete!';
END $$;

-- Verify the fix
SELECT 
    county_name,
    state_code,
    total_firms,
    total_seats,
    ROUND((total_seats::NUMERIC / NULLIF(total_firms, 0)) * 100, 1) as percent,
    CASE 
        WHEN total_seats > total_firms THEN '❌ BROKEN'
        WHEN total_seats = 72 THEN '⚠️  STILL 72'
        WHEN total_seats > ROUND(total_firms * 0.33) + 1 THEN '⚠️  WARNING'
        ELSE '✅ FIXED'
    END as status
FROM web_availability_county
WHERE is_active = true
    AND (total_seats = 72 OR total_seats > total_firms OR total_seats > ROUND(total_firms * 0.33) + 1)
ORDER BY 
    CASE 
        WHEN total_seats > total_firms THEN 1
        WHEN total_seats = 72 THEN 2
        ELSE 3
    END,
    total_seats DESC;

