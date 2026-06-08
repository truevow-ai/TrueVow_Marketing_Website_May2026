-- Missouri County Data
-- Generated: 2025-12-02T01:43:20.743Z
-- This script populates Missouri counties and independent cities with validated law firm counts

BEGIN;

-- Delete existing Missouri county data
DELETE FROM web_availability_practice_area_seats WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = 'MO');
DELETE FROM web_availability_county WHERE state_code = 'MO';

-- Insert Missouri counties and independent cities
INSERT INTO web_availability_county 
    (state_code, county_slug, county_name, total_firms, total_seats, 
     premium_total, standard_total, filled, premium_remaining, standard_remaining, is_active)
VALUES 
    ('MO', 'st-louis', 'St. Louis', 1200, 396, 
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

INSERT INTO web_availability_county 
    (state_code, county_slug, county_name, total_firms, total_seats, 
     premium_total, standard_total, filled, premium_remaining, standard_remaining, is_active)
VALUES 
    ('MO', 'st-louis-city', 'St. Louis City', 600, 198, 
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
    ('MO', 'st-charles', 'St. Charles', 310, 102, 
     21, 81, 11, 20, 71, true)
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
    ('MO', 'jackson', 'Jackson', 900, 297, 
     62, 235, 35, 55, 207, true)
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
    ('MO', 'clay', 'Clay', 260, 86, 
     18, 68, 10, 17, 59, true)
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
    ('MO', 'platte', 'Platte', 160, 53, 
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
    ('MO', 'greene', 'Greene', 400, 132, 
     28, 104, 16, 26, 90, true)
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
    ('MO', 'boone', 'Boone', 350, 116, 
     24, 92, 15, 22, 79, true)
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