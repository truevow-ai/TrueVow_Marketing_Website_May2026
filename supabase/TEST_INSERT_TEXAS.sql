-- Test insert one Texas county
INSERT INTO web_availability_county 
    (state_code, county_slug, county_name, total_firms, total_seats, 
     premium_total, standard_total, filled, premium_remaining, standard_remaining, is_active)
VALUES 
    ('TX', 'harris', 'Harris', 3200, 1056, 222, 834, 127, 195, 707, true)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    is_active = EXCLUDED.is_active;

-- Verify
SELECT COUNT(*) as count FROM web_availability_county WHERE state_code = 'TX';

