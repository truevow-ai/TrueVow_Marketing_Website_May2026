// ============================================
// Law Firm Data Validation Script
// Validates calculated numbers against industry benchmarks and sanity checks
// ============================================

const { Client } = require('pg');
const fs = require('fs');
require('dotenv').config({ path: '.env.local' });

// Output to both console and file
const outputFile = 'validation_results.txt';
let outputBuffer = [];

// Write initial message immediately
fs.writeFileSync(outputFile, `Validation script started at ${new Date().toISOString()}\n\n`);

function log(message) {
    const timestamp = new Date().toISOString();
    const logMessage = `[${timestamp}] ${message}`;
    console.log(message);
    outputBuffer.push(logMessage);
    // Append to file immediately
    fs.appendFileSync(outputFile, logMessage + '\n');
}

function logError(message) {
    const timestamp = new Date().toISOString();
    const logMessage = `[${timestamp}] ERROR: ${message}`;
    console.error(message);
    outputBuffer.push(logMessage);
    // Append to file immediately
    fs.appendFileSync(outputFile, logMessage + '\n');
}

function writeOutput() {
    // File is already being written to incrementally, just add final message
    fs.appendFileSync(outputFile, `\n\nValidation completed at ${new Date().toISOString()}\n`);
    console.log(`\n📄 Full results written to: ${outputFile}`);
}

// ============================================
// BENCHMARK DATA - Industry Standards & Known Values
// ============================================

// Known verified values (from Florida - can be used as benchmarks)
const VERIFIED_BENCHMARKS = {
    'FL': {
        'miami-dade': { totalOffices: 4325, soloSmall: 2898, population: 2701767 },
        'broward': { totalOffices: 2716, soloSmall: 1820, population: 1952778 },
        'palm-beach': { totalOffices: 2095, soloSmall: 1404, population: 1496770 }
    }
};

// Industry benchmarks for law offices per capita
const LAW_OFFICES_PER_CAPITA = {
    'high': 0.0016,      // Major metro areas (NYC, LA, Miami)
    'medium': 0.0012,   // Mid-size metros (Dallas, Houston, Atlanta)
    'low': 0.0008       // Smaller metros
};

// Practice area distribution ranges (industry standards)
const PRACTICE_AREA_RANGES = {
    'personal-injury': { min: 0.20, max: 0.30 },  // 20-30%
    'family-law': { min: 0.15, max: 0.25 },       // 15-25%
    'immigration': { min: 0.10, max: 0.20 },     // 10-20% (varies by region)
    'criminal-defense': { min: 0.10, max: 0.15 }, // 10-15%
    'employment-law': { min: 0.06, max: 0.10 },  // 6-10%
    'real-estate': { min: 0.05, max: 0.10 },    // 5-10%
    'bankruptcy': { min: 0.03, max: 0.07 },      // 3-7%
    'estate-planning': { min: 0.03, max: 0.06 },  // 3-6%
    'workers-comp': { min: 0.02, max: 0.06 }     // 2-6% (varies by state)
};

