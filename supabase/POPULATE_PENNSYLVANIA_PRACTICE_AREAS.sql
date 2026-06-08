-- Pennsylvania Practice Area Data
-- Generated: 2025-12-02T12:13:24.409Z
-- This script populates practice area seats for Pennsylvania counties

BEGIN;

-- Delete existing practice area data
DELETE FROM web_availability_practice_area_seats WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = 'PA');

-- Insert practice area seats
INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 704, 348, 73, 275, 42, 64, 242, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'philadelphia';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 563, 277, 58, 219, 33, 51, 193, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'philadelphia';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 422, 208, 44, 164, 25, 39, 144, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'philadelphia';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 338, 166, 35, 131, 20, 31, 115, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'philadelphia';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 225, 111, 23, 88, 13, 20, 78, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'philadelphia';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 197, 97, 20, 77, 12, 18, 67, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'philadelphia';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 141, 69, 14, 55, 8, 12, 49, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'philadelphia';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 113, 55, 12, 43, 7, 10, 38, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'philadelphia';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 113, 55, 12, 43, 7, 10, 38, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'philadelphia';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 469, 231, 49, 182, 28, 43, 160, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'allegheny';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 375, 185, 39, 146, 22, 34, 129, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'allegheny';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 281, 139, 29, 110, 17, 25, 97, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'allegheny';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 225, 111, 23, 88, 13, 20, 78, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'allegheny';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 150, 74, 16, 58, 9, 14, 51, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'allegheny';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 131, 65, 14, 51, 8, 12, 45, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'allegheny';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 94, 46, 10, 36, 6, 9, 31, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'allegheny';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 75, 37, 8, 29, 4, 7, 26, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'allegheny';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 75, 36, 8, 28, 4, 7, 25, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'allegheny';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 302, 149, 31, 118, 18, 27, 104, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'montgomery';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 241, 119, 25, 94, 14, 22, 83, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'montgomery';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 181, 89, 19, 70, 11, 17, 61, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'montgomery';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 145, 71, 15, 56, 9, 13, 49, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'montgomery';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 96, 48, 10, 38, 6, 9, 33, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'montgomery';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 84, 42, 9, 33, 5, 8, 29, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'montgomery';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 60, 30, 6, 24, 4, 5, 21, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'montgomery';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 48, 23, 5, 18, 3, 4, 16, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'montgomery';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 48, 23, 5, 18, 3, 4, 16, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'montgomery';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 201, 99, 21, 78, 12, 18, 69, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'bucks';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 161, 79, 17, 62, 9, 15, 55, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'bucks';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 121, 59, 12, 47, 7, 11, 41, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'bucks';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 96, 48, 10, 38, 6, 9, 33, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'bucks';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 64, 32, 7, 25, 4, 6, 22, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'bucks';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 56, 28, 6, 22, 3, 5, 20, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'bucks';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 40, 20, 4, 16, 2, 4, 14, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'bucks';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 32, 16, 3, 13, 2, 3, 11, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'bucks';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 32, 15, 3, 12, 2, 3, 10, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'bucks';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 184, 91, 19, 72, 11, 17, 63, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'delaware';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 147, 73, 15, 58, 9, 13, 51, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'delaware';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 111, 54, 11, 43, 6, 10, 38, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'delaware';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 88, 44, 9, 35, 5, 8, 31, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'delaware';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 59, 29, 6, 23, 3, 5, 21, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'delaware';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 52, 25, 5, 20, 3, 4, 18, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'delaware';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 37, 18, 4, 14, 2, 4, 12, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'delaware';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 29, 15, 3, 12, 2, 3, 10, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'delaware';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 29, 14, 3, 11, 2, 3, 9, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'delaware';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 159, 79, 17, 62, 9, 15, 55, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'chester';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 127, 63, 13, 50, 8, 11, 44, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'chester';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 96, 47, 10, 37, 6, 9, 32, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'chester';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 76, 38, 8, 30, 5, 7, 26, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'chester';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 51, 25, 5, 20, 3, 4, 18, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'chester';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 45, 22, 5, 17, 3, 4, 15, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'chester';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 32, 16, 3, 13, 2, 3, 11, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'chester';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 25, 12, 3, 9, 1, 3, 8, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'chester';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 25, 12, 3, 9, 1, 3, 8, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'chester';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 109, 54, 11, 43, 6, 10, 38, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lancaster';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 87, 43, 9, 34, 5, 8, 30, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lancaster';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 65, 32, 7, 25, 4, 6, 22, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lancaster';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 52, 26, 5, 21, 3, 4, 19, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lancaster';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 35, 17, 4, 13, 2, 4, 11, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lancaster';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 31, 15, 3, 12, 2, 3, 10, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lancaster';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 22, 11, 2, 9, 1, 2, 8, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lancaster';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 17, 9, 2, 7, 1, 2, 6, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lancaster';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 17, 8, 2, 6, 1, 2, 5, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lancaster';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 92, 46, 10, 36, 6, 9, 31, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'york';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 74, 36, 8, 28, 4, 7, 25, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'york';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 55, 27, 6, 21, 3, 5, 19, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'york';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 44, 22, 5, 17, 3, 4, 15, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'york';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 30, 15, 3, 12, 2, 3, 10, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'york';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 26, 13, 3, 10, 2, 3, 8, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'york';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 18, 9, 2, 7, 1, 2, 6, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'york';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 15, 7, 1, 6, 1, 1, 5, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'york';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 15, 7, 1, 6, 1, 1, 5, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'york';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 81, 40, 8, 32, 5, 7, 28, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lehigh';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 64, 32, 7, 25, 4, 6, 22, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lehigh';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 48, 24, 5, 19, 3, 4, 17, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lehigh';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 39, 19, 4, 15, 2, 4, 13, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lehigh';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 26, 13, 3, 10, 2, 3, 8, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lehigh';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 23, 11, 2, 9, 1, 2, 8, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lehigh';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 16, 8, 2, 6, 1, 2, 5, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lehigh';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 13, 6, 1, 5, 1, 1, 4, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lehigh';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 13, 5, 1, 4, 1, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lehigh';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 76, 38, 8, 30, 5, 7, 26, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'dauphin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 60, 30, 6, 24, 4, 5, 21, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'dauphin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 45, 22, 5, 17, 3, 4, 15, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'dauphin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 36, 18, 4, 14, 2, 4, 12, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'dauphin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 24, 12, 3, 9, 1, 3, 8, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'dauphin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 21, 10, 2, 8, 1, 2, 7, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'dauphin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 15, 7, 1, 6, 1, 1, 5, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'dauphin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 12, 6, 1, 5, 1, 1, 4, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'dauphin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 12, 6, 1, 5, 1, 1, 4, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'dauphin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 70, 35, 7, 28, 4, 6, 25, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'berks';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 56, 28, 6, 22, 3, 5, 20, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'berks';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 42, 21, 4, 17, 3, 3, 15, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'berks';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 34, 17, 4, 13, 2, 4, 11, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'berks';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 22, 11, 2, 9, 1, 2, 8, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'berks';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 20, 10, 2, 8, 1, 2, 7, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'berks';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 14, 7, 1, 6, 1, 1, 5, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'berks';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 11, 5, 1, 4, 1, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'berks';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 11, 5, 1, 4, 1, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'berks';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 64, 31, 7, 24, 4, 6, 21, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'northampton';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 51, 25, 5, 20, 3, 4, 18, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'northampton';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 38, 19, 4, 15, 2, 4, 13, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'northampton';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 31, 15, 3, 12, 2, 3, 10, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'northampton';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 20, 10, 2, 8, 1, 2, 7, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'northampton';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 18, 9, 2, 7, 1, 2, 6, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'northampton';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 13, 6, 1, 5, 1, 1, 4, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'northampton';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 10, 5, 1, 4, 1, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'northampton';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 10, 5, 1, 4, 1, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'northampton';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 59, 29, 6, 23, 3, 5, 21, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'westmoreland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 47, 23, 5, 18, 3, 4, 16, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'westmoreland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 35, 17, 4, 13, 2, 4, 11, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'westmoreland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 28, 14, 3, 11, 2, 3, 9, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'westmoreland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 19, 9, 2, 7, 1, 2, 6, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'westmoreland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 16, 8, 2, 6, 1, 2, 5, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'westmoreland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 12, 6, 1, 5, 1, 1, 4, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'westmoreland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 9, 5, 1, 4, 1, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'westmoreland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 9, 5, 1, 4, 1, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'westmoreland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 54, 28, 6, 22, 3, 5, 20, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'erie';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 43, 21, 4, 17, 3, 3, 15, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'erie';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 32, 16, 3, 13, 2, 3, 11, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'erie';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 26, 13, 3, 10, 2, 3, 8, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'erie';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 17, 8, 2, 6, 1, 2, 5, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'erie';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 15, 7, 1, 6, 1, 1, 5, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'erie';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 11, 5, 1, 4, 1, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'erie';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 9, 4, 1, 3, 0, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'erie';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 9, 4, 1, 3, 0, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'erie';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 47, 23, 5, 18, 3, 4, 16, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'cumberland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 38, 18, 4, 14, 2, 4, 12, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'cumberland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 28, 14, 3, 11, 2, 3, 9, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'cumberland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 23, 11, 2, 9, 1, 2, 8, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'cumberland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 15, 7, 1, 6, 1, 1, 5, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'cumberland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 13, 6, 1, 5, 1, 1, 4, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'cumberland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 9, 5, 1, 4, 1, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'cumberland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 8, 4, 1, 3, 0, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'cumberland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 8, 4, 1, 3, 0, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'cumberland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 44, 23, 5, 18, 3, 4, 16, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'luzerne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 35, 17, 4, 13, 2, 4, 11, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'luzerne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 26, 13, 3, 10, 2, 3, 8, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'luzerne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 21, 10, 2, 8, 1, 2, 7, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'luzerne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 14, 7, 1, 6, 1, 1, 5, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'luzerne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 12, 6, 1, 5, 1, 1, 4, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'luzerne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 9, 4, 1, 3, 0, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'luzerne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 7, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'luzerne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 7, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'luzerne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 42, 21, 4, 17, 3, 3, 15, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lackawanna';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 34, 17, 4, 13, 2, 4, 11, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lackawanna';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 25, 12, 3, 9, 1, 3, 8, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lackawanna';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 20, 10, 2, 8, 1, 2, 7, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lackawanna';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 13, 7, 1, 6, 1, 1, 5, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lackawanna';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 12, 6, 1, 5, 1, 1, 4, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lackawanna';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 8, 4, 1, 3, 0, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lackawanna';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 7, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lackawanna';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 7, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'lackawanna';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 40, 20, 4, 16, 2, 4, 14, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'washington';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 32, 16, 3, 13, 2, 3, 11, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'washington';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 24, 12, 3, 9, 1, 3, 8, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'washington';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 19, 9, 2, 7, 1, 2, 6, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'washington';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 13, 6, 1, 5, 1, 1, 4, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'washington';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 11, 6, 1, 5, 1, 1, 4, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'washington';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 8, 4, 1, 3, 0, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'washington';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 6, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'washington';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 6, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'washington';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 39, 20, 4, 16, 2, 4, 14, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'butler';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 31, 15, 3, 12, 2, 3, 10, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'butler';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 23, 11, 2, 9, 1, 2, 8, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'butler';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 18, 9, 2, 7, 1, 2, 6, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'butler';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 12, 6, 1, 5, 1, 1, 4, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'butler';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 11, 5, 1, 4, 1, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'butler';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 8, 4, 1, 3, 0, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'butler';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 6, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'butler';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 6, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'butler';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 37, 18, 4, 14, 2, 4, 12, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'fayette';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 29, 15, 3, 12, 2, 3, 10, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'fayette';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 22, 11, 2, 9, 1, 2, 8, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'fayette';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 18, 9, 2, 7, 1, 2, 6, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'fayette';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 12, 6, 1, 5, 1, 1, 4, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'fayette';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 10, 5, 1, 4, 1, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'fayette';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 7, 4, 1, 3, 0, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'fayette';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 6, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'fayette';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 6, 2, 0, 2, 0, 0, 2, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'fayette';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 35, 17, 4, 13, 2, 4, 11, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'schuylkill';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 28, 14, 3, 11, 2, 3, 9, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'schuylkill';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 21, 10, 2, 8, 1, 2, 7, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'schuylkill';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 17, 8, 2, 6, 1, 2, 5, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'schuylkill';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 11, 6, 1, 5, 1, 1, 4, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'schuylkill';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 10, 5, 1, 4, 1, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'schuylkill';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 7, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'schuylkill';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 6, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'schuylkill';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 6, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'schuylkill';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 34, 17, 4, 13, 2, 4, 11, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'venango';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 27, 13, 3, 10, 2, 3, 8, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'venango';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 20, 10, 2, 8, 1, 2, 7, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'venango';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 16, 8, 2, 6, 1, 2, 5, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'venango';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 11, 5, 1, 4, 1, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'venango';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 9, 5, 1, 4, 1, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'venango';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 7, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'venango';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'venango';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 2, 0, 2, 0, 0, 2, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'venango';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 32, 16, 3, 13, 2, 3, 11, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'clearfield';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 25, 13, 3, 10, 2, 3, 8, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'clearfield';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 19, 9, 2, 7, 1, 2, 6, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'clearfield';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 15, 8, 2, 6, 1, 2, 5, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'clearfield';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 10, 5, 1, 4, 1, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'clearfield';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 9, 4, 1, 3, 0, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'clearfield';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 6, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'clearfield';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'clearfield';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 2, 0, 2, 0, 0, 2, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'clearfield';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 54, 28, 6, 22, 3, 5, 20, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'centre';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 43, 21, 4, 17, 3, 3, 15, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'centre';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 32, 16, 3, 13, 2, 3, 11, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'centre';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 26, 13, 3, 10, 2, 3, 8, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'centre';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 17, 8, 2, 6, 1, 2, 5, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'centre';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 15, 7, 1, 6, 1, 1, 5, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'centre';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 11, 5, 1, 4, 1, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'centre';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 9, 4, 1, 3, 0, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'centre';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 9, 4, 1, 3, 0, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'centre';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 30, 15, 3, 12, 2, 3, 10, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'blair';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 24, 12, 3, 9, 1, 3, 8, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'blair';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 18, 9, 2, 7, 1, 2, 6, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'blair';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 15, 7, 1, 6, 1, 1, 5, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'blair';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 10, 5, 1, 4, 1, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'blair';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 8, 4, 1, 3, 0, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'blair';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 6, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'blair';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 2, 0, 2, 0, 0, 2, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'blair';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 2, 0, 2, 0, 0, 2, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'blair';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 29, 15, 3, 12, 2, 3, 10, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'cambria';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 23, 11, 2, 9, 1, 2, 8, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'cambria';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 17, 8, 2, 6, 1, 2, 5, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'cambria';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 14, 7, 1, 6, 1, 1, 5, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'cambria';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 9, 4, 1, 3, 0, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'cambria';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 8, 4, 1, 3, 0, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'cambria';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 6, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'cambria';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 2, 0, 2, 0, 0, 2, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'cambria';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 2, 0, 2, 0, 0, 2, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'cambria';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 27, 13, 3, 10, 2, 3, 8, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'indiana';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 21, 11, 2, 9, 1, 2, 8, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'indiana';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 16, 8, 2, 6, 1, 2, 5, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'indiana';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 13, 6, 1, 5, 1, 1, 4, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'indiana';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 9, 4, 1, 3, 0, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'indiana';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 7, 4, 1, 3, 0, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'indiana';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 5, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'indiana';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 4, 2, 0, 2, 0, 0, 2, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'indiana';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 4, 2, 0, 2, 0, 0, 2, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'indiana';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 25, 13, 3, 10, 2, 3, 8, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'armstrong';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 20, 10, 2, 8, 1, 2, 7, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'armstrong';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 15, 8, 2, 6, 1, 2, 5, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'armstrong';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 12, 6, 1, 5, 1, 1, 4, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'armstrong';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 8, 4, 1, 3, 0, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'armstrong';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 7, 4, 1, 3, 0, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'armstrong';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 5, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'armstrong';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 4, 1, 0, 1, 0, 0, 1, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'armstrong';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 4, 1, 0, 1, 0, 0, 1, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'armstrong';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 47, 23, 5, 18, 3, 4, 16, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'beaver';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 38, 18, 4, 14, 2, 4, 12, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'beaver';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 28, 14, 3, 11, 2, 3, 9, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'beaver';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 23, 11, 2, 9, 1, 2, 8, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'beaver';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 15, 7, 1, 6, 1, 1, 5, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'beaver';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 13, 6, 1, 5, 1, 1, 4, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'beaver';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 9, 5, 1, 4, 1, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'beaver';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 8, 4, 1, 3, 0, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'beaver';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 8, 4, 1, 3, 0, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'beaver';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 24, 12, 3, 9, 1, 3, 8, 1, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'mifflin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 19, 9, 2, 7, 1, 2, 6, 2, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'mifflin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 14, 7, 1, 6, 1, 1, 5, 3, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'mifflin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 11, 6, 1, 5, 1, 1, 4, 4, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'mifflin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 8, 4, 1, 3, 0, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'mifflin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 7, 3, 1, 2, 0, 1, 2, 7, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'mifflin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 5, 2, 0, 2, 0, 0, 2, 6, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'mifflin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 4, 2, 0, 2, 0, 0, 2, 8, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'mifflin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 4, 1, 0, 1, 0, 0, 1, 9, true
FROM web_availability_county WHERE state_code = 'PA' AND county_slug = 'mifflin';

COMMIT;
