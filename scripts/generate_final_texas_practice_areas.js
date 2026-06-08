/**
 * Generate complete practice areas SQL for ALL 28 Texas counties
 */

const fs = require('fs');

const SOLO_SMALL_PERCENTAGE = 0.67;
const PREMIUM_PERCENTAGE = 0.21;
const FILLED_PERCENTAGE = 0.12;

const PRACTICE_AREA_DISTRIBUTION = {
    "personal-injury": 0.25, "family-law": 0.20, "immigration": 0.15,
    "criminal-defense": 0.12, "employment-law": 0.08, "real-estate": 0.07,
    "bankruptcy": 0.05, "estate-planning": 0.04, "workers-comp": 0.04
};

const PRACTICE_AREA_ORDER = {
    'personal-injury': 1, 'family-law': 2, 'immigration': 3, 'criminal-defense': 4,
    'employment-law': 5, 'bankruptcy': 6, 'real-estate': 7, 'estate-planning': 8, 'workers-comp': 9
};

const PRACTICE_AREA_NAMES = {
    'personal-injury': 'Personal Injury', 'family-law': 'Family Law', 'immigration': 'Immigration',
    'criminal-defense': 'Criminal Defense', 'employment-law': 'Employment Law', 'bankruptcy': 'Bankruptcy',
    'real-estate': 'Real Estate', 'estate-planning': 'Estate Planning', 'workers-comp': 'Workers Compensation'
};

// All 28 Texas counties with their data
const counties = [
    { slug: 'harris', firms: 3200, seats: 1056 },
    { slug: 'dallas', firms: 2800, seats: 924 },
    { slug: 'tarrant', firms: 1800, seats: 594 },
    { slug: 'bexar', firms: 1650, seats: 545 },
    { slug: 'travis', firms: 1500, seats: 495 },
    { slug: 'collin', firms: 850, seats: 281 },
    { slug: 'denton', firms: 650, seats: 215 },
    { slug: 'fort-bend', firms: 550, seats: 182 },
    { slug: 'montgomery', firms: 480, seats: 158 },
    { slug: 'williamson', firms: 420, seats: 139 },
    { slug: 'hidalgo', firms: 400, seats: 132 },
    { slug: 'el-paso', firms: 380, seats: 125 },
    { slug: 'cameron', firms: 320, seats: 106 },
    { slug: 'lubbock', firms: 320, seats: 106 },
    { slug: 'nueces', firms: 280, seats: 92 },
    { slug: 'smith', firms: 280, seats: 92 },
    { slug: 'brazoria', firms: 250, seats: 83 },
    { slug: 'galveston', firms: 240, seats: 79 },
    { slug: 'jefferson', firms: 220, seats: 73 },
    { slug: 'mclennan', firms: 200, seats: 66 },
    { slug: 'gregg', firms: 200, seats: 66 },
    { slug: 'midland', firms: 200, seats: 66 },
    { slug: 'bell', firms: 190, seats: 63 },
    { slug: 'ellis', firms: 180, seats: 59 },
    { slug: 'potter', firms: 180, seats: 59 },
    { slug: 'ector', firms: 150, seats: 50 },
    { slug: 'brown', firms: 150, seats: 50 },
    { slug: 'taylor', firms: 140, seats: 46 },
    { slug: 'tom-green', firms: 130, seats: 43 },
    { slug: 'randall', firms: 120, seats: 40 }
];

