/**
 * Fix premium calculation logic in all state generation scripts
 * Ensures premium is always 21% of each cap (rounded), with minimal adjustments only if total doesn't match
 */

const fs = require('fs');
const path = require('path');

// The OLD problematic code (premium calculated early, then redistributed incorrectly)
const OLD_PREMIUM_LOGIC = /const premium = Math\.max\(1, Math\.round\(cap \* PREMIUM_PERCENTAGE\)\);\s+const standard = Math\.max\(0, cap - premium\);\s+const filled = Math\.round\(cap \* FILLED_PERCENTAGE\);\s+const premiumRemaining = Math\.max\(0, premium - Math\.round\(filled \* \(premium \/ cap\)\)\);\s+const standardRemaining = Math\.max\(0, standard - Math\.round\(filled \* \(standard \/ cap\)\)\);\s+practiceAreas\[areaKey\] = \{[\s\S]*?standardRemaining: standardRemaining[\s\S]*?\};/;

// The NEW correct code (premium calculated AFTER caps are finalized)
const NEW_PREMIUM_LOGIC = `        // Don't calculate premium yet - wait until caps are finalized
        practiceAreas[areaKey] = {
            ...areaData,
            cap: cap
        };`;

// The OLD premium redistribution (breaks 21% per-cap rule)
const OLD_REDISTRIBUTION = /\/\/ Calculate total premium at county level \(21% of total_seats\) - MUST BE EXACT[\s\S]*?currentPremiumTotal = Object\.values\(practiceAreas\)\.reduce\(\(sum, a\) => sum \+ a\.premium, 0\);/;

// The NEW premium calculation (21% of each cap, then minimal adjustments)
const NEW_PREMIUM_CALC = `    // NOW calculate premium for each practice area: 21% of cap (rounded) - MUST BE EXACT PER AREA
    // Then adjust if total doesn't match 21% of total_seats
    const expectedPremiumTotal = Math.round(totalSeats * PREMIUM_PERCENTAGE);
    
    // First pass: Calculate premium as 21% of each cap
    for (const [areaKey, areaData] of Object.entries(practiceAreas)) {
        const cap = areaData.cap;
        // Premium is 21% of cap, rounded - this is the PRIMARY rule
        areaData.premium = cap === 0 ? 0 : Math.max(0, Math.round(cap * PREMIUM_PERCENTAGE));
        areaData.standard = cap - areaData.premium;
    }
    
    // Check if total premium matches expected
    let currentPremiumTotal = Object.values(practiceAreas).reduce((sum, a) => sum + a.premium, 0);
    
    // If total doesn't match, make minimal adjustments while keeping each premium close to 21% of cap
    if (currentPremiumTotal !== expectedPremiumTotal) {
        const diff = expectedPremiumTotal - currentPremiumTotal;
        const areas = Object.entries(practiceAreas)
            .map(([key, data]) => ({ key, cap: data.cap, premium: data.premium, idealPremium: Math.round(data.cap * PREMIUM_PERCENTAGE) }))
            .sort((a, b) => {
                // Sort by how far current premium is from ideal (ascending), then by cap (descending)
                const aDiff = Math.abs(a.premium - a.idealPremium);
                const bDiff = Math.abs(b.premium - b.idealPremium);
                if (aDiff !== bDiff) return aDiff - bDiff;
                return b.cap - a.cap;
            });
        
        if (diff > 0) {
            // Need to add premium seats - add to areas where current premium < ideal
            let remaining = diff;
            for (const area of areas) {
                if (remaining <= 0) break;
                if (area.premium < area.idealPremium && area.premium < area.cap) {
                    const add = Math.min(1, remaining, area.idealPremium - area.premium, area.cap - area.premium);
                    practiceAreas[area.key].premium += add;
                    practiceAreas[area.key].standard -= add;
                    remaining -= add;
                }
            }
            // If still need to add, add to largest caps
            if (remaining > 0) {
                const sortedByCap = areas.sort((a, b) => b.cap - a.cap);
                for (const area of sortedByCap) {
                    if (remaining <= 0) break;
                    if (practiceAreas[area.key].premium < area.cap) {
                        const add = Math.min(1, remaining, area.cap - practiceAreas[area.key].premium);
                        practiceAreas[area.key].premium += add;
                        practiceAreas[area.key].standard -= add;
                        remaining -= add;
                    }
                }
            }
        } else {
            // Need to remove premium seats - remove from areas where current premium > ideal
            let remaining = -diff;
            for (const area of areas) {
                if (remaining <= 0) break;
                if (area.premium > area.idealPremium && area.premium > 0) {
                    const remove = Math.min(1, remaining, area.premium - area.idealPremium, area.premium);
                    practiceAreas[area.key].premium -= remove;
                    practiceAreas[area.key].standard += remove;
                    remaining -= remove;
                }
            }
            // If still need to remove, remove from smallest caps
            if (remaining > 0) {
                const sortedByCap = areas.sort((a, b) => a.cap - b.cap);
                for (const area of sortedByCap) {
                    if (remaining <= 0) break;
                    if (practiceAreas[area.key].premium > 0) {
                        const remove = Math.min(1, remaining, practiceAreas[area.key].premium);
                        practiceAreas[area.key].premium -= remove;
                        practiceAreas[area.key].standard += remove;
                        remaining -= remove;
                    }
                }
            }
        }
    }
    
    // Now calculate filled and remaining seats
    for (const [areaKey, areaData] of Object.entries(practiceAreas)) {
        const cap = areaData.cap;
        const premium = areaData.premium;
        const standard = areaData.standard;
        const filled = Math.round(cap * FILLED_PERCENTAGE);
        
        areaData.filled = filled;
        areaData.premiumRemaining = Math.max(0, premium - Math.round(filled * (premium / Math.max(1, cap))));
        areaData.standardRemaining = Math.max(0, standard - Math.round(filled * (standard / Math.max(1, cap))));
    }`;

