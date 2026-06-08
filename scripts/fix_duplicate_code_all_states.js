/**
 * Remove duplicate code sections from all state files
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
    
    // Remove duplicate code after function closing brace
    const duplicatePattern = /}\s+for \(const \[areaKey, areaData\] of Object\.entries\(practiceAreas\)\) \{[\s\S]*?practiceAreas\[areaKey\]\.standardRemaining = Math\.max\(0, standard - Math\.round\(filled \* \(standard \/ Math\.max\(1, cap\)\)\)\);\s*\}/;
    if (content.match(duplicatePattern)) {
        content = content.replace(duplicatePattern, '}');
        modified = true;
    }
    
    // Fix currentPremiumTotal reference
    if (content.includes('const totalPremium = currentPremiumTotal;')) {
        content = content.replace(/const totalPremium = currentPremiumTotal;/g, 'const totalPremium = Object.values(practiceAreas).reduce((sum, a) => sum + a.premium, 0);');
        modified = true;
    }
    
    if (modified) {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`✅ Fixed: ${file}`);
        fixed++;
    }
}

console.log(`\n✅ Fixed ${fixed} files`);

