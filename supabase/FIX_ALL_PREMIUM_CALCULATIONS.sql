-- Fix All Premium Calculations
-- Generated: 2025-12-02T12:22:11.614Z
-- This script sets premium = ROUND(cap * 0.21) for all practice areas
-- Standard = cap - premium

BEGIN;

-- Fixing personal-injury: cap=40, old_premium=9, new_premium=8
UPDATE web_availability_practice_area_seats
SET 
    premium = 8,
    standard = 32,
    premium_remaining = GREATEST(0, 8 - ROUND(filled * (8::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 32 - ROUND(filled * (32::numeric / NULLIF(cap, 0))))
WHERE id = 'cfcbd697-b11f-4d61-9197-a2485bcdf8e0';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = '2322f049-fc0d-4a42-b00a-25e9143ad3ed';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'f7a8ebca-eda2-46a1-86b0-e1f0d3e3c307';

-- Fixing family-law: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '6c0d0076-b8a2-4781-b41f-a4a913ff392e';

-- Fixing immigration: cap=50, old_premium=10, new_premium=11
UPDATE web_availability_practice_area_seats
SET 
    premium = 11,
    standard = 39,
    premium_remaining = GREATEST(0, 11 - ROUND(filled * (11::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 39 - ROUND(filled * (39::numeric / NULLIF(cap, 0))))
WHERE id = 'edb4dfed-492f-4c40-aa93-65b9e615bc80';

-- Fixing workers-comp: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'd1c2585c-3e9d-49f6-817e-c6d192b529d2';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = 'f762d15f-5563-412d-b508-6f44f24fcd4b';

-- Fixing family-law: cap=26, old_premium=6, new_premium=5
UPDATE web_availability_practice_area_seats
SET 
    premium = 5,
    standard = 21,
    premium_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 21 - ROUND(filled * (21::numeric / NULLIF(cap, 0))))
WHERE id = '3bc024c2-73d0-4281-8b29-4f4c44b63f9f';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '9bdcad59-2ef0-42fa-b6d0-2b70e6e92174';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'd7526b59-8d14-4283-bebf-7c4c0c29dff9';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'f0decd7c-6e34-4737-b9a8-82ee004a2777';

-- Fixing real-estate: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'e0488f86-e7ba-4f16-9631-40d900574fa0';

-- Fixing estate-planning: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '8e74ba8f-dde4-4f33-8107-ddb8a8593b7f';

-- Fixing workers-comp: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '69857100-26bd-4a19-b005-0bbf725754ea';

-- Fixing criminal-defense: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '44d17636-4907-4936-a751-580227f759a5';

-- Fixing personal-injury: cap=8, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 6,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '28731643-accc-4712-af0c-031f839da79c';

-- Fixing personal-injury: cap=48, old_premium=11, new_premium=10
UPDATE web_availability_practice_area_seats
SET 
    premium = 10,
    standard = 38,
    premium_remaining = GREATEST(0, 10 - ROUND(filled * (10::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 38 - ROUND(filled * (38::numeric / NULLIF(cap, 0))))
WHERE id = '6ddd70aa-7270-418e-9a24-6aebb9ff26c8';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = 'ffccebad-7deb-4a00-bea1-f699e8558b3a';

-- Fixing family-law: cap=26, old_premium=6, new_premium=5
UPDATE web_availability_practice_area_seats
SET 
    premium = 5,
    standard = 21,
    premium_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 21 - ROUND(filled * (21::numeric / NULLIF(cap, 0))))
WHERE id = 'c1f5ce64-8855-43be-88cd-17a7c899402a';

-- Fixing workers-comp: cap=7, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '36c81c1c-9242-4ff4-9b28-4d6f0557f121';

-- Fixing criminal-defense: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '1888f66c-0cc7-48e4-893e-a0d5797848f8';

-- Fixing workers-comp: cap=11, old_premium=1, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'f607a13c-86dc-4560-b55c-498fd57d095c';

-- Fixing family-law: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '9d125715-181f-4f7f-8279-d4cc8e713c9a';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = '44c00179-f267-41cd-9237-506eb133decb';

-- Fixing family-law: cap=26, old_premium=6, new_premium=5
UPDATE web_availability_practice_area_seats
SET 
    premium = 5,
    standard = 21,
    premium_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 21 - ROUND(filled * (21::numeric / NULLIF(cap, 0))))
WHERE id = '92ec2060-0e8c-4e55-bf2b-021f73b1cd26';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '92a2734e-ea3a-4a91-bc8f-63e934eb253f';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'a5b37b40-bb8f-44e7-ad9f-922d44de0e78';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '415fea27-0d0a-4c99-b4d8-98fab50a4acf';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '2668f2a9-bd71-480a-9591-963f42252d2c';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'aa955a78-d153-4099-85ec-cc0df564a0ff';

-- Fixing personal-injury: cap=40, old_premium=9, new_premium=8
UPDATE web_availability_practice_area_seats
SET 
    premium = 8,
    standard = 32,
    premium_remaining = GREATEST(0, 8 - ROUND(filled * (8::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 32 - ROUND(filled * (32::numeric / NULLIF(cap, 0))))
WHERE id = '17486c21-b45d-4ffb-85eb-7d5952393280';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = '64c3d0d2-7543-4cde-9e5f-ced30545f070';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '1a05f4df-6578-4bab-9f8d-907fc540d056';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = '960f749d-619e-4d2a-92ed-b6377b10d5ed';

-- Fixing family-law: cap=26, old_premium=6, new_premium=5
UPDATE web_availability_practice_area_seats
SET 
    premium = 5,
    standard = 21,
    premium_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 21 - ROUND(filled * (21::numeric / NULLIF(cap, 0))))
WHERE id = '36454dd5-6c9c-44f3-9c40-079de209df01';

-- Fixing employment-law: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '560be3fc-63e2-47c8-a7d8-66203774a61a';

-- Fixing bankruptcy: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = 'e793fe9a-99d1-4ec8-a105-81b287406c41';

-- Fixing real-estate: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '95bbca6a-21b2-448a-bc90-961498cf5a26';

-- Fixing estate-planning: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = 'f19c8099-d2a1-464c-baad-5a258cf590ee';

-- Fixing workers-comp: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = 'd4312aaa-ad34-45b0-bab1-7d1c252297ec';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '91690e23-52d4-47f3-abac-f8af01570b10';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = '080b2d01-cebe-4ea3-b3c7-7dcf0663e7e7';

-- Fixing family-law: cap=26, old_premium=6, new_premium=5
UPDATE web_availability_practice_area_seats
SET 
    premium = 5,
    standard = 21,
    premium_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 21 - ROUND(filled * (21::numeric / NULLIF(cap, 0))))
WHERE id = 'f48a2feb-94e0-4c92-95dd-6b2c03ed4d11';

-- Fixing criminal-defense: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '4a3feaee-92cb-4258-9679-265a996cd40a';

-- Fixing employment-law: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'f9bdd039-4d96-4537-b2f5-b5a531977943';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '069f642a-a76a-44f8-8710-f865648fcc6c';

-- Fixing real-estate: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '07d4083d-b59d-4594-b8b7-01c1f4d3949d';

-- Fixing estate-planning: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '6e87c341-1d53-4e55-aff1-8e743738013b';

-- Fixing workers-comp: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '79e5f69e-44a9-4982-9988-9211a5490c26';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = 'b6788c73-1a60-4b3c-8b0b-b877d67f9e73';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '233e4506-53b8-4302-a87c-711f30bc5233';

-- Fixing family-law: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '72320560-d65e-41b4-9328-e2f02eb775d6';

-- Fixing personal-injury: cap=40, old_premium=9, new_premium=8
UPDATE web_availability_practice_area_seats
SET 
    premium = 8,
    standard = 32,
    premium_remaining = GREATEST(0, 8 - ROUND(filled * (8::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 32 - ROUND(filled * (32::numeric / NULLIF(cap, 0))))
WHERE id = 'dba0dae1-6e5b-4a6f-afa5-e793b3bfc3b1';

-- Fixing estate-planning: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '77c0d44b-0952-4bc0-b26e-b8be4544dbbb';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'f0774d99-80a6-4e06-96b5-7a357bfd2f8d';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '5cf2553b-db23-4090-8909-0ec77da7616b';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = '2b5c01a1-e5ab-4993-be08-c54ffc129603';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '66294fb6-e85b-4f5e-a161-fd76347f2ff8';

-- Fixing personal-injury: cap=8, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 6,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'c7f3a9c9-9520-4617-81f4-e112172d055b';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'cf252134-ab3c-41a6-b9ee-d0f9dcf2c242';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '227ff87d-3bcc-4efb-b370-1c8b15aa0c8f';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '481e95a3-9435-4fb6-88e4-303d479cebe1';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '76ebc35a-66c3-4c45-9602-2d005bfd443c';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '308b3111-a7e2-4165-bc1f-8e05062722db';

-- Fixing workers-comp: cap=37, old_premium=7, new_premium=8
UPDATE web_availability_practice_area_seats
SET 
    premium = 8,
    standard = 29,
    premium_remaining = GREATEST(0, 8 - ROUND(filled * (8::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 29 - ROUND(filled * (29::numeric / NULLIF(cap, 0))))
WHERE id = 'c342e78b-5093-417d-b450-2e8ebed7994b';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'b0e7b078-f6ea-4191-b393-fb9a8ac816ed';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'dbb43964-eef2-4499-b2c1-82366caa1172';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '3d7e388a-b4f2-4120-9a6f-ffdfceb8d80a';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '8c0ccdf0-daff-4109-981e-afe200cca3e5';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = '6668a0af-45f9-49d8-a21e-7a12c650cefc';

-- Fixing family-law: cap=26, old_premium=6, new_premium=5
UPDATE web_availability_practice_area_seats
SET 
    premium = 5,
    standard = 21,
    premium_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 21 - ROUND(filled * (21::numeric / NULLIF(cap, 0))))
WHERE id = 'b60ba7b5-6fcd-4135-a76e-9d101ffd611a';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'd92f62b7-3673-40e8-9f71-357d79c729c7';

-- Fixing family-law: cap=6, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 5,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0))))
WHERE id = 'ec94d04b-217a-47b1-ab8e-50c98f1affea';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '82ac2fbc-0b18-4831-ae0b-dcd4f7ddb844';

-- Fixing family-law: cap=6, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 5,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0))))
WHERE id = '9cc56c9a-758d-4bc1-a1e2-784aa084ed85';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '07653adc-e725-42d3-905b-60bc0a24de8e';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = 'ec1207b6-dfc8-48bf-bf64-9527cbb48536';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '73ef8c68-7ce9-4591-8a2c-3fbb43e9119f';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '3bf6b836-7566-46b3-a0c1-ef7cd9a53c4c';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'a4778641-d5d9-4b32-8fa6-134faba41ecd';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'df074217-40d4-46d5-a0e7-1f71850a70be';

