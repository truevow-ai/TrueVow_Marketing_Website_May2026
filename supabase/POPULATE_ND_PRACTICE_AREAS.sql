-- North Dakota Practice Area Data
-- Generated: 2025-12-02T02:35:31.690Z
-- This script populates practice area seats for North Dakota countyes

BEGIN;

-- Delete existing practice area data
DELETE FROM web_availability_practice_area_seats WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = 'ND');

-- Insert practice area seats
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
WHERE state_code = 'ND' AND county_slug = 'cass'
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
WHERE state_code = 'ND' AND county_slug = 'cass'
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
WHERE state_code = 'ND' AND county_slug = 'cass'
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
WHERE state_code = 'ND' AND county_slug = 'cass'
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
WHERE state_code = 'ND' AND county_slug = 'cass'
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
WHERE state_code = 'ND' AND county_slug = 'cass'
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
WHERE state_code = 'ND' AND county_slug = 'cass'
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
WHERE state_code = 'ND' AND county_slug = 'cass'
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
WHERE state_code = 'ND' AND county_slug = 'cass'
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
WHERE state_code = 'ND' AND county_slug = 'grand-forks'
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
WHERE state_code = 'ND' AND county_slug = 'grand-forks'
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
WHERE state_code = 'ND' AND county_slug = 'grand-forks'
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
WHERE state_code = 'ND' AND county_slug = 'grand-forks'
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
WHERE state_code = 'ND' AND county_slug = 'grand-forks'
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
WHERE state_code = 'ND' AND county_slug = 'grand-forks'
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
WHERE state_code = 'ND' AND county_slug = 'grand-forks'
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
WHERE state_code = 'ND' AND county_slug = 'grand-forks'
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
WHERE state_code = 'ND' AND county_slug = 'grand-forks'
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
WHERE state_code = 'ND' AND county_slug = 'ward'
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
WHERE state_code = 'ND' AND county_slug = 'ward'
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
WHERE state_code = 'ND' AND county_slug = 'ward'
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
WHERE state_code = 'ND' AND county_slug = 'ward'
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
WHERE state_code = 'ND' AND county_slug = 'ward'
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
WHERE state_code = 'ND' AND county_slug = 'ward'
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
WHERE state_code = 'ND' AND county_slug = 'ward'
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
WHERE state_code = 'ND' AND county_slug = 'ward'
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
WHERE state_code = 'ND' AND county_slug = 'ward'
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