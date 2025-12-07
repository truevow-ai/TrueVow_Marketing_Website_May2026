-- ============================================
-- POPULATE WEB_AVAILABILITY_COUNTY AND WEB_AVAILABILITY_PRACTICE_AREA_SEATS
-- Generated from marketing/county-cap.html practiceAreaData
-- ============================================
-- This script populates the tables with all county and practice area data
-- Run this AFTER creating the tables

-- Clear existing data (optional - comment out if you want to keep existing)
-- TRUNCATE TABLE web_availability_practice_area_seats CASCADE;
-- TRUNCATE TABLE web_availability_county CASCADE;

-- ============================================
-- FLORIDA COUNTIES
-- ============================================

-- Miami-Dade County, FL
INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'miami-dade', 'Miami-Dade',
    5200, 1716, 360, 1356,
    206, 316, 1193, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

-- Miami-Dade Practice Areas
INSERT INTO web_availability_practice_area_seats (
    county_availability_id, practice_area_slug, practice_area_name,
    total_firms, cap, premium, standard,
    filled, premium_remaining, standard_remaining,
    display_order, is_active
) 
SELECT id, 'personal-injury', 'Personal Injury', 1300, 429, 90, 339, 51, 79, 298, 1, true
FROM web_availability_county WHERE state_code = 'FL' AND county_slug = 'miami-dade'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms, cap = EXCLUDED.cap,
    premium = EXCLUDED.premium, standard = EXCLUDED.standard,
    filled = EXCLUDED.filled, premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining, display_order = EXCLUDED.display_order, updated_at = now();

INSERT INTO web_availability_practice_area_seats (
    county_availability_id, practice_area_slug, practice_area_name,
    total_firms, cap, premium, standard,
    filled, premium_remaining, standard_remaining,
    display_order, is_active
) 
SELECT id, 'family-law', 'Family Law', 1040, 343, 72, 271, 41, 63, 238, 2, true
FROM web_availability_county WHERE state_code = 'FL' AND county_slug = 'miami-dade'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms, cap = EXCLUDED.cap,
    premium = EXCLUDED.premium, standard = EXCLUDED.standard,
    filled = EXCLUDED.filled, premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining, display_order = EXCLUDED.display_order, updated_at = now();

INSERT INTO web_availability_practice_area_seats (
    county_availability_id, practice_area_slug, practice_area_name,
    total_firms, cap, premium, standard,
    filled, premium_remaining, standard_remaining,
    display_order, is_active
) 
SELECT id, 'immigration', 'Immigration', 780, 257, 54, 203, 31, 47, 179, 3, true
FROM web_availability_county WHERE state_code = 'FL' AND county_slug = 'miami-dade'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms, cap = EXCLUDED.cap,
    premium = EXCLUDED.premium, standard = EXCLUDED.standard,
    filled = EXCLUDED.filled, premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining, display_order = EXCLUDED.display_order, updated_at = now();

INSERT INTO web_availability_practice_area_seats (
    county_availability_id, practice_area_slug, practice_area_name,
    total_firms, cap, premium, standard,
    filled, premium_remaining, standard_remaining,
    display_order, is_active
) 
SELECT id, 'criminal-defense', 'Criminal Defense', 624, 206, 43, 163, 25, 38, 143, 4, true
FROM web_availability_county WHERE state_code = 'FL' AND county_slug = 'miami-dade'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms, cap = EXCLUDED.cap,
    premium = EXCLUDED.premium, standard = EXCLUDED.standard,
    filled = EXCLUDED.filled, premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining, display_order = EXCLUDED.display_order, updated_at = now();

INSERT INTO web_availability_practice_area_seats (
    county_availability_id, practice_area_slug, practice_area_name,
    total_firms, cap, premium, standard,
    filled, premium_remaining, standard_remaining,
    display_order, is_active
) 
SELECT id, 'employment-law', 'Employment Law', 416, 137, 29, 108, 17, 25, 95, 5, true
FROM web_availability_county WHERE state_code = 'FL' AND county_slug = 'miami-dade'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms, cap = EXCLUDED.cap,
    premium = EXCLUDED.premium, standard = EXCLUDED.standard,
    filled = EXCLUDED.filled, premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining, display_order = EXCLUDED.display_order, updated_at = now();

INSERT INTO web_availability_practice_area_seats (
    county_availability_id, practice_area_slug, practice_area_name,
    total_firms, cap, premium, standard,
    filled, premium_remaining, standard_remaining,
    display_order, is_active
) 
SELECT id, 'real-estate', 'Real Estate', 364, 120, 25, 95, 14, 22, 83, 6, true
FROM web_availability_county WHERE state_code = 'FL' AND county_slug = 'miami-dade'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms, cap = EXCLUDED.cap,
    premium = EXCLUDED.premium, standard = EXCLUDED.standard,
    filled = EXCLUDED.filled, premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining, display_order = EXCLUDED.display_order, updated_at = now();

INSERT INTO web_availability_practice_area_seats (
    county_availability_id, practice_area_slug, practice_area_name,
    total_firms, cap, premium, standard,
    filled, premium_remaining, standard_remaining,
    display_order, is_active
) 
SELECT id, 'bankruptcy', 'Bankruptcy', 260, 86, 18, 68, 10, 16, 60, 7, true
FROM web_availability_county WHERE state_code = 'FL' AND county_slug = 'miami-dade'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms, cap = EXCLUDED.cap,
    premium = EXCLUDED.premium, standard = EXCLUDED.standard,
    filled = EXCLUDED.filled, premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining, display_order = EXCLUDED.display_order, updated_at = now();

INSERT INTO web_availability_practice_area_seats (
    county_availability_id, practice_area_slug, practice_area_name,
    total_firms, cap, premium, standard,
    filled, premium_remaining, standard_remaining,
    display_order, is_active
) 
SELECT id, 'estate-planning', 'Estate Planning', 208, 69, 14, 55, 8, 12, 48, 8, true
FROM web_availability_county WHERE state_code = 'FL' AND county_slug = 'miami-dade'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms, cap = EXCLUDED.cap,
    premium = EXCLUDED.premium, standard = EXCLUDED.standard,
    filled = EXCLUDED.filled, premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining, display_order = EXCLUDED.display_order, updated_at = now();

INSERT INTO web_availability_practice_area_seats (
    county_availability_id, practice_area_slug, practice_area_name,
    total_firms, cap, premium, standard,
    filled, premium_remaining, standard_remaining,
    display_order, is_active
) 
SELECT id, 'workers-comp', 'Workers'' Compensation', 208, 69, 14, 55, 8, 12, 48, 9, true
FROM web_availability_county WHERE state_code = 'FL' AND county_slug = 'miami-dade'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms, cap = EXCLUDED.cap,
    premium = EXCLUDED.premium, standard = EXCLUDED.standard,
    filled = EXCLUDED.filled, premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining, display_order = EXCLUDED.display_order, updated_at = now();

-- Note: This is a template. The full file will contain all 67 Florida counties and 54 California counties.
-- Due to file size, I'll create a script that generates the complete SQL file.

-- ============================================
-- VERIFICATION
-- ============================================

SELECT 'County records:' AS type, COUNT(*) AS count FROM web_availability_county;
SELECT 'Practice area records:' AS type, COUNT(*) AS count FROM web_availability_practice_area_seats;
SELECT state_code, COUNT(*) AS county_count FROM web_availability_county GROUP BY state_code;