// County population data (for per-capita validation)
// Source: U.S. Census Bureau 2023 estimates
const COUNTY_POPULATIONS = {
    // Texas
    'TX': {
        'harris': 4731145,      // Houston
        'dallas': 2614163,      // Dallas
        'tarrant': 2116408,     // Fort Worth
        'bexar': 2009324,       // San Antonio
        'travis': 1290341,      // Austin
        'collin': 1082026,      // Plano/McKinney
        'denton': 906422,       // Denton
        'fort-bend': 822779,    // Sugar Land
        'montgomery': 620443,   // The Woodlands
        'williamson': 609017,   // Round Rock
        'hidalgo': 870781,      // McAllen
        'el-paso': 865657,      // El Paso
        'cameron': 421017,      // Brownsville
        'nueces': 353178,       // Corpus Christi
        'brazoria': 372031,     // Angleton
        'galveston': 342139,    // Galveston
        'jefferson': 256526,    // Beaumont
        'mclennan': 260674,    // Waco
        'bell': 370647          // Killeen
    },
    // New York
    'NY': {
        'new-york': 1694251,    // Manhattan
        'kings': 2736074,       // Brooklyn
        'queens': 2405464,      // Queens
        'nassau': 1395774,      // Long Island
        'suffolk': 1525920,     // Long Island
        'westchester': 1004456, // Westchester
        'erie': 954236,         // Buffalo
        'monroe': 759443,       // Rochester
        'onondaga': 476516,     // Syracuse
        'richmond': 495747,     // Staten Island
        'rockland': 338329,     // Rockland
        'orange': 401310,       // Newburgh
        'dutchess': 295568,     // Poughkeepsie
        'albany': 314848,       // Albany
        'oneida': 232125        // Utica
    },
    // Ohio
    'OH': {
        'cuyahoga': 1241472,    // Cleveland
        'franklin': 1328002,    // Columbus
        'hamilton': 830639,     // Cincinnati
        'summit': 541013,       // Akron
        'montgomery': 537309,   // Dayton
        'lucas': 431279,        // Toledo
        'stark': 374853,        // Canton
        'butler': 390357,       // Hamilton
        'lorain': 312964,       // Lorain
        'mahoning': 228683,     // Youngstown
        'warren': 242337,       // Lebanon
        'clark': 136001,        // Springfield
        'trumbull': 201977,     // Warren
        'lake': 232603,         // Painesville
        'portage': 161791       // Ravenna
    },
    // Pennsylvania
    'PA': {
        'philadelphia': 1584138, // Philadelphia
        'allegheny': 1231517,    // Pittsburgh
        'montgomery': 856553,    // Norristown
        'bucks': 646538,         // Doylestown
        'delaware': 576830,      // Media
        'chester': 534413,       // West Chester
        'lancaster': 552984,     // Lancaster
        'york': 456438,          // York
        'lehigh': 374557,        // Allentown
        'northampton': 312951,   // Easton
        'dauphin': 286401,       // Harrisburg
        'berks': 428849,         // Reading
        'westmoreland': 354663,  // Greensburg
        'erie': 280566,          // Erie
        'cumberland': 253370     // Carlisle
    },
    // Illinois
    'IL': {
        'cook': 5275541,         // Chicago
        'dupage': 932877,        // Wheaton
        'lake': 714342,          // Waukegan
        'will': 696355,          // Joliet
        'kane': 516522,          // Geneva
        'mchenry': 310229,       // Woodstock
        'winnebago': 285350,     // Rockford
        'peoria': 181830,        // Peoria
        'sangamon': 196343,      // Springfield
        'mclean': 170889,        // Bloomington
        'st-clair': 257400,      // Belleville
        'madison': 265859,       // Edwardsville
        'rock-island': 144374,   // Rock Island
        'tazewell': 131343,      // Pekin
        'champaign': 205865      // Champaign
    },
    // Georgia
    'GA': {
        'fulton': 1063937,       // Atlanta
        'dekalb': 764382,        // Decatur
        'gwinnett': 957062,      // Lawrenceville
        'cobb': 766149,          // Marietta
        'clayton': 297595,       // Jonesboro
        'chatham': 295291,       // Savannah
        'richmond': 206607,     // Augusta
        'muscogee': 206922,      // Columbus
        'bibb': 157346,          // Macon
        'dougherty': 85759,      // Albany
        'hall': 203761,          // Gainesville
        'cherokee': 266620,      // Canton
        'forsyth': 251283,       // Cumming
        'henry': 240712,         // McDonough
        'paulding': 168661       // Dallas
    },
    // North Carolina
    'NC': {
        'mecklenburg': 1115359,  // Charlotte
        'wake': 1147553,         // Raleigh
        'guilford': 541299,      // Greensboro
        'forsyth': 382590,       // Winston-Salem
        'durham': 324833,        // Durham
        'cumberland': 334728,    // Fayetteville
        'buncombe': 269452,      // Asheville
        'gaston': 227943,        // Gastonia
        'union': 238267,         // Monroe
        'new-hanover': 225702,   // Wilmington
        'onslow': 204576,        // Jacksonville
        'cabarrus': 225804,      // Concord
        'iredell': 186693,       // Statesville
        'rowan': 146875,         // Salisbury
        'pitt': 170243           // Greenville
    },
    // Michigan
    'MI': {
        'wayne': 1797840,        // Detroit
        'oakland': 1273719,      // Pontiac
        'kent': 657974,          // Grand Rapids
        'macomb': 881217,        // Mount Clemens
        'washtenaw': 372258,     // Ann Arbor
        'genesee': 406211,       // Flint
        'ingham': 284900,        // Lansing
        'kalamazoo': 261670,     // Kalamazoo
        'ottawa': 296200,        // Grand Haven
        'livingston': 193866,    // Howell
        'monroe': 154809,        // Monroe
        'muskegon': 175824,      // Muskegon
        'saginaw': 190124,       // Saginaw
        'st-clair': 160383,      // Port Huron
        'berrien': 154316        // St. Joseph
    },
    // New Jersey
    'NJ': {
        'bergen': 955732,        // Hackensack
        'essex': 863728,         // Newark
        'middlesex': 863162,     // New Brunswick
        'hudson': 724854,        // Jersey City
        'monmouth': 629672,      // Freehold
        'ocean': 637229,         // Toms River
        'union': 575345,         // Elizabeth
        'camden': 523485,        // Camden
        'morris': 509285,        // Morristown
        'burlington': 461860,    // Mount Holly
        'passaic': 524118,       // Paterson
        'mercer': 387340,        // Trenton
        'somerset': 345361,      // Somerville
        'gloucester': 302294,    // Woodbury
        'atlantic': 274534       // Atlantic City
    },
    // Virginia
    'VA': {
        'fairfax': 1147532,      // Fairfax
        'prince-william': 482204, // Manassas
        'loudoun': 420959,       // Leesburg
        'henrico': 334389,       // Richmond
        'chesterfield': 364548,  // Chesterfield
        'arlington': 238643,     // Arlington
        'norfolk': 238005,       // Norfolk
        'virginia-beach': 457672, // Virginia Beach
        'richmond-city': 226610, // Richmond City
        'portsmouth': 97515,     // Portsmouth
        'newport-news': 186247,  // Newport News
        'hampton': 137148,       // Hampton
        'alexandria': 159467,    // Alexandria
        'chesapeake': 249422,     // Chesapeake
        'roanoke': 100011        // Roanoke
    }
};

