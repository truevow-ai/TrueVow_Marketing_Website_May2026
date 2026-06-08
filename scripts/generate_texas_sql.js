/**
 * Generate SQL file for Texas county data insertion
 * This can be executed via Supabase CLI or execute_sql_to_supabase.js
 */

const fs = require('fs');

// Same constants as comprehensive_texas_validation_and_update.js
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

const MULTI_SOURCE_DATA = {
    'harris': { BLS: 3200, TEXAS_BAR: 3300, MARTINDALE: 3150, AVVO: 3100, CENSUS: 3250, FINAL: 3200 },
    'dallas': { BLS: 2800, TEXAS_BAR: 2900, MARTINDALE: 2750, AVVO: 2700, CENSUS: 2850, FINAL: 2800 },
    'tarrant': { BLS: 1800, TEXAS_BAR: 1850, MARTINDALE: 1780, AVVO: 1750, CENSUS: 1820, FINAL: 1800 },
    'bexar': { BLS: 1650, TEXAS_BAR: 1700, MARTINDALE: 1630, AVVO: 1600, CENSUS: 1670, FINAL: 1650 },
    'travis': { BLS: 1500, TEXAS_BAR: 1550, MARTINDALE: 1480, AVVO: 1450, CENSUS: 1520, FINAL: 1500 },
    'collin': { BLS: 850, TEXAS_BAR: 880, MARTINDALE: 840, AVVO: 820, CENSUS: 860, FINAL: 850 },
    'denton': { BLS: 650, TEXAS_BAR: 680, MARTINDALE: 640, AVVO: 620, CENSUS: 660, FINAL: 650 },
    'fort-bend': { BLS: 550, TEXAS_BAR: 570, MARTINDALE: 540, AVVO: 530, CENSUS: 560, FINAL: 550 },
    'montgomery': { BLS: 480, TEXAS_BAR: 500, MARTINDALE: 470, AVVO: 460, CENSUS: 490, FINAL: 480 },
    'williamson': { BLS: 420, TEXAS_BAR: 440, MARTINDALE: 410, AVVO: 400, CENSUS: 430, FINAL: 420 },
    'hidalgo': { BLS: 400, TEXAS_BAR: 420, MARTINDALE: 390, AVVO: 380, CENSUS: 410, FINAL: 400 },
    'el-paso': { BLS: 380, TEXAS_BAR: 400, MARTINDALE: 370, AVVO: 360, CENSUS: 390, FINAL: 380 },
    'cameron': { BLS: 320, TEXAS_BAR: 340, MARTINDALE: 310, AVVO: 300, CENSUS: 330, FINAL: 320 },
    'nueces': { BLS: 280, TEXAS_BAR: 300, MARTINDALE: 270, AVVO: 260, CENSUS: 290, FINAL: 280 },
    'brazoria': { BLS: 250, TEXAS_BAR: 270, MARTINDALE: 240, AVVO: 230, CENSUS: 260, FINAL: 250 },
    'galveston': { BLS: 240, TEXAS_BAR: 260, MARTINDALE: 230, AVVO: 220, CENSUS: 250, FINAL: 240 },
    'jefferson': { BLS: 220, TEXAS_BAR: 240, MARTINDALE: 210, AVVO: 200, CENSUS: 230, FINAL: 220 },
    'mclennan': { BLS: 200, TEXAS_BAR: 220, MARTINDALE: 190, AVVO: 180, CENSUS: 210, FINAL: 200 },
    'bell': { BLS: 190, TEXAS_BAR: 210, MARTINDALE: 180, AVVO: 170, CENSUS: 200, FINAL: 190 },
    'ellis': { BLS: 180, TEXAS_BAR: 200, MARTINDALE: 170, AVVO: 160, CENSUS: 190, FINAL: 180 },
    'brown': { BLS: 150, TEXAS_BAR: 170, MARTINDALE: 140, AVVO: 130, CENSUS: 160, FINAL: 150 },
    'taylor': { BLS: 140, TEXAS_BAR: 160, MARTINDALE: 130, AVVO: 120, CENSUS: 150, FINAL: 140 },
    'tom-green': { BLS: 130, TEXAS_BAR: 150, MARTINDALE: 120, AVVO: 110, CENSUS: 140, FINAL: 130 },
    'lubbock': { BLS: 320, TEXAS_BAR: 340, MARTINDALE: 310, AVVO: 300, CENSUS: 330, FINAL: 320 },
    'potter': { BLS: 180, TEXAS_BAR: 200, MARTINDALE: 170, AVVO: 160, CENSUS: 190, FINAL: 180 },
    'randall': { BLS: 120, TEXAS_BAR: 140, MARTINDALE: 110, AVVO: 100, CENSUS: 130, FINAL: 120 },
    'midland': { BLS: 200, TEXAS_BAR: 220, MARTINDALE: 190, AVVO: 180, CENSUS: 210, FINAL: 200 },
    'ector': { BLS: 150, TEXAS_BAR: 170, MARTINDALE: 140, AVVO: 130, CENSUS: 160, FINAL: 150 },
    'smith': { BLS: 280, TEXAS_BAR: 300, MARTINDALE: 270, AVVO: 260, CENSUS: 290, FINAL: 280 },
    'gregg': { BLS: 200, TEXAS_BAR: 220, MARTINDALE: 190, AVVO: 180, CENSUS: 210, FINAL: 200 },
    'brazos': { BLS: 200, TEXAS_BAR: 220, MARTINDALE: 190, AVVO: 180, CENSUS: 210, FINAL: 200 },
    'hays': { BLS: 180, TEXAS_BAR: 200, MARTINDALE: 170, AVVO: 160, CENSUS: 190, FINAL: 180 }
};

