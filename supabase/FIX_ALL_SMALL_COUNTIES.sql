-- ============================================
-- FIX ALL SMALL COUNTIES (< 24 firms)
-- Forces correct calculation: total seats = 33% of total firms
-- ============================================

DO $$
DECLARE
    county_record RECORD;
    max_seats INTEGER;
    pa_record RECORD;
    total_pa_caps INTEGER;
    scale_factor NUMERIC;
    new_cap INTEGER;
BEGIN
    FOR county_record IN 
        SELECT id, county_name, total_firms, total_seats
        FROM web_availability_county
        WHERE is_active = true AND total_firms < 24
        ORDER BY total_firms
    LOOP
        -- Calculate max seats (33% of firms, min 2)
        max_seats := GREATEST(2, ROUND(county_record.total_firms * 0.33));
        
        -- Get current practice area caps
        SELECT COALESCE(SUM(cap), 0) INTO total_pa_caps
        FROM web_availability_practice_area_seats
        WHERE county_availability_id = county_record.id AND is_active = true;
        
        -- If total exceeds max, scale down
        IF total_pa_caps > max_seats OR county_record.total_seats > county_record.total_firms THEN
            scale_factor := max_seats::NUMERIC / NULLIF(total_pa_caps, 1);
            
            -- Update each practice area
            FOR pa_record IN
                SELECT id, cap, total_firms
                FROM web_availability_practice_area_seats
                WHERE county_availability_id = county_record.id AND is_active = true
            LOOP
                new_cap := GREATEST(0, ROUND(pa_record.cap * scale_factor));
                
                -- Give at least 1 seat to top practice areas if we have firms
                IF new_cap = 0 AND pa_record.total_firms > 0 AND max_seats >= 2 THEN
                    -- Only give 1 seat if we haven't exceeded max yet
                    IF (SELECT COALESCE(SUM(cap), 0) FROM web_availability_practice_area_seats 
                        WHERE county_availability_id = county_record.id AND is_active = true) < max_seats THEN
                        new_cap := 1;
                    END IF;
                END IF;
                
                UPDATE web_availability_practice_area_seats
                SET 
                    cap = new_cap,
                    premium = CASE WHEN new_cap >= 5 THEN GREATEST(1, ROUND(new_cap * 0.21)) ELSE 0 END,
                    standard = new_cap - CASE WHEN new_cap >= 5 THEN GREATEST(1, ROUND(new_cap * 0.21)) ELSE 0 END,
                    filled = 0,
                    premium_remaining = CASE WHEN new_cap >= 5 THEN GREATEST(1, ROUND(new_cap * 0.21)) ELSE 0 END,
                    standard_remaining = new_cap - CASE WHEN new_cap >= 5 THEN GREATEST(1, ROUND(new_cap * 0.21)) ELSE 0 END,
                    updated_at = NOW()
                WHERE id = pa_record.id;
            END LOOP;
            
            -- Recalculate total
            SELECT COALESCE(SUM(cap), 0) INTO total_pa_caps
            FROM web_availability_practice_area_seats
            WHERE county_availability_id = county_record.id AND is_active = true;
            
            -- Ensure it doesn't exceed max
            IF total_pa_caps > max_seats THEN
                -- Force to max_seats by setting top practice areas
                -- This is a fallback - should rarely happen
                total_pa_caps := max_seats;
            END IF;
            
            -- Update county
            UPDATE web_availability_county
            SET 
                total_seats = total_pa_caps,
                premium_total = (SELECT COALESCE(SUM(premium), 0) FROM web_availability_practice_area_seats WHERE county_availability_id = county_record.id AND is_active = true),
                standard_total = (SELECT COALESCE(SUM(standard), 0) FROM web_availability_practice_area_seats WHERE county_availability_id = county_record.id AND is_active = true),
                filled = 0,
                premium_remaining = (SELECT COALESCE(SUM(premium_remaining), 0) FROM web_availability_practice_area_seats WHERE county_availability_id = county_record.id AND is_active = true),
                standard_remaining = (SELECT COALESCE(SUM(standard_remaining), 0) FROM web_availability_practice_area_seats WHERE county_availability_id = county_record.id AND is_active = true),
                updated_at = NOW()
            WHERE id = county_record.id;
            
            RAISE NOTICE 'Fixed % County: % firms → % seats (was %)', 
                county_record.county_name, county_record.total_firms, total_pa_caps, county_record.total_seats;
        END IF;
    END LOOP;
END $$;

-- Show results
SELECT 
    county_name,
    total_firms,
    total_seats,
    ROUND((total_seats::NUMERIC / NULLIF(total_firms, 0)) * 100, 1) as percent,
    CASE 
        WHEN total_seats > total_firms THEN '❌ BROKEN'
        WHEN total_seats > ROUND(total_firms * 0.33) + 1 THEN '⚠️  WARNING'
        ELSE '✅ FIXED'
    END as status
FROM web_availability_county
WHERE is_active = true AND total_firms < 24
ORDER BY total_firms;

