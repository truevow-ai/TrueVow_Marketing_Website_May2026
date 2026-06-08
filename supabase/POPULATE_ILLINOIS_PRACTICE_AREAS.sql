-- Illinois Practice Area Data
-- Generated: 2025-12-01T22:44:38.499Z
-- This script populates practice area seats for Illinois counties

BEGIN;

-- Delete existing practice area data
DELETE FROM web_availability_practice_area_seats WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = 'IL');

-- Insert practice area seats
INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 804, 396, 83, 313, 48, 73, 275, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'cook';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 643, 317, 67, 250, 38, 59, 220, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'cook';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 482, 238, 50, 188, 29, 44, 165, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'cook';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 386, 190, 40, 150, 23, 35, 132, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'cook';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 257, 127, 27, 100, 15, 24, 88, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'cook';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 225, 111, 23, 88, 13, 20, 78, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'cook';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 161, 79, 17, 62, 9, 15, 55, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'cook';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 129, 63, 13, 50, 8, 11, 44, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'cook';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 129, 63, 13, 50, 8, 11, 44, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'cook';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 201, 98, 21, 77, 12, 18, 68, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'dupage';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 161, 79, 17, 62, 9, 15, 55, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'dupage';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 121, 59, 12, 47, 7, 11, 41, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'dupage';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 96, 48, 10, 38, 6, 9, 33, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'dupage';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 64, 32, 7, 25, 4, 6, 22, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'dupage';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 56, 28, 6, 22, 3, 5, 20, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'dupage';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 40, 20, 4, 16, 2, 4, 14, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'dupage';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 32, 16, 3, 13, 2, 3, 11, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'dupage';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 32, 16, 3, 13, 2, 3, 11, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'dupage';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 159, 77, 16, 61, 9, 14, 54, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'lake';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 127, 63, 13, 50, 8, 11, 44, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'lake';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 96, 47, 10, 37, 6, 9, 32, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'lake';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 76, 38, 8, 30, 5, 7, 26, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'lake';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 51, 25, 5, 20, 3, 4, 18, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'lake';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 45, 22, 5, 17, 3, 4, 15, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'lake';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 32, 16, 3, 13, 2, 3, 11, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'lake';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 25, 13, 3, 10, 2, 3, 8, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'lake';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 25, 13, 3, 10, 2, 3, 8, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'lake';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 143, 71, 15, 56, 9, 13, 49, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'will';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 114, 56, 12, 44, 7, 10, 38, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'will';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 86, 42, 9, 33, 5, 8, 29, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'will';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 68, 34, 7, 27, 4, 6, 24, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'will';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 46, 22, 5, 17, 3, 4, 15, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'will';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 40, 20, 4, 16, 2, 4, 14, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'will';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 29, 14, 3, 11, 2, 3, 9, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'will';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 23, 11, 2, 9, 1, 2, 8, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'will';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 23, 11, 2, 9, 1, 2, 8, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'will';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 109, 53, 11, 42, 6, 10, 37, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kane';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 87, 43, 9, 34, 5, 8, 30, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kane';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 65, 32, 7, 25, 4, 6, 22, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kane';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 52, 26, 5, 21, 3, 4, 19, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kane';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 35, 17, 4, 13, 2, 4, 11, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kane';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 31, 15, 3, 12, 2, 3, 10, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kane';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 22, 11, 2, 9, 1, 2, 8, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kane';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 17, 9, 2, 7, 1, 2, 6, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kane';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 17, 9, 2, 7, 1, 2, 6, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kane';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 81, 39, 8, 31, 5, 7, 27, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'mchenry';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 64, 32, 7, 25, 4, 6, 22, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'mchenry';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 48, 24, 5, 19, 3, 4, 17, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'mchenry';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 39, 19, 4, 15, 2, 4, 13, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'mchenry';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 26, 13, 3, 10, 2, 3, 8, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'mchenry';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 23, 11, 2, 9, 1, 2, 8, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'mchenry';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 16, 8, 2, 6, 1, 2, 5, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'mchenry';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 13, 6, 1, 5, 1, 1, 4, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'mchenry';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 13, 6, 1, 5, 1, 1, 4, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'mchenry';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 70, 33, 7, 26, 4, 6, 23, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'winnebago';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 56, 28, 6, 22, 3, 5, 20, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'winnebago';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 42, 21, 4, 17, 3, 3, 15, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'winnebago';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 34, 17, 4, 13, 2, 4, 11, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'winnebago';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 22, 11, 2, 9, 1, 2, 8, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'winnebago';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 20, 10, 2, 8, 1, 2, 7, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'winnebago';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 14, 7, 1, 6, 1, 1, 5, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'winnebago';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 11, 6, 1, 5, 1, 1, 4, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'winnebago';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 11, 6, 1, 5, 1, 1, 4, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'winnebago';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 64, 31, 7, 24, 4, 6, 21, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'peoria';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 51, 25, 5, 20, 3, 4, 18, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'peoria';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 38, 19, 4, 15, 2, 4, 13, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'peoria';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 31, 15, 3, 12, 2, 3, 10, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'peoria';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 20, 10, 2, 8, 1, 2, 7, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'peoria';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 18, 9, 2, 7, 1, 2, 6, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'peoria';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 13, 6, 1, 5, 1, 1, 4, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'peoria';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 10, 5, 1, 4, 1, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'peoria';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 10, 5, 1, 4, 1, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'peoria';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 59, 29, 6, 23, 3, 5, 21, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'sangamon';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 47, 23, 5, 18, 3, 4, 16, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'sangamon';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 35, 17, 4, 13, 2, 4, 11, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'sangamon';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 28, 14, 3, 11, 2, 3, 9, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'sangamon';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 19, 9, 2, 7, 1, 2, 6, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'sangamon';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 16, 8, 2, 6, 1, 2, 5, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'sangamon';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 12, 6, 1, 5, 1, 1, 4, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'sangamon';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 9, 5, 1, 4, 1, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'sangamon';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 9, 5, 1, 4, 1, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'sangamon';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 54, 28, 6, 22, 3, 5, 20, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'mclean';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 43, 21, 4, 17, 3, 3, 15, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'mclean';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 32, 16, 3, 13, 2, 3, 11, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'mclean';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 26, 13, 3, 10, 2, 3, 8, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'mclean';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 17, 8, 2, 6, 1, 2, 5, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'mclean';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 15, 7, 1, 6, 1, 1, 5, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'mclean';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 11, 5, 1, 4, 1, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'mclean';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 9, 4, 1, 3, 0, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'mclean';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 9, 4, 1, 3, 0, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'mclean';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 47, 23, 5, 18, 3, 4, 16, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'st-clair';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 38, 18, 4, 14, 2, 4, 12, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'st-clair';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 28, 14, 3, 11, 2, 3, 9, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'st-clair';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 23, 11, 2, 9, 1, 2, 8, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'st-clair';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 15, 7, 1, 6, 1, 1, 5, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'st-clair';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 13, 6, 1, 5, 1, 1, 4, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'st-clair';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 9, 5, 1, 4, 1, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'st-clair';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 8, 4, 1, 3, 0, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'st-clair';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 8, 4, 1, 3, 0, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'st-clair';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 42, 21, 4, 17, 3, 3, 15, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'madison';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 34, 17, 4, 13, 2, 4, 11, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'madison';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 25, 12, 3, 9, 1, 3, 8, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'madison';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 20, 10, 2, 8, 1, 2, 7, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'madison';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 13, 7, 1, 6, 1, 1, 5, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'madison';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 12, 6, 1, 5, 1, 1, 4, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'madison';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 8, 4, 1, 3, 0, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'madison';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 7, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'madison';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 7, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'madison';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 37, 17, 4, 13, 2, 4, 11, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'rock-island';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 29, 15, 3, 12, 2, 3, 10, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'rock-island';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 22, 11, 2, 9, 1, 2, 8, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'rock-island';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 18, 9, 2, 7, 1, 2, 6, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'rock-island';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 12, 6, 1, 5, 1, 1, 4, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'rock-island';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 10, 5, 1, 4, 1, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'rock-island';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 7, 4, 1, 3, 0, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'rock-island';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 6, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'rock-island';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 6, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'rock-island';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 34, 16, 3, 13, 2, 3, 11, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'tazewell';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 27, 13, 3, 10, 2, 3, 8, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'tazewell';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 20, 10, 2, 8, 1, 2, 7, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'tazewell';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 16, 8, 2, 6, 1, 2, 5, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'tazewell';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 11, 5, 1, 4, 1, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'tazewell';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 9, 5, 1, 4, 1, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'tazewell';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 7, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'tazewell';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'tazewell';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'tazewell';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 32, 15, 3, 12, 2, 3, 10, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'champaign';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 25, 13, 3, 10, 2, 3, 8, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'champaign';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 19, 9, 2, 7, 1, 2, 6, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'champaign';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 15, 8, 2, 6, 1, 2, 5, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'champaign';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 10, 5, 1, 4, 1, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'champaign';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 9, 4, 1, 3, 0, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'champaign';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 6, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'champaign';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'champaign';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'champaign';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 30, 15, 3, 12, 2, 3, 10, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kendall';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 24, 12, 3, 9, 1, 3, 8, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kendall';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 18, 9, 2, 7, 1, 2, 6, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kendall';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 15, 7, 1, 6, 1, 1, 5, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kendall';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 10, 5, 1, 4, 1, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kendall';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 8, 4, 1, 3, 0, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kendall';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 6, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kendall';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 2, 1, 1, 0, 1, 1, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kendall';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 2, 1, 1, 0, 1, 1, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kendall';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 29, 15, 3, 12, 2, 3, 10, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kankakee';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 23, 11, 2, 9, 1, 2, 8, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kankakee';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 17, 8, 2, 6, 1, 2, 5, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kankakee';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 14, 7, 1, 6, 1, 1, 5, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kankakee';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 9, 4, 1, 3, 0, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kankakee';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 8, 4, 1, 3, 0, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kankakee';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 6, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kankakee';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 2, 1, 1, 0, 1, 1, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kankakee';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 2, 1, 1, 0, 1, 1, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'kankakee';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 27, 13, 3, 10, 2, 3, 8, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'lasalle';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 21, 11, 2, 9, 1, 2, 8, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'lasalle';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 16, 8, 2, 6, 1, 2, 5, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'lasalle';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 13, 6, 1, 5, 1, 1, 4, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'lasalle';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 9, 4, 1, 3, 0, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'lasalle';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 7, 4, 1, 3, 0, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'lasalle';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 5, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'lasalle';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 4, 2, 1, 1, 0, 1, 1, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'lasalle';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 4, 2, 1, 1, 0, 1, 1, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'lasalle';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 54, 28, 6, 22, 3, 5, 20, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'dekalb';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 43, 21, 4, 17, 3, 3, 15, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'dekalb';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 32, 16, 3, 13, 2, 3, 11, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'dekalb';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 26, 13, 3, 10, 2, 3, 8, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'dekalb';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 17, 8, 2, 6, 1, 2, 5, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'dekalb';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 15, 7, 1, 6, 1, 1, 5, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'dekalb';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 11, 5, 1, 4, 1, 1, 3, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'dekalb';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 9, 4, 1, 3, 0, 1, 3, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'dekalb';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 9, 4, 1, 3, 0, 1, 3, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'dekalb';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 25, 11, 2, 9, 1, 2, 8, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'boone';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 20, 10, 2, 8, 1, 2, 7, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'boone';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 15, 8, 2, 6, 1, 2, 5, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'boone';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 12, 6, 1, 5, 1, 1, 4, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'boone';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 8, 4, 1, 3, 0, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'boone';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 7, 4, 1, 3, 0, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'boone';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 5, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'boone';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 4, 2, 1, 1, 0, 1, 1, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'boone';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 4, 2, 1, 1, 0, 1, 1, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'boone';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 24, 11, 2, 9, 1, 2, 8, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'whiteside';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 19, 9, 2, 7, 1, 2, 6, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'whiteside';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 14, 7, 1, 6, 1, 1, 5, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'whiteside';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 11, 6, 1, 5, 1, 1, 4, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'whiteside';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 8, 4, 1, 3, 0, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'whiteside';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 7, 3, 1, 2, 0, 1, 2, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'whiteside';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 5, 2, 1, 1, 0, 1, 1, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'whiteside';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 4, 2, 1, 1, 0, 1, 1, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'whiteside';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 4, 2, 1, 1, 0, 1, 1, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'whiteside';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 22, 11, 2, 9, 1, 2, 8, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'vermilion';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 17, 9, 2, 7, 1, 2, 6, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'vermilion';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 13, 6, 1, 5, 1, 1, 4, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'vermilion';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 10, 5, 1, 4, 1, 1, 3, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'vermilion';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 7, 3, 1, 2, 0, 1, 2, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'vermilion';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 6, 3, 1, 2, 0, 1, 2, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'vermilion';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 4, 2, 1, 1, 0, 1, 1, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'vermilion';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 3, 2, 1, 1, 0, 1, 1, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'vermilion';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 3, 2, 1, 1, 0, 1, 1, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'vermilion';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 34, 16, 3, 13, 2, 3, 11, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'macon';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 27, 13, 3, 10, 2, 3, 8, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'macon';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 20, 10, 2, 8, 1, 2, 7, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'macon';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 16, 8, 2, 6, 1, 2, 5, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'macon';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 11, 5, 1, 4, 1, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'macon';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 9, 5, 1, 4, 1, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'macon';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 7, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'macon';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'macon';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'macon';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 20, 9, 2, 7, 1, 2, 6, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'jackson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 16, 8, 2, 6, 1, 2, 5, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'jackson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 12, 6, 1, 5, 1, 1, 4, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'jackson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 10, 5, 1, 4, 1, 1, 3, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'jackson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 6, 3, 1, 2, 0, 1, 2, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'jackson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 6, 3, 1, 2, 0, 1, 2, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'jackson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 4, 2, 1, 1, 0, 1, 1, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'jackson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 3, 2, 1, 1, 0, 1, 1, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'jackson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 3, 2, 1, 1, 0, 1, 1, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'jackson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 19, 10, 2, 8, 1, 2, 7, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'williamson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 15, 7, 1, 6, 1, 1, 5, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'williamson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 11, 5, 1, 4, 1, 1, 3, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'williamson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 9, 4, 1, 3, 0, 1, 3, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'williamson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 6, 3, 1, 2, 0, 1, 2, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'williamson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 5, 3, 1, 2, 0, 1, 2, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'williamson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 4, 2, 1, 1, 0, 1, 1, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'williamson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 3, 1, 1, 0, 0, 1, 0, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'williamson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 3, 1, 1, 0, 0, 1, 0, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'williamson';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 34, 16, 3, 13, 2, 3, 11, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'adams';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 27, 13, 3, 10, 2, 3, 8, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'adams';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 20, 10, 2, 8, 1, 2, 7, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'adams';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 16, 8, 2, 6, 1, 2, 5, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'adams';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 11, 5, 1, 4, 1, 1, 3, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'adams';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 9, 5, 1, 4, 1, 1, 3, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'adams';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 7, 3, 1, 2, 0, 1, 2, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'adams';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 5, 3, 1, 2, 0, 1, 2, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'adams';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 5, 3, 1, 2, 0, 1, 2, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'adams';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 17, 8, 2, 6, 1, 2, 5, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'coles';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 13, 7, 1, 6, 1, 1, 5, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'coles';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 10, 5, 1, 4, 1, 1, 3, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'coles';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 8, 4, 1, 3, 0, 1, 3, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'coles';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 5, 3, 1, 2, 0, 1, 2, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'coles';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 5, 2, 1, 1, 0, 1, 1, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'coles';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 3, 2, 1, 1, 0, 1, 1, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'coles';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 3, 1, 1, 0, 0, 1, 0, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'coles';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 3, 1, 1, 0, 0, 1, 0, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'coles';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 15, 7, 1, 6, 1, 1, 5, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'clinton';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 12, 6, 1, 5, 1, 1, 4, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'clinton';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 9, 5, 1, 4, 1, 1, 3, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'clinton';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 7, 4, 1, 3, 0, 1, 3, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'clinton';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 5, 2, 1, 1, 0, 1, 1, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'clinton';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 4, 2, 1, 1, 0, 1, 1, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'clinton';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 3, 2, 1, 1, 0, 1, 1, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'clinton';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 2, 1, 1, 0, 0, 1, 0, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'clinton';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 2, 1, 1, 0, 0, 1, 0, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'clinton';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 14, 7, 1, 6, 1, 1, 5, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'effingham';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 11, 5, 1, 4, 1, 1, 3, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'effingham';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 8, 4, 1, 3, 0, 1, 3, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'effingham';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 6, 3, 1, 2, 0, 1, 2, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'effingham';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 4, 2, 1, 1, 0, 1, 1, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'effingham';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 4, 2, 1, 1, 0, 1, 1, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'effingham';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 3, 1, 1, 0, 0, 1, 0, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'effingham';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 2, 1, 1, 0, 0, 1, 0, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'effingham';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 2, 1, 1, 0, 0, 1, 0, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'effingham';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'personal-injury', 'Personal Injury', 15, 7, 1, 6, 1, 1, 5, 1, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'henry';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'family-law', 'Family Law', 12, 6, 1, 5, 1, 1, 4, 2, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'henry';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'immigration', 'Immigration', 9, 5, 1, 4, 1, 1, 3, 3, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'henry';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'criminal-defense', 'Criminal Defense', 7, 4, 1, 3, 0, 1, 3, 4, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'henry';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'employment-law', 'Employment Law', 5, 2, 1, 1, 0, 1, 1, 5, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'henry';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'real-estate', 'Real Estate', 4, 2, 1, 1, 0, 1, 1, 7, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'henry';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'bankruptcy', 'Bankruptcy', 3, 2, 1, 1, 0, 1, 1, 6, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'henry';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'estate-planning', 'Estate Planning', 2, 1, 1, 0, 0, 1, 0, 8, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'henry';

INSERT INTO web_availability_practice_area_seats
(county_availability_id, practice_area_slug, practice_area_name, total_firms,
 cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT id, 'workers-comp', 'Workers Compensation', 2, 1, 1, 0, 0, 1, 0, 9, true
FROM web_availability_county WHERE state_code = 'IL' AND county_slug = 'henry';

COMMIT;
