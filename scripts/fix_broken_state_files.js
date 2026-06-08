/**
 * Fix all broken state files by removing duplicate code sections
 */

const fs = require('fs');
const path = require('path');

const scriptsDir = path.join(__dirname);
const files = fs.readdirSync(scriptsDir)
    .filter(f => f.startsWith('generate_') && f.endsWith('_sql.js') && f !== 'generate_dc_sql.js');

let fixed = 0;

for (const file of files) {
    const filePath = path.join(scriptsDir, file);
    let content = fs.readFileSync(filePath, 'utf8');
    let modified = false;
    
    // Remove duplicate comment line
    if (content.includes('// Now calculate remaining seats with corrected premium/standard values')) {
        content = content.replace(/\/\/ Now calculate remaining seats with corrected premium\/standard values\n/g, '');
        modified = true;
    }
    
    // Ensure proper closing of calculateCountyData function
    // Check if return statement exists after the filled/remaining calculation
    const returnMatch = content.match(/areaData\.standardRemaining = Math\.max\(0, standard - Math\.round\(filled \* \(standard \/ Math\.max\(1, cap\)\)\)\);\s*\n\s*\/\/ Now calculate remaining seats/);
    if (returnMatch) {
        // Find where the return should be
        const afterRemaining = content.indexOf('areaData.standardRemaining = Math.max(0, standard - Math.round(filled * (standard / Math.max(1, cap))));');
        if (afterRemaining > 0) {
            const nextLine = content.indexOf('\n', afterRemaining) + 1;
            const checkReturn = content.substring(nextLine, nextLine + 100);
            if (!checkReturn.includes('const totalFilled')) {
                // Insert the missing totals calculation and return
                const insertPoint = nextLine;
                const insertCode = `    }
    
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
`;
                content = content.substring(0, insertPoint) + insertCode + content.substring(insertPoint);
                modified = true;
            }
        }
    }
    
    if (modified) {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`✅ Fixed: ${file}`);
        fixed++;
    }
}

console.log(`\n✅ Fixed ${fixed} files`);

