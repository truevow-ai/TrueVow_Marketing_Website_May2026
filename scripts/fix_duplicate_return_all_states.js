/**
 * Remove duplicate return statements and calculations from all state files
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
    
    // Remove duplicate return block after function closing brace
    // Pattern: } followed by duplicate calculations and return
    const duplicatePattern = /}\s+\n\s+const totalFilled = Object\.values\(practiceAreas\)\.reduce\(\(sum, a\) => sum \+ a\.filled, 0\);\s*\n\s+const totalPremiumRemaining = Object\.values\(practiceAreas\)\.reduce\(\(sum, a\) => sum \+ a\.premiumRemaining, 0\);\s*\n\s+const totalStandardRemaining = Object\.values\(practiceAreas\)\.reduce\(\(sum, a\) => sum \+ a\.standardRemaining, 0\);\s*\n\s+const totalPremium = Object\.values\(practiceAreas\)\.reduce\(\(sum, a\) => sum \+ a\.premium, 0\);\s*\n\s+const totalStandard = Object\.values\(practiceAreas\)\.reduce\(\(sum, a\) => sum \+ a\.standard, 0\);\s*\n\s+return \{[\s\S]*?practiceAreas: practiceAreas\s*\};[\s\S]*?\}/;
    
    if (content.match(duplicatePattern)) {
        content = content.replace(duplicatePattern, '}');
        modified = true;
    }
    
    // Also check for simpler pattern - just the duplicate calculations after }
    const simplePattern = /}\s*\n\s*const totalFilled = Object\.values\(practiceAreas\)\.reduce/;
    if (content.match(simplePattern) && !content.match(/\/\/ Generate SQL for counties/)) {
        // Find the end of the duplicate block (next function or comment)
        const match = content.match(/}\s*\n\s*(const totalFilled = Object\.values\(practiceAreas\)\.reduce[\s\S]*?practiceAreas: practiceAreas\s*\};\s*\n\s*\})/);
        if (match) {
            content = content.replace(match[1], '');
            modified = true;
        }
    }
    
    if (modified) {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`✅ Fixed: ${file}`);
        fixed++;
    }
}

console.log(`\n✅ Fixed ${fixed} files`);

