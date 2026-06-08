-- California Practice Area Data
-- Generated: 2025-12-01T23:12:47.495Z
-- This script populates practice area seats for California counties
-- TOP 30 counties selected by law firm count

BEGIN;

-- Delete existing practice area data
DELETE FROM web_availability_practice_area_seats WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = 'CA');

-- Insert practice area seats
INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 1508, 741, 156, 585, 89, 137, 515, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'los-angeles';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 1206, 594, 125, 469, 71, 110, 413, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'los-angeles';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 905, 446, 94, 352, 54, 83, 309, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'los-angeles';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 724, 356, 75, 281, 43, 66, 247, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'los-angeles';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 482, 238, 50, 188, 29, 44, 165, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'los-angeles';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 422, 208, 44, 164, 25, 39, 144, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'los-angeles';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 302, 149, 31, 118, 18, 27, 104, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'los-angeles';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 241, 119, 25, 94, 14, 22, 83, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'los-angeles';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 241, 119, 24, 95, 14, 21, 84, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'los-angeles';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 452, 222, 47, 175, 27, 41, 154, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-diego';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 362, 178, 37, 141, 21, 33, 124, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-diego';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 271, 134, 28, 106, 16, 25, 93, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-diego';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 217, 107, 22, 85, 13, 19, 75, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-diego';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 145, 71, 15, 56, 9, 13, 49, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-diego';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 127, 62, 13, 49, 7, 12, 43, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-diego';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 90, 45, 9, 36, 5, 8, 32, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-diego';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 72, 36, 8, 28, 4, 7, 25, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-diego';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 72, 36, 8, 28, 4, 7, 25, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-diego';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 498, 246, 53, 193, 30, 47, 169, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'orange';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 399, 196, 41, 155, 24, 36, 136, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'orange';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 299, 147, 31, 116, 18, 27, 102, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'orange';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 239, 118, 25, 93, 14, 22, 82, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'orange';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 159, 78, 16, 62, 9, 14, 55, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'orange';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 140, 69, 14, 55, 8, 12, 49, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'orange';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 100, 49, 10, 39, 6, 9, 34, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'orange';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 80, 39, 8, 31, 5, 7, 27, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'orange';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 80, 39, 8, 31, 5, 7, 27, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'orange';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 159, 77, 16, 61, 9, 14, 54, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-clara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 127, 63, 13, 50, 8, 11, 44, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-clara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 96, 47, 10, 37, 6, 9, 32, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-clara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 76, 38, 8, 30, 5, 7, 26, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-clara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 51, 25, 5, 20, 3, 4, 18, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-clara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 45, 22, 5, 17, 3, 4, 15, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-clara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 32, 16, 3, 13, 2, 3, 11, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-clara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 25, 13, 3, 10, 2, 3, 8, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-clara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 25, 13, 3, 10, 2, 3, 8, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-clara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 126, 62, 13, 49, 7, 12, 43, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'alameda';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 101, 50, 10, 40, 6, 9, 35, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'alameda';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 75, 37, 8, 29, 4, 7, 26, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'alameda';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 60, 30, 6, 24, 4, 5, 21, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'alameda';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 40, 20, 4, 16, 2, 4, 14, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'alameda';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 35, 17, 4, 13, 2, 4, 11, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'alameda';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 25, 12, 3, 9, 1, 3, 8, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'alameda';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 20, 10, 2, 8, 1, 2, 7, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'alameda';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 20, 10, 2, 8, 1, 2, 7, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'alameda';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 235, 118, 25, 93, 14, 22, 82, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-francisco';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 188, 92, 19, 73, 11, 17, 64, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-francisco';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 141, 69, 14, 55, 8, 12, 49, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-francisco';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 113, 55, 12, 43, 7, 10, 38, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-francisco';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 75, 37, 8, 29, 4, 7, 26, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-francisco';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 66, 32, 7, 25, 4, 6, 22, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-francisco';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 47, 23, 5, 18, 3, 4, 16, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-francisco';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 38, 18, 4, 14, 2, 4, 12, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-francisco';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 38, 18, 3, 15, 2, 3, 13, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-francisco';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 268, 133, 29, 104, 16, 26, 91, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sacramento';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 214, 106, 22, 84, 13, 19, 74, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sacramento';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 161, 79, 17, 62, 9, 15, 55, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sacramento';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 129, 63, 13, 50, 8, 11, 44, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sacramento';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 86, 42, 9, 33, 5, 8, 29, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sacramento';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 75, 37, 8, 29, 4, 7, 26, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sacramento';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 54, 26, 5, 21, 3, 4, 19, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sacramento';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 43, 21, 4, 17, 3, 3, 15, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sacramento';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 43, 21, 4, 17, 3, 3, 15, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sacramento';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 201, 98, 21, 77, 12, 18, 68, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'riverside';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 161, 79, 17, 62, 9, 15, 55, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'riverside';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 121, 59, 12, 47, 7, 11, 41, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'riverside';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 96, 48, 10, 38, 6, 9, 33, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'riverside';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 64, 32, 7, 25, 4, 6, 22, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'riverside';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 56, 28, 6, 22, 3, 5, 20, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'riverside';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 40, 20, 4, 16, 2, 4, 14, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'riverside';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 32, 16, 3, 13, 2, 3, 11, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'riverside';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 32, 16, 3, 13, 2, 3, 11, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'riverside';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 184, 90, 20, 70, 11, 18, 61, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-bernardino';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 147, 73, 15, 58, 9, 13, 51, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-bernardino';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 111, 54, 11, 43, 6, 10, 38, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-bernardino';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 88, 44, 9, 35, 5, 8, 31, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-bernardino';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 59, 29, 6, 23, 3, 5, 21, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-bernardino';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 52, 25, 5, 20, 3, 4, 18, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-bernardino';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 37, 18, 4, 14, 2, 4, 12, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-bernardino';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 29, 15, 3, 12, 2, 3, 10, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-bernardino';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 29, 15, 3, 12, 2, 3, 10, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-bernardino';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 184, 90, 20, 70, 11, 18, 61, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'contra-costa';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 147, 73, 15, 58, 9, 13, 51, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'contra-costa';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 111, 54, 11, 43, 6, 10, 38, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'contra-costa';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 88, 44, 9, 35, 5, 8, 31, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'contra-costa';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 59, 29, 6, 23, 3, 5, 21, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'contra-costa';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 52, 25, 5, 20, 3, 4, 18, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'contra-costa';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 37, 18, 4, 14, 2, 4, 12, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'contra-costa';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 29, 15, 3, 12, 2, 3, 10, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'contra-costa';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 29, 15, 3, 12, 2, 3, 10, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'contra-costa';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 168, 82, 17, 65, 10, 15, 57, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-mateo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 134, 66, 14, 52, 8, 12, 46, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-mateo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 101, 50, 10, 40, 6, 9, 35, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-mateo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 80, 40, 8, 32, 5, 7, 28, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-mateo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 54, 26, 5, 21, 3, 4, 19, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-mateo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 47, 23, 5, 18, 3, 4, 16, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-mateo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 34, 17, 4, 13, 2, 4, 11, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-mateo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 27, 13, 3, 10, 2, 3, 8, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-mateo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 27, 13, 3, 10, 2, 3, 8, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-mateo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 151, 73, 15, 58, 9, 13, 51, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'fresno';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 121, 59, 12, 47, 7, 11, 41, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'fresno';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 90, 45, 9, 36, 5, 8, 32, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'fresno';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 72, 36, 8, 28, 4, 7, 25, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'fresno';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 48, 24, 5, 19, 3, 4, 17, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'fresno';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 42, 21, 4, 17, 3, 3, 15, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'fresno';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 30, 15, 3, 12, 2, 3, 10, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'fresno';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 24, 12, 3, 9, 1, 3, 8, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'fresno';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 24, 12, 3, 9, 1, 3, 8, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'fresno';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 134, 65, 14, 51, 8, 12, 45, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'ventura';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 107, 53, 11, 42, 6, 10, 37, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'ventura';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 80, 40, 8, 32, 5, 7, 28, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'ventura';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 64, 32, 7, 25, 4, 6, 22, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'ventura';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 43, 21, 4, 17, 3, 3, 15, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'ventura';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 38, 18, 4, 14, 2, 4, 12, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'ventura';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 27, 13, 3, 10, 2, 3, 8, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'ventura';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 21, 11, 2, 9, 1, 2, 8, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'ventura';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 21, 11, 2, 9, 1, 2, 8, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'ventura';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 117, 58, 12, 46, 7, 11, 40, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'kern';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 94, 46, 10, 36, 6, 9, 31, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'kern';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 70, 35, 7, 28, 4, 6, 25, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'kern';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 56, 28, 6, 22, 3, 5, 20, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'kern';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 38, 18, 4, 14, 2, 4, 12, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'kern';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 33, 16, 3, 13, 2, 3, 11, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'kern';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 23, 12, 3, 9, 1, 3, 8, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'kern';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 19, 9, 2, 7, 1, 2, 6, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'kern';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 19, 9, 2, 7, 1, 2, 6, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'kern';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 101, 48, 11, 37, 6, 10, 32, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sonoma';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 80, 40, 8, 32, 5, 7, 28, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sonoma';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 60, 30, 6, 24, 4, 5, 21, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sonoma';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 48, 24, 5, 19, 3, 4, 17, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sonoma';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 32, 16, 3, 13, 2, 3, 11, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sonoma';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 28, 14, 3, 11, 2, 3, 9, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sonoma';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 20, 10, 2, 8, 1, 2, 7, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sonoma';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 16, 8, 2, 6, 1, 2, 5, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sonoma';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 16, 8, 2, 6, 1, 2, 5, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sonoma';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 84, 40, 9, 31, 5, 8, 27, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-joaquin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 67, 33, 7, 26, 4, 6, 23, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-joaquin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 50, 25, 5, 20, 3, 4, 18, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-joaquin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 40, 20, 4, 16, 2, 4, 14, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-joaquin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 27, 13, 3, 10, 2, 3, 8, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-joaquin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 23, 12, 3, 9, 1, 3, 8, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-joaquin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 17, 8, 2, 6, 1, 2, 5, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-joaquin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 13, 7, 1, 6, 1, 1, 5, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-joaquin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 13, 7, 1, 6, 1, 1, 5, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-joaquin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 84, 40, 9, 31, 5, 8, 27, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'stanislaus';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 67, 33, 7, 26, 4, 6, 23, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'stanislaus';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 50, 25, 5, 20, 3, 4, 18, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'stanislaus';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 40, 20, 4, 16, 2, 4, 14, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'stanislaus';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 27, 13, 3, 10, 2, 3, 8, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'stanislaus';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 23, 12, 3, 9, 1, 3, 8, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'stanislaus';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 17, 8, 2, 6, 1, 2, 5, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'stanislaus';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 13, 7, 1, 6, 1, 1, 5, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'stanislaus';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 13, 7, 1, 6, 1, 1, 5, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'stanislaus';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 84, 40, 9, 31, 5, 8, 27, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-barbara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 67, 33, 7, 26, 4, 6, 23, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-barbara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 50, 25, 5, 20, 3, 4, 18, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-barbara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 40, 20, 4, 16, 2, 4, 14, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-barbara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 27, 13, 3, 10, 2, 3, 8, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-barbara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 23, 12, 3, 9, 1, 3, 8, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-barbara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 17, 8, 2, 6, 1, 2, 5, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-barbara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 13, 7, 1, 6, 1, 1, 5, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-barbara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 13, 7, 1, 6, 1, 1, 5, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-barbara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 67, 33, 8, 25, 4, 7, 22, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'marin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 54, 26, 6, 20, 3, 5, 18, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'marin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 40, 20, 4, 16, 2, 4, 14, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'marin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 32, 16, 3, 13, 2, 3, 11, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'marin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 21, 11, 2, 9, 1, 2, 8, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'marin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 19, 9, 2, 7, 1, 2, 6, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'marin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 13, 7, 1, 6, 1, 1, 5, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'marin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 11, 5, 1, 4, 1, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'marin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 11, 5, 1, 4, 1, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'marin';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 67, 33, 8, 25, 4, 7, 22, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tulare';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 54, 26, 6, 20, 3, 5, 18, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tulare';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 40, 20, 4, 16, 2, 4, 14, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tulare';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 32, 16, 3, 13, 2, 3, 11, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tulare';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 21, 11, 2, 9, 1, 2, 8, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tulare';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 19, 9, 2, 7, 1, 2, 6, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tulare';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 13, 7, 1, 6, 1, 1, 5, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tulare';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 11, 5, 1, 4, 1, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tulare';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 11, 5, 1, 4, 1, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tulare';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 67, 33, 8, 25, 4, 7, 22, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'solano';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 54, 26, 6, 20, 3, 5, 18, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'solano';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 40, 20, 4, 16, 2, 4, 14, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'solano';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 32, 16, 3, 13, 2, 3, 11, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'solano';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 21, 11, 2, 9, 1, 2, 8, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'solano';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 19, 9, 2, 7, 1, 2, 6, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'solano';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 13, 7, 1, 6, 1, 1, 5, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'solano';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 11, 5, 1, 4, 1, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'solano';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 11, 5, 1, 4, 1, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'solano';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 67, 33, 8, 25, 4, 7, 22, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'monterey';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 54, 26, 6, 20, 3, 5, 18, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'monterey';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 40, 20, 4, 16, 2, 4, 14, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'monterey';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 32, 16, 3, 13, 2, 3, 11, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'monterey';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 21, 11, 2, 9, 1, 2, 8, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'monterey';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 19, 9, 2, 7, 1, 2, 6, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'monterey';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 13, 7, 1, 6, 1, 1, 5, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'monterey';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 11, 5, 1, 4, 1, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'monterey';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 11, 5, 1, 4, 1, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'monterey';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 67, 33, 8, 25, 4, 7, 22, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'placer';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 54, 26, 6, 20, 3, 5, 18, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'placer';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 40, 20, 4, 16, 2, 4, 14, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'placer';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 32, 16, 3, 13, 2, 3, 11, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'placer';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 21, 11, 2, 9, 1, 2, 8, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'placer';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 19, 9, 2, 7, 1, 2, 6, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'placer';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 13, 7, 1, 6, 1, 1, 5, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'placer';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 11, 5, 1, 4, 1, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'placer';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 11, 5, 1, 4, 1, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'placer';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 42, 21, 5, 16, 3, 4, 14, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'butte';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 34, 17, 3, 14, 2, 3, 12, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'butte';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 25, 12, 2, 10, 1, 2, 9, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'butte';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 20, 10, 2, 8, 1, 2, 7, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'butte';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 13, 7, 1, 6, 1, 1, 5, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'butte';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 12, 6, 1, 5, 1, 1, 4, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'butte';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 8, 4, 1, 3, 0, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'butte';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 7, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'butte';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 7, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'butte';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 42, 21, 5, 16, 3, 4, 14, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'merced';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 34, 17, 3, 14, 2, 3, 12, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'merced';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 25, 12, 2, 10, 1, 2, 9, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'merced';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 20, 10, 2, 8, 1, 2, 7, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'merced';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 13, 7, 1, 6, 1, 1, 5, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'merced';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 12, 6, 1, 5, 1, 1, 4, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'merced';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 8, 4, 1, 3, 0, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'merced';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 7, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'merced';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 7, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'merced';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 34, 16, 3, 13, 2, 3, 11, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'shasta';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 27, 13, 3, 10, 2, 3, 8, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'shasta';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 20, 10, 2, 8, 1, 2, 7, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'shasta';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 16, 8, 2, 6, 1, 2, 5, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'shasta';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 11, 5, 1, 4, 1, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'shasta';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 9, 5, 1, 4, 1, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'shasta';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 7, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'shasta';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'shasta';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 3, 0, 3, 0, 0, 3, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'shasta';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 34, 16, 3, 13, 2, 3, 11, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'el-dorado';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 27, 13, 3, 10, 2, 3, 8, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'el-dorado';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 20, 10, 2, 8, 1, 2, 7, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'el-dorado';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 16, 8, 2, 6, 1, 2, 5, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'el-dorado';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 11, 5, 1, 4, 1, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'el-dorado';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 9, 5, 1, 4, 1, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'el-dorado';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 7, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'el-dorado';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'el-dorado';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 3, 0, 3, 0, 0, 3, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'el-dorado';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 34, 16, 3, 13, 2, 3, 11, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'yolo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 27, 13, 3, 10, 2, 3, 8, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'yolo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 20, 10, 2, 8, 1, 2, 7, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'yolo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 16, 8, 2, 6, 1, 2, 5, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'yolo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 11, 5, 1, 4, 1, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'yolo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 9, 5, 1, 4, 1, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'yolo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 7, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'yolo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'yolo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 3, 0, 3, 0, 0, 3, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'yolo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 34, 16, 3, 13, 2, 3, 11, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'napa';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 27, 13, 3, 10, 2, 3, 8, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'napa';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 20, 10, 2, 8, 1, 2, 7, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'napa';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 16, 8, 2, 6, 1, 2, 5, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'napa';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 11, 5, 1, 4, 1, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'napa';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 9, 5, 1, 4, 1, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'napa';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 7, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'napa';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'napa';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 3, 0, 3, 0, 0, 3, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'napa';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 34, 16, 3, 13, 2, 3, 11, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'humboldt';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 27, 13, 3, 10, 2, 3, 8, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'humboldt';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 20, 10, 2, 8, 1, 2, 7, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'humboldt';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 16, 8, 2, 6, 1, 2, 5, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'humboldt';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 11, 5, 1, 4, 1, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'humboldt';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 9, 5, 1, 4, 1, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'humboldt';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 7, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'humboldt';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'humboldt';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 3, 0, 3, 0, 0, 3, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'humboldt';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 30, 15, 4, 11, 2, 3, 10, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'imperial';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 24, 12, 2, 10, 1, 2, 9, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'imperial';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 18, 9, 2, 7, 1, 2, 6, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'imperial';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 15, 7, 1, 6, 1, 1, 5, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'imperial';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 10, 5, 1, 4, 1, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'imperial';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 8, 4, 1, 3, 0, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'imperial';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 6, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'imperial';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 2, 0, 2, 0, 0, 2, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'imperial';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 2, 0, 2, 0, 0, 2, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'imperial';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 27, 13, 3, 10, 2, 3, 8, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'kings';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 21, 11, 2, 9, 1, 2, 8, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'kings';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 16, 8, 2, 6, 1, 2, 5, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'kings';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 13, 6, 1, 5, 1, 1, 4, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'kings';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 9, 4, 1, 3, 0, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'kings';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 7, 4, 1, 3, 0, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'kings';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 5, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'kings';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 4, 2, 0, 2, 0, 0, 2, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'kings';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 4, 2, 0, 2, 0, 0, 2, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'kings';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 25, 11, 3, 8, 1, 3, 7, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'madera';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 20, 10, 2, 8, 1, 2, 7, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'madera';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 15, 8, 2, 6, 1, 2, 5, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'madera';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 12, 6, 1, 5, 1, 1, 4, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'madera';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 8, 4, 1, 3, 0, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'madera';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 7, 4, 1, 3, 0, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'madera';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 5, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'madera';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 4, 2, 0, 2, 0, 0, 2, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'madera';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 4, 2, 0, 2, 0, 0, 2, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'madera';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 24, 11, 3, 8, 1, 3, 7, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sutter';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 19, 9, 2, 7, 1, 2, 6, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sutter';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 14, 7, 2, 5, 1, 2, 4, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sutter';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 11, 6, 1, 5, 1, 1, 4, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sutter';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 8, 4, 1, 3, 0, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sutter';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 7, 3, 1, 2, 0, 1, 2, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sutter';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 5, 2, 0, 2, 0, 0, 2, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sutter';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 4, 2, 0, 2, 0, 0, 2, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sutter';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 4, 2, 0, 2, 0, 0, 2, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'sutter';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 22, 11, 3, 8, 1, 3, 7, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'yuba';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 17, 9, 2, 7, 1, 2, 6, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'yuba';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 13, 6, 1, 5, 1, 1, 4, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'yuba';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 10, 5, 1, 4, 1, 1, 3, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'yuba';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 7, 3, 1, 2, 0, 1, 2, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'yuba';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 6, 3, 1, 2, 0, 1, 2, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'yuba';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 4, 2, 0, 2, 0, 0, 2, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'yuba';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 3, 2, 0, 2, 0, 0, 2, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'yuba';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 3, 2, 0, 2, 0, 0, 2, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'yuba';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 59, 29, 6, 23, 3, 5, 21, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-luis-obispo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 47, 23, 5, 18, 3, 4, 16, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-luis-obispo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 35, 17, 4, 13, 2, 4, 11, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-luis-obispo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 28, 14, 3, 11, 2, 3, 9, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-luis-obispo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 19, 9, 2, 7, 1, 2, 6, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-luis-obispo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 16, 8, 2, 6, 1, 2, 5, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-luis-obispo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 12, 6, 1, 5, 1, 1, 4, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-luis-obispo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 9, 5, 1, 4, 1, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-luis-obispo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 9, 5, 0, 5, 1, 0, 4, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-luis-obispo';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 54, 28, 6, 22, 3, 5, 20, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-cruz';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 43, 21, 4, 17, 3, 3, 15, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-cruz';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 32, 16, 3, 13, 2, 3, 11, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-cruz';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 26, 13, 3, 10, 2, 3, 8, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-cruz';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 17, 8, 2, 6, 1, 2, 5, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-cruz';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 15, 7, 1, 6, 1, 1, 5, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-cruz';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 11, 5, 1, 4, 1, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-cruz';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 9, 4, 1, 3, 0, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-cruz';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 9, 4, 1, 3, 0, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'santa-cruz';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 15, 7, 2, 5, 1, 2, 4, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-benito';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 12, 6, 2, 4, 1, 2, 3, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-benito';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 9, 5, 1, 4, 1, 1, 3, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-benito';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 7, 4, 1, 3, 0, 1, 3, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-benito';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 5, 2, 0, 2, 0, 0, 2, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-benito';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 4, 2, 0, 2, 0, 0, 2, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-benito';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 3, 2, 0, 2, 0, 0, 2, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-benito';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 2, 1, 0, 1, 0, 0, 1, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-benito';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 2, 1, 0, 1, 0, 0, 1, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'san-benito';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 14, 7, 2, 5, 1, 2, 4, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'amador';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 11, 5, 1, 4, 1, 1, 3, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'amador';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 8, 4, 1, 3, 0, 1, 3, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'amador';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 6, 3, 1, 2, 0, 1, 2, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'amador';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 4, 2, 0, 2, 0, 0, 2, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'amador';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 4, 2, 0, 2, 0, 0, 2, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'amador';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 3, 1, 0, 1, 0, 0, 1, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'amador';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 2, 1, 0, 1, 0, 0, 1, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'amador';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 2, 1, 0, 1, 0, 0, 1, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'amador';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 12, 5, 2, 3, 1, 2, 2, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'calaveras';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 9, 5, 1, 4, 1, 1, 3, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'calaveras';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 7, 3, 1, 2, 0, 1, 2, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'calaveras';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 6, 3, 1, 2, 0, 1, 2, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'calaveras';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 4, 2, 0, 2, 0, 0, 2, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'calaveras';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 3, 2, 0, 2, 0, 0, 2, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'calaveras';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 2, 1, 0, 1, 0, 0, 1, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'calaveras';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 2, 1, 0, 1, 0, 0, 1, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'calaveras';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 2, 1, 0, 1, 0, 0, 1, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'calaveras';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 15, 7, 2, 5, 1, 2, 4, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tuolumne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 12, 6, 2, 4, 1, 2, 3, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tuolumne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 9, 5, 1, 4, 1, 1, 3, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tuolumne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 7, 4, 1, 3, 0, 1, 3, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tuolumne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 5, 2, 0, 2, 0, 0, 2, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tuolumne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 4, 2, 0, 2, 0, 0, 2, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tuolumne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 3, 2, 0, 2, 0, 0, 2, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tuolumne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 2, 1, 0, 1, 0, 0, 1, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tuolumne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 2, 1, 0, 1, 0, 0, 1, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tuolumne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 20, 9, 2, 7, 1, 2, 6, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'mendocino';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 16, 8, 2, 6, 1, 2, 5, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'mendocino';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 12, 6, 1, 5, 1, 1, 4, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'mendocino';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 10, 5, 1, 4, 1, 1, 3, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'mendocino';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 6, 3, 1, 2, 0, 1, 2, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'mendocino';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 6, 3, 1, 2, 0, 1, 2, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'mendocino';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 4, 2, 0, 2, 0, 0, 2, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'mendocino';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 3, 2, 0, 2, 0, 0, 2, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'mendocino';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 3, 2, 0, 2, 0, 0, 2, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'mendocino';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 17, 8, 3, 5, 1, 3, 4, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'lake';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 13, 7, 1, 6, 1, 1, 5, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'lake';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 10, 5, 1, 4, 1, 1, 3, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'lake';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 8, 4, 1, 3, 0, 1, 3, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'lake';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 5, 3, 1, 2, 0, 1, 2, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'lake';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 5, 2, 0, 2, 0, 0, 2, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'lake';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 3, 2, 0, 2, 0, 0, 2, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'lake';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 3, 1, 0, 1, 0, 0, 1, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'lake';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 3, 1, 0, 1, 0, 0, 1, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'lake';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 14, 7, 2, 5, 1, 2, 4, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tehama';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 11, 5, 1, 4, 1, 1, 3, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tehama';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 8, 4, 1, 3, 0, 1, 3, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tehama';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 6, 3, 1, 2, 0, 1, 2, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tehama';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 4, 2, 0, 2, 0, 0, 2, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tehama';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 4, 2, 0, 2, 0, 0, 2, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tehama';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 3, 1, 0, 1, 0, 0, 1, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tehama';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 2, 1, 0, 1, 0, 0, 1, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tehama';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 2, 1, 0, 1, 0, 0, 1, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'tehama';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 20, 9, 2, 7, 1, 2, 6, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'nevada';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 16, 8, 2, 6, 1, 2, 5, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'nevada';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 12, 6, 1, 5, 1, 1, 4, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'nevada';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 10, 5, 1, 4, 1, 1, 3, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'nevada';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 6, 3, 1, 2, 0, 1, 2, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'nevada';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 6, 3, 1, 2, 0, 1, 2, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'nevada';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 4, 2, 0, 2, 0, 0, 2, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'nevada';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 3, 2, 0, 2, 0, 0, 2, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'nevada';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 3, 2, 0, 2, 0, 0, 2, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'nevada';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 12, 5, 2, 3, 1, 2, 2, 1, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'siskiyou';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 9, 5, 1, 4, 1, 1, 3, 2, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'siskiyou';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 7, 3, 1, 2, 0, 1, 2, 3, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'siskiyou';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 6, 3, 1, 2, 0, 1, 2, 4, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'siskiyou';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 4, 2, 0, 2, 0, 0, 2, 5, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'siskiyou';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 3, 2, 0, 2, 0, 0, 2, 7, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'siskiyou';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 2, 1, 0, 1, 0, 0, 1, 6, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'siskiyou';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 2, 1, 0, 1, 0, 0, 1, 8, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'siskiyou';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 2, 1, 0, 1, 0, 0, 1, 9, true
FROM web_availability_county WHERE state_code = 'CA' AND county_slug = 'siskiyou';

COMMIT;
