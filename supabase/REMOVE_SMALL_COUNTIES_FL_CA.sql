-- ============================================
-- REMOVE COUNTIES WITH < 4 SEATS
-- Removes counties from Florida and California that have less than 4 seats
-- These are not viable markets and not worth operational overhead
-- ============================================

-- Step 1: Delete practice area seats for counties with < 4 seats
DELETE FROM web_availability_practice_area_seats
WHERE county_availability_id IN (
    SELECT id FROM web_availability_county
    WHERE state_code IN ('FL', 'CA') 
      AND total_seats < 4
);

-- Step 2: Delete counties with < 4 seats
DELETE FROM web_availability_county
WHERE state_code IN ('FL', 'CA') 
  AND total_seats < 4;
