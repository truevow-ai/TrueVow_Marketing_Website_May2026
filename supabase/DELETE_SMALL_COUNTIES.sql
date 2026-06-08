-- Delete counties with < 4 seats from FL and CA
-- This uses a single transaction to ensure both deletions happen

BEGIN;

-- Delete practice area seats first
DELETE FROM web_availability_practice_area_seats
WHERE county_availability_id IN (
    SELECT id FROM web_availability_county
    WHERE state_code IN ('FL', 'CA') AND total_seats < 4
);

-- Delete counties
DELETE FROM web_availability_county
WHERE state_code IN ('FL', 'CA') AND total_seats < 4;

COMMIT;

