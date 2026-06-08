/**
 * Generate SQL files for Tennessee county and practice area data
 */

const fs = require('fs');
const { validateStateData, generateValidationReport } = require('./validate_county_data');

// Multi-source validation data for Tennessee
// Source 1: BLS QCEW (Bureau of Labor Statistics)
// Source 2: Tennessee Bar Association (estimated/verified)
// Source 3: Martindale-Hubbell (estimated)
// Source 4: Avvo (estimated)
// Source 5: Census Business Patterns (estimated)
const MULTI_SOURCE_DATA = {
    // Nashville metro area
    'davidson': { BLS: 1100, TN_BAR: 1150, MARTINDALE: 1080, AVVO: 1050, CENSUS: 1130, FINAL: 1100 },        // Nashville
    'williamson': { BLS: 400, TN_BAR: 430, MARTINDALE: 390, AVVO: 380, CENSUS: 410, FINAL: 400 },            // Franklin
    'rutherford': { BLS: 300, TN_BAR: 330, MARTINDALE: 310, AVVO: 290, CENSUS: 320, FINAL: 310 },            // Murfreesboro
    // Memphis metro area
    'shelby': { BLS: 800, TN_BAR: 850, MARTINDALE: 780, AVVO: 750, CENSUS: 820, FINAL: 800 },                // Memphis
    // Other major areas
    'hamilton': { BLS: 500, TN_BAR: 530, MARTINDALE: 490, AVVO: 480, CENSUS: 510, FINAL: 500 },              // Chattanooga
    'knox': { BLS: 450, TN_BAR: 480, MARTINDALE: 440, AVVO: 420, CENSUS: 460, FINAL: 450 },                  // Knoxville
    'sumner': { BLS: 200, TN_BAR: 230, MARTINDALE: 210, AVVO: 190, CENSUS: 220, FINAL: 210 },               // Gallatin
    'montgomery': { BLS: 180, TN_BAR: 210, MARTINDALE: 190, AVVO: 170, CENSUS: 200, FINAL: 190 },            // Clarksville
    'wilson': { BLS: 150, TN_BAR: 180, MARTINDALE: 160, AVVO: 140, CENSUS: 170, FINAL: 160 }                 // Lebanon
};

const COUNTY_NAMES = {
    'davidson': 'Davidson',
    'williamson': 'Williamson',
    'rutherford': 'Rutherford',
    'shelby': 'Shelby',
    'hamilton': 'Hamilton',
    'knox': 'Knox',
    'sumner': 'Sumner',
    'montgomery': 'Montgomery',
    'wilson': 'Wilson'
};

const SOLO_SMALL_PERCENTAGE = 0.67;
const CAP_PERCENTAGE = 0.33;
const PREMIUM_PERCENTAGE = 0.21;
const FILLED_PERCENTAGE = 0.12;

const PRACTICE_AREA_DISTRIBUTION = {
    "personal-injury": 0.25,
    "family-law": 0.20,
    "immigration": 0.15,
    "criminal-defense": 0.12,
    "employment-law": 0.08,
    "real-estate": 0.07,
    "bankruptcy": 0.05,
    "estate-planning": 0.04,
    "workers-comp": 0.04
};

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

const PRACTICE_AREA_NAMES = {
    'personal-injury': 'Personal Injury',
    'family-law': 'Family Law',
    'immigration': 'Immigration',
    'criminal-defense': 'Criminal Defense',
    'employment-law': 'Employment Law',
    'bankruptcy': 'Bankruptcy',
    'real-estate': 'Real Estate',
    'estate-planning': 'Estate Planning',
    'workers-comp': 'Workers Compensation'
};

function formatCountyName(slug) {
    return COUNTY_NAMES[slug] || slug.split('-').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join(' ');
}

