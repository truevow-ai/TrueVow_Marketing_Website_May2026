-- ============================================
-- DELETE ALL COUNTY DATA
-- Starting fresh with corrected calculation logic
-- ============================================

-- Delete all practice area seats first (foreign key constraint)
DELETE FROM web_availability_practice_area_seats;

-- Delete all county data
DELETE FROM web_availability_county;

-- Verify deletion
SELECT 
    (SELECT COUNT(*) FROM web_availability_county) as counties_remaining,
    (SELECT COUNT(*) FROM web_availability_practice_area_seats) as practice_areas_remaining;

-- Should show 0 for both

