/**
 * Fix missing return statements in all state files
 */

const fs = require('fs');
const path = require('path');

const scriptsDir = path.join(__dirname);
const files = fs.readdirSync(scriptsDir)
    .filter(f => f.startsWith('generate_') && f.endsWith('_sql.js') && f !== 'generate_dc_sql.js');

const MISSING_RETURN_PATTERN = /areaData\.standardRemaining = Math\.max\(0, standard - Math\.round\(filled \* \(standard \/ Math\.max\(1, cap\)\)\)\);\s*\n\s*\}\s*\n\s*\/\/ Generate SQL for counties/;

const RETURN_CODE = `    }
    
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
    
    if (content.match(MISSING_RETURN_PATTERN)) {
        content = content.replace(MISSING_RETURN_PATTERN, RETURN_CODE);
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`✅ Fixed: ${file}`);
        fixed++;
    }
}

console.log(`\n✅ Fixed ${fixed} files`);

