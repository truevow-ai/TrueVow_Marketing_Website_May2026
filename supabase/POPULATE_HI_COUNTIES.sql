-- Hawaii Parish Data
-- Generated: 2025-12-02T02:25:02.326Z
-- This script populates Hawaii countyes with validated law firm counts
-- Note: Hawaii uses "countyes" instead of counties

BEGIN;

-- Delete existing Hawaii county data
DELETE FROM web_availability_practice_area_seats WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = 'HI');
DELETE FROM web_availability_county WHERE state_code = 'HI';

-- Insert Hawaii countyes
INSERT INTO web_availability_county 
    (state_code, county_slug, county_name, total_firms, total_seats, 
     premium_total, standard_total, filled, premium_remaining, standard_remaining, is_active)
VALUES 
    ('HI', 'honolulu', 'Honolulu', 600, 198, 
     42, 156, 25, 38, 135, true)
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

INSERT INTO web_availability_county 
    (state_code, county_slug, county_name, total_firms, total_seats, 
     premium_total, standard_total, filled, premium_remaining, standard_remaining, is_active)
VALUES 
    ('HI', 'maui', 'Maui', 160, 53, 
     11, 42, 5, 11, 37, true)
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

INSERT INTO web_availability_county 
    (state_code, county_slug, county_name, total_firms, total_seats, 
     premium_total, standard_total, filled, premium_remaining, standard_remaining, is_active)
VALUES 
    ('HI', 'hawaii', 'Hawaii', 110, 36, 
     8, 28, 3, 8, 25, true)
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