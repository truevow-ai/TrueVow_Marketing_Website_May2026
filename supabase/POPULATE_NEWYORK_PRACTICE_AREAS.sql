-- New York Practice Area Data
-- Generated: 2025-12-01T22:44:31.992Z
-- This script populates practice area seats for New York counties

BEGIN;

-- Delete existing practice area data
DELETE FROM web_availability_practice_area_seats WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = 'NY');

-- Insert practice area seats
INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 1424, 702, 147, 555, 84, 129, 489, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'new-york';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 1139, 561, 118, 443, 67, 104, 390, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'new-york';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 854, 421, 88, 333, 51, 77, 293, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'new-york';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 683, 337, 71, 266, 40, 63, 234, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'new-york';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 456, 224, 47, 177, 27, 41, 156, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'new-york';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 399, 196, 41, 155, 24, 36, 136, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'new-york';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 285, 140, 29, 111, 17, 25, 98, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'new-york';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 228, 112, 24, 88, 13, 21, 78, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'new-york';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 228, 112, 24, 88, 13, 21, 78, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'new-york';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 536, 265, 56, 209, 32, 49, 184, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'kings';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 429, 211, 44, 167, 25, 39, 147, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'kings';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 322, 158, 33, 125, 19, 29, 110, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'kings';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 257, 127, 27, 100, 15, 24, 88, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'kings';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 172, 84, 18, 66, 10, 16, 58, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'kings';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 150, 74, 16, 58, 9, 14, 51, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'kings';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 107, 53, 11, 42, 6, 10, 37, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'kings';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 86, 42, 9, 33, 5, 8, 29, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'kings';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 86, 42, 9, 33, 5, 8, 29, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'kings';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 469, 230, 48, 182, 28, 42, 160, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'queens';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 375, 185, 39, 146, 22, 34, 129, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'queens';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 281, 139, 29, 110, 17, 25, 97, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'queens';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 225, 111, 23, 88, 13, 20, 78, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'queens';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 150, 74, 16, 58, 9, 14, 51, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'queens';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 131, 65, 14, 51, 8, 12, 45, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'queens';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 94, 46, 10, 36, 6, 9, 31, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'queens';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 75, 37, 8, 29, 4, 7, 26, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'queens';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 75, 37, 8, 29, 4, 7, 26, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'queens';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 402, 198, 42, 156, 24, 37, 137, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'nassau';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 322, 158, 33, 125, 19, 29, 110, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'nassau';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 241, 119, 25, 94, 14, 22, 83, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'nassau';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 193, 95, 20, 75, 11, 18, 66, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'nassau';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 129, 63, 13, 50, 8, 11, 44, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'nassau';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 113, 55, 12, 43, 7, 10, 38, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'nassau';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 80, 40, 8, 32, 5, 7, 28, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'nassau';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 64, 32, 7, 25, 4, 6, 22, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'nassau';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 64, 32, 7, 25, 4, 6, 22, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'nassau';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 302, 147, 31, 116, 18, 27, 102, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'suffolk';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 241, 119, 25, 94, 14, 22, 83, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'suffolk';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 181, 89, 19, 70, 11, 17, 61, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'suffolk';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 145, 71, 15, 56, 9, 13, 49, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'suffolk';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 96, 48, 10, 38, 6, 9, 33, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'suffolk';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 84, 42, 9, 33, 5, 8, 29, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'suffolk';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 60, 30, 6, 24, 4, 5, 21, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'suffolk';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 48, 24, 5, 19, 3, 4, 17, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'suffolk';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 48, 24, 5, 19, 3, 4, 17, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'suffolk';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 201, 98, 21, 77, 12, 18, 68, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'westchester';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 161, 79, 17, 62, 9, 15, 55, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'westchester';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 121, 59, 12, 47, 7, 11, 41, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'westchester';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 96, 48, 10, 38, 6, 9, 33, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'westchester';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 64, 32, 7, 25, 4, 6, 22, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'westchester';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 56, 28, 6, 22, 3, 5, 20, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'westchester';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 40, 20, 4, 16, 2, 4, 14, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'westchester';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 32, 16, 3, 13, 2, 3, 11, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'westchester';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 32, 16, 3, 13, 2, 3, 11, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'westchester';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 159, 77, 16, 61, 9, 14, 54, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'erie';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 127, 63, 13, 50, 8, 11, 44, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'erie';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 96, 47, 10, 37, 6, 9, 32, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'erie';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 76, 38, 8, 30, 5, 7, 26, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'erie';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 51, 25, 5, 20, 3, 4, 18, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'erie';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 45, 22, 5, 17, 3, 4, 15, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'erie';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 32, 16, 3, 13, 2, 3, 11, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'erie';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 25, 13, 3, 10, 2, 3, 8, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'erie';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 25, 13, 3, 10, 2, 3, 8, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'erie';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 143, 71, 15, 56, 9, 13, 49, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'monroe';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 114, 56, 12, 44, 7, 10, 38, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'monroe';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 86, 42, 9, 33, 5, 8, 29, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'monroe';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 68, 34, 7, 27, 4, 6, 24, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'monroe';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 46, 22, 5, 17, 3, 4, 15, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'monroe';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 40, 20, 4, 16, 2, 4, 14, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'monroe';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 29, 14, 3, 11, 2, 3, 9, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'monroe';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 23, 11, 2, 9, 1, 2, 8, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'monroe';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 23, 11, 2, 9, 1, 2, 8, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'monroe';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 109, 53, 11, 42, 6, 10, 37, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'onondaga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 87, 43, 9, 34, 5, 8, 30, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'onondaga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 65, 32, 7, 25, 4, 6, 22, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'onondaga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 52, 26, 5, 21, 3, 4, 19, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'onondaga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 35, 17, 4, 13, 2, 4, 11, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'onondaga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 31, 15, 3, 12, 2, 3, 10, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'onondaga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 22, 11, 2, 9, 1, 2, 8, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'onondaga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 17, 9, 2, 7, 1, 2, 6, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'onondaga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 17, 9, 2, 7, 1, 2, 6, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'onondaga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 97, 47, 10, 37, 6, 9, 32, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'richmond';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 78, 38, 8, 30, 5, 7, 26, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'richmond';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 58, 29, 6, 23, 3, 5, 21, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'richmond';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 47, 23, 5, 18, 3, 4, 16, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'richmond';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 31, 15, 3, 12, 2, 3, 10, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'richmond';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 27, 13, 3, 10, 2, 3, 8, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'richmond';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 19, 10, 2, 8, 1, 2, 7, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'richmond';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 16, 8, 2, 6, 1, 2, 5, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'richmond';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 16, 8, 2, 6, 1, 2, 5, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'richmond';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 81, 39, 8, 31, 5, 7, 27, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'rockland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 64, 32, 7, 25, 4, 6, 22, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'rockland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 48, 24, 5, 19, 3, 4, 17, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'rockland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 39, 19, 4, 15, 2, 4, 13, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'rockland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 26, 13, 3, 10, 2, 3, 8, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'rockland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 23, 11, 2, 9, 1, 2, 8, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'rockland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 16, 8, 2, 6, 1, 2, 5, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'rockland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 13, 6, 1, 5, 1, 1, 4, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'rockland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 13, 6, 1, 5, 1, 1, 4, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'rockland';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 70, 33, 7, 26, 4, 6, 23, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'orange';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 56, 28, 6, 22, 3, 5, 20, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'orange';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 42, 21, 4, 17, 3, 3, 15, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'orange';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 34, 17, 4, 13, 2, 4, 11, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'orange';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 22, 11, 2, 9, 1, 2, 8, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'orange';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 20, 10, 2, 8, 1, 2, 7, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'orange';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 14, 7, 1, 6, 1, 1, 5, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'orange';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 11, 6, 1, 5, 1, 1, 4, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'orange';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 11, 6, 1, 5, 1, 1, 4, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'orange';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 64, 31, 7, 24, 4, 6, 21, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'dutchess';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 51, 25, 5, 20, 3, 4, 18, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'dutchess';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 38, 19, 4, 15, 2, 4, 13, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'dutchess';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 31, 15, 3, 12, 2, 3, 10, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'dutchess';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 20, 10, 2, 8, 1, 2, 7, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'dutchess';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 18, 9, 2, 7, 1, 2, 6, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'dutchess';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 13, 6, 1, 5, 1, 1, 4, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'dutchess';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 10, 5, 1, 4, 1, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'dutchess';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 10, 5, 1, 4, 1, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'dutchess';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 59, 29, 6, 23, 3, 5, 21, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'albany';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 47, 23, 5, 18, 3, 4, 16, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'albany';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 35, 17, 4, 13, 2, 4, 11, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'albany';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 28, 14, 3, 11, 2, 3, 9, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'albany';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 19, 9, 2, 7, 1, 2, 6, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'albany';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 16, 8, 2, 6, 1, 2, 5, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'albany';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 12, 6, 1, 5, 1, 1, 4, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'albany';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 9, 5, 1, 4, 1, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'albany';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 9, 5, 1, 4, 1, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'albany';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 47, 23, 5, 18, 3, 4, 16, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'oneida';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 38, 18, 4, 14, 2, 4, 12, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'oneida';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 28, 14, 3, 11, 2, 3, 9, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'oneida';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 23, 11, 2, 9, 1, 2, 8, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'oneida';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 15, 7, 1, 6, 1, 1, 5, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'oneida';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 13, 6, 1, 5, 1, 1, 4, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'oneida';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 9, 5, 1, 4, 1, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'oneida';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 8, 4, 1, 3, 0, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'oneida';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 8, 4, 1, 3, 0, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'oneida';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 42, 21, 4, 17, 3, 3, 15, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'broome';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 34, 17, 4, 13, 2, 4, 11, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'broome';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 25, 12, 3, 9, 1, 3, 8, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'broome';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 20, 10, 2, 8, 1, 2, 7, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'broome';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 13, 7, 1, 6, 1, 1, 5, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'broome';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 12, 6, 1, 5, 1, 1, 4, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'broome';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 8, 4, 1, 3, 0, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'broome';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 7, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'broome';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 7, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'broome';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 40, 20, 4, 16, 2, 4, 14, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'ulster';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 32, 16, 3, 13, 2, 3, 11, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'ulster';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 24, 12, 3, 9, 1, 3, 8, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'ulster';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 19, 9, 2, 7, 1, 2, 6, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'ulster';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 13, 6, 1, 5, 1, 1, 4, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'ulster';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 11, 6, 1, 5, 1, 1, 4, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'ulster';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 8, 4, 1, 3, 0, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'ulster';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 6, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'ulster';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 6, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'ulster';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 39, 20, 4, 16, 2, 4, 14, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'saratoga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 31, 15, 3, 12, 2, 3, 10, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'saratoga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 23, 11, 2, 9, 1, 2, 8, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'saratoga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 18, 9, 2, 7, 1, 2, 6, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'saratoga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 12, 6, 1, 5, 1, 1, 4, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'saratoga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 11, 5, 1, 4, 1, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'saratoga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 8, 4, 1, 3, 0, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'saratoga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 6, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'saratoga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 6, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'saratoga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 37, 17, 4, 13, 2, 4, 11, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'schenectady';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 29, 15, 3, 12, 2, 3, 10, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'schenectady';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 22, 11, 2, 9, 1, 2, 8, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'schenectady';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 18, 9, 2, 7, 1, 2, 6, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'schenectady';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 12, 6, 1, 5, 1, 1, 4, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'schenectady';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 10, 5, 1, 4, 1, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'schenectady';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 7, 4, 1, 3, 0, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'schenectady';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 6, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'schenectady';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 6, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'schenectady';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 35, 17, 4, 13, 2, 4, 11, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'putnam';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 28, 14, 3, 11, 2, 3, 9, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'putnam';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 21, 10, 2, 8, 1, 2, 7, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'putnam';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 17, 8, 2, 6, 1, 2, 5, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'putnam';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 11, 6, 1, 5, 1, 1, 4, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'putnam';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 10, 5, 1, 4, 1, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'putnam';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 7, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'putnam';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 6, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'putnam';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 6, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'putnam';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 34, 16, 3, 13, 2, 3, 11, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'sullivan';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 27, 13, 3, 10, 2, 3, 8, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'sullivan';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 20, 10, 2, 8, 1, 2, 7, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'sullivan';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 16, 8, 2, 6, 1, 2, 5, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'sullivan';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 11, 5, 1, 4, 1, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'sullivan';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 9, 5, 1, 4, 1, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'sullivan';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 7, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'sullivan';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'sullivan';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'sullivan';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 32, 15, 3, 12, 2, 3, 10, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'oswego';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 25, 13, 3, 10, 2, 3, 8, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'oswego';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 19, 9, 2, 7, 1, 2, 6, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'oswego';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 15, 8, 2, 6, 1, 2, 5, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'oswego';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 10, 5, 1, 4, 1, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'oswego';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 9, 4, 1, 3, 0, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'oswego';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 6, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'oswego';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'oswego';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'oswego';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 30, 15, 3, 12, 2, 3, 10, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'st-lawrence';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 24, 12, 3, 9, 1, 3, 8, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'st-lawrence';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 18, 9, 2, 7, 1, 2, 6, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'st-lawrence';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 15, 7, 1, 6, 1, 1, 5, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'st-lawrence';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 10, 5, 1, 4, 1, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'st-lawrence';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 8, 4, 1, 3, 0, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'st-lawrence';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 6, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'st-lawrence';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 2, 1, 1, 0, 1, 1, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'st-lawrence';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 2, 1, 1, 0, 1, 1, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'st-lawrence';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 29, 15, 3, 12, 2, 3, 10, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'jefferson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 23, 11, 2, 9, 1, 2, 8, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'jefferson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 17, 8, 2, 6, 1, 2, 5, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'jefferson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 14, 7, 1, 6, 1, 1, 5, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'jefferson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 9, 4, 1, 3, 0, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'jefferson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 8, 4, 1, 3, 0, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'jefferson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 6, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'jefferson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 2, 1, 1, 0, 1, 1, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'jefferson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 2, 1, 1, 0, 1, 1, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'jefferson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 54, 28, 6, 22, 3, 5, 20, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'niagara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 43, 21, 4, 17, 3, 3, 15, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'niagara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 32, 16, 3, 13, 2, 3, 11, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'niagara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 26, 13, 3, 10, 2, 3, 8, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'niagara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 17, 8, 2, 6, 1, 2, 5, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'niagara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 15, 7, 1, 6, 1, 1, 5, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'niagara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 11, 5, 1, 4, 1, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'niagara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 9, 4, 1, 3, 0, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'niagara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 9, 4, 1, 3, 0, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'niagara';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 27, 13, 3, 10, 2, 3, 8, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'ontario';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 21, 11, 2, 9, 1, 2, 8, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'ontario';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 16, 8, 2, 6, 1, 2, 5, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'ontario';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 13, 6, 1, 5, 1, 1, 4, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'ontario';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 9, 4, 1, 3, 0, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'ontario';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 7, 4, 1, 3, 0, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'ontario';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 5, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'ontario';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 4, 2, 1, 1, 0, 1, 1, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'ontario';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 4, 2, 1, 1, 0, 1, 1, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'ontario';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 25, 11, 2, 9, 1, 2, 8, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'steuben';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 20, 10, 2, 8, 1, 2, 7, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'steuben';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 15, 8, 2, 6, 1, 2, 5, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'steuben';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 12, 6, 1, 5, 1, 1, 4, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'steuben';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 8, 4, 1, 3, 0, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'steuben';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 7, 4, 1, 3, 0, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'steuben';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 5, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'steuben';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 4, 2, 1, 1, 0, 1, 1, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'steuben';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 4, 2, 1, 1, 0, 1, 1, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'steuben';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 24, 11, 2, 9, 1, 2, 8, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'wayne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 19, 9, 2, 7, 1, 2, 6, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'wayne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 14, 7, 1, 6, 1, 1, 5, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'wayne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 11, 6, 1, 5, 1, 1, 4, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'wayne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 8, 4, 1, 3, 0, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'wayne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 7, 3, 1, 2, 0, 1, 2, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'wayne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 5, 2, 1, 1, 0, 1, 1, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'wayne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 4, 2, 1, 1, 0, 1, 1, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'wayne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 4, 2, 1, 1, 0, 1, 1, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'wayne';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 22, 11, 2, 9, 1, 2, 8, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'cayuga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 17, 9, 2, 7, 1, 2, 6, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'cayuga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 13, 6, 1, 5, 1, 1, 4, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'cayuga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 10, 5, 1, 4, 1, 1, 3, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'cayuga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 7, 3, 1, 2, 0, 1, 2, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'cayuga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 6, 3, 1, 2, 0, 1, 2, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'cayuga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 4, 2, 1, 1, 0, 1, 1, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'cayuga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 3, 2, 1, 1, 0, 1, 1, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'cayuga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 3, 2, 1, 1, 0, 1, 1, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'cayuga';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 34, 16, 3, 13, 2, 3, 11, 1, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'chautauqua';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 27, 13, 3, 10, 2, 3, 8, 2, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'chautauqua';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 20, 10, 2, 8, 1, 2, 7, 3, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'chautauqua';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 16, 8, 2, 6, 1, 2, 5, 4, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'chautauqua';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 11, 5, 1, 4, 1, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'chautauqua';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 9, 5, 1, 4, 1, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'chautauqua';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 7, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'chautauqua';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'chautauqua';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'NY' AND county_slug = 'chautauqua';

COMMIT;