-- Fixing criminal-defense: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '6b63312d-5bc2-4286-87c9-7642f6b841e2';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '3db6026d-d8a7-4631-a04b-2687d7341345';

-- Fixing estate-planning: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '0dd77555-9887-4700-9b1d-c9ae50fb6056';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'd430f3c4-02e7-4274-a031-6835bdd1ceb6';

-- Fixing personal-injury: cap=8, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 6,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'e1890fc4-2786-4326-9c88-0c34e63c8116';

-- Fixing personal-injury: cap=48, old_premium=11, new_premium=10
UPDATE web_availability_practice_area_seats
SET 
    premium = 10,
    standard = 38,
    premium_remaining = GREATEST(0, 10 - ROUND(filled * (10::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 38 - ROUND(filled * (38::numeric / NULLIF(cap, 0))))
WHERE id = '67aaf9e0-940f-48aa-b198-56fe1f3bf0dc';

-- Fixing workers-comp: cap=119, old_premium=24, new_premium=25
UPDATE web_availability_practice_area_seats
SET 
    premium = 25,
    standard = 94,
    premium_remaining = GREATEST(0, 25 - ROUND(filled * (25::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 94 - ROUND(filled * (94::numeric / NULLIF(cap, 0))))
WHERE id = 'e6f85f18-c4ab-4a04-95a9-d43ec84b1955';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'ae63c3e5-89ff-4c77-a5a7-f9dfb23c47a9';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '9b31b505-3def-4976-ac8b-82a94c30ada0';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '17a0489d-45fc-4ac0-bb34-3ca4be749d1b';

-- Fixing family-law: cap=6, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 5,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0))))
WHERE id = 'b014ad28-8b10-4577-afab-d793fae4c14a';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'd8e21337-3efd-49f1-a742-5f05d65f44a0';

-- Fixing estate-planning: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '96f0bddd-9ec3-4b20-a9eb-c6691dcdb222';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'c2241895-ad0b-4c04-915f-e7f93aa8f6e3';

-- Fixing workers-comp: cap=5, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = '40d1e711-b95a-456a-bc0f-ab952ea3fce4';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '11b5122e-99d5-4550-85fc-c3faa1dabb2b';

-- Fixing real-estate: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '591bfa6c-7a38-4d8c-8836-f76424f96881';

-- Fixing estate-planning: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '4fbf58a6-8623-4dea-b366-36dde1ba2959';

-- Fixing workers-comp: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '8e2cdd04-109b-4b94-ad21-0797c7e5d5f4';

-- Fixing personal-injury: cap=48, old_premium=11, new_premium=10
UPDATE web_availability_practice_area_seats
SET 
    premium = 10,
    standard = 38,
    premium_remaining = GREATEST(0, 10 - ROUND(filled * (10::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 38 - ROUND(filled * (38::numeric / NULLIF(cap, 0))))
WHERE id = 'e786e64d-3e4c-4088-bc1b-114dc303ea24';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = '5b420390-1921-437a-8f6c-2a8207c36005';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '245a405e-9ad1-4706-a3b8-b364be35a594';

-- Fixing personal-injury: cap=15, old_premium=4, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 12,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 12 - ROUND(filled * (12::numeric / NULLIF(cap, 0))))
WHERE id = 'ce5544a5-c5b9-4175-8066-5e9b8109ea22';

-- Fixing family-law: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '1df56e1d-f1c8-4f52-aaf2-4a4c4e99e196';

-- Fixing estate-planning: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '9231e02c-df64-4370-8c4d-ff47a9b7d850';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '1be289fd-cee3-4afb-8ef7-39bced669b84';

-- Fixing personal-injury: cap=48, old_premium=11, new_premium=10
UPDATE web_availability_practice_area_seats
SET 
    premium = 10,
    standard = 38,
    premium_remaining = GREATEST(0, 10 - ROUND(filled * (10::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 38 - ROUND(filled * (38::numeric / NULLIF(cap, 0))))
WHERE id = 'f95d7994-2e78-4638-aa8a-801083c5381c';

-- Fixing personal-injury: cap=8, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 6,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '507b08d2-4bc7-4a2c-bee7-e4fa210f6baa';

-- Fixing employment-law: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'aad0af32-572b-4e3c-a20f-a8034745223a';

-- Fixing bankruptcy: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '875ff8ed-fa43-4aca-86d7-2cd34c5a6bdb';

-- Fixing real-estate: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '91e21c2b-6d13-49b0-a1e9-5e8c1fbbe934';

-- Fixing estate-planning: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = 'cd7e1f1e-7c03-4f80-81f6-a78738b8b3c5';

-- Fixing workers-comp: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '951e2b01-e2f6-419c-a945-0fd612b8cf80';

-- Fixing family-law: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '4edbb125-397f-484c-972f-29da283dcdd1';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = '0cece181-015b-4012-b684-9cc17e7b2641';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '5fc1078e-1f72-43a5-97b4-d62b39f277b3';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = 'f0c660a1-82ce-4e80-83e9-cb419d5f28f7';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'b277984f-509e-4e34-bc79-a4320c0a7fc5';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '1f6858da-f1b7-4e17-a571-b0db8ec1e91a';

-- Fixing family-law: cap=6, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 5,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0))))
WHERE id = '09a992ea-f039-41ec-9e10-d8d85f67a692';

-- Fixing personal-injury: cap=5, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = '20d057c7-bdbe-4649-8b3d-f024e857c264';

-- Fixing workers-comp: cap=5, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = 'b44546de-ccec-43e9-a471-18fae440cbc6';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = 'd0027270-a8af-43c0-a1fb-ed0397e17f06';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '5adbe9ff-88ad-425d-9ce2-f0497d48a2fe';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = 'afc1a97f-d6dc-4f17-9c5c-4e27d2a0e5e0';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'dbb73f41-c4d4-4774-bfa7-308ee8cc5dda';

-- Fixing family-law: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '3d7dc186-b39d-4c91-b23d-48bff102779c';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'db63a2aa-6b6a-4d42-bfa4-18068b463c63';

-- Fixing family-law: cap=6, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 5,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0))))
WHERE id = 'ebea5f8f-b827-4143-bec5-4d3942387013';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '33880db0-62c7-4de0-b196-21d5f5bc465a';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'dad95fa1-b8d3-4ae4-a125-4d1b9f339d6a';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '5baefc66-0872-4898-b031-a2c711fb0450';

-- Fixing workers-comp: cap=5, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = 'ff5ac771-7906-41d5-a7a1-a7e11e9a4502';

-- Fixing employment-law: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'e4aaa3d3-eb0e-490b-8cf5-8d91b03e9be4';

-- Fixing bankruptcy: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '919e6bdc-91ff-4aff-841a-0d4b74fdc3d7';

-- Fixing real-estate: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '7b8184a2-1e3b-4ed7-8b65-0751ea88bee6';

-- Fixing estate-planning: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = 'a0c4ae81-7d11-4cf4-8827-8c70d2d0f690';

-- Fixing workers-comp: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '430233fe-cc58-4aa0-89d7-85e956941664';

-- Fixing workers-comp: cap=18, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 14,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 14 - ROUND(filled * (14::numeric / NULLIF(cap, 0))))
WHERE id = 'e9a24a16-9921-464f-b92e-601a00a3eb88';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '374c513a-29b6-47a0-a223-3c8b8a318c54';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '69cfba34-bf89-41f9-8fd6-1b68dd79a832';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = '585b91da-e5b3-4c27-96f6-aedc6f7044a9';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'b3b42b90-e0d0-4b39-9b51-e8ac5a190a12';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = 'edadc1d0-210b-4163-9521-7c75ac0b147c';

-- Fixing family-law: cap=26, old_premium=6, new_premium=5
UPDATE web_availability_practice_area_seats
SET 
    premium = 5,
    standard = 21,
    premium_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 21 - ROUND(filled * (21::numeric / NULLIF(cap, 0))))
WHERE id = '683ea123-d941-430d-b038-7faa57343cb7';

-- Fixing family-law: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '638f2ba0-1bd0-4ee0-badc-ab5645c3b0eb';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '23c17d04-5cf4-4440-aecd-1dd11910fb07';

-- Fixing immigration: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '01a077a8-6cfc-4384-9f88-ed7b6cc0b086';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '40b6a8cb-874d-4751-a502-24789340527d';

-- Fixing family-law: cap=6, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 5,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0))))
WHERE id = 'ae0b1ce0-9864-4853-b0b6-47b2bc507670';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '8fe71466-2bf2-4ff1-9180-24a1641ef6d6';

-- Fixing personal-injury: cap=5, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = '8206e4e2-9da2-4fc2-bdd8-fbbfca92d8a6';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '4c858681-0912-41c5-a77c-bd7adb7bbd75';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '2f81a57a-4c8f-4e8e-aaaa-1bdedf08cfc9';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '4130f7fd-aa47-4fb8-b215-584416b4c184';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'f432fbed-0dcd-4be9-87c6-9d3d31320aac';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'cf497bf1-b4e5-4003-898d-37b606c73d64';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '5137f6ed-9305-4881-82b2-523160fa85e5';

-- Fixing criminal-defense: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'dfa5bcd9-b10e-44c7-944c-783d82a90091';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'd8047fce-4895-4f22-9552-e232bbdcb834';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'b9c8b601-687a-4a55-92b3-c82385709e74';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = '444871e1-dde6-4f71-ae79-6c70e1ff56e3';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '8b1bc906-3bc5-40ac-a1fa-e24a7dc621aa';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '173f6cf2-bbb9-40ef-88c3-451b5cc6a57f';

-- Fixing workers-comp: cap=4, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 3,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0))))
WHERE id = '0b0b441d-eb0c-4b1a-b1b3-90c5bf68e128';

-- Fixing personal-injury: cap=40, old_premium=9, new_premium=8
UPDATE web_availability_practice_area_seats
SET 
    premium = 8,
    standard = 32,
    premium_remaining = GREATEST(0, 8 - ROUND(filled * (8::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 32 - ROUND(filled * (32::numeric / NULLIF(cap, 0))))
WHERE id = '6c544d32-ee98-4e2e-b2ab-18327fe295bd';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = '0b359037-cb7a-4b80-9c8e-de40b936923d';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '3816b19e-aa7d-49e3-a0d3-0b1c2ab25255';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '171465ab-49d0-43c8-9195-5ec3aa7001cd';

-- Fixing personal-injury: cap=48, old_premium=11, new_premium=10
UPDATE web_availability_practice_area_seats
SET 
    premium = 10,
    standard = 38,
    premium_remaining = GREATEST(0, 10 - ROUND(filled * (10::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 38 - ROUND(filled * (38::numeric / NULLIF(cap, 0))))
WHERE id = '3d756262-8572-48b6-bebc-8d46646d2c1b';

-- Fixing personal-injury: cap=40, old_premium=9, new_premium=8
UPDATE web_availability_practice_area_seats
SET 
    premium = 8,
    standard = 32,
    premium_remaining = GREATEST(0, 8 - ROUND(filled * (8::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 32 - ROUND(filled * (32::numeric / NULLIF(cap, 0))))
WHERE id = '7d9f98df-4b21-4825-86dc-8006026b997d';

-- Fixing family-law: cap=50, old_premium=10, new_premium=11
UPDATE web_availability_practice_area_seats
SET 
    premium = 11,
    standard = 39,
    premium_remaining = GREATEST(0, 11 - ROUND(filled * (11::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 39 - ROUND(filled * (39::numeric / NULLIF(cap, 0))))
WHERE id = '4c499427-9f7f-49e1-93a5-0fe539fe6767';

-- Fixing workers-comp: cap=8, old_premium=1, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 6,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '2337249c-f29e-43d2-afd2-ce1a94d26795';

-- Fixing criminal-defense: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '349da367-c183-48b5-83f6-538c7f2ef718';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '84d14805-6cd0-4040-b5dd-b23af92a2c54';

-- Fixing personal-injury: cap=34, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 27,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 27 - ROUND(filled * (27::numeric / NULLIF(cap, 0))))
WHERE id = '6c3092e7-8a2c-4740-89f9-bdce78fa0fd3';

-- Fixing personal-injury: cap=246, old_premium=53, new_premium=52
UPDATE web_availability_practice_area_seats
SET 
    premium = 52,
    standard = 194,
    premium_remaining = GREATEST(0, 52 - ROUND(filled * (52::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 194 - ROUND(filled * (194::numeric / NULLIF(cap, 0))))
WHERE id = '2125f580-3a93-4bc1-b215-2299e05dad74';

-- Fixing personal-injury: cap=40, old_premium=9, new_premium=8
UPDATE web_availability_practice_area_seats
SET 
    premium = 8,
    standard = 32,
    premium_remaining = GREATEST(0, 8 - ROUND(filled * (8::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 32 - ROUND(filled * (32::numeric / NULLIF(cap, 0))))
WHERE id = '596edde0-2d2a-4972-bda2-6da1a4eb3d9f';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'fdea487f-f75c-42b0-9007-1ee7e81ea193';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'f5bb3557-1dd8-40c4-8f54-e00731a22dff';

-- Fixing criminal-defense: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '7e5fac43-2c7a-47c7-a186-f0d04877f161';

-- Fixing employment-law: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = 'd27940df-8068-4ba6-a945-e50308f06636';

-- Fixing bankruptcy: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '0d0e89bb-8564-4795-bd16-612eb9ba5a92';

-- Fixing real-estate: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '15ec59d8-3a5e-40e0-9ee5-cbc9775c2fce';

-- Fixing estate-planning: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = 'd94e4981-dbb4-45b2-8fc2-1df48701ccd9';

-- Fixing workers-comp: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '482f0d39-43dd-4a26-8abc-a6cd7dfa7fae';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '3c2048b0-f6ce-4207-a2bd-2b6be66b97fb';

-- Fixing family-law: cap=6, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 5,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0))))
WHERE id = '24f3fe02-f240-47b0-94b8-87dc76a3ca6e';

-- Fixing family-law: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '7ff964e0-bf4e-4784-b2ab-5773a3fa8a8c';

-- Fixing personal-injury: cap=21, old_premium=5, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 17,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 17 - ROUND(filled * (17::numeric / NULLIF(cap, 0))))
WHERE id = 'cacb26ca-b43c-40e5-99cb-cc6a9fb7925d';

-- Fixing family-law: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = 'd578450c-f292-4ea0-b022-4524240db763';

-- Fixing immigration: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'f2241c45-9f44-4796-af1f-e4f750eb889a';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'f66ad3ea-54ef-4fc5-a897-dfc67a2bb8b7';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'dedc7891-98e0-48ab-a8c1-350df12ec9bc';

-- Fixing personal-injury: cap=15, old_premium=4, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 12,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 12 - ROUND(filled * (12::numeric / NULLIF(cap, 0))))
WHERE id = 'e198aab1-2cb4-49fe-ad1d-8c0bd751ba46';

-- Fixing family-law: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'c234c7a2-173e-4dd2-8226-d61c8ef43394';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'c5a100ad-12ad-4fba-8714-d0f560617cf0';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'a6dd3292-08c8-4c43-86f0-4b953bca6b28';

-- Fixing personal-injury: cap=90, old_premium=20, new_premium=19
UPDATE web_availability_practice_area_seats
SET 
    premium = 19,
    standard = 71,
    premium_remaining = GREATEST(0, 19 - ROUND(filled * (19::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 71 - ROUND(filled * (71::numeric / NULLIF(cap, 0))))
WHERE id = 'c275792f-8456-45c0-b9b0-34b7e5ac1dbe';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '6be576f6-5287-4af2-b541-5b9c01d2a671';

-- Fixing family-law: cap=6, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 5,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0))))
WHERE id = 'c976a5ee-6935-4a8b-9b4a-df1efe15a138';

-- Fixing workers-comp: cap=4, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 3,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0))))
WHERE id = '8490bdb9-a40b-4b6d-abbf-0a19b4d0a8cb';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '63bafc12-6d45-4993-beed-1ea53b46646b';

