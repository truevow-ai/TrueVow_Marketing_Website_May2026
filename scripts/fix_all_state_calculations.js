/**
 * Fix calculation logic in all state generation scripts
 * Applies the corrected adjustment algorithm that prioritizes by percentage
 */

const fs = require('fs');
const path = require('path');

// Match the old pattern more flexibly
const OLD_PATTERN = /let finalTotalCap = Object\.values\(practiceAreas\)\.reduce\(\(sum, a\) => sum \+ a\.cap, 0\);\s+if \(finalTotalCap !== totalSeats\) \{[^}]+\}/s;

const NEW_CODE = `    let finalTotalCap = Object.values(practiceAreas).reduce((sum, a) => sum + a.cap, 0);
    if (finalTotalCap !== totalSeats) {
        const diff = totalSeats - finalTotalCap;
        // Use a better distribution: prioritize areas by percentage, not just current cap
        // This ensures Personal Injury (25%) gets priority over smaller areas
        const sortedAreas = Object.entries(practiceAreas)
            .sort((a, b) => {
                // First sort by percentage (descending), then by cap (descending)
                if (Math.abs(a[1].areaPercentage - b[1].areaPercentage) > 0.001) {
                    return b[1].areaPercentage - a[1].areaPercentage;
                }
                return b[1].cap - a[1].cap;
            });
        
        if (diff > 0) {
            // Need to add seats - add to highest percentage areas first
            let remaining = diff;
            for (const [areaKey, areaData] of sortedAreas) {
                if (remaining <= 0) break;
                practiceAreas[areaKey].cap += 1;
                remaining -= 1;
            }
        } else {
            // Need to remove seats - remove from lowest percentage areas first
            let remaining = -diff;
            for (let i = sortedAreas.length - 1; i >= 0 && remaining > 0; i--) {
                const [areaKey, areaData] = sortedAreas[i];
                if (practiceAreas[areaKey].cap > 1) {
                    practiceAreas[areaKey].cap -= 1;
                    remaining -= 1;
                }
            }
            // If still need to remove, remove from smallest caps
            if (remaining > 0) {
                const sortedByCap = Object.entries(practiceAreas)
                    .sort((a, b) => a[1].cap - b[1].cap);
                for (const [areaKey, areaData] of sortedByCap) {
                    if (remaining <= 0) break;
                    if (practiceAreas[areaKey].cap > 1) {
                        practiceAreas[areaKey].cap -= 1;
                        remaining -= 1;
                    }
                }
            }
        }
        
        // Recalculate premium/standard for all adjusted areas
        for (const [areaKey, areaData] of Object.entries(practiceAreas)) {
            const cap = areaData.cap;
            areaData.premium = Math.max(1, Math.round(cap * PREMIUM_PERCENTAGE));
            areaData.standard = Math.max(0, cap - areaData.premium);
            areaData.filled = Math.round(cap * FILLED_PERCENTAGE);
            areaData.premiumRemaining = Math.max(0, areaData.premium - Math.round(areaData.filled * (areaData.premium / Math.max(1, cap))));
            areaData.standardRemaining = Math.max(0, areaData.standard - Math.round(areaData.filled * (areaData.standard / Math.max(1, cap))));
        }
    }`;

// Get all state generation scripts
const scriptsDir = path.join(__dirname);
const files = fs.readdirSync(scriptsDir)
    .filter(f => f.startsWith('generate_') && f.endsWith('_sql.js') && f !== 'generate_dc_sql.js'); // DC already fixed

let fixed = 0;
let skipped = 0;

for (const file of files) {
    const filePath = path.join(scriptsDir, file);
    let content = fs.readFileSync(filePath, 'utf8');
    
    // Check if already fixed
    if (content.includes('prioritize areas by percentage')) {
        console.log(`⏭️  Already fixed: ${file}`);
        skipped++;
        continue;
    }
    
    // Find and replace the adjustment block
    const match = content.match(/let finalTotalCap = Object\.values\(practiceAreas\)\.reduce\(\(sum, a\) => sum \+ a\.cap, 0\);\s+if \(finalTotalCap !== totalSeats\) \{[\s\S]*?\n    \}/);
    
    if (match) {
        content = content.replace(match[0], NEW_CODE);
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`✅ Fixed: ${file}`);
        fixed++;
    } else {
        console.log(`⚠️  Pattern not found: ${file}`);
    }
}

console.log(`\n✅ Fixed ${fixed} files`);
console.log(`⏭️  Skipped ${skipped} files (already fixed)`);
console.log(`\nAll state generation scripts now use the corrected calculation algorithm!`);