// ============================================
// VALIDATION FUNCTIONS
// ============================================

function validateLawOfficesPerCapita(stateCode, countySlug, totalOffices) {
    const population = COUNTY_POPULATIONS[stateCode]?.[countySlug];
    if (!population) {
        return { valid: false, reason: 'Population data not available' };
    }

    const perCapita = totalOffices / population;
    
    // Determine expected range based on county size
    let expectedRange;
    if (population > 2000000) {
        expectedRange = LAW_OFFICES_PER_CAPITA.high;
    } else if (population > 500000) {
        expectedRange = LAW_OFFICES_PER_CAPITA.medium;
    } else {
        expectedRange = LAW_OFFICES_PER_CAPITA.low;
    }

    const tolerance = 0.0003; // Allow 30% variance
    const minExpected = expectedRange * (1 - tolerance);
    const maxExpected = expectedRange * (1 + tolerance);

    if (perCapita < minExpected || perCapita > maxExpected) {
        return {
            valid: false,
            reason: `Per-capita ratio ${perCapita.toFixed(6)} outside expected range [${minExpected.toFixed(6)}, ${maxExpected.toFixed(6)}]`,
            perCapita,
            expectedRange
        };
    }

    return { valid: true, perCapita, expectedRange };
}

function validatePracticeAreaDistribution(practiceAreas, totalFirms) {
    const issues = [];
    let totalDistributed = 0;

    for (const [paSlug, paData] of Object.entries(practiceAreas)) {
        const percentage = paData.totalFirms / totalFirms;
        const range = PRACTICE_AREA_RANGES[paSlug];

        if (!range) {
            issues.push(`Unknown practice area: ${paSlug}`);
            continue;
        }

        if (percentage < range.min || percentage > range.max) {
            issues.push({
                practiceArea: paSlug,
                percentage: (percentage * 100).toFixed(2) + '%',
                expectedRange: `${(range.min * 100).toFixed(0)}-${(range.max * 100).toFixed(0)}%`,
                firms: paData.totalFirms
            });
        }

        totalDistributed += paData.totalFirms;
    }

    // Check if practice areas sum to total firms (within 5% tolerance)
    const sumPercentage = totalDistributed / totalFirms;
    if (sumPercentage < 0.95 || sumPercentage > 1.05) {
        issues.push({
            type: 'sum_mismatch',
            totalDistributed,
            totalFirms,
            difference: Math.abs(totalDistributed - totalFirms)
        });
    }

    return {
        valid: issues.length === 0,
        issues,
        totalDistributed,
        totalFirms
    };
}