-- Fixing personal-injury: cap=40, old_premium=9, new_premium=8
UPDATE web_availability_practice_area_seats
SET 
    premium = 8,
    standard = 32,
    premium_remaining = GREATEST(0, 8 - ROUND(filled * (8::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 32 - ROUND(filled * (32::numeric / NULLIF(cap, 0))))
WHERE id = '5ba0c31d-8f2b-45d9-9280-adc78f3ec04e';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'eec7882d-e63d-4b10-91c8-b6dabfbc3d85';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'c8cfffa6-92b0-4060-a093-e45dbb384877';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '9c22dafc-ef5d-4819-bccc-809034d5d617';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'b12edf58-52bb-464f-9977-7ce4c6a8becf';

-- Fixing criminal-defense: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '815bebc1-fe0b-4ac3-840a-1c0fb57ca9cf';

-- Fixing employment-law: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '274af806-e9ef-4711-b0eb-c47ed62bbe88';

-- Fixing bankruptcy: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '39e8583f-24b4-4efc-b84b-1ab406a2014c';

-- Fixing real-estate: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '21a80c53-cf6c-4cdb-bdb4-b6157890eefb';

-- Fixing estate-planning: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '186bdd8a-3321-41db-bc71-76317458371e';

-- Fixing workers-comp: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = 'c58e3d72-76af-49e0-9544-c408c3448aa3';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = 'b74b11f7-9b3b-4cc1-802a-b877b057af82';

-- Fixing family-law: cap=26, old_premium=6, new_premium=5
UPDATE web_availability_practice_area_seats
SET 
    premium = 5,
    standard = 21,
    premium_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 21 - ROUND(filled * (21::numeric / NULLIF(cap, 0))))
WHERE id = 'c7371f95-da2f-447e-864f-3520d397694b';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'a73cba39-5d58-46bb-9bdd-cd35503b230f';

-- Fixing real-estate: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '20f5262a-6f1a-417d-8553-4aa45037bc04';

-- Fixing estate-planning: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '768e6bcf-0051-4402-a531-d9b570ec0953';

-- Fixing workers-comp: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '43b41321-8077-4641-ba78-5034f7f18d9c';

-- Fixing personal-injury: cap=15, old_premium=4, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 12,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 12 - ROUND(filled * (12::numeric / NULLIF(cap, 0))))
WHERE id = '2c3ce058-c794-4cb4-b219-b927ad29f23d';

-- Fixing family-law: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '7077fc15-b13b-4bba-8a50-827389548407';

-- Fixing employment-law: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '9c2ca90c-2293-4eec-a033-306851bf69f0';

-- Fixing bankruptcy: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '07b1bf62-0adf-41e1-84df-635352c542d5';

-- Fixing real-estate: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '8949c581-c2ef-4b3f-ba43-680ec8697c95';

-- Fixing estate-planning: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = 'e643604e-9eca-47b7-8bec-fa5ecd739969';

-- Fixing workers-comp: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = 'c84f9492-5c52-40a1-9009-8cc926aa2feb';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = '13e0c852-5ce6-41bf-82c3-7eadbd44f1d1';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'a73348a4-c6a7-4c49-b73d-e7b0e6bda466';

-- Fixing personal-injury: cap=123, old_premium=27, new_premium=26
UPDATE web_availability_practice_area_seats
SET 
    premium = 26,
    standard = 97,
    premium_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 97 - ROUND(filled * (97::numeric / NULLIF(cap, 0))))
WHERE id = 'a52d93c6-532d-4f0a-8eed-0f943269e71b';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '72a9ec5b-c8ed-46f7-9e87-f71395440068';

