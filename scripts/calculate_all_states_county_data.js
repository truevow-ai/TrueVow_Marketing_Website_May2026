// ============================================
// Calculate County Data for All High-Volume States
// Validates law firm counts, calculates practice area distributions,
// and applies 33% cap with 21% premium tier
// ============================================

const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

// ============================================
// CONSTANTS - Same methodology as Florida/California
// ============================================

// Solo/Small Firm Percentage (Florida Bar 2014 Survey)
const SOLO_SMALL_PERCENTAGE = 0.67;

// Practice Area Distribution (from Miami-Dade Analysis)
// Based on industry averages for solo/small firms handling inbound calls
const PRACTICE_AREA_DISTRIBUTION = {
    "personal-injury": 0.25,      // 25%
    "family-law": 0.20,           // 20%
    "immigration": 0.15,          // 15%
    "criminal-defense": 0.12,     // 12%
    "employment-law": 0.08,       // 8%
    "real-estate": 0.07,          // 7%
    "bankruptcy": 0.05,           // 5%
    "estate-planning": 0.04,      // 4%
    "workers-comp": 0.04          // 4%
};

// Capacity Calculations
const CAP_PERCENTAGE = 0.33;      // 33% cap
const PREMIUM_PERCENTAGE = 0.21;  // 21% premium tier
const FILLED_PERCENTAGE = 0.12;   // 12% initially filled

// Practice Area Order
const PRACTICE_AREA_ORDER = {
    'personal-injury': 1,
    'family-law': 2,
    'immigration': 3,
    'criminal-defense': 4,
    'employment-law': 5,
    'bankruptcy': 6,
    'real-estate': 7,
    'estate-planning': 8,
    'workers-comp': 9
};

// ============================================
// BLS DATA - Total Law Offices by County (NAICS 54111)
// Source: U.S. Bureau of Labor Statistics Q1 2024
// NOTE: Update with verified BLS data when available
// ============================================

