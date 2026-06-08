/**
 * Debug script to trace DC calculation issues
 */

const totalSeats = 396;
const PREMIUM_PERCENTAGE = 0.21;

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

console.log('=== DC Calculation Debug ===\n');
console.log(`Total Seats: ${totalSeats}\n`);

// Step 1: Calculate ideal caps
const idealCaps = {};
let totalIdeal = 0;
for (const [area, pct] of Object.entries(PRACTICE_AREA_DISTRIBUTION)) {
    const ideal = Math.round(totalSeats * pct);
    idealCaps[area] = ideal;
    totalIdeal += ideal;
    console.log(`${area} (${(pct*100).toFixed(0)}%): ${ideal}`);
}
console.log(`\nTotal Ideal Caps: ${totalIdeal} (should be ${totalSeats}, diff: ${totalIdeal - totalSeats})`);

// Step 2: Apply scale factor
const scaleFactor = totalSeats / totalIdeal;
console.log(`\nScale Factor: ${scaleFactor.toFixed(6)}`);

const scaledCaps = {};
let totalScaled = 0;
for (const [area, ideal] of Object.entries(idealCaps)) {
    const scaled = Math.round(ideal * scaleFactor);
    scaledCaps[area] = scaled;
    totalScaled += scaled;
    console.log(`${area}: ${ideal} * ${scaleFactor.toFixed(6)} = ${(ideal * scaleFactor).toFixed(2)} → ${scaled}`);
}
console.log(`\nTotal Scaled Caps: ${totalScaled} (should be ${totalSeats}, diff: ${totalScaled - totalSeats})`);

// Step 3: Adjust to match total
if (totalScaled !== totalSeats) {
    const diff = totalSeats - totalScaled;
    const sorted = Object.entries(scaledCaps).sort((a, b) => b[1] - a[1]);
    const largest = sorted[0][0];
    scaledCaps[largest] += diff;
    console.log(`\nAdjustment: Adding ${diff} to ${largest}`);
    console.log(`${largest}: ${scaledCaps[largest] - diff} → ${scaledCaps[largest]}`);
}

// Step 4: Calculate premiums
console.log(`\n=== Premium Calculations ===`);
let totalPremium = 0;
for (const [area, cap] of Object.entries(scaledCaps)) {
    const premium = Math.round(cap * PREMIUM_PERCENTAGE);
    const standard = cap - premium;
    totalPremium += premium;
    console.log(`${area}: cap=${cap}, premium=${premium} (${(premium/cap*100).toFixed(1)}%), standard=${standard}`);
}
console.log(`\nTotal Premium: ${totalPremium} (expected: ${Math.round(totalSeats * PREMIUM_PERCENTAGE)})`);

// Expected values
console.log(`\n=== Expected Values ===`);
console.log(`Personal Injury: cap=${Math.round(totalSeats * 0.25)}, premium=${Math.round(Math.round(totalSeats * 0.25) * 0.21)}`);
console.log(`Real Estate: cap=${Math.round(totalSeats * 0.07)}, premium=${Math.round(Math.round(totalSeats * 0.07) * 0.21)}`);

