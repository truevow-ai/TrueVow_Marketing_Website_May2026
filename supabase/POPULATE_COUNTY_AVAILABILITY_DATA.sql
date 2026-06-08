-- ============================================
-- Populate County Availability Tables
-- Generated from marketing/county-cap.html
-- ============================================

BEGIN;

-- Insert Counties
INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'miami-dade', 'Miami Dade',
    5200, 1716,
    360, 1356,
    206, 316,
    1193, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'broward', 'Broward',
    1820, 600,
    126, 474,
    73, 110,
    417, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'palm-beach', 'Palm Beach',
    1404, 462,
    99, 363,
    55, 88,
    319, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'hillsborough', 'Hillsborough',
    1012, 333,
    70, 263,
    41, 62,
    231, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'orange', 'Orange',
    1905, 629,
    133, 496,
    82, 115,
    432, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'duval', 'Duval',
    657, 217,
    45, 172,
    25, 41,
    151, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'pinellas', 'Pinellas',
    586, 195,
    41, 154,
    24, 37,
    134, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'lee', 'Lee',
    436, 149,
    33, 116,
    17, 31,
    101, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'polk', 'Polk',
    389, 136,
    29, 107,
    16, 27,
    92, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'brevard', 'Brevard',
    348, 124,
    28, 96,
    15, 26,
    83, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'volusia', 'Volusia',
    322, 117,
    25, 92,
    15, 24,
    79, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'seminole', 'Seminole',
    302, 112,
    25, 87,
    13, 24,
    76, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'sarasota', 'Sarasota',
    281, 106,
    24, 82,
    13, 23,
    71, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'manatee', 'Manatee',
    255, 101,
    23, 78,
    13, 23,
    67, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'collier', 'Collier',
    241, 98,
    22, 76,
    11, 22,
    65, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'pasco', 'Pasco',
    228, 94,
    21, 73,
    11, 21,
    63, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'osceola', 'Osceola',
    214, 92,
    21, 71,
    11, 21,
    61, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'escambia', 'Escambia',
    208, 89,
    21, 68,
    11, 21,
    58, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'marion', 'Marion',
    194, 87,
    20, 67,
    11, 20,
    57, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'leon', 'Leon',
    188, 86,
    20, 66,
    11, 20,
    56, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'alachua', 'Alachua',
    181, 84,
    20, 64,
    10, 20,
    55, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'st-lucie', 'St Lucie',
    174, 84,
    20, 64,
    10, 20,
    55, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'indian-river', 'Indian River',
    168, 81,
    19, 62,
    10, 19,
    53, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'okaloosa', 'Okaloosa',
    161, 80,
    19, 61,
    10, 19,
    52, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'lake', 'Lake',
    68, 24,
    6, 18,
    4, 5,
    15, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'bay', 'Bay',
    147, 78,
    19, 59,
    9, 19,
    50, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'santa-rosa', 'Santa Rosa',
    141, 77,
    19, 58,
    9, 19,
    49, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'clay', 'Clay',
    134, 76,
    18, 58,
    9, 18,
    49, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'citrus', 'Citrus',
    127, 75,
    18, 57,
    9, 18,
    48, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'hernando', 'Hernando',
    121, 74,
    18, 56,
    9, 18,
    47, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'martin', 'Martin',
    114, 73,
    18, 55,
    9, 18,
    46, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'charlotte', 'Charlotte',
    107, 73,
    18, 55,
    9, 18,
    46, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'monroe', 'Monroe',
    100, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'highlands', 'Highlands',
    94, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'walton', 'Walton',
    87, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'columbia', 'Columbia',
    80, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'putnam', 'Putnam',
    74, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'gadsden', 'Gadsden',
    67, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'sumter', 'Sumter',
    64, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'flagler', 'Flagler',
    60, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'desoto', 'Desoto',
    57, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'hendry', 'Hendry',
    54, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'taylor', 'Taylor',
    50, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'calhoun', 'Calhoun',
    47, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'holmes', 'Holmes',
    44, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'washington', 'Washington',
    40, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'jefferson', 'Jefferson',
    37, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'madison', 'Madison',
    34, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'liberty', 'Liberty',
    30, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'dixie', 'Dixie',
    27, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'gilchrist', 'Gilchrist',
    23, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'union', 'Union',
    20, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'franklin', 'Franklin',
    17, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'lafayette', 'Lafayette',
    13, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'wakulla', 'Wakulla',
    12, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'hamilton', 'Hamilton',
    10, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'baker', 'Baker',
    8, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'glades', 'Glades',
    7, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'hardee', 'Hardee',
    5, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'bradford', 'Bradford',
    5, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'levy', 'Levy',
    5, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'nassau', 'Nassau',
    5, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'suwannee', 'Suwannee',
    5, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'gulf', 'Gulf',
    17, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'jackson', 'Jackson',
    30, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'FL', 'okeechobee', 'Okeechobee',
    23, 72,
    18, 54,
    9, 18,
    45, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'st-johns', 'St Johns',
    121, 74,
    18, 56,
    9, 18,
    47, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'alameda', 'Alameda',
    1496, 494,
    104, 390,
    65, 90,
    339, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'amador', 'Amador',
    34, 24,
    6, 18,
    4, 5,
    15, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'butte', 'Butte',
    170, 57,
    12, 45,
    8, 10,
    39, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'calaveras', 'Calaveras',
    34, 24,
    6, 18,
    4, 5,
    15, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'colusa', 'Colusa',
    34, 24,
    6, 18,
    4, 5,
    15, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'contra-costa', 'Contra Costa',
    748, 247,
    52, 195,
    33, 45,
    169, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'del-norte', 'Del Norte',
    34, 24,
    6, 18,
    4, 5,
    15, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'el-dorado', 'El Dorado',
    136, 45,
    10, 35,
    6, 8,
    31, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'fresno', 'Fresno',
    612, 202,
    43, 159,
    27, 37,
    138, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'glenn', 'Glenn',
    34, 24,
    6, 18,
    4, 5,
    15, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'humboldt', 'Humboldt',
    136, 45,
    10, 35,
    6, 8,
    31, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'imperial', 'Imperial',
    103, 34,
    8, 26,
    5, 6,
    23, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'inyo', 'Inyo',
    21, 24,
    6, 18,
    4, 5,
    15, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'kern', 'Kern',
    477, 158,
    34, 124,
    21, 29,
    108, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'kings', 'Kings',
    103, 34,
    8, 26,
    5, 6,
    23, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'lassen', 'Lassen',
    21, 24,
    6, 18,
    4, 5,
    15, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'los-angeles', 'Los Angeles',
    10336, 3411,
    717, 2694,
    444, 623,
    2344, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'madera', 'Madera',
    103, 34,
    8, 26,
    5, 6,
    23, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'marin', 'Marin',
    272, 90,
    19, 71,
    12, 16,
    62, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'mendocino', 'Mendocino',
    68, 24,
    6, 18,
    4, 5,
    15, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'merced', 'Merced',
    170, 57,
    12, 45,
    8, 10,
    39, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'modoc', 'Modoc',
    14, 24,
    6, 18,
    4, 5,
    15, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'mono', 'Mono',
    21, 24,
    6, 18,
    4, 5,
    15, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'monterey', 'Monterey',
    272, 90,
    19, 71,
    12, 16,
    62, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'napa', 'Napa',
    136, 45,
    10, 35,
    6, 8,
    31, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'nevada', 'Nevada',
    68, 24,
    6, 18,
    4, 5,
    15, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'placer', 'Placer',
    272, 90,
    19, 71,
    12, 16,
    62, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'plumas', 'Plumas',
    21, 24,
    6, 18,
    4, 5,
    15, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'riverside', 'Riverside',
    817, 270,
    57, 213,
    36, 49,
    185, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'sacramento', 'Sacramento',
    1088, 360,
    76, 284,
    47, 66,
    247, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'san-bernardino', 'San Bernardino',
    748, 247,
    52, 195,
    33, 45,
    169, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'san-diego', 'San Diego',
    2176, 719,
    151, 568,
    94, 131,
    494, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'san-francisco', 'San Francisco',
    1360, 449,
    95, 354,
    59, 82,
    308, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'san-joaquin', 'San Joaquin',
    340, 113,
    24, 89,
    15, 20,
    78, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'san-luis-obispo', 'San Luis Obispo',
    205, 68,
    15, 53,
    9, 13,
    46, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'san-mateo', 'San Mateo',
    680, 225,
    48, 177,
    30, 41,
    154, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'santa-barbara', 'Santa Barbara',
    340, 113,
    24, 89,
    15, 20,
    78, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'santa-clara', 'Santa Clara',
    1633, 539,
    114, 425,
    71, 99,
    369, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'shasta', 'Shasta',
    136, 45,
    10, 35,
    6, 8,
    31, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'sierra', 'Sierra',
    14, 24,
    6, 18,
    4, 5,
    15, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'siskiyou', 'Siskiyou',
    34, 24,
    6, 18,
    4, 5,
    15, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'solano', 'Solano',
    272, 90,
    19, 71,
    12, 16,
    62, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'sonoma', 'Sonoma',
    409, 135,
    29, 106,
    18, 25,
    92, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'stanislaus', 'Stanislaus',
    340, 113,
    24, 89,
    15, 20,
    78, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'sutter', 'Sutter',
    68, 24,
    6, 18,
    4, 5,
    15, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'tehama', 'Tehama',
    68, 24,
    6, 18,
    4, 5,
    15, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'trinity', 'Trinity',
    21, 24,
    6, 18,
    4, 5,
    15, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'tulare', 'Tulare',
    272, 90,
    19, 71,
    12, 16,
    62, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'tuolumne', 'Tuolumne',
    34, 24,
    6, 18,
    4, 5,
    15, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'ventura', 'Ventura',
    544, 180,
    38, 142,
    24, 33,
    123, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'yolo', 'Yolo',
    136, 45,
    10, 35,
    6, 8,
    31, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    'CA', 'yuba', 'Yuba',
    68, 24,
    6, 18,
    4, 5,
    15, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();


-- Insert Practice Area Seats
COMMIT;