function calculatePracticeAreas(totalLawOffices, totalSeats) {
    const totalSoloSmall = Math.round(totalLawOffices * SOLO_SMALL_PERCENTAGE);
    const practiceAreas = {};
    
    for (const [areaKey, distribution] of Object.entries(PRACTICE_AREA_DISTRIBUTION)) {
        const areaFirms = Math.round(totalSoloSmall * distribution);
        let cap = Math.round(totalSeats * distribution);
        if (cap < 1) cap = 0;
        
        const premium = cap > 0 ? Math.max(1, Math.round(cap * PREMIUM_PERCENTAGE)) : 0;
        const standard = Math.max(0, cap - premium);
        const filled = cap > 0 ? Math.round(cap * FILLED_PERCENTAGE) : 0;
        const premiumRemaining = cap > 0 ? Math.max(0, premium - Math.round(filled * (premium / cap))) : 0;
        const standardRemaining = cap > 0 ? Math.max(0, standard - Math.round(filled * (standard / cap))) : 0;
        
        practiceAreas[areaKey] = { totalFirms: areaFirms, cap, premium, standard, filled, premiumRemaining, standardRemaining };
    }
    
    let finalTotalCap = Object.values(practiceAreas).reduce((sum, a) => sum + a.cap, 0);
    if (finalTotalCap !== totalSeats) {
        const sortedAreas = Object.entries(practiceAreas).sort((a, b) => b[1].cap - a[1].cap);
        const diff = totalSeats - finalTotalCap;
        if (sortedAreas.length > 0 && sortedAreas[0][1].cap > 0) {
            const largestArea = sortedAreas[0][0];
            practiceAreas[largestArea].cap += diff;
            const adjustedArea = practiceAreas[largestArea];
            adjustedArea.premium = Math.max(1, Math.round(adjustedArea.cap * PREMIUM_PERCENTAGE));
            adjustedArea.standard = Math.max(0, adjustedArea.cap - adjustedArea.premium);
            adjustedArea.filled = Math.round(adjustedArea.cap * FILLED_PERCENTAGE);
            adjustedArea.premiumRemaining = Math.max(0, adjustedArea.premium - Math.round(adjustedArea.filled * (adjustedArea.premium / adjustedArea.cap)));
            adjustedArea.standardRemaining = Math.max(0, adjustedArea.standard - Math.round(adjustedArea.filled * (adjustedArea.standard / adjustedArea.cap)));
        }
    }
    
    return practiceAreas;
}

// Generate SQL
const sql = [];
sql.push('BEGIN;');
sql.push('');
sql.push('-- Delete existing Texas practice areas');
sql.push("DELETE FROM web_availability_practice_area_seats WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = 'TX');");
sql.push('');
sql.push('-- Insert practice areas for all 28 Texas counties');
sql.push('-- EXACT same structure as Florida (cap, premium, standard columns)');
sql.push('');

let totalInserts = 0;

for (const county of counties) {
    const practiceAreas = calculatePracticeAreas(county.firms, county.seats);
    
    for (const [areaKey, areaData] of Object.entries(practiceAreas)) {
        if (areaData.cap > 0) {
            sql.push(`INSERT INTO web_availability_practice_area_seats`);
            sql.push(`(county_availability_id, practice_area_slug, practice_area_name, total_firms,`);
            sql.push(` cap, premium, standard, filled, premium_remaining, standard_remaining, display_order)`);
            sql.push(`SELECT id, '${areaKey}', '${PRACTICE_AREA_NAMES[areaKey].replace(/'/g, "''")}', ${areaData.totalFirms}, ${areaData.cap}, ${areaData.premium}, ${areaData.standard}, ${areaData.filled}, ${areaData.premiumRemaining}, ${areaData.standardRemaining}, ${PRACTICE_AREA_ORDER[areaKey]}`);
            sql.push(`FROM web_availability_county WHERE state_code = 'TX' AND county_slug = '${county.slug}';`);
            sql.push('');
            totalInserts++;
        }
    }
}

sql.push('COMMIT;');

fs.writeFileSync('supabase/POPULATE_TEXAS_PRACTICE_AREAS.sql', sql.join('\n'));

console.log(`✅ Generated supabase/POPULATE_TEXAS_PRACTICE_AREAS.sql`);
console.log(`   Counties: ${counties.length}`);
console.log(`   Total practice area records: ${totalInserts}`);