// Get all state generation scripts
const scriptsDir = path.join(__dirname);
const files = fs.readdirSync(scriptsDir)
    .filter(f => f.startsWith('generate_') && f.endsWith('_sql.js') && f !== 'generate_dc_sql.js'); // DC already fixed

let fixed = 0;
let skipped = 0;
let errors = 0;

for (const file of files) {
    const filePath = path.join(scriptsDir, file);
    let content = fs.readFileSync(filePath, 'utf8');
    
    // Check if already fixed
    if (content.includes('NOW calculate premium for each practice area: 21% of cap')) {
        console.log(`⏭️  Already fixed: ${file}`);
        skipped++;
        continue;
    }
    
    try {
        // Step 1: Replace early premium calculation with deferred calculation
        if (content.match(OLD_PREMIUM_LOGIC)) {
            content = content.replace(OLD_PREMIUM_LOGIC, NEW_PREMIUM_LOGIC);
        }
        
        // Step 2: Find and replace the premium redistribution section
        // Find the section after cap adjustment and before "Now calculate remaining seats"
        const capAdjustmentEnd = content.indexOf('// Recalculate premium/standard for all adjusted areas');
        if (capAdjustmentEnd > 0) {
            // Find the end of the premium redistribution section
            const remainingSeatsStart = content.indexOf('// Now calculate remaining seats with corrected premium/standard values');
            if (remainingSeatsStart > 0) {
                // Replace the section between cap adjustment and remaining seats calculation
                const before = content.substring(0, capAdjustmentEnd);
                const after = content.substring(remainingSeatsStart);
                
                // Find where the premium redistribution ends
                const premiumRedistEnd = content.lastIndexOf('currentPremiumTotal = Object.values(practiceAreas).reduce((sum, a) => sum + a.premium, 0);', remainingSeatsStart);
                if (premiumRedistEnd > capAdjustmentEnd) {
                    const oldSection = content.substring(capAdjustmentEnd, remainingSeatsStart);
                    // Replace the old recalculation + redistribution with new logic
                    content = before + NEW_PREMIUM_CALC + '\n    ' + after;
                } else {
                    // Fallback: just replace the recalculation section
                    const recalcSection = /\/\/ Recalculate premium\/standard for all adjusted areas[\s\S]*?standardRemaining = Math\.max\(0, adjustedArea\.standard - Math\.round\(adjustedArea\.filled \* \(adjustedArea\.standard \/ adjustedArea\.cap\)\)\);/;
                    if (content.match(recalcSection)) {
                        content = content.replace(recalcSection, '');
                    }
                }
            }
        }
        
        // Step 3: Replace the old premium redistribution with new logic
        if (content.includes('// Calculate total premium at county level (21% of total_seats) - MUST BE EXACT')) {
            // Find the entire redistribution block and replace it
            const redistStart = content.indexOf('// Calculate total premium at county level (21% of total_seats) - MUST BE EXACT');
            const redistEnd = content.indexOf('// Now calculate remaining seats with corrected premium/standard values', redistStart);
            
            if (redistEnd > redistStart) {
                const beforeRedist = content.substring(0, redistStart);
                const afterRedist = content.substring(redistEnd);
                content = beforeRedist + NEW_PREMIUM_CALC + '\n    ' + afterRedist;
            }
        }
        
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`✅ Fixed: ${file}`);
        fixed++;
    } catch (error) {
        console.log(`❌ Error fixing ${file}: ${error.message}`);
        errors++;
    }
}

console.log(`\n✅ Fixed ${fixed} files`);
console.log(`⏭️  Skipped ${skipped} files (already fixed)`);
console.log(`❌ Errors: ${errors} files`);
console.log(`\nAll state generation scripts now use the corrected premium calculation!`);