-- Fixing immigration: cap=50, old_premium=10, new_premium=11
UPDATE web_availability_practice_area_seats
SET 
    premium = 11,
    standard = 39,
    premium_remaining = GREATEST(0, 11 - ROUND(filled * (11::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 39 - ROUND(filled * (39::numeric / NULLIF(cap, 0))))
WHERE id = 'a45dbab1-ab28-4460-947d-4fb3122c9ea0';

-- Fixing personal-injury: cap=5, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = 'be2b412f-eb1a-47bd-9d19-41a86fb8d3e8';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '62f9e830-4ec6-42af-8252-c11107116f1e';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '7fc5327d-b70a-4ba9-99e7-3beaa07f0e8d';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'c2e4121f-4c9a-40dd-9c8c-fd0210285ae7';

-- Fixing workers-comp: cap=5, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = '03cbd3bb-63b3-404b-8895-62d9cdbf73a2';

-- Fixing personal-injury: cap=40, old_premium=9, new_premium=8
UPDATE web_availability_practice_area_seats
SET 
    premium = 8,
    standard = 32,
    premium_remaining = GREATEST(0, 8 - ROUND(filled * (8::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 32 - ROUND(filled * (32::numeric / NULLIF(cap, 0))))
WHERE id = '6887fa01-4e35-4d80-a7c9-c0352f60b38a';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '3648b710-c148-41fe-8258-919bc2b445d4';

-- Fixing personal-injury: cap=90, old_premium=20, new_premium=19
UPDATE web_availability_practice_area_seats
SET 
    premium = 19,
    standard = 71,
    premium_remaining = GREATEST(0, 19 - ROUND(filled * (19::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 71 - ROUND(filled * (71::numeric / NULLIF(cap, 0))))
WHERE id = '16681650-15a8-4653-8771-625cfd27b6c0';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '6f6cbb23-c9de-4670-8dae-d48a1798c0ad';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'bbf28842-76aa-4a21-bb0a-b260374328e8';

-- Fixing personal-injury: cap=15, old_premium=4, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 12,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 12 - ROUND(filled * (12::numeric / NULLIF(cap, 0))))
WHERE id = 'c84c5b57-7fe0-4d4e-a9bd-4f6b499f45ee';

-- Fixing family-law: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'df2d1c2d-f6b5-4c45-bd2a-25cc0bb116f5';

-- Fixing personal-injury: cap=21, old_premium=5, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 17,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 17 - ROUND(filled * (17::numeric / NULLIF(cap, 0))))
WHERE id = 'b90aeb87-8df3-4638-916c-6c6f08f73b4d';

-- Fixing family-law: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = '277f46d3-572a-415f-a584-16648ac16e78';

-- Fixing immigration: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '425a146b-7f2f-4568-ae61-cd63b7c47d62';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = '511bfdc4-85e9-48ed-8f41-a4a5fcbb54a7';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '560dd8b2-fecb-4ee6-bdad-2ba4a7dbf380';

-- Fixing personal-injury: cap=21, old_premium=5, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 17,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 17 - ROUND(filled * (17::numeric / NULLIF(cap, 0))))
WHERE id = 'b99718ad-2c23-4373-90a5-dd448393b421';

-- Fixing family-law: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = '4dd7c9a5-7e0e-41ea-a7ae-1e673ad1050a';

-- Fixing immigration: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '93ed174b-4f90-4d32-9189-1cffb8e95c4a';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = '6d002620-a1d1-491e-85f5-276a0c18874f';

-- Fixing estate-planning: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'eba09b8c-6b33-4f13-a293-06ad3f809e5e';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '7e4716bf-1253-45b1-aac5-05d99c968d14';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '4256c692-8d09-448d-84fb-c93bd6e31ea7';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '74150a9b-55c8-4c5d-8b82-b7049dbe3a29';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '60964e1d-68dc-41d6-9c7e-75f6c4cb70bd';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = '490f848a-d5fd-4cae-973d-ff746304ac4a';

-- Fixing family-law: cap=26, old_premium=6, new_premium=5
UPDATE web_availability_practice_area_seats
SET 
    premium = 5,
    standard = 21,
    premium_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 21 - ROUND(filled * (21::numeric / NULLIF(cap, 0))))
WHERE id = '75fa8824-ea41-436e-9d44-a86c816b29dd';

-- Fixing criminal-defense: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '65648e3e-59cf-44c4-bd0e-73c5bd37bd18';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'be9c9d5a-f1bf-4e66-8485-ccfed10a8bb0';

-- Fixing immigration: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '2571f75a-abed-4eed-96d9-059927328288';

-- Fixing employment-law: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'f3dee033-d3f4-4b73-9e89-ae61453dc8f4';

-- Fixing bankruptcy: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '6030508d-6a63-48fb-b9e8-8eda1601fd36';

-- Fixing real-estate: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '3abbfbea-182c-499d-ab57-c1fc7eb36cb8';

-- Fixing estate-planning: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '7b343ddb-d568-48ff-b953-a679d8789253';

-- Fixing workers-comp: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '3ca55fd8-632d-45c2-a135-6f648a490087';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = '9e62437a-531d-48bd-904a-7a0c115c820a';

-- Fixing family-law: cap=26, old_premium=6, new_premium=5
UPDATE web_availability_practice_area_seats
SET 
    premium = 5,
    standard = 21,
    premium_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 21 - ROUND(filled * (21::numeric / NULLIF(cap, 0))))
WHERE id = '4dfd3b32-5e96-4c91-a467-4f9731d3bd48';

-- Fixing family-law: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '7b7e00b8-c1ad-4747-84ce-6cfd71d7bfa5';

-- Fixing personal-injury: cap=40, old_premium=9, new_premium=8
UPDATE web_availability_practice_area_seats
SET 
    premium = 8,
    standard = 32,
    premium_remaining = GREATEST(0, 8 - ROUND(filled * (8::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 32 - ROUND(filled * (32::numeric / NULLIF(cap, 0))))
WHERE id = '9c035ce5-4a56-494f-8c12-4651aef3cfbb';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '3ce18b75-00f6-4ede-96d0-e7167cf38648';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '03a711ee-dc37-4998-b084-3c09550083a7';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'e68fa620-c520-4c71-afe1-f59f0d291d93';

-- Fixing family-law: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '1d2d7f33-c87c-4ab9-89fa-cd818ecbc5d4';

-- Fixing criminal-defense: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'f9a8179b-9d6e-4523-87b3-f2d8c490847d';

-- Fixing employment-law: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'd487b6f1-5dc6-4623-88ad-30e2bb9161da';

-- Fixing bankruptcy: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = 'a08e294c-bcd6-42ad-922e-e8a78315eeab';

-- Fixing real-estate: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '3bc51aaf-5954-4d5f-8881-a37f25c28234';

-- Fixing estate-planning: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = 'abebfeb9-b37d-4c72-a93b-7481d2d80b5e';

-- Fixing workers-comp: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = 'a466a1e7-33a3-4d8c-a0d1-6f53ec454822';

-- Fixing criminal-defense: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'd9ef3c14-c98f-4bf8-a434-17e647f84a78';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = '03098bb9-2a60-4e1b-9ca9-cb1453ee3344';

-- Fixing family-law: cap=26, old_premium=6, new_premium=5
UPDATE web_availability_practice_area_seats
SET 
    premium = 5,
    standard = 21,
    premium_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 21 - ROUND(filled * (21::numeric / NULLIF(cap, 0))))
WHERE id = '17f3c74c-07c5-4a32-89de-33f2fdc4500a';

-- Fixing workers-comp: cap=5, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = 'f4598c9c-9b3d-43c0-a4d7-d8ba4eefeee1';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '8720169e-d4ed-43b3-a884-02c12e84fcfd';

-- Fixing workers-comp: cap=5, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = '31db66dd-0f8c-46f4-8d59-25308ee5ac28';

-- Fixing personal-injury: cap=21, old_premium=5, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 17,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 17 - ROUND(filled * (17::numeric / NULLIF(cap, 0))))
WHERE id = 'f8b34f1d-95c1-4f9a-a176-c742f03218fb';

-- Fixing family-law: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = 'af256acc-a645-46ad-b613-e8ebc2710afd';

-- Fixing immigration: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'c3727f4e-87a3-442a-9b5a-48c888a77f1b';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = '362e8fc1-ab78-4a05-8d93-eff89c58083f';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '19a8b78d-1e0e-44c0-9a6c-c44a9c1fc644';

-- Fixing personal-injury: cap=21, old_premium=5, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 17,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 17 - ROUND(filled * (17::numeric / NULLIF(cap, 0))))
WHERE id = '50c86f92-6cfd-4de5-8691-96cfd01ccbd3';

-- Fixing family-law: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = 'f2b1d96f-9734-4339-8078-cf09a2112314';

-- Fixing immigration: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '86d0cd08-0b0c-47df-9fda-16a6e6b7e388';

-- Fixing personal-injury: cap=40, old_premium=9, new_premium=8
UPDATE web_availability_practice_area_seats
SET 
    premium = 8,
    standard = 32,
    premium_remaining = GREATEST(0, 8 - ROUND(filled * (8::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 32 - ROUND(filled * (32::numeric / NULLIF(cap, 0))))
WHERE id = 'b158878f-8d76-4557-9087-aae47397d0af';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'aba2e7b3-9d45-45d7-8131-8eac935fdfd1';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '0d5f4174-a2be-4896-a68b-27b70ffc6e97';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'bd6de921-b62c-4b2f-bb6e-91473b77ae9a';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '4148edc2-67dd-4953-97d2-5d884eafe1bd';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = 'c00e62c5-438d-40eb-96a4-c60c4cb67282';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '733595a3-2918-4ff4-bf34-020e8eda9e8a';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '67e2a5e1-2f6b-4546-b4e2-4b4d7ae89c5a';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'ac9a73f7-2bd1-4e1e-8b4b-c583aa1f63bb';

-- Fixing criminal-defense: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'e93560c8-c277-4c28-8de5-146ea27d26b7';

-- Fixing workers-comp: cap=5, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = '42ceef90-655c-45a8-8b18-b176c59d2b9b';

-- Fixing criminal-defense: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '3df26efe-c572-4363-9e33-f5aaa1736bc7';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'f1dcc23b-1c30-4b5a-95ca-5844da56089f';

-- Fixing family-law: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '2823e2ee-c488-4bf4-a43d-e4ac6c526ccd';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '24ff3d8a-e06d-42e7-becd-dd5e02f1373c';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '6ea0f74a-3c18-434f-94f6-8b6ae2b2b3a2';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '234ca248-b5c7-4219-ab9d-97ea349cb13f';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '95f13b49-cacd-48a9-824b-6c9069890762';

-- Fixing family-law: cap=6, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 5,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0))))
WHERE id = '2c7d0056-5ab3-4966-a87e-9dbb460e03d0';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = '6e1da037-d791-4a4b-aaa4-039be6e4876b';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'b65ac811-9f1f-4fc9-a11b-9ef03951ace8';

-- Fixing criminal-defense: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'e37d208d-706a-480d-b832-ec79f58a35c9';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '8e2fb69b-4e37-452b-a995-b64ae0a67911';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '1b15f07d-0c62-4cf0-997f-1b0fb7c90fc1';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'eb480887-4298-4e8c-b596-0b29776605dc';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = 'f6765f01-9610-4bff-a444-9813b583abdf';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '04ebbd1f-8458-4537-bc03-03ec75fff9b1';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '9dd3f01d-e2a7-465a-a2ec-5792c1b86317';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'e842181d-0c63-4519-80a8-c145873bf9f2';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '9d29f07b-ac9a-4771-b245-3f05e4a053be';

-- Fixing workers-comp: cap=5, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = '95bbc2d9-4536-4b32-b367-87a4a090cb54';

-- Fixing criminal-defense: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'c322707a-a0ff-4d42-b5bc-200a65158e29';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = '31be45a0-22d6-4c2b-a111-dd8fda2760bb';

-- Fixing family-law: cap=26, old_premium=6, new_premium=5
UPDATE web_availability_practice_area_seats
SET 
    premium = 5,
    standard = 21,
    premium_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 21 - ROUND(filled * (21::numeric / NULLIF(cap, 0))))