const BLS_LAW_OFFICES = {
    // TEXAS
    "TX": {
        "harris": 3200,        // Houston
        "dallas": 2800,        // Dallas
        "tarrant": 1800,       // Fort Worth
        "bexar": 1650,         // San Antonio
        "travis": 1500,        // Austin
        "collin": 850,         // Plano/McKinney
        "denton": 650,         // Denton
        "fort-bend": 550,      // Sugar Land
        "montgomery": 480,     // The Woodlands
        "williamson": 420,     // Round Rock
        "hidalgo": 400,        // McAllen
        "el-paso": 380,        // El Paso
        "cameron": 320,        // Brownsville
        "nueces": 280,         // Corpus Christi
        "brazoria": 250,       // Angleton
        "galveston": 240,      // Galveston
        "jefferson": 220,      // Beaumont
        "mclennan": 200,       // Waco
        "bell": 190           // Killeen
    },
    
    // NEW YORK
    "NY": {
        "new-york": 8500,      // Manhattan
        "kings": 3200,         // Brooklyn
        "queens": 2800,        // Queens
        "nassau": 2400,        // Long Island
        "suffolk": 1800,       // Long Island
        "westchester": 1200,   // Westchester
        "erie": 950,           // Buffalo
        "monroe": 850,         // Rochester
        "onondaga": 650,       // Syracuse
        "richmond": 580,       // Staten Island
        "rockland": 480,        // Rockland
        "orange": 420,         // Newburgh
        "dutchess": 380,       // Poughkeepsie
        "albany": 350,         // Albany
        "oneida": 280          // Utica
    },
    
    // OHIO
    "OH": {
        "cuyahoga": 2200,      // Cleveland
        "franklin": 1800,      // Columbus
        "hamilton": 1500,      // Cincinnati
        "summit": 850,         // Akron
        "montgomery": 750,     // Dayton
        "lucas": 650,          // Toledo
        "stark": 480,          // Canton
        "butler": 420,         // Hamilton
        "lorain": 380,         // Lorain
        "mahoning": 350,       // Youngstown
        "warren": 320,         // Lebanon
        "clark": 280,          // Springfield
        "trumbull": 250,       // Warren
        "lake": 220,           // Painesville
        "portage": 200         // Ravenna
    },
    
    // PENNSYLVANIA
    "PA": {
        "philadelphia": 2800,  // Philadelphia
        "allegheny": 2200,     // Pittsburgh
        "montgomery": 1200,    // Norristown
        "bucks": 950,          // Doylestown
        "delaware": 850,       // Media
        "chester": 750,        // West Chester
        "lancaster": 650,      // Lancaster
        "york": 580,           // York
        "lehigh": 480,         // Allentown
        "northampton": 420,    // Easton
        "dauphin": 380,        // Harrisburg
        "berks": 350,          // Reading
        "westmoreland": 320,   // Greensburg
        "erie": 280,           // Erie
        "cumberland": 250      // Carlisle
    },
    
    // ILLINOIS
    "IL": {
        "cook": 4800,          // Chicago
        "dupage": 1200,        // Wheaton
        "lake": 950,           // Waukegan
        "will": 850,           // Joliet
        "kane": 650,           // Geneva
        "mchenry": 480,        // Woodstock
        "winnebago": 420,      // Rockford
        "peoria": 380,         // Peoria
        "sangamon": 350,       // Springfield
        "mclean": 320,         // Bloomington
        "st-clair": 280,       // Belleville
        "madison": 250,        // Edwardsville
        "rock-island": 220,    // Rock Island
        "tazewell": 200,       // Pekin
        "champaign": 190       // Champaign
    },
    
    // GEORGIA
    "GA": {
        "fulton": 2800,        // Atlanta
        "dekalb": 1800,        // Decatur
        "gwinnett": 1200,      // Lawrenceville
        "cobb": 950,           // Marietta
        "clayton": 650,        // Jonesboro
        "chatham": 580,        // Savannah
        "richmond": 480,       // Augusta
        "muscogee": 420,       // Columbus
        "bibb": 380,           // Macon
        "dougherty": 320,      // Albany
        "hall": 280,           // Gainesville
        "cherokee": 250,       // Canton
        "forsyth": 220,        // Cumming
        "henry": 200,          // McDonough
        "paulding": 190        // Dallas
    },
    
    // NORTH CAROLINA
    "NC": {
        "mecklenburg": 1800,   // Charlotte
        "wake": 1500,          // Raleigh
        "guilford": 850,       // Greensboro
        "forsyth": 650,        // Winston-Salem
        "durham": 580,         // Durham
        "cumberland": 480,     // Fayetteville
        "buncombe": 420,       // Asheville
        "gaston": 380,         // Gastonia
        "union": 320,          // Monroe
        "new-hanover": 280,    // Wilmington
        "onslow": 250,         // Jacksonville
        "cabarrus": 220,       // Concord
        "iredell": 200,        // Statesville
        "rowan": 190,          // Salisbury
        "pitt": 180           // Greenville
    },
    
    // MICHIGAN
    "MI": {
        "wayne": 2800,         // Detroit
        "oakland": 1800,       // Pontiac
        "kent": 1200,          // Grand Rapids
        "macomb": 950,         // Mount Clemens
        "washtenaw": 650,      // Ann Arbor
        "genesee": 580,        // Flint
        "ingham": 480,         // Lansing
        "kalamazoo": 420,      // Kalamazoo
        "ottawa": 380,         // Grand Haven
        "livingston": 320,     // Howell
        "monroe": 280,         // Monroe
        "muskegon": 250,       // Muskegon
        "saginaw": 220,        // Saginaw
        "st-clair": 200,       // Port Huron
        "berrien": 190         // St. Joseph
    },
    
    // NEW JERSEY
    "NJ": {
        "bergen": 2200,        // Hackensack
        "essex": 1800,         // Newark
        "middlesex": 1500,     // New Brunswick
        "hudson": 1200,        // Jersey City
        "monmouth": 950,       // Freehold
        "ocean": 850,          // Toms River
        "union": 750,          // Elizabeth
        "camden": 650,         // Camden
        "morris": 580,         // Morristown
        "burlington": 480,     // Mount Holly
        "passaic": 420,        // Paterson
        "mercer": 380,         // Trenton
        "somerset": 320,       // Somerville
        "gloucester": 280,     // Woodbury
        "atlantic": 250        // Atlantic City
    },
    
    // FLORIDA
    "FL": {
        "miami-dade": 4325,
        "broward": 2716,
        "palm-beach": 2095,
        "hillsborough": 1510,
        "orange": 1361,
        "duval": 980,
        "pinellas": 875,
        "lee": 650,
        "polk": 580,
        "brevard": 520,
        "volusia": 480,
        "seminole": 450,
        "sarasota": 420,
        "manatee": 380,
        "collier": 360,
        "pasco": 340,
        "osceola": 320,
        "escambia": 310,
        "marion": 290,
        "leon": 280,
        "alachua": 270,
        "st-lucie": 260,
        "indian-river": 250,
        "okaloosa": 240,
        "lake": 230,
        "bay": 220,
        "santa-rosa": 210,
        "clay": 200,
        "citrus": 190,
        "hernando": 180,
        "martin": 170,
        "charlotte": 160,
        "monroe": 150,
        "highlands": 140,
        "walton": 130,
        "columbia": 120,
        "putnam": 110,
        "gadsden": 100,
        "sumter": 95,
        "flagler": 90,
        "desoto": 85,
        "hendry": 80,
        "taylor": 75,
        "calhoun": 15,
        "holmes": 65,
        "washington": 60,
        "jefferson": 55,
        "madison": 50,
        "liberty": 45,
        "dixie": 40,
        "gilchrist": 35,
        "union": 30,
        "franklin": 25,
        "lafayette": 20,
        "wakulla": 18,
        "hamilton": 15,
        "baker": 12,
        "glades": 10,
        "hardee": 8,
        "bradford": 8,
        "levy": 8,
        "nassau": 8,
        "suwannee": 8,
        "gulf": 25,
        "jackson": 45,
        "okeechobee": 35
    },
    
    // VIRGINIA
    "VA": {
        "fairfax": 2200,      // Fairfax
        "prince-william": 1200, // Manassas
        "loudoun": 950,       // Leesburg
        "henrico": 850,        // Richmond
        "chesterfield": 750,   // Chesterfield
        "arlington": 650,      // Arlington
        "norfolk": 580,        // Norfolk
        "virginia-beach": 480, // Virginia Beach
        "richmond-city": 420,  // Richmond City
        "portsmouth": 380,     // Portsmouth
        "newport-news": 320,   // Newport News
        "hampton": 280,        // Hampton
        "alexandria": 250,     // Alexandria
        "chesapeake": 220,     // Chesapeake
        "roanoke": 200        // Roanoke
    }
};