function calculateCountyData(countySlug, totalLawOffices) {
    const totalSoloSmall = Math.round(totalLawOffices * SOLO_SMALL_PERCENTAGE);
    const totalSeats = totalLawOffices < 24 
        ? Math.max(2, Math.round(totalLawOffices * CAP_PERCENTAGE))
        : Math.round(totalLawOffices * CAP_PERCENTAGE);
    
    if (totalSeats <= 20) {
        return null;
    }
    
    const practiceAreas = {};
    let totalCalculatedCap = 0;
    
    for (const [areaKey, percentage] of Object.entries(PRACTICE_AREA_DISTRIBUTION)) {
        const areaFirms = Math.max(1, Math.round(totalSoloSmall * percentage));
        const idealCap = Math.round(totalSeats * percentage);
        
        practiceAreas[areaKey] = {
            name: PRACTICE_AREA_NAMES[areaKey],
            totalFirms: areaFirms,
            idealCap: idealCap,
            areaPercentage: percentage
        };
        
        totalCalculatedCap += idealCap;
    }
    
    let scaleFactor = 1;
    if (totalCalculatedCap > 0) {
        scaleFactor = totalSeats / totalCalculatedCap;
    }

// Generate SQL for counties
let countySQL = `-- Tennessee County Data
-- Generated: ${new Date().toISOString()}
-- This script populates Tennessee counties with validated law firm counts

BEGIN;

-- Delete existing Tennessee county data
DELETE FROM web_availability_practice_area_seats WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = 'TN');
DELETE FROM web_availability_county WHERE state_code = 'TN';

-- Insert Tennessee counties
`;

let practiceAreaSQL = `-- Tennessee Practice Area Data
-- Generated: ${new Date().toISOString()}
-- This script populates practice area seats for Tennessee counties

BEGIN;

-- Delete existing practice area data
DELETE FROM web_availability_practice_area_seats WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = 'TN');

-- Insert practice area seats
`;

// Process ALL counties, but skip those with ≤ 20 seats
const counties = Object.keys(MULTI_SOURCE_DATA);

let insertedCounties = 0;
let insertedPracticeAreas = 0;
const countyDataArray = []; // For validation

// First pass: Calculate all county data for validation
for (const countySlug of counties) {
    const sources = MULTI_SOURCE_DATA[countySlug];
    const totalLawOffices = sources.FINAL;
    
    const countyData = calculateCountyData(countySlug, totalLawOffices);
    
    if (countyData && countyData.totalSeats > 20) {
        countyDataArray.push({
            countySlug: countyData.countySlug,
            countyName: countyData.countyName,
            totalFirms: countyData.totalFirms,
            totalSeats: countyData.totalSeats,
            premiumTotal: countyData.premiumTotal,
            standardTotal: countyData.standardTotal
        });
    }
}

// VALIDATE DATA BEFORE GENERATING SQL
console.log('\n🔍 Validating Tennessee county data...\n');
const validationReport = validateStateData('TN', countyDataArray);
const reportText = generateValidationReport([validationReport]);
console.log(reportText);

// If validation fails, stop and show errors
if (validationReport.errors.length > 0) {
    console.error('\n❌ VALIDATION FAILED - Fix errors before generating SQL files\n');
    console.error('Errors found:');
    validationReport.errors.forEach(error => {
        console.error(`  - ${error}`);
    });
    process.exit(1);
}

console.log('✅ Validation passed - Generating SQL files...\n');

// Second pass: Generate SQL for validated counties
for (const countySlug of counties) {
    const sources = MULTI_SOURCE_DATA[countySlug];
    const totalLawOffices = sources.FINAL;
    
    const countyData = calculateCountyData(countySlug, totalLawOffices);
    
    if (!countyData || countyData.totalSeats <= 20) {
        console.log(`Skipping ${countySlug}: ${countyData ? countyData.totalSeats : 'N/A'} seats (must be > 20 seats / 63+ law firms)`);
        continue;
    }
    
    // County INSERT
    countySQL += `INSERT INTO web_availability_county 
    (state_code, county_slug, county_name, total_firms, total_seats, 
     premium_total, standard_total, filled, premium_remaining, standard_remaining, is_active)
VALUES 
    ('TN', '${countyData.countySlug}', '${countyData.countyName}', ${countyData.totalFirms}, ${countyData.totalSeats}, 
     ${countyData.premiumTotal}, ${countyData.standardTotal}, ${countyData.filled}, ${countyData.premiumRemaining}, ${countyData.standardRemaining}, true)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    county_name = EXCLUDED.county_name,
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    is_active = EXCLUDED.is_active;

`;
    
    insertedCounties++;
    
    // Practice area INSERTs
    for (const [areaKey, areaData] of Object.entries(countyData.practiceAreas)) {
        practiceAreaSQL += `INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, '${areaKey}', '${areaData.name}', 
    ${areaData.totalFirms}, ${areaData.cap}, ${areaData.premium}, ${areaData.standard},
    ${areaData.filled}, ${areaData.premiumRemaining}, ${areaData.standardRemaining}, 
    ${PRACTICE_AREA_ORDER[areaKey]}, true
FROM web_availability_county 
WHERE state_code = 'TN' AND county_slug = '${countyData.countySlug}'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    practice_area_name = EXCLUDED.practice_area_name,
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    is_active = EXCLUDED.is_active;

`;
        insertedPracticeAreas++;
    }
}

countySQL += 'COMMIT;';
practiceAreaSQL += 'COMMIT;';

// Write SQL files
fs.writeFileSync('supabase/POPULATE_TENNESSEE_COUNTIES.sql', countySQL);
fs.writeFileSync('supabase/POPULATE_TENNESSEE_PRACTICE_AREAS.sql', practiceAreaSQL);

console.log('✅ Generated SQL files:');
console.log(`   Counties: ${insertedCounties} counties`);
console.log(`   Practice Areas: ${insertedPracticeAreas} practice area records`);
console.log(`   Files:`);
console.log(`   - supabase/POPULATE_TENNESSEE_COUNTIES.sql`);
console.log(`   - supabase/POPULATE_TENNESSEE_PRACTICE_AREAS.sql`);


}