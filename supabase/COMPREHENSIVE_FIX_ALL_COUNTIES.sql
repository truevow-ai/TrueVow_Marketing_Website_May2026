-- ============================================
-- COMPREHENSIVE FIX: ALL COUNTIES
-- Ensures total seats NEVER exceed total firms
-- Fixes the catastrophic error for ALL counties
-- ============================================

-- This script fixes the critical bug where total seats exceed total firms
-- It recalculates ALL counties to ensure mathematical correctness

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
    fixed_count INTEGER := 0;
    error_count INTEGER := 0;
BEGIN
    RAISE NOTICE 'Starting comprehensive fix for all counties...';
    
    -- Loop through each county
    FOR county_record IN 
        SELECT id, total_firms, state_code, county_name, county_slug
        FROM web_availability_county
        WHERE is_active = true
        ORDER BY total_firms
    LOOP
        total_firms := county_record.total_firms;
        
        -- Calculate maximum total seats (33% of total firms)
        -- For very small counties, be more conservative
        IF total_firms < 24 THEN
            max_total_seats := GREATEST(2, ROUND(total_firms * 0.33));
        ELSE
            max_total_seats := GREATEST(8, ROUND(total_firms * 0.33));
        END IF;
        
        -- Get current practice area caps
        SELECT 
            COUNT(*),
            COALESCE(SUM(cap), 0)
        INTO practice_area_total, total_calculated_caps
        FROM web_availability_practice_area_seats
        WHERE county_availability_id = county_record.id AND is_active = true;
        
        -- Skip if no practice areas
        IF practice_area_total = 0 THEN
            CONTINUE;
        END IF;
        
        -- Check if fix is needed
        IF total_calculated_caps > max_total_seats OR total_calculated_caps > total_firms THEN
            -- Calculate scale factor
            scale_factor := 1.0;
            IF total_calculated_caps > max_total_seats THEN
                scale_factor := max_total_seats::NUMERIC / total_calculated_caps::NUMERIC;
            END IF;
            
            -- CRITICAL: Ensure scale factor prevents exceeding total firms
            IF (total_calculated_caps * scale_factor) > total_firms THEN
                scale_factor := total_firms::NUMERIC / total_calculated_caps::NUMERIC;
            END IF;
            
            -- Update each practice area
            FOR practice_area_record IN
                SELECT 
                    id, 
                    total_firms as pa_firms,
                    practice_area_slug,
                    display_order,
                    cap as current_cap
                FROM web_availability_practice_area_seats
                WHERE county_availability_id = county_record.id AND is_active = true
                ORDER BY display_order
            LOOP
                -- Calculate what the cap SHOULD be (33% of practice area firms)
                new_cap := GREATEST(1, ROUND(practice_area_record.pa_firms * 0.33));
                
                -- Apply scale factor
                new_cap := ROUND(new_cap * scale_factor);
                
                -- Ensure minimum of 1 seat if there are firms
                IF new_cap = 0 AND practice_area_record.pa_firms > 0 THEN
                    new_cap := 1;
                END IF;
                
                -- For very small counties, distribute max_total_seats proportionally
                IF total_firms < 24 THEN
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
            
            -- Recalculate final total
            SELECT COALESCE(SUM(cap), 0) INTO final_total_cap
            FROM web_availability_practice_area_seats
            WHERE county_availability_id = county_record.id AND is_active = true;
            
            -- FINAL SAFETY CHECK: If still exceeds total firms, force correction
            IF final_total_cap > total_firms THEN
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
                
                -- Recalculate again
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
            
            -- Verify the fix
            IF final_total_cap > total_firms THEN
                error_count := error_count + 1;
                RAISE WARNING '⚠️  % County, %: Still has issue after fix - % seats for % firms', 
                    county_record.county_name, county_record.state_code, final_total_cap, total_firms;
            ELSE
                fixed_count := fixed_count + 1;
                IF final_total_cap != total_calculated_caps THEN
                    RAISE NOTICE '✅ Fixed % County, %: % → % seats', 
                        county_record.county_name, county_record.state_code, total_calculated_caps, final_total_cap;
                END IF;
            END IF;
        END IF;
    END LOOP;
    
    RAISE NOTICE 'Fix complete: % counties fixed, % still have issues', fixed_count, error_count;
END $$;

-- Final verification query
SELECT 
    COUNT(*) as total_counties,
    COUNT(CASE WHEN total_seats > total_firms THEN 1 END) as catastrophic_errors,
    COUNT(CASE WHEN total_seats > ROUND(total_firms * 0.33) + 1 THEN 1 END) as warnings,
    COUNT(CASE WHEN total_seats <= total_firms AND total_seats <= ROUND(total_firms * 0.33) + 1 THEN 1 END) as valid_counties
FROM web_availability_county
WHERE is_active = true;

-- Show any remaining issues
SELECT 
    county_name,
    state_code,
    total_firms,
    total_seats,
    CASE 
        WHEN total_seats > total_firms THEN '❌ CATASTROPHIC'
        WHEN total_seats > ROUND(total_firms * 0.33) + 1 THEN '⚠️  WARNING'
        ELSE '✅ OK'
    END as status,
    ROUND((total_seats::NUMERIC / NULLIF(total_firms, 0)) * 100, 1) as percent
FROM web_availability_county
WHERE is_active = true
    AND (total_seats > total_firms OR total_seats > ROUND(total_firms * 0.33) + 1)
ORDER BY 
    CASE 
        WHEN total_seats > total_firms THEN 1
        ELSE 2
    END,
    total_seats DESC;