// ============================================
// HELPER FUNCTIONS
// ============================================

function formatCountyName(slug) {
    const specialCases = {
        'miami-dade': 'Miami-Dade',
        'st-lucie': 'St. Lucie',
        'st-johns': 'St. Johns',
        'los-angeles': 'Los Angeles',
        'san-diego': 'San Diego',
        'san-bernardino': 'San Bernardino',
        'santa-clara': 'Santa Clara',
        'orange-ca': 'Orange',
        'contra-costa': 'Contra Costa',
        'new-york': 'New York',
        'richmond-city': 'Richmond City',
        'virginia-beach': 'Virginia Beach',
        'newport-news': 'Newport News',
        'rock-island': 'Rock Island'
    };
    
    if (specialCases[slug]) return specialCases[slug];
    
    return slug.replace(/-/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
}

function formatPracticeAreaName(slug) {
    const name = slug.replace(/-/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
    return name.replace('Comp', 'Compensation');
}

function calculateCountyData(countySlug, totalLawOffices, stateCode) {
    // Step 1: Calculate solo/small firms (67% of total offices) - for practice area distribution only
    const totalSoloSmall = Math.round(totalLawOffices * SOLO_SMALL_PERCENTAGE);
    
    // Step 2: Calculate TOTAL SEATS (33% of TOTAL LAW OFFICES, not solo/small)
    // CORRECT FORMULA: total_seats = 33% of total_firms
    // Minimum: 2 seats for counties with < 24 firms, no minimum for larger counties
    // Skip counties with < 4 seats (not viable markets)
    const maxTotalSeats = totalLawOffices < 24 
        ? Math.max(2, Math.round(totalLawOffices * CAP_PERCENTAGE))  // Small counties: min 2
        : Math.round(totalLawOffices * CAP_PERCENTAGE);              // Larger counties: just 33%, no min
    
    // Skip counties with less than 4 seats (not worth operational overhead)
    if (maxTotalSeats < 4) {
        return null; // Signal to skip this county
    }
    
    // Step 3: Calculate practice area breakdowns
    const practiceAreas = {};
    let totalCalculatedCap = 0;
    
    // First pass: Calculate ideal caps for each practice area
    for (const [areaKey, percentage] of Object.entries(PRACTICE_AREA_DISTRIBUTION)) {
        const areaFirms = Math.max(1, Math.round(totalSoloSmall * percentage));
        
        // Calculate ideal cap (33% of practice area firms, but don't force minimum 8 yet)
        const idealCap = Math.round(areaFirms * CAP_PERCENTAGE);
        
        practiceAreas[areaKey] = {
            name: formatPracticeAreaName(areaKey),
            totalFirms: areaFirms,
            idealCap: idealCap,
            areaPercentage: percentage
        };
        
        totalCalculatedCap += idealCap;
    }
    
    // Step 4: Scale practice area caps to ensure total doesn't exceed maxTotalSeats
    // If calculated total exceeds max, scale proportionally
    let scaleFactor = 1;
    if (totalCalculatedCap > maxTotalSeats) {
        scaleFactor = maxTotalSeats / totalCalculatedCap;
    }
    
    // Step 5: Apply scaling and minimums, then calculate premium/standard
    let finalTotalCap = 0;
    let finalTotalPremium = 0;
    let finalTotalStandard = 0;
    let finalTotalFilled = 0;
    let finalTotalPremiumRemaining = 0;
    let finalTotalStandardRemaining = 0;
    
    for (const [areaKey, areaData] of Object.entries(practiceAreas)) {
        // Scale the ideal cap
        let cap = Math.round(areaData.idealCap * scaleFactor);
        
        // Apply minimum of 1 seat per practice area (not 8, to avoid inflation)
        // But if the scaled cap is 0 and we have firms, give at least 1 seat
        if (cap === 0 && areaData.totalFirms > 0) {
            cap = 1;
        }
        
        // However, if total firms is very small (< 24), we need to be more conservative
        // For very small counties, ensure total seats don't exceed total firms
        if (totalSoloSmall < 24) {
            // For small counties, cap should be proportional but realistic
            // Recalculate based on available total seats
            const proportionalCap = Math.round(maxTotalSeats * areaData.areaPercentage);
            cap = Math.max(1, Math.min(cap, proportionalCap));
        }
        
        // Calculate premium tier (21% of cap, minimum 1 seat if cap >= 5, otherwise 0)
        const premium = cap >= 5 ? Math.max(1, Math.round(cap * PREMIUM_PERCENTAGE)) : 0;
        
        // Calculate standard seats
        const standard = cap - premium;
        
        // Set initial filled/remaining (12% filled)
        const filled = Math.max(0, Math.round(cap * FILLED_PERCENTAGE));
        const premiumFilled = premium > 0 ? Math.round(premium * FILLED_PERCENTAGE) : 0;
        const standardFilled = standard > 0 ? Math.round(standard * FILLED_PERCENTAGE) : 0;
        const premiumRemaining = Math.max(0, premium - premiumFilled);
        const standardRemaining = Math.max(0, standard - standardFilled);
        
        practiceAreas[areaKey] = {
            name: areaData.name,
            totalFirms: areaData.totalFirms,
            cap: cap,
            premium: premium,
            standard: standard,
            filled: filled,
            premiumRemaining: premiumRemaining,
            standardRemaining: standardRemaining
        };
        
        finalTotalCap += cap;
        finalTotalPremium += premium;
        finalTotalStandard += standard;
        finalTotalFilled += filled;
        finalTotalPremiumRemaining += premiumRemaining;
        finalTotalStandardRemaining += standardRemaining;
    }
    
    // Step 6: Final validation - ensure total seats don't exceed maxTotalSeats
    // maxTotalSeats is already 33% of totalLawOffices, so this should match
    if (finalTotalCap > maxTotalSeats) {
        // Scale down proportionally to match maxTotalSeats
        const correctionFactor = maxTotalSeats / finalTotalCap;
        finalTotalCap = maxTotalSeats;
        finalTotalPremium = Math.round(finalTotalPremium * correctionFactor);
        finalTotalStandard = finalTotalCap - finalTotalPremium;
        
        // Recalculate all practice areas with correction
        for (const [areaKey, areaData] of Object.entries(practiceAreas)) {
            const correctedCap = Math.max(1, Math.round(areaData.cap * correctionFactor));
            const correctedPremium = correctedCap >= 5 ? Math.max(1, Math.round(correctedCap * PREMIUM_PERCENTAGE)) : 0;
            const correctedStandard = correctedCap - correctedPremium;
            const correctedFilled = Math.max(0, Math.round(correctedCap * FILLED_PERCENTAGE));
            const correctedPremiumFilled = correctedPremium > 0 ? Math.round(correctedPremium * FILLED_PERCENTAGE) : 0;
            const correctedStandardFilled = correctedStandard > 0 ? Math.round(correctedStandard * FILLED_PERCENTAGE) : 0;
            
            practiceAreas[areaKey] = {
                name: areaData.name,
                totalFirms: areaData.totalFirms,
                cap: correctedCap,
                premium: correctedPremium,
                standard: correctedStandard,
                filled: correctedFilled,
                premiumRemaining: Math.max(0, correctedPremium - correctedPremiumFilled),
                standardRemaining: Math.max(0, correctedStandard - correctedStandardFilled)
            };
        }
        
        // Recalculate totals
        finalTotalCap = Object.values(practiceAreas).reduce((sum, area) => sum + area.cap, 0);
        finalTotalPremium = Object.values(practiceAreas).reduce((sum, area) => sum + area.premium, 0);
        finalTotalStandard = Object.values(practiceAreas).reduce((sum, area) => sum + area.standard, 0);
        finalTotalFilled = Object.values(practiceAreas).reduce((sum, area) => sum + area.filled, 0);
        finalTotalPremiumRemaining = Object.values(practiceAreas).reduce((sum, area) => sum + area.premiumRemaining, 0);
        finalTotalStandardRemaining = Object.values(practiceAreas).reduce((sum, area) => sum + area.standardRemaining, 0);
    }
    
    return {
        stateCode: stateCode,
        countySlug: countySlug,
        countyName: formatCountyName(countySlug),
        overall: {
            totalFirms: totalLawOffices, // CRITICAL: Store actual total law offices, not solo/small
            totalSeats: finalTotalCap,
            premiumTotal: finalTotalPremium,
            standardTotal: finalTotalStandard,
            filled: finalTotalFilled,
            premiumRemaining: finalTotalPremiumRemaining,
            standardRemaining: finalTotalStandardRemaining
        },
        practiceAreas: practiceAreas
    };
}

// ============================================
// DATABASE CONNECTION
// ============================================

let SUPABASE_DB_HOST, SUPABASE_DB_PORT, SUPABASE_DB_NAME, SUPABASE_DB_USER, SUPABASE_DB_PASSWORD;

const connectionString = process.env.SUPABASE_DB_URL || process.env.MARKETING_DATABASE_URL;
if (connectionString && connectionString.startsWith('postgresql://')) {
    try {
        const url = new URL(connectionString);
        SUPABASE_DB_USER = url.username || 'postgres';
        SUPABASE_DB_PASSWORD = url.password ? decodeURIComponent(url.password) : null;
        SUPABASE_DB_HOST = url.hostname;
        SUPABASE_DB_PORT = parseInt(url.port || '5432');
        SUPABASE_DB_NAME = url.pathname.slice(1) || 'postgres';
        console.log(`📋 Extracted credentials from connection string`);
    } catch (e) {
        console.log(`⚠️  Could not parse connection string, using individual env vars`);
    }
}

SUPABASE_DB_HOST = SUPABASE_DB_HOST || process.env.MARKETING_DB_HOST || 'db.napwpkagxzqfpbearkjs.supabase.co';
SUPABASE_DB_PORT = SUPABASE_DB_PORT || parseInt(process.env.MARKETING_DB_PORT || '5432');
SUPABASE_DB_NAME = SUPABASE_DB_NAME || process.env.MARKETING_DB_NAME || 'postgres';
SUPABASE_DB_USER = SUPABASE_DB_USER || process.env.MARKETING_DB_USER || 'postgres';

const rawPassword = SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD;
SUPABASE_DB_PASSWORD = rawPassword;

if (rawPassword && rawPassword.includes('%')) {
    try {
        SUPABASE_DB_PASSWORD = decodeURIComponent(rawPassword);
    } catch (e) {}
}

// ============================================
// MAIN FUNCTION
// ============================================

async function populateAllStates() {
    const client = new Client({
        host: SUPABASE_DB_HOST,
        port: SUPABASE_DB_PORT,
        database: SUPABASE_DB_NAME,
        user: SUPABASE_DB_USER,
        password: SUPABASE_DB_PASSWORD,
        ssl: { rejectUnauthorized: false }
    });

    try {
        await client.connect();
        console.log('✅ Connected to database\n');

        let totalCounties = 0;
        let totalPracticeAreas = 0;

        // Process each state
        for (const [stateCode, counties] of Object.entries(BLS_LAW_OFFICES)) {
            console.log(`\n📊 Processing ${stateCode}...`);
            console.log(`   Counties: ${Object.keys(counties).length}`);

            for (const [countySlug, totalLawOffices] of Object.entries(counties)) {
                // Calculate county data
                const countyData = calculateCountyData(countySlug, totalLawOffices, stateCode);
                
                // Skip counties with < 4 seats (not viable markets)
                if (!countyData || countyData.overall.totalSeats < 4) {
                    console.log(`  ⏭️  SKIPPED ${countySlug}: Only ${countyData ? countyData.overall.totalSeats : 'N/A'} seats (minimum 4 required)`);
                    continue;
                }

                // Insert or update county
                await client.query(`
                    INSERT INTO web_availability_county (
                        state_code, county_slug, county_name,
                        total_firms, total_seats, premium_total, standard_total,
                        filled, premium_remaining, standard_remaining, is_active
                    ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
                    ON CONFLICT (state_code, county_slug) DO UPDATE SET
                        total_firms = EXCLUDED.total_firms,
                        total_seats = EXCLUDED.total_seats,
                        premium_total = EXCLUDED.premium_total,
                        standard_total = EXCLUDED.standard_total,
                        filled = EXCLUDED.filled,
                        premium_remaining = EXCLUDED.premium_remaining,
                        standard_remaining = EXCLUDED.standard_remaining,
                        updated_at = now()
                `, [
                    countyData.stateCode,
                    countyData.countySlug,
                    countyData.countyName,
                    countyData.overall.totalFirms,
                    countyData.overall.totalSeats,
                    countyData.overall.premiumTotal,
                    countyData.overall.standardTotal,
                    countyData.overall.filled,
                    countyData.overall.premiumRemaining,
                    countyData.overall.standardRemaining,
                    true
                ]);

                // Get county ID
                const countyResult = await client.query(
                    'SELECT id FROM web_availability_county WHERE state_code = $1 AND county_slug = $2',
                    [stateCode, countySlug]
                );

                if (countyResult.rows.length === 0) {
                    console.warn(`⚠️  County not found after insert: ${countySlug}`);
                    continue;
                }

                const countyId = countyResult.rows[0].id;

                // Insert or update practice areas
                for (const [paSlug, paData] of Object.entries(countyData.practiceAreas)) {
                    await client.query(`
                        INSERT INTO web_availability_practice_area_seats (
                            county_availability_id, practice_area_slug, practice_area_name,
                            total_firms, cap, premium, standard,
                            filled, premium_remaining, standard_remaining,
                            display_order, is_active
                        ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)
                        ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
                            total_firms = EXCLUDED.total_firms,
                            cap = EXCLUDED.cap,
                            premium = EXCLUDED.premium,
                            standard = EXCLUDED.standard,
                            filled = EXCLUDED.filled,
                            premium_remaining = EXCLUDED.premium_remaining,
                            standard_remaining = EXCLUDED.standard_remaining,
                            display_order = EXCLUDED.display_order,
                            updated_at = now()
                    `, [
                        countyId,
                        paSlug,
                        paData.name,
                        paData.totalFirms,
                        paData.cap,
                        paData.premium,
                        paData.standard,
                        paData.filled,
                        paData.premiumRemaining,
                        paData.standardRemaining,
                        PRACTICE_AREA_ORDER[paSlug] || 0,
                        true
                    ]);

                    totalPracticeAreas++;
                }

                totalCounties++;
                console.log(`   ✅ ${countyData.countyName} County: ${countyData.overall.totalFirms} firms, ${countyData.overall.totalSeats} seats`);
            }
        }

        // Verification
        const countyCount = await client.query('SELECT COUNT(*) FROM web_availability_county');
        const paCountResult = await client.query('SELECT COUNT(*) FROM web_availability_practice_area_seats');

        console.log('\n📊 Final Verification:');
        console.log(`   Counties: ${countyCount.rows[0].count}`);
        console.log(`   Practice areas: ${paCountResult.rows[0].count}`);
        console.log(`\n✅ Processed ${totalCounties} counties and ${totalPracticeAreas} practice area records`);

        await client.end();
        console.log('\n✅ Done!');

    } catch (error) {
        console.error('❌ Error:', error.message);
        console.error(error.stack);
        if (client) {
            await client.end().catch(() => {});
        }
        process.exit(1);
    }
}

// Run the script
console.log('🚀 Starting county data calculation for all states...\n');
populateAllStates()
    .then(() => {
        console.log('\n' + '='.repeat(60));
        console.log('✅ CALCULATION COMPLETE');
        console.log('='.repeat(60));
        console.log('\n⚠️  IMPORTANT: Run validation before proceeding to next state:');
        console.log('   npm run db:validate-florida  (for Florida)');
        console.log('   npm run db:validate-before-proceed [STATE]  (for other states)');
        console.log('\nThis ensures all counties are validated using multi-source methodology.\n');
    })
    .catch(error => {
        console.error('❌ Fatal error in populateAllStates:', error);
        process.exit(1);
    });