WHERE id = '146010f9-af14-4cad-bc0d-08ad46b846aa';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'bf56958b-ef93-42b6-acec-3f144dec5072';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '40c9b0df-820d-4731-af88-426bbf4f29d1';

-- Fixing immigration: cap=50, old_premium=10, new_premium=11
UPDATE web_availability_practice_area_seats
SET 
    premium = 11,
    standard = 39,
    premium_remaining = GREATEST(0, 11 - ROUND(filled * (11::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 39 - ROUND(filled * (39::numeric / NULLIF(cap, 0))))
WHERE id = '9ebb8554-8df5-450f-9ab1-0aee9158736c';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '9a2247cc-db79-4663-bbe9-ca5d58ce59b7';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '3ce35f63-8686-421a-9575-b05785b33b89';

-- Fixing personal-injury: cap=40, old_premium=9, new_premium=8
UPDATE web_availability_practice_area_seats
SET 
    premium = 8,
    standard = 32,
    premium_remaining = GREATEST(0, 8 - ROUND(filled * (8::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 32 - ROUND(filled * (32::numeric / NULLIF(cap, 0))))
WHERE id = '5fe368c3-a7e3-49e4-8257-aa5ed6160540';

-- Fixing workers-comp: cap=5, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = '12af4933-3d40-4cd4-ac5a-5b47ecc4e438';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '664299c5-2f30-4ec5-bfb9-b6521f712e58';

-- Fixing family-law: cap=6, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 5,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0))))
WHERE id = 'db336721-63ab-4e22-8d57-7a034a9ba912';

-- Fixing criminal-defense: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'e75379eb-555d-4fde-989e-49e408239599';

-- Fixing criminal-defense: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'd4d38b00-4352-41bc-9c81-df931667bd5b';

-- Fixing personal-injury: cap=8, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 6,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'a240822d-577c-437f-9fcf-4a1fb3b43ffe';

-- Fixing personal-injury: cap=40, old_premium=9, new_premium=8
UPDATE web_availability_practice_area_seats
SET 
    premium = 8,
    standard = 32,
    premium_remaining = GREATEST(0, 8 - ROUND(filled * (8::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 32 - ROUND(filled * (32::numeric / NULLIF(cap, 0))))
WHERE id = '252f91d9-525a-42be-9227-5fefb1a8b1b2';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '05e71823-d55c-4b68-8725-e9a909f9b94f';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = 'b7a3d104-2076-461b-9faf-d9f110227a0f';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'ec4caf9b-bb75-4883-88d4-f146ac8a510c';

-- Fixing family-law: cap=6, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 5,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0))))
WHERE id = 'b9870906-4218-4fa8-be09-6fe242afc1a8';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = '25a82184-8b18-4005-86cd-3b2003813c4d';

-- Fixing family-law: cap=26, old_premium=6, new_premium=5
UPDATE web_availability_practice_area_seats
SET 
    premium = 5,
    standard = 21,
    premium_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 21 - ROUND(filled * (21::numeric / NULLIF(cap, 0))))
WHERE id = 'd0d0dfcd-aca6-4163-9a0b-eec4b83adec7';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = '0f8a6349-7d4b-46da-916a-9f272706f0b9';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '5dfe771d-66d7-462d-959a-b081d1772418';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '744bab5e-fdc9-4890-91e5-1682e934dfbd';

-- Fixing immigration: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '9628d70f-bdd7-4e64-b276-3147cd964479';

-- Fixing family-law: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '8d095194-b07e-459c-bb66-e232418e6980';

-- Fixing estate-planning: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '8e5a83c5-295a-40bc-910b-d074aab35bad';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'b94b1a90-7fb2-41d3-bb38-e22fdf34f29d';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = 'aafab4cf-889a-4a97-9eaa-b6351d9f5631';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '81484f86-9e5a-43e9-b405-db442d60495c';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = '87ce7905-b4e7-4862-a7e4-d159535820c4';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '7c581882-12ec-4e14-845a-ad837bd9c669';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'c1528aef-9116-47f2-af0e-c4974de5b741';

-- Fixing personal-injury: cap=133, old_premium=29, new_premium=28
UPDATE web_availability_practice_area_seats
SET 
    premium = 28,
    standard = 105,
    premium_remaining = GREATEST(0, 28 - ROUND(filled * (28::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 105 - ROUND(filled * (105::numeric / NULLIF(cap, 0))))
WHERE id = '7fc91ab7-b034-4199-b3e0-3a03f5930095';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '7ac0bc54-59d8-4dff-bb03-252cee7f2ef7';

-- Fixing family-law: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'db717258-704f-46eb-b591-b1eee6df4b39';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = 'b3772799-1cb2-4fdb-87d7-70a3ff17c313';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'a8ecb31f-9087-45ce-b430-1b15d7e8b50b';

-- Fixing workers-comp: cap=5, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = '5e92e8ad-6aee-4cfe-bf4a-b9b68e6a2972';

-- Fixing estate-planning: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '83306758-ecbd-4169-80d1-2bd1f0ad6d05';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'f2cc5a72-2402-4799-a30b-13c0d5ec5662';

-- Fixing criminal-defense: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'a864e2f4-9cda-4110-9f70-373d17606197';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '601c343f-340d-4b1a-b55f-4d287ff76f9f';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'bc697570-ddb3-4160-b89f-6aed2275eebb';

-- Fixing family-law: cap=6, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 5,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0))))
WHERE id = '334cc038-ffca-4398-a9d7-5f9eae02889c';

-- Fixing criminal-defense: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'e0dbebf9-f3a7-42ea-8cf4-cbaa491ea3a4';

-- Fixing employment-law: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '43aafb2d-f59c-47b2-a832-896f1466d103';

-- Fixing bankruptcy: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '00922aee-5bb9-4c98-9445-8b2c331dc173';

-- Fixing real-estate: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '22129688-2a47-4fc6-b962-b82b7725735d';

-- Fixing estate-planning: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '154ae707-245c-49df-abe9-799cea735fc9';

-- Fixing workers-comp: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '0409ef0e-c066-4d99-b719-c0d6ebeb7257';

-- Fixing personal-injury: cap=21, old_premium=5, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 17,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 17 - ROUND(filled * (17::numeric / NULLIF(cap, 0))))
WHERE id = 'a6ad3ac9-6b72-4b61-a70e-0b9a05efbe37';

-- Fixing family-law: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = '0caabe29-0d5c-4213-8b7c-9758bc22cb6c';

-- Fixing immigration: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '2f57d34d-b95b-4842-bfd1-1021c92fa9ca';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'b07c7954-5c9a-40f9-9aab-8d869649b60d';

-- Fixing family-law: cap=6, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 5,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0))))
WHERE id = '6c7195d8-6f8b-4c96-8857-e2530536d9a7';

-- Fixing personal-injury: cap=8, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 6,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'b2993b43-9321-4e4f-9e08-fbdc6a03960c';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '62834e52-2cfd-4971-bb38-68eb9c9c4037';

-- Fixing immigration: cap=50, old_premium=10, new_premium=11
UPDATE web_availability_practice_area_seats
SET 
    premium = 11,
    standard = 39,
    premium_remaining = GREATEST(0, 11 - ROUND(filled * (11::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 39 - ROUND(filled * (39::numeric / NULLIF(cap, 0))))
WHERE id = 'b3671d86-9033-4326-89d9-85c0a8c98660';

-- Fixing workers-comp: cap=5, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = '39e63755-cf0a-4903-a1fc-523427efc1ef';

-- Fixing personal-injury: cap=15, old_premium=4, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 12,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 12 - ROUND(filled * (12::numeric / NULLIF(cap, 0))))
WHERE id = '1737cb6a-eb7b-4b97-8c4a-5b1016149782';

-- Fixing family-law: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'cbda976a-8e67-4fb0-bbc6-97e4633eca78';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '81ef8eee-a83c-48ac-abaf-3d84d7593d1e';

-- Fixing family-law: cap=6, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 5,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0))))
WHERE id = 'ed6360ea-1583-4b29-9c27-200ab30506f8';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'e40902df-223d-48a2-bbe8-aedb3203ed8a';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'b316e2a4-ea39-43ed-a84e-acc108387dfa';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '01b86cf2-1e94-4587-8138-f831f539ad86';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '3c0d267d-08a0-4c4b-8883-79faf5f75466';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '283131f3-9393-4b7b-bff2-3d721b10124f';

