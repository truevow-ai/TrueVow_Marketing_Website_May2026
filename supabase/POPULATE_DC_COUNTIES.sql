-- District of Columbia Parish Data
-- Generated: 2025-12-02T10:00:15.439Z
-- This script populates District of Columbia countyes with validated law firm counts
-- Note: District of Columbia uses "countyes" instead of counties

BEGIN;

-- Delete existing District of Columbia county data
DELETE FROM web_availability_practice_area_seats WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = 'DC');
DELETE FROM web_availability_county WHERE state_code = 'DC';

-- Insert District of Columbia countyes
INSERT INTO web_availability_county 
    (state_code, county_slug, county_name, total_firms, total_seats, 
     premium_total, standard_total, filled, premium_remaining, standard_remaining, is_active)
VALUES 
    ('DC', 'district-of-columbia', 'District of Columbia', 1200, 396, 
     83, 313, 47, 74, 275, true)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    county_name = EXCLUDED.county_name,
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    is_active = EXCLUDED.is_active;

COMMIT;