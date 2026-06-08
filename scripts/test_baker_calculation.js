// Test the calculation logic for Baker County specifically
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

// Baker County: 12 BLS offices
const totalLawOffices = 12;
const totalSoloSmall = Math.round(totalLawOffices * SOLO_SMALL_PERCENTAGE); // 8 firms

console.log('Baker County Calculation Test:');
console.log('='.repeat(60));
console.log(`BLS Offices: ${totalLawOffices}`);
console.log(`Solo/Small Firms (67%): ${totalSoloSmall}`);
console.log('');

// Calculate max total seats (33% of total firms)
const maxTotalSeats = totalSoloSmall < 24 
    ? Math.max(2, Math.round(totalSoloSmall * CAP_PERCENTAGE))
    : Math.max(8, Math.round(totalSoloSmall * CAP_PERCENTAGE));

console.log(`Max Total Seats (33%): ${maxTotalSeats}`);
console.log('');

// Calculate practice areas
const practiceAreas = {};
let totalCalculatedCap = 0;

for (const [areaKey, percentage] of Object.entries(PRACTICE_AREA_DISTRIBUTION)) {
    const areaFirms = Math.max(1, Math.round(totalSoloSmall * percentage));
    const idealCap = Math.round(areaFirms * CAP_PERCENTAGE);
    
    practiceAreas[areaKey] = {
        name: areaKey,
        totalFirms: areaFirms,
        idealCap: idealCap
    };
    
    totalCalculatedCap += idealCap;
}

console.log('Practice Area Breakdown:');
Object.values(practiceAreas).forEach(pa => {
    console.log(`  ${pa.name}: ${pa.totalFirms} firms → ${pa.idealCap} seats (ideal)`);
});
console.log(`\nTotal Ideal Caps: ${totalCalculatedCap}`);

// Scale if needed
let scaleFactor = 1;
if (totalCalculatedCap > maxTotalSeats) {
    scaleFactor = maxTotalSeats / totalCalculatedCap;
    console.log(`\nScale Factor: ${scaleFactor.toFixed(4)} (needed because ${totalCalculatedCap} > ${maxTotalSeats})`);
}

let finalTotal = 0;
console.log('\nFinal Practice Area Caps (after scaling):');
for (const [areaKey, areaData] of Object.entries(practiceAreas)) {
    let cap = Math.round(areaData.idealCap * scaleFactor);
    if (cap === 0 && areaData.totalFirms > 0) {
        cap = 1;
    }
    
    // For small counties, distribute proportionally
    if (totalSoloSmall < 24) {
        const proportionalCap = Math.round(maxTotalSeats * (areaData.totalFirms / totalSoloSmall));
        cap = Math.max(1, Math.min(cap, proportionalCap));
    }
    
    finalTotal += cap;
    console.log(`  ${areaData.name}: ${cap} seats`);
}

console.log(`\nFinal Total Seats: ${finalTotal}`);
console.log(`Expected Max: ${maxTotalSeats}`);
console.log(`Total Firms: ${totalSoloSmall}`);
console.log(`\nStatus: ${finalTotal <= totalSoloSmall && finalTotal <= maxTotalSeats + 1 ? '✅ CORRECT' : '❌ WRONG'}`);

