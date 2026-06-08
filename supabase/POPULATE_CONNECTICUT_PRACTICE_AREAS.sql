-- Connecticut Practice Area Data
-- Generated: 2025-12-02T01:51:47.559Z
-- This script populates practice area seats for Connecticut counties

BEGIN;

-- Delete existing practice area data
DELETE FROM web_availability_practice_area_seats WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = 'CT');

-- Insert practice area seats
INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'personal-injury', 'Personal Injury', 
    134, 65, 14, 51,
    8, 12, 45, 
    1, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'hartford'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'family-law', 'Family Law', 
    107, 53, 11, 42,
    6, 10, 37, 
    2, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'hartford'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'immigration', 'Immigration', 
    80, 40, 8, 32,
    5, 7, 28, 
    3, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'hartford'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'criminal-defense', 'Criminal Defense', 
    64, 32, 7, 25,
    4, 6, 22, 
    4, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'hartford'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'employment-law', 'Employment Law', 
    43, 21, 4, 17,
    3, 3, 15, 
    5, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'hartford'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'real-estate', 'Real Estate', 
    38, 18, 4, 14,
    2, 4, 12, 
    7, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'hartford'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'bankruptcy', 'Bankruptcy', 
    27, 13, 3, 10,
    2, 3, 8, 
    6, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'hartford'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'estate-planning', 'Estate Planning', 
    21, 11, 2, 9,
    1, 2, 8, 
    8, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'hartford'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'workers-comp', 'Workers Compensation', 
    21, 11, 2, 9,
    1, 2, 8, 
    9, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'hartford'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'personal-injury', 'Personal Injury', 
    117, 58, 12, 46,
    7, 11, 40, 
    1, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'new-haven'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'family-law', 'Family Law', 
    94, 46, 10, 36,
    6, 9, 31, 
    2, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'new-haven'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'immigration', 'Immigration', 
    70, 35, 7, 28,
    4, 6, 25, 
    3, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'new-haven'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'criminal-defense', 'Criminal Defense', 
    56, 28, 6, 22,
    3, 5, 20, 
    4, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'new-haven'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'employment-law', 'Employment Law', 
    38, 18, 4, 14,
    2, 4, 12, 
    5, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'new-haven'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'real-estate', 'Real Estate', 
    33, 16, 3, 13,
    2, 3, 11, 
    7, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'new-haven'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'bankruptcy', 'Bankruptcy', 
    23, 12, 3, 9,
    1, 3, 8, 
    6, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'new-haven'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'estate-planning', 'Estate Planning', 
    19, 9, 2, 7,
    1, 2, 6, 
    8, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'new-haven'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'workers-comp', 'Workers Compensation', 
    19, 9, 2, 7,
    1, 2, 6, 
    9, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'new-haven'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'personal-injury', 'Personal Injury', 
    168, 82, 17, 65,
    10, 15, 57, 
    1, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'fairfield'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'family-law', 'Family Law', 
    134, 66, 14, 52,
    8, 12, 46, 
    2, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'fairfield'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'immigration', 'Immigration', 
    101, 50, 10, 40,
    6, 9, 35, 
    3, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'fairfield'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'criminal-defense', 'Criminal Defense', 
    80, 40, 8, 32,
    5, 7, 28, 
    4, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'fairfield'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'employment-law', 'Employment Law', 
    54, 26, 5, 21,
    3, 4, 19, 
    5, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'fairfield'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'real-estate', 'Real Estate', 
    47, 23, 5, 18,
    3, 4, 16, 
    7, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'fairfield'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'bankruptcy', 'Bankruptcy', 
    34, 17, 4, 13,
    2, 4, 11, 
    6, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'fairfield'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'estate-planning', 'Estate Planning', 
    27, 13, 3, 10,
    2, 3, 8, 
    8, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'fairfield'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'workers-comp', 'Workers Compensation', 
    27, 13, 3, 10,
    2, 3, 8, 
    9, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'fairfield'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'personal-injury', 'Personal Injury', 
    35, 17, 3, 14,
    2, 3, 12, 
    1, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'middlesex'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'family-law', 'Family Law', 
    28, 14, 3, 11,
    2, 3, 9, 
    2, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'middlesex'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'immigration', 'Immigration', 
    21, 10, 2, 8,
    1, 2, 7, 
    3, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'middlesex'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'criminal-defense', 'Criminal Defense', 
    17, 8, 2, 6,
    1, 2, 5, 
    4, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'middlesex'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'employment-law', 'Employment Law', 
    11, 6, 1, 5,
    1, 1, 4, 
    5, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'middlesex'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'real-estate', 'Real Estate', 
    10, 5, 1, 4,
    1, 1, 3, 
    7, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'middlesex'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'bankruptcy', 'Bankruptcy', 
    7, 3, 1, 2,
    0, 1, 2, 
    6, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'middlesex'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'estate-planning', 'Estate Planning', 
    6, 3, 1, 2,
    0, 1, 2, 
    8, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'middlesex'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'workers-comp', 'Workers Compensation', 
    6, 3, 0, 3,
    0, 0, 3, 
    9, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'middlesex'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'personal-injury', 'Personal Injury', 
    32, 15, 3, 12,
    2, 3, 10, 
    1, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'new-london'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'family-law', 'Family Law', 
    25, 13, 3, 10,
    2, 3, 8, 
    2, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'new-london'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'immigration', 'Immigration', 
    19, 9, 2, 7,
    1, 2, 6, 
    3, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'new-london'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'criminal-defense', 'Criminal Defense', 
    15, 8, 2, 6,
    1, 2, 5, 
    4, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'new-london'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'employment-law', 'Employment Law', 
    10, 5, 1, 4,
    1, 1, 3, 
    5, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'new-london'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'real-estate', 'Real Estate', 
    9, 4, 1, 3,
    0, 1, 3, 
    7, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'new-london'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'bankruptcy', 'Bankruptcy', 
    6, 3, 1, 2,
    0, 1, 2, 
    6, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'new-london'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'estate-planning', 'Estate Planning', 
    5, 3, 0, 3,
    0, 0, 3, 
    8, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'new-london'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'workers-comp', 'Workers Compensation', 
    5, 3, 0, 3,
    0, 0, 3, 
    9, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'new-london'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'personal-injury', 'Personal Injury', 
    19, 10, 2, 8,
    1, 2, 7, 
    1, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'windham'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'family-law', 'Family Law', 
    15, 7, 2, 5,
    1, 2, 4, 
    2, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'windham'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'immigration', 'Immigration', 
    11, 5, 1, 4,
    1, 1, 3, 
    3, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'windham'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'criminal-defense', 'Criminal Defense', 
    9, 4, 1, 3,
    0, 1, 3, 
    4, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'windham'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'employment-law', 'Employment Law', 
    6, 3, 1, 2,
    0, 1, 2, 
    5, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'windham'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'real-estate', 'Real Estate', 
    5, 3, 1, 2,
    0, 1, 2, 
    7, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'windham'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'bankruptcy', 'Bankruptcy', 
    4, 2, 0, 2,
    0, 0, 2, 
    6, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'windham'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'estate-planning', 'Estate Planning', 
    3, 1, 0, 1,
    0, 0, 1, 
    8, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'windham'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'workers-comp', 'Workers Compensation', 
    3, 1, 0, 1,
    0, 0, 1, 
    9, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'windham'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'personal-injury', 'Personal Injury', 
    17, 8, 3, 5,
    1, 3, 4, 
    1, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'tolland'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'family-law', 'Family Law', 
    13, 7, 1, 6,
    1, 1, 5, 
    2, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'tolland'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'immigration', 'Immigration', 
    10, 5, 1, 4,
    1, 1, 3, 
    3, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'tolland'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'criminal-defense', 'Criminal Defense', 
    8, 4, 1, 3,
    0, 1, 3, 
    4, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'tolland'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'employment-law', 'Employment Law', 
    5, 3, 1, 2,
    0, 1, 2, 
    5, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'tolland'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'real-estate', 'Real Estate', 
    5, 2, 0, 2,
    0, 0, 2, 
    7, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'tolland'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'bankruptcy', 'Bankruptcy', 
    3, 2, 0, 2,
    0, 0, 2, 
    6, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'tolland'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'estate-planning', 'Estate Planning', 
    3, 1, 0, 1,
    0, 0, 1, 
    8, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'tolland'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'workers-comp', 'Workers Compensation', 
    3, 1, 0, 1,
    0, 0, 1, 
    9, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'tolland'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'personal-injury', 'Personal Injury', 
    22, 11, 3, 8,
    1, 3, 7, 
    1, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'litchfield'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'family-law', 'Family Law', 
    17, 9, 2, 7,
    1, 2, 6, 
    2, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'litchfield'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'immigration', 'Immigration', 
    13, 6, 1, 5,
    1, 1, 4, 
    3, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'litchfield'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'criminal-defense', 'Criminal Defense', 
    10, 5, 1, 4,
    1, 1, 3, 
    4, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'litchfield'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'employment-law', 'Employment Law', 
    7, 3, 1, 2,
    0, 1, 2, 
    5, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'litchfield'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'real-estate', 'Real Estate', 
    6, 3, 1, 2,
    0, 1, 2, 
    7, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'litchfield'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'bankruptcy', 'Bankruptcy', 
    4, 2, 0, 2,
    0, 0, 2, 
    6, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'litchfield'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'estate-planning', 'Estate Planning', 
    3, 2, 0, 2,
    0, 0, 2, 
    8, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'litchfield'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, 'workers-comp', 'Workers Compensation', 
    3, 2, 0, 2,
    0, 0, 2, 
    9, true
FROM web_availability_county 
WHERE state_code = 'CT' AND county_slug = 'litchfield'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

COMMIT;