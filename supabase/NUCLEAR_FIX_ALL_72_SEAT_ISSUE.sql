-- ============================================
-- NUCLEAR FIX: All Counties Showing 72 Seats
-- This is a comprehensive fix that recalculates EVERYTHING from scratch
-- ============================================

-- The issue: Many counties show exactly 72 seats regardless of firm count
-- This happens because each practice area got minimum 8 seats (9 areas × 8 = 72)
-- We need to recalculate ALL counties properly

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
    fixed_count INTEGER := 0;
BEGIN
    RAISE NOTICE 'Starting nuclear fix for all counties...';
    
    -- Loop through EVERY county
    FOR county_record IN 
        SELECT id, total_firms, state_code, county_name, county_slug
        FROM web_availability_county
        WHERE is_active = true
        ORDER BY total_firms
    LOOP
        total_firms := county_record.total_firms;
        
        -- Calculate MAXIMUM total seats (33% of total firms)
        -- This is the REAL cap - not the sum of practice area minimums
        max_total_seats := ROUND(total_firms * 0.33);
        
        -- For very small counties, ensure minimum of 2 seats total
        IF max_total_seats < 2 THEN
            max_total_seats := 2;
        END IF;
        
        -- Get all practice areas for this county
        SELECT 
            COUNT(*),
            COALESCE(SUM(total_firms), 0)
        INTO practice_area_record, total_practice_area_firms
        FROM web_availability_practice_area_seats
        WHERE county_availability_id = county_record.id AND is_active = true;
        
        -- Skip if no practice areas
        IF practice_area_record = 0 THEN
            CONTINUE;
        END IF;
        
        -- Recalculate each practice area from scratch
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
            -- Calculate what percentage this practice area represents
            practice_area_percentage := practice_area_record.pa_firms::NUMERIC / NULLIF(total_firms, 0);
            
            -- Calculate cap as proportional share of max_total_seats
            new_cap := ROUND(max_total_seats * practice_area_percentage);
            
            -- Ensure minimum of 1 seat if there are firms in this practice area
            IF new_cap = 0 AND practice_area_record.pa_firms > 0 THEN
                new_cap := 1;
            END IF;
            
            -- However, if this would cause total to exceed max, scale down
            -- We'll do a final pass after this to ensure total is correct
            
            -- Calculate premium and standard
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
        
        -- Calculate actual total after updates
        SELECT COALESCE(SUM(cap), 0) INTO new_cap
        FROM web_availability_practice_area_seats
        WHERE county_availability_id = county_record.id AND is_active = true;
        
        -- FINAL CORRECTION: If total still exceeds max_total_seats or total_firms, scale down
        IF new_cap > max_total_seats OR new_cap > total_firms THEN
            -- Use the stricter limit
            DECLARE
                final_limit INTEGER := LEAST(max_total_seats, total_firms);
                scale_factor NUMERIC := final_limit::NUMERIC / new_cap::NUMERIC;
            BEGIN
                -- Scale all practice areas down
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
                SELECT COALESCE(SUM(cap), 0) INTO new_cap
                FROM web_availability_practice_area_seats
                WHERE county_availability_id = county_record.id AND is_active = true;
            END;
        END IF;
        
        -- Update county totals
        UPDATE web_availability_county
        SET 
            total_seats = new_cap,
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
        
        fixed_count := fixed_count + 1;
        
        IF fixed_count % 10 = 0 THEN
            RAISE NOTICE 'Fixed % counties...', fixed_count;
        END IF;
    END LOOP;
    
    RAISE NOTICE 'Nuclear fix complete: % counties recalculated', fixed_count;
END $$;

-- Verify the fix
SELECT 
    COUNT(*) as total_counties,
    COUNT(CASE WHEN total_seats = 72 THEN 1 END) as still_72_seats,
    COUNT(CASE WHEN total_seats > total_firms THEN 1 END) as still_exceed_firms,
    COUNT(CASE WHEN total_seats <= total_firms AND total_seats <= ROUND(total_firms * 0.33) + 1 THEN 1 END) as valid_counties
FROM web_availability_county
WHERE is_active = true;

-- Show counties that still have 72 seats (should be 0)
SELECT 
    county_name,
    state_code,
    total_firms,
    total_seats,
    ROUND((total_seats::NUMERIC / NULLIF(total_firms, 0)) * 100, 1) as percent
FROM web_availability_county
WHERE is_active = true AND total_seats = 72
ORDER BY total_firms;

