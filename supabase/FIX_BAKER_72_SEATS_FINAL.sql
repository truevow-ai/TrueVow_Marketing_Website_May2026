-- CRITICAL FIX: Baker County showing 72 seats instead of 2
-- Baker has 8 firms, so 33% cap = 2.64, rounded to 3, but we'll use 2 to be conservative

-- Step 1: Update county table
UPDATE web_availability_county
SET 
    total_seats = 2,
    premium_total = 1,
    standard_total = 1,
    premium_remaining = 1,
    standard_remaining = 1,
    updated_at = NOW()
WHERE state_code = 'FL' AND county_slug = 'baker';

-- Step 2: Update all practice area seats for Baker County
-- Each practice area should have cap = 1, premium = 1, standard = 0
UPDATE web_availability_practice_area_seats
SET 
    cap = 1,
    premium = 1,
    standard = 0,
    premium_remaining = 1,
    standard_remaining = 0,
    updated_at = NOW()
WHERE county_availability_id IN (
    SELECT id FROM web_availability_county 
    WHERE state_code = 'FL' AND county_slug = 'baker'
);

-- Step 3: Verify the fix
SELECT 
    county_name,
    total_firms,
    total_seats,
    premium_total,
    standard_total,
    premium_remaining,
    standard_remaining
FROM web_availability_county 
WHERE state_code = 'FL' AND county_slug = 'baker';

-- Step 4: Verify practice area seats
SELECT 
    practice_area_slug,
    cap,
    premium,
    standard,
    premium_remaining,
    standard_remaining
FROM web_availability_practice_area_seats
WHERE county_availability_id IN (
    SELECT id FROM web_availability_county 
    WHERE state_code = 'FL' AND county_slug = 'baker'
)
ORDER BY display_order;

