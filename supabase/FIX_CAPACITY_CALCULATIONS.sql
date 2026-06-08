-- ============================================
-- Fix Capacity Calculations
-- Automatically corrects any capacity calculation errors
-- ============================================

-- Fix capacity calculations for all practice areas
-- This ensures cap, premium, standard, filled, and remaining values are correct

UPDATE web_availability_practice_area_seats
SET 
    cap = GREATEST(8, ROUND(total_firms * 0.33)),
    premium = GREATEST(2, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21)),
    standard = GREATEST(8, ROUND(total_firms * 0.33)) - GREATEST(2, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21)),
    filled = ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.12),
    premium_remaining = GREATEST(2, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21)) - ROUND(GREATEST(2, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21)) * 0.12),
    standard_remaining = (GREATEST(8, ROUND(total_firms * 0.33)) - GREATEST(2, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21))) - ROUND((GREATEST(8, ROUND(total_firms * 0.33)) - GREATEST(2, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21))) * 0.12),
    updated_at = NOW()
WHERE is_active = true;

-- Verify the fixes
SELECT 
    COUNT(*) as total_practice_areas,
    COUNT(CASE WHEN cap < 8 THEN 1 END) as cap_below_minimum,
    COUNT(CASE WHEN premium < 2 THEN 1 END) as premium_below_minimum,
    COUNT(CASE WHEN standard != (cap - premium) THEN 1 END) as standard_mismatch,
    COUNT(CASE WHEN ABS(filled - ROUND(cap * 0.12)) > 1 THEN 1 END) as filled_mismatch
FROM web_availability_practice_area_seats
WHERE is_active = true;

