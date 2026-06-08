-- =====================================================
-- REMOVE COUNTIES WITH ≤ 20 SEATS (≤ 63 LAW FIRMS)
-- =====================================================
-- This script removes counties that don't meet the new
-- threshold of > 20 seats (63+ law firms minimum)
-- 
-- Threshold: > 20 seats = > 63 law firms
-- Rationale: Focus on viable, profitable markets only
-- =====================================================

BEGIN;

-- Step 1: Delete practice area data for counties with ≤ 20 seats
DELETE FROM web_availability_practice_area_seats
WHERE county_availability_id IN (
    SELECT id 
    FROM web_availability_county 
    WHERE total_seats <= 20
);

-- Step 2: Delete county data with ≤ 20 seats
DELETE FROM web_availability_county
WHERE total_seats <= 20;

-- Step 3: Show summary of what was removed
DO $$
DECLARE
    removed_count INTEGER;
BEGIN
    -- Note: This will show 0 because we just deleted them
    -- But it confirms the transaction completed
    SELECT COUNT(*) INTO removed_count
    FROM web_availability_county
    WHERE total_seats <= 20;
    
    RAISE NOTICE 'Cleanup complete. Counties with ≤ 20 seats have been removed.';
    RAISE NOTICE 'Remaining counties: All have > 20 seats (63+ law firms)';
END $$;

COMMIT;

-- =====================================================
-- VERIFICATION QUERY (Run separately to verify)
-- =====================================================
-- SELECT 
--     state_code,
--     county_name,
--     total_firms,
--     total_seats,
--     CASE 
--         WHEN total_seats <= 20 THEN '❌ REMOVE'
--         ELSE '✅ KEEP'
--     END as status
-- FROM web_availability_county
-- ORDER BY state_code, total_seats ASC;
-- =====================================================