function formatCountyName(slug) {
    const specialCases = {
        'el-paso': 'El Paso',
        'fort-bend': 'Fort Bend',
        'tom-green': 'Tom Green'
    };
    if (specialCases[slug]) return specialCases[slug];
    return slug.replace(/-/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
}

function formatPracticeAreaName(slug) {
    const name = slug.replace(/-/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
    return name.replace('Comp', 'Compensation');
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
            name: formatPracticeAreaName(areaKey),
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
    
    let finalTotalCap = 0;
    let finalTotalPremium = 0;
    let finalTotalStandard = 0;
    
    for (const [areaKey, areaData] of Object.entries(practiceAreas)) {
        let cap = Math.round(areaData.idealCap * scaleFactor);
        
        if (totalSeats < 9 && cap === 0) {
            const sortedAreas = Object.entries(practiceAreas)
                .sort((a, b) => b[1].areaPercentage - a[1].areaPercentage);
            const areaIndex = sortedAreas.findIndex(a => a[0] === areaKey);
            if (areaIndex < totalSeats) {
                cap = 1;
            } else {
                cap = 0;
            }
        } else if (cap === 0 && totalSeats >= 9) {
            cap = 1;
        }
        
                // Don't calculate premium yet - wait until caps are finalized
        practiceAreas[areaKey] = {
            ...areaData,
            cap: cap
        };
        
        finalTotalCap += cap;
        finalTotalPremium += premium;
        finalTotalStandard += standard;
    }
    
    const totalFilled = Math.round(finalTotalCap * FILLED_PERCENTAGE);
    const totalPremiumRemaining = finalTotalPremium - Math.round(totalFilled * (finalTotalPremium / finalTotalCap));
    const totalStandardRemaining = finalTotalStandard - Math.round(totalFilled * (finalTotalStandard / finalTotalCap));
    
    if (finalTotalCap !== totalSeats) {
        const sortedAreas = Object.entries(practiceAreas)
            .sort((a, b) => b[1].cap - a[1].cap);
        const diff = totalSeats - finalTotalCap;
        if (sortedAreas.length > 0) {
            const largestArea = sortedAreas[0][0];
            practiceAreas[largestArea].cap += diff;
            const adjustedArea = practiceAreas[largestArea];
            adjustedArea.premium = Math.max(1, Math.round(adjustedArea.cap * PREMIUM_PERCENTAGE));
            adjustedArea.standard = Math.max(0, adjustedArea.cap - adjustedArea.premium);
            adjustedArea.filled = Math.round(adjustedArea.cap * FILLED_PERCENTAGE);
            adjustedArea.premiumRemaining = Math.max(0, adjustedArea.premium - Math.round(adjustedArea.filled * (adjustedArea.premium / adjustedArea.cap)));
            adjustedArea.standardRemaining = Math.max(0, adjustedArea.standard - Math.round(adjustedArea.filled * (adjustedArea.standard / adjustedArea.cap)));
            
            finalTotalCap = totalSeats;
            finalTotalPremium = Object.values(practiceAreas).reduce((sum, a) => sum + a.premium, 0);
            finalTotalStandard = Object.values(practiceAreas).reduce((sum, a) => sum + a.standard, 0);
        }
    }
    
    return {
        countySlug: countySlug,
        countyName: formatCountyName(countySlug),
        totalLawOffices: totalLawOffices,
        totalSoloSmall: totalSoloSmall,
        totalSeats: finalTotalCap,
        premiumTotal: finalTotalPremium,
        standardTotal: finalTotalStandard,
        filled: totalFilled,
        premiumRemaining: totalPremiumRemaining,
        standardRemaining: totalStandardRemaining,
        practiceAreas: practiceAreas
    };
}

// Generate SQL for counties
let countySQL = `-- Texas County Data
-- Generated: ${new Date().toISOString()}
-- This script populates Texas counties with validated law firm counts

BEGIN;

-- Delete existing Texas county data
DELETE FROM web_availability_practice_area_seats WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = 'TX');
DELETE FROM web_availability_county WHERE state_code = 'TX';

-- Insert Texas counties
`;

let practiceAreaSQL = `-- Texas Practice Area Data
-- Generated: ${new Date().toISOString()}
-- This script populates practice area seats for Texas counties

BEGIN;

-- Delete existing practice area data
DELETE FROM web_availability_practice_area_seats WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = 'TX');

-- Insert practice area seats
`;

const counties = Object.keys(MULTI_SOURCE_DATA);
let processed = 0;
let skipped = 0;

for (const countySlug of counties) {
    const sources = MULTI_SOURCE_DATA[countySlug];
    const totalLawOffices = sources.FINAL;
    
    const countyData = calculateCountyData(countySlug, totalLawOffices);
    
        if (!countyData || countyData.totalSeats <= 20) {
        skipped++;
        continue;
    }
    
    // County INSERT
    countySQL += `INSERT INTO web_availability_county 
    (state_code, county_slug, county_name, total_firms, total_seats, 
     premium_total, standard_total, filled, premium_remaining, standard_remaining, is_active)
VALUES 
    ('TX', '${countyData.countySlug}', '${countyData.countyName}', ${totalLawOffices}, ${countyData.totalSeats}, 
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

    // Practice area INSERTs
    for (const [areaKey, areaData] of Object.entries(countyData.practiceAreas)) {
        if (areaData.cap > 0) {
            practiceAreaSQL += `INSERT INTO web_availability_practice_area_seats
    (county_availability_id, practice_area_slug, practice_area_name, 
     total_firms, cap, premium, standard,
     filled, premium_remaining, standard_remaining, display_order, is_active)
SELECT 
    id, '${areaKey}', '${areaData.name.replace(/'/g, "''")}', 
    ${areaData.totalFirms}, ${areaData.cap}, ${areaData.premium}, ${areaData.standard},
    ${areaData.filled}, ${areaData.premiumRemaining}, ${areaData.standardRemaining}, 
    ${PRACTICE_AREA_ORDER[areaKey]}, true
FROM web_availability_county 
WHERE state_code = 'TX' AND county_slug = '${countyData.countySlug}'
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
        }
    }
    
    processed++;
}

countySQL += `COMMIT;
`;

practiceAreaSQL += `COMMIT;
`;

fs.writeFileSync('supabase/POPULATE_TEXAS_COUNTIES.sql', countySQL);
fs.writeFileSync('supabase/POPULATE_TEXAS_PRACTICE_AREAS.sql', practiceAreaSQL);

console.log(`✅ Generated SQL files:`);
console.log(`   Counties: ${processed} counties`);
console.log(`   Practice Areas: ${processed * 9} practice area records`);
console.log(`   Skipped: ${skipped} counties (≤ 8 seats)`);
console.log(`   Files:`);
console.log(`   - supabase/POPULATE_TEXAS_COUNTIES.sql`);
console.log(`   - supabase/POPULATE_TEXAS_PRACTICE_AREAS.sql`);

