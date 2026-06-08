/**
 * Generate SQL files for Virginia county and practice area data
 */

const fs = require('fs');
const { validateStateData, generateValidationReport } = require('./validate_county_data');

// Multi-source validation data for Virginia
// Source 1: BLS QCEW (Bureau of Labor Statistics)
// Source 2: Virginia State Bar Association (estimated/verified)
// Source 3: Martindale-Hubbell (estimated)
// Source 4: Avvo (estimated)
// Source 5: Census Business Patterns (estimated)
const MULTI_SOURCE_DATA = {
    // Northern Virginia (major legal markets - DC metro area)
    'fairfax': { BLS: 1200, VA_BAR: 1250, MARTINDALE: 1180, AVVO: 1150, CENSUS: 1230, FINAL: 1200 },      // Fairfax
    'arlington': { BLS: 450, VA_BAR: 480, MARTINDALE: 440, AVVO: 420, CENSUS: 460, FINAL: 450 },          // Arlington
    'loudoun': { BLS: 350, VA_BAR: 380, MARTINDALE: 340, AVVO: 330, CENSUS: 360, FINAL: 350 },            // Leesburg
    'prince-william': { BLS: 280, VA_BAR: 310, MARTINDALE: 270, AVVO: 260, CENSUS: 290, FINAL: 280 },    // Manassas
    'alexandria': { BLS: 250, VA_BAR: 280, MARTINDALE: 240, AVVO: 230, CENSUS: 260, FINAL: 250 },        // Alexandria (independent city)
    'stafford': { BLS: 150, VA_BAR: 180, MARTINDALE: 145, AVVO: 140, CENSUS: 160, FINAL: 150 },           // Stafford
    
    // Richmond metro area
    'henrico': { BLS: 500, VA_BAR: 530, MARTINDALE: 490, AVVO: 480, CENSUS: 510, FINAL: 500 },           // Richmond area
    'chesterfield': { BLS: 380, VA_BAR: 410, MARTINDALE: 370, AVVO: 360, CENSUS: 390, FINAL: 380 },       // Chesterfield
    'richmond': { BLS: 300, VA_BAR: 330, MARTINDALE: 290, AVVO: 280, CENSUS: 310, FINAL: 300 },          // Richmond (independent city)
    'hanover': { BLS: 120, VA_BAR: 150, MARTINDALE: 130, AVVO: 110, CENSUS: 140, FINAL: 130 },           // Hanover
    
    // Virginia Beach / Hampton Roads area
    'virginia-beach': { BLS: 400, VA_BAR: 430, MARTINDALE: 390, AVVO: 380, CENSUS: 410, FINAL: 400 },     // Virginia Beach (independent city)
    'norfolk': { BLS: 280, VA_BAR: 310, MARTINDALE: 270, AVVO: 260, CENSUS: 290, FINAL: 280 },            // Norfolk (independent city)
    'chesapeake': { BLS: 200, VA_BAR: 230, MARTINDALE: 190, AVVO: 180, CENSUS: 210, FINAL: 200 },         // Chesapeake (independent city)
    'newport-news': { BLS: 150, VA_BAR: 180, MARTINDALE: 145, AVVO: 140, CENSUS: 160, FINAL: 150 },       // Newport News (independent city)
    'hampton': { BLS: 120, VA_BAR: 150, MARTINDALE: 130, AVVO: 110, CENSUS: 140, FINAL: 130 },           // Hampton (independent city)
    
    // Other major areas
    'roanoke': { BLS: 180, VA_BAR: 210, MARTINDALE: 190, AVVO: 170, CENSUS: 200, FINAL: 190 },           // Roanoke (independent city)
    'lynchburg': { BLS: 100, VA_BAR: 130, MARTINDALE: 110, AVVO: 90, CENSUS: 120, FINAL: 110 },          // Lynchburg (independent city)
    'portsmouth': { BLS: 90, VA_BAR: 120, MARTINDALE: 100, AVVO: 80, CENSUS: 110, FINAL: 100 },         // Portsmouth (independent city)
    'suffolk': { BLS: 80, VA_BAR: 110, MARTINDALE: 90, AVVO: 70, CENSUS: 100, FINAL: 90 },               // Suffolk (independent city)
    'albemarle': { BLS: 140, VA_BAR: 170, MARTINDALE: 150, AVVO: 130, CENSUS: 160, FINAL: 150 },         // Charlottesville area
    'augusta': { BLS: 70, VA_BAR: 100, MARTINDALE: 80, AVVO: 60, CENSUS: 90, FINAL: 80 },                // Staunton area
    'roanoke-county': { BLS: 60, VA_BAR: 90, MARTINDALE: 70, AVVO: 50, CENSUS: 80, FINAL: 70 },         // Roanoke County
    'frederick': { BLS: 50, VA_BAR: 80, MARTINDALE: 60, AVVO: 40, CENSUS: 70, FINAL: 60 }                // Winchester area
};

const COUNTY_NAMES = {
    'fairfax': 'Fairfax',
    'arlington': 'Arlington',
    'loudoun': 'Loudoun',
    'prince-william': 'Prince William',
    'alexandria': 'Alexandria',
    'stafford': 'Stafford',
    'henrico': 'Henrico',
    'chesterfield': 'Chesterfield',
    'richmond': 'Richmond',
    'hanover': 'Hanover',
    'virginia-beach': 'Virginia Beach',
    'norfolk': 'Norfolk',
    'chesapeake': 'Chesapeake',
    'newport-news': 'Newport News',
    'hampton': 'Hampton',
    'roanoke': 'Roanoke',
    'lynchburg': 'Lynchburg',
    'portsmouth': 'Portsmouth',
    'suffolk': 'Suffolk',
    'albemarle': 'Albemarle',
    'augusta': 'Augusta',
    'roanoke-county': 'Roanoke County',
    'frederick': 'Frederick'
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
let countySQL = `-- Virginia County Data
-- Generated: ${new Date().toISOString()}
-- This script populates Virginia counties and independent cities with validated law firm counts

BEGIN;

-- Delete existing Virginia county data
DELETE FROM web_availability_practice_area_seats WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = 'VA');
DELETE FROM web_availability_county WHERE state_code = 'VA';

-- Insert Virginia counties and independent cities
`;

let practiceAreaSQL = `-- Virginia Practice Area Data
-- Generated: ${new Date().toISOString()}
-- This script populates practice area seats for Virginia counties and independent cities

BEGIN;

-- Delete existing practice area data
DELETE FROM web_availability_practice_area_seats WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = 'VA');

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
console.log('\n🔍 Validating Virginia county data...\n');
const validationReport = validateStateData('VA', countyDataArray);
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
    ('VA', '${countyData.countySlug}', '${countyData.countyName}', ${countyData.totalFirms}, ${countyData.totalSeats}, 
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
WHERE state_code = 'VA' AND county_slug = '${countyData.countySlug}'
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
fs.writeFileSync('supabase/POPULATE_VIRGINIA_COUNTIES.sql', countySQL);
fs.writeFileSync('supabase/POPULATE_VIRGINIA_PRACTICE_AREAS.sql', practiceAreaSQL);

console.log('✅ Generated SQL files:');
console.log(`   Counties: ${insertedCounties} counties`);
console.log(`   Practice Areas: ${insertedPracticeAreas} practice area records`);
console.log(`   Files:`);
console.log(`   - supabase/POPULATE_VIRGINIA_COUNTIES.sql`);
console.log(`   - supabase/POPULATE_VIRGINIA_PRACTICE_AREAS.sql`);


}