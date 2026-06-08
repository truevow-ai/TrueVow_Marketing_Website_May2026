/**
 * Fix all state files to use the correct premium calculation structure
 * Remove old recalculation logic and replace with new structure
 */

const fs = require('fs');
const path = require('path');

const scriptsDir = path.join(__dirname);
const files = fs.readdirSync(scriptsDir)
    .filter(f => f.startsWith('generate_') && f.endsWith('_sql.js') && f !== 'generate_dc_sql.js' && f !== 'generate_maryland_sql.js');

const OLD_RECALC_PATTERN = /\/\/ Recalculate premium\/standard for all adjusted areas[\s\S]*?areaData\.standardRemaining = Math\.max\(0, areaData\.standard - Math\.round\(areaData\.filled \* \(areaData\.standard \/ Math\.max\(1, cap\)\)\)\);\s*\n\s*\}\s*\n\s*\}\s*\n\s*\/\/ Generate SQL for counties/;

const NEW_PREMIUM_SECTION = `    }
    
    // NOW calculate premium for each practice area: 21% of cap (rounded) - MUST BE EXACT PER AREA
    // DO NOT adjust individual premiums - premium MUST be exactly 21% of each cap
    const expectedPremiumTotal = Math.round(totalSeats * PREMIUM_PERCENTAGE);
    
    // Calculate premium as 21% of each cap - this is the PRIMARY and ONLY rule
    for (const [areaKey, areaData] of Object.entries(practiceAreas)) {
        const cap = areaData.cap;
        // Premium is 21% of cap, rounded - NO ADJUSTMENTS ALLOWED
        areaData.premium = cap === 0 ? 0 : Math.max(0, Math.round(cap * PREMIUM_PERCENTAGE));
        areaData.standard = cap - areaData.premium;
    }
    
    // CRITICAL: Premium MUST be exactly 21% of each cap (rounded)
    // DO NOT adjust individual premiums to match total - this breaks the 21% per-cap rule
    // Total premium may be off by ±1-2 seats due to rounding - that's acceptable
    // Individual premium accuracy is more important than total premium accuracy
    
    // Now calculate filled and remaining seats
    for (const [areaKey, areaData] of Object.entries(practiceAreas)) {
        const cap = areaData.cap;
        const premium = areaData.premium;
        const standard = areaData.standard;
        const filled = Math.round(cap * FILLED_PERCENTAGE);
        
        areaData.filled = filled;
        areaData.premiumRemaining = Math.max(0, premium - Math.round(filled * (premium / Math.max(1, cap))));
        areaData.standardRemaining = Math.max(0, standard - Math.round(filled * (standard / Math.max(1, cap))));
    }
    
    const totalFilled = Object.values(practiceAreas).reduce((sum, a) => sum + a.filled, 0);
    const totalPremiumRemaining = Object.values(practiceAreas).reduce((sum, a) => sum + a.premiumRemaining, 0);
    const totalStandardRemaining = Object.values(practiceAreas).reduce((sum, a) => sum + a.standardRemaining, 0);
    const totalPremium = Object.values(practiceAreas).reduce((sum, a) => sum + a.premium, 0);
    const totalStandard = Object.values(practiceAreas).reduce((sum, a) => sum + a.standard, 0);
    
    return {
        countySlug: countySlug,
        countyName: formatCountyName(countySlug),
        totalFirms: totalLawOffices,
        totalSeats: totalSeats,
        premiumTotal: totalPremium,
        standardTotal: totalStandard,
        filled: totalFilled,
        premiumRemaining: totalPremiumRemaining,
        standardRemaining: totalStandardRemaining,
        practiceAreas: practiceAreas
    };
}

// Generate SQL for counties`;

let fixed = 0;

for (const file of files) {
    const filePath = path.join(scriptsDir, file);
    let content = fs.readFileSync(filePath, 'utf8');
    
    // Check if already has the new structure
    if (content.includes('// NOW calculate premium for each practice area: 21% of cap')) {
        console.log(`⏭️  Already fixed: ${file}`);
        continue;
    }
    
    // Check if has old recalculation pattern
    if (content.match(OLD_RECALC_PATTERN)) {
        content = content.replace(OLD_RECALC_PATTERN, NEW_PREMIUM_SECTION);
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`✅ Fixed: ${file}`);
        fixed++;
    } else if (content.includes('// Recalculate premium/standard for all adjusted areas')) {
        // Try to find and replace manually
        const recalcStart = content.indexOf('// Recalculate premium/standard for all adjusted areas');
        const sqlStart = content.indexOf('// Generate SQL for counties', recalcStart);
        if (recalcStart > 0 && sqlStart > recalcStart) {
            const before = content.substring(0, recalcStart);
            const after = content.substring(sqlStart);
            content = before + NEW_PREMIUM_SECTION;
            fs.writeFileSync(filePath, content, 'utf8');
            console.log(`✅ Fixed: ${file}`);
            fixed++;
        }
    }
}

console.log(`\n✅ Fixed ${fixed} files`);