-- Fixing personal-injury: cap=48, old_premium=11, new_premium=10
UPDATE web_availability_practice_area_seats
SET 
    premium = 10,
    standard = 38,
    premium_remaining = GREATEST(0, 10 - ROUND(filled * (10::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 38 - ROUND(filled * (38::numeric / NULLIF(cap, 0))))
WHERE id = '87b9e462-b9ef-4617-a178-5b4b2cbe15a5';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'd86cc3ad-3e47-4102-9501-c5ee1bb8adc4';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '4b8338f4-d35f-4c98-b942-a479f4d4be5a';

-- Fixing criminal-defense: cap=12, old_premium=2, new_premium=3
UPDATE web_availability_practice_area_seats
SET 
    premium = 3,
    standard = 9,
    premium_remaining = GREATEST(0, 3 - ROUND(filled * (3::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'fd95fb87-8a6c-4659-a48e-c02aa18a0318';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = 'e8f7378b-a4f0-4007-8b8b-5ceec631b5bb';

-- Fixing family-law: cap=26, old_premium=6, new_premium=5
UPDATE web_availability_practice_area_seats
SET 
    premium = 5,
    standard = 21,
    premium_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 21 - ROUND(filled * (21::numeric / NULLIF(cap, 0))))
WHERE id = 'e215cf6e-ca22-4e2d-a8d6-801231b974b7';

-- Fixing employment-law: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '10df3d2e-e09f-4786-a805-4b6c422eb672';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '43ad4b35-f70c-4631-9ab9-327f6f67a403';

-- Fixing real-estate: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'c8b04ad2-8821-451f-bcf1-c08d931a9309';

-- Fixing estate-planning: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '14b011da-4532-48c6-86cb-2a7cb9b226f7';

-- Fixing workers-comp: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = 'b24f0095-23da-480a-a9a2-a64e9b0a2773';

-- Fixing personal-injury: cap=48, old_premium=11, new_premium=10
UPDATE web_availability_practice_area_seats
SET 
    premium = 10,
    standard = 38,
    premium_remaining = GREATEST(0, 10 - ROUND(filled * (10::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 38 - ROUND(filled * (38::numeric / NULLIF(cap, 0))))
WHERE id = '6233e537-81ed-44cb-8be6-cca949a97511';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '2c49413d-c094-4e7a-afeb-536bb1fa4b63';

-- Fixing immigration: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'a2558883-6674-4b84-bbc1-5357863352a4';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = 'dacf0fa2-1360-4e59-94aa-77c3415978fe';

-- Fixing family-law: cap=26, old_premium=6, new_premium=5
UPDATE web_availability_practice_area_seats
SET 
    premium = 5,
    standard = 21,
    premium_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 21 - ROUND(filled * (21::numeric / NULLIF(cap, 0))))
WHERE id = 'd8ab772a-008a-4de1-8430-2c9b7580b798';

-- Fixing criminal-defense: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '47ac9e05-6c40-489f-a6b2-d65e3b7d747d';

-- Fixing employment-law: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '1a45bc92-9580-417b-94bc-c526609c9b26';

-- Fixing bankruptcy: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = 'a6f9c4ec-c257-4d35-a751-12070341f78d';

-- Fixing real-estate: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = 'd7ab082f-e9c6-4e42-ae06-8aba598ae937';

-- Fixing estate-planning: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '5606c69c-cbb1-4a3f-b475-7d8f02783f5e';

-- Fixing workers-comp: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = 'ff0be045-7dbd-4b9b-bccd-494878e58080';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'd48dd98a-ac7b-4e76-8ef6-1e2c814a5c30';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '54831074-3436-46b8-bacd-5615bebc9668';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '06160d70-9b10-4f29-a234-6412d60de3ed';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '20592b96-2a60-4262-bc09-0e4b3e24b6d1';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '7435a544-7f06-45b9-b9dd-21221f08587b';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '26937e8a-0f19-4156-af11-40e682ef73fa';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '30147ff3-ff0b-4b16-9dde-cbdad7c48c43';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '220335c9-f29c-48f6-a59f-92696a420788';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '77837b15-4e90-4a8c-b44d-bef517ffd911';

-- Fixing personal-injury: cap=90, old_premium=20, new_premium=19
UPDATE web_availability_practice_area_seats
SET 
    premium = 19,
    standard = 71,
    premium_remaining = GREATEST(0, 19 - ROUND(filled * (19::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 71 - ROUND(filled * (71::numeric / NULLIF(cap, 0))))
WHERE id = 'b85aeaf1-cbcc-4fd6-a50e-c1e97e68446a';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '0b454ebf-42fd-4024-8a03-c5c89ca7b38f';

-- Fixing workers-comp: cap=18, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 14,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 14 - ROUND(filled * (14::numeric / NULLIF(cap, 0))))
WHERE id = '1bc26bbd-e6aa-42fd-aff1-4207914ab6c3';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '59093792-6fcd-461b-8049-4af888c7246d';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'ea8a31cf-76ff-4a88-afb2-6a77689f45ed';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'e955d6b0-f184-4bea-a877-98d491ce3c9e';

-- Fixing personal-injury: cap=5, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = '2cf7a5d0-c107-4857-a50b-98b5c8a27be7';

-- Fixing personal-injury: cap=5, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = '37c771cf-653b-43a3-b3f6-2070e9f268c4';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '2960203f-5cac-439a-a1c8-f9a6eda11958';

-- Fixing workers-comp: cap=5, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = '8203597c-3e2c-47a2-825a-aa921ad562be';

-- Fixing family-law: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'dbf7b0da-52ea-458b-bfe4-b61164baae06';

-- Fixing personal-injury: cap=48, old_premium=11, new_premium=10
UPDATE web_availability_practice_area_seats
SET 
    premium = 10,
    standard = 38,
    premium_remaining = GREATEST(0, 10 - ROUND(filled * (10::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 38 - ROUND(filled * (38::numeric / NULLIF(cap, 0))))
WHERE id = '9bfc5d72-b976-4941-8ef4-7effb35cfe3e';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '0dd75c28-2e61-40f4-9989-9ad48c47e0b5';

-- Fixing workers-comp: cap=5, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = '0962afd3-f35b-4d18-a7d1-f07c026a3e26';

-- Fixing personal-injury: cap=48, old_premium=11, new_premium=10
UPDATE web_availability_practice_area_seats
SET 
    premium = 10,
    standard = 38,
    premium_remaining = GREATEST(0, 10 - ROUND(filled * (10::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 38 - ROUND(filled * (38::numeric / NULLIF(cap, 0))))
WHERE id = 'a1f155f7-5f58-46dc-8165-15aead6dc6e0';

-- Fixing personal-injury: cap=48, old_premium=11, new_premium=10
UPDATE web_availability_practice_area_seats
SET 
    premium = 10,
    standard = 38,
    premium_remaining = GREATEST(0, 10 - ROUND(filled * (10::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 38 - ROUND(filled * (38::numeric / NULLIF(cap, 0))))
WHERE id = '309f58ce-2cd3-4cf7-81ff-de679c9546f6';

-- Fixing workers-comp: cap=5, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = 'b0dd550b-0485-4dd9-9bca-5045f1ccfc9e';

-- Fixing workers-comp: cap=37, old_premium=7, new_premium=8
UPDATE web_availability_practice_area_seats
SET 
    premium = 8,
    standard = 29,
    premium_remaining = GREATEST(0, 8 - ROUND(filled * (8::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 29 - ROUND(filled * (29::numeric / NULLIF(cap, 0))))
WHERE id = '3481ef20-ffc5-46c6-aeb9-4c5711e8e9aa';

-- Fixing family-law: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'd5f18e6d-b44b-40ce-826b-394b9c3c17ba';

-- Fixing personal-injury: cap=8, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 6,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '9fa7e040-2cab-4581-ab70-edc95296db92';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = '13ac0f71-3288-4342-a05c-b8a8bb8ae700';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '2d4919ea-7eac-4c7b-ae7e-2282cdac6460';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = '50d75557-3e68-4c23-8046-b6aa131d5431';

-- Fixing family-law: cap=26, old_premium=6, new_premium=5
UPDATE web_availability_practice_area_seats
SET 
    premium = 5,
    standard = 21,
    premium_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 21 - ROUND(filled * (21::numeric / NULLIF(cap, 0))))
WHERE id = '25f1efd2-d63f-4120-98a6-d7849f5766fd';

-- Fixing personal-injury: cap=5, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = '685d0690-841d-4a38-9cd3-05a237e35996';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '4a84b45e-dc55-4b04-80b9-6c3e48548bdd';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '3d7a89d4-5271-4b17-9650-6b7e037aec91';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'f5106963-26e3-4d89-8718-00292a4ded4c';

-- Fixing personal-injury: cap=8, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 6,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'e715046e-3300-4051-8b2f-e900184b6c9c';

-- Fixing family-law: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '4edefe0f-171c-450b-8f30-a9bd1c8d097c';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '4d227903-0798-47fc-8fb8-8cc485b1d215';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'ba84d39e-45e3-4851-bdfb-f42ce81c07fd';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '4c2bdece-7932-49c7-9efa-d51faf2c7ce0';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '0df6537c-ccd2-4f5f-a9aa-f9e081498361';

-- Fixing estate-planning: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '79f3efd0-95bc-4e53-b648-8a24f9d2395a';

-- Fixing workers-comp: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = 'a9a346f2-1c50-4d7a-bc81-88aa08d136d0';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'afa0cb75-2d5b-4a9c-8a6e-3acfb7f71c6f';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'aadfcaeb-8aeb-4fb9-a75e-1bce0bbfa50b';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '9e08a799-b117-4a37-8e4c-d574a884b1fc';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'e822c8fc-d332-4d24-a98e-0db5f5e4c6aa';

-- Fixing workers-comp: cap=5, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = '49b27dc4-83c0-459e-afdb-7b12a059f381';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '8e42dccc-2aac-495c-b897-52e075b31e6a';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'ee074f0b-503e-4721-80e4-9de5fd3a5bf9';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '0476a003-f303-4b14-b77a-9881a223badc';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = 'e3c95d6a-0e50-4d71-beae-b8c84294a1c2';

-- Fixing family-law: cap=26, old_premium=6, new_premium=5
UPDATE web_availability_practice_area_seats
SET 
    premium = 5,
    standard = 21,
    premium_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 21 - ROUND(filled * (21::numeric / NULLIF(cap, 0))))
WHERE id = '2706366b-1074-46cf-894e-6f399f6fc09e';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'c83dcc25-8610-4dd0-b3e1-13e541ea2f63';

-- Fixing workers-comp: cap=33, old_premium=6, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = 'bba6c09b-5757-4511-935d-1f43315f92d4';

-- Fixing personal-injury: cap=5, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = '73fa8adc-a4cc-4f72-b92c-f1ae04c16e2f';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '3dbfae2b-21e9-4ed2-895b-54ca41509a61';

-- Fixing estate-planning: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'a5930bcc-40df-4548-92bd-ff90e5781a26';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'a3395aa1-0416-4155-b559-7225d0b7cb0a';

-- Fixing personal-injury: cap=5, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = '09059a2a-9adf-40c1-a97e-81516f2ef774';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = '0b95977d-8467-4011-a334-1444dafbd26d';

-- Fixing family-law: cap=26, old_premium=6, new_premium=5
UPDATE web_availability_practice_area_seats
SET 
    premium = 5,
    standard = 21,
    premium_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 21 - ROUND(filled * (21::numeric / NULLIF(cap, 0))))
WHERE id = '28418534-be23-4f8b-ba36-f69323969245';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '413e6c4e-4fdc-4500-bc42-dff6be19fa29';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '7936f871-6a0e-4724-9d11-57dca50ab5f3';

-- Fixing immigration: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'f597fb4d-4ff2-463c-bb96-baea63fe8f5a';

-- Fixing estate-planning: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '3ef8f127-ad8e-4ed8-b7a3-832325243ff7';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'cac79a02-6694-44b9-9f24-ce02a528df04';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '72e6ea93-eed4-475c-a84e-0607399dbc6f';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'ccf5da95-5c0a-4a6f-adfa-a7a38283e5de';

-- Fixing family-law: cap=6, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 5,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0))))
WHERE id = '570ad679-9f38-40ae-b130-1e9bf1025706';

-- Fixing personal-injury: cap=17, old_premium=3, new_premium=4
UPDATE web_availability_practice_area_seats
SET 
    premium = 4,
    standard = 13,
    premium_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 13 - ROUND(filled * (13::numeric / NULLIF(cap, 0))))
WHERE id = '9e237ad2-2a5e-4e72-8bb3-1ce268760bca';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'bd396146-ca3b-4026-b3c5-c3844105f7c8';

-- Fixing personal-injury: cap=8, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 6,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'c91dd130-9149-401f-82ae-05149fd55306';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '53e012e9-92c8-4d6d-96b5-e87152504b7b';

-- Fixing real-estate: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '8a353dde-5f42-44ba-b1e7-605a529116ef';

-- Fixing estate-planning: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = 'd6649672-a7a0-461d-adcb-2379072a2e38';

-- Fixing workers-comp: cap=1, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 1,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0))))
WHERE id = '764dbb4f-16f5-40e7-bcc4-84e700bf6821';

-- Fixing workers-comp: cap=5, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = '1f6cdccc-5137-4371-b6b9-e21300bc0c27';

-- Fixing workers-comp: cap=3, old_premium=0, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 2,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'd17b0db7-6191-4bfd-bfb5-e18471da30ee';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = 'bc9740df-1fc3-499e-a666-8d5ff995397f';

-- Fixing family-law: cap=26, old_premium=6, new_premium=5
UPDATE web_availability_practice_area_seats
SET 
    premium = 5,
    standard = 21,
    premium_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 21 - ROUND(filled * (21::numeric / NULLIF(cap, 0))))
WHERE id = '012d6cea-66f2-472b-9d43-3bf6d688c991';

-- Fixing personal-injury: cap=5, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 4,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 4 - ROUND(filled * (4::numeric / NULLIF(cap, 0))))
WHERE id = 'c6fe8e44-1e17-4188-9279-1a001b48d656';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = '4418bdd1-ea8a-46f2-bc50-23b3409bf0c0';