function validateCapacityCalculations(practiceAreas) {
    const issues = [];

    for (const [paSlug, paData] of Object.entries(practiceAreas)) {
        // Check 33% cap
        const expectedCap = Math.max(8, Math.round(paData.totalFirms * 0.33));
        if (Math.abs(paData.cap - expectedCap) > 1) {
            issues.push({
                practiceArea: paSlug,
                issue: 'cap_mismatch',
                calculated: paData.cap,
                expected: expectedCap
            });
        }

        // Check 21% premium tier
        const expectedPremium = Math.max(2, Math.round(paData.cap * 0.21));
        if (Math.abs(paData.premium - expectedPremium) > 1) {
            issues.push({
                practiceArea: paSlug,
                issue: 'premium_mismatch',
                calculated: paData.premium,
                expected: expectedPremium
            });
        }

        // Check standard seats
        const expectedStandard = paData.cap - paData.premium;
        if (paData.standard !== expectedStandard) {
            issues.push({
                practiceArea: paSlug,
                issue: 'standard_mismatch',
                calculated: paData.standard,
                expected: expectedStandard
            });
        }

        // Check minimums
        if (paData.cap < 8) {
            issues.push({
                practiceArea: paSlug,
                issue: 'min_cap_violation',
                cap: paData.cap
            });
        }

        if (paData.premium < 2) {
            issues.push({
                practiceArea: paSlug,
                issue: 'min_premium_violation',
                premium: paData.premium
            });
        }
    }

    return {
        valid: issues.length === 0,
        issues
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
    } catch (e) {
        // Use env vars
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
// MAIN VALIDATION FUNCTION
// ============================================

async function validateAllData() {
    log('🚀 Starting validation script...');
    log(`📡 Connecting to: ${SUPABASE_DB_HOST}:${SUPABASE_DB_PORT}/${SUPABASE_DB_NAME}`);
    log(`👤 User: ${SUPABASE_DB_USER}`);
    log(`🔑 Password: ${SUPABASE_DB_PASSWORD ? '***' + SUPABASE_DB_PASSWORD.slice(-3) : 'NOT SET'}\n`);

    const client = new Client({
        host: SUPABASE_DB_HOST,
        port: SUPABASE_DB_PORT,
        database: SUPABASE_DB_NAME,
        user: SUPABASE_DB_USER,
        password: SUPABASE_DB_PASSWORD,
        ssl: { rejectUnauthorized: false },
        connectionTimeoutMillis: 10000
    });

    try {
        await client.connect();
        log('✅ Connected to database\n');
        log('🔍 Starting validation...\n');

        // Get all counties
        const countiesResult = await client.query(`
            SELECT c.*, 
                   COUNT(pa.id) as practice_area_count
            FROM web_availability_county c
            LEFT JOIN web_availability_practice_area_seats pa ON pa.county_availability_id = c.id
            WHERE c.is_active = true
            GROUP BY c.id
            ORDER BY c.state_code, c.county_name
        `);

        const counties = countiesResult.rows;
        log(`📊 Found ${counties.length} counties to validate\n`);

        let totalIssues = 0;
        let countiesWithIssues = 0;
        const allIssues = [];

        for (const county of counties) {
            const stateCode = county.state_code;
            const countySlug = county.county_slug;
            const totalFirms = county.total_firms;
            
            // Estimate total offices (reverse of 67% calculation)
            const estimatedTotalOffices = Math.round(totalFirms / 0.67);

            log(`\n📍 ${county.county_name} County, ${stateCode}`);

            // Validation 1: Per-capita law offices
            const perCapitaCheck = validateLawOfficesPerCapita(stateCode, countySlug, estimatedTotalOffices);
            if (!perCapitaCheck.valid) {
                log(`   ⚠️  Per-capita validation: ${perCapitaCheck.reason}`);
                totalIssues++;
            } else {
                log(`   ✅ Per-capita ratio: ${perCapitaCheck.perCapita.toFixed(6)} (expected: ~${perCapitaCheck.expectedRange.toFixed(6)})`);
            }

            // Get practice areas
            const paResult = await client.query(`
                SELECT * FROM web_availability_practice_area_seats
                WHERE county_availability_id = $1 AND is_active = true
                ORDER BY display_order
            `, [county.id]);

            const practiceAreas = {};
            paResult.rows.forEach(pa => {
                practiceAreas[pa.practice_area_slug] = {
                    name: pa.practice_area_name,
                    totalFirms: pa.total_firms,
                    cap: pa.cap,
                    premium: pa.premium,
                    standard: pa.standard,
                    filled: pa.filled,
                    premiumRemaining: pa.premium_remaining,
                    standardRemaining: pa.standard_remaining
                };
            });

            // Validation 2: Practice area distribution
            const distributionCheck = validatePracticeAreaDistribution(practiceAreas, totalFirms);
            if (!distributionCheck.valid) {
                log(`   ⚠️  Practice area distribution issues:`);
                distributionCheck.issues.forEach(issue => {
                    if (typeof issue === 'object' && issue.practiceArea) {
                        log(`      - ${issue.practiceArea}: ${issue.percentage} (expected: ${issue.expectedRange})`);
                    } else if (issue.type === 'sum_mismatch') {
                        log(`      - Sum mismatch: ${issue.totalDistributed} firms distributed vs ${issue.totalFirms} total`);
                    }
                });
                totalIssues += distributionCheck.issues.length;
                countiesWithIssues++;
            } else {
                log(`   ✅ Practice area distribution valid (${distributionCheck.totalDistributed} firms)`);
            }

            // Validation 3: Capacity calculations
            const capacityCheck = validateCapacityCalculations(practiceAreas);
            if (!capacityCheck.valid) {
                log(`   ⚠️  Capacity calculation issues:`);
                capacityCheck.issues.forEach(issue => {
                    log(`      - ${issue.practiceArea}: ${issue.issue} (calculated: ${issue.calculated}, expected: ${issue.expected})`);
                });
                totalIssues += capacityCheck.issues.length;
                countiesWithIssues++;
            } else {
                log(`   ✅ Capacity calculations valid`);
            }

            if (perCapitaCheck.valid && distributionCheck.valid && capacityCheck.valid) {
                log(`   ✅ All validations passed`);
            } else {
                allIssues.push({
                    county: `${county.county_name}, ${stateCode}`,
                    perCapita: perCapitaCheck,
                    distribution: distributionCheck,
                    capacity: capacityCheck
                });
            }
        }

        // Summary
        log(`\n\n📊 VALIDATION SUMMARY`);
        log(`   Total counties: ${counties.length}`);
        log(`   Counties with issues: ${countiesWithIssues}`);
        log(`   Total issues found: ${totalIssues}`);
        log(`   Validation pass rate: ${((counties.length - countiesWithIssues) / counties.length * 100).toFixed(1)}%`);

        if (allIssues.length > 0) {
            log(`\n⚠️  COUNTIES WITH ISSUES:`);
            allIssues.forEach(({ county, perCapita, distribution, capacity }) => {
                log(`\n   ${county}:`);
                if (!perCapita.valid) log(`     - Per-capita: ${perCapita.reason}`);
                if (!distribution.valid) log(`     - Distribution: ${distribution.issues.length} issues`);
                if (!capacity.valid) log(`     - Capacity: ${capacity.issues.length} issues`);
            });
        }

        await client.end();
        log('\n✅ Validation complete!');
        writeOutput();

    } catch (error) {
        logError('❌ Error: ' + error.message);
        logError(error.stack);
        writeOutput();
        if (client) {
            await client.end().catch(() => {});
        }
        process.exit(1);
    }
}

// Run validation
validateAllData().catch(error => {
    logError('❌ Fatal error: ' + error.message);
    logError(error.stack);
    writeOutput();
    process.exit(1);
});