-- Fixing personal-injury: cap=90, old_premium=20, new_premium=19
UPDATE web_availability_practice_area_seats
SET 
    premium = 19,
    standard = 71,
    premium_remaining = GREATEST(0, 19 - ROUND(filled * (19::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 71 - ROUND(filled * (71::numeric / NULLIF(cap, 0))))
WHERE id = '16dcc849-9d66-45cb-9b27-3a22a326d0ca';

-- Fixing bankruptcy: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = 'd62e3b21-f50d-47de-9dee-263e19a70df8';

-- Fixing estate-planning: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '0e9ab8a8-a0a4-4122-8e51-97542142130c';

-- Fixing workers-comp: cap=2, old_premium=1, new_premium=0
UPDATE web_availability_practice_area_seats
SET 
    premium = 0,
    standard = 2,
    premium_remaining = GREATEST(0, 0 - ROUND(filled * (0::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0))))
WHERE id = '2c3d830e-2847-44ea-93d7-d00ca5c77bbd';

-- Fixing personal-injury: cap=33, old_premium=8, new_premium=7
UPDATE web_availability_practice_area_seats
SET 
    premium = 7,
    standard = 26,
    premium_remaining = GREATEST(0, 7 - ROUND(filled * (7::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 26 - ROUND(filled * (26::numeric / NULLIF(cap, 0))))
WHERE id = '76065783-a8a9-4464-8069-9bcf65de1afa';

-- Fixing family-law: cap=26, old_premium=6, new_premium=5
UPDATE web_availability_practice_area_seats
SET 
    premium = 5,
    standard = 21,
    premium_remaining = GREATEST(0, 5 - ROUND(filled * (5::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 21 - ROUND(filled * (21::numeric / NULLIF(cap, 0))))
WHERE id = '94df9e9d-ce7e-4dcb-9a8d-4be536eec5d1';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = '20a9ed8c-f307-4b0d-b7fb-065ecb8d1e18';

-- Fixing personal-injury: cap=8, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 6,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'fe473e32-4fad-403e-b1bd-2f847186ed8c';

-- Fixing personal-injury: cap=7, old_premium=2, new_premium=1
UPDATE web_availability_practice_area_seats
SET 
    premium = 1,
    standard = 6,
    premium_remaining = GREATEST(0, 1 - ROUND(filled * (1::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 6 - ROUND(filled * (6::numeric / NULLIF(cap, 0))))
WHERE id = 'c4825cee-04da-4f4e-acf6-a92b32ed7175';

-- Fixing personal-injury: cap=11, old_premium=3, new_premium=2
UPDATE web_availability_practice_area_seats
SET 
    premium = 2,
    standard = 9,
    premium_remaining = GREATEST(0, 2 - ROUND(filled * (2::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, 9 - ROUND(filled * (9::numeric / NULLIF(cap, 0))))
WHERE id = 'd91cb96a-0b5d-4b3f-bd9f-57051811edf9';

COMMIT;

-- Summary: Updated 515 practice area records
