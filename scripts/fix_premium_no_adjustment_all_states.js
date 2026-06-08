/**
 * Remove premium adjustment logic from all state files
 * Premium MUST be exactly 21% of each cap - no adjustments allowed
 */

const fs = require('fs');
const path = require('path');

const scriptsDir = path.join(__dirname);
const files = fs.readdirSync(scriptsDir)
    .filter(f => f.startsWith('generate_') && f.endsWith('_sql.js') && f !== 'generate_dc_sql.js');

// Match the adjustment block more flexibly
const ADJUSTMENT_START = /\/\/ Check if total premium matches expected/;
const ADJUSTMENT_END = /\/\/ Now calculate filled and remaining seats/;

const REPLACEMENT = `    // CRITICAL: Premium MUST be exactly 21% of each cap (rounded)
    // DO NOT adjust individual premiums to match total - this breaks the 21% per-cap rule
    // Total premium may be off by ±1-2 seats due to rounding - that's acceptable
    // Individual premium accuracy is more important than total premium accuracy
    
    // Now calculate filled and remaining seats`;

let fixed = 0;

for (const file of files) {
    const filePath = path.join(scriptsDir, file);
    let content = fs.readFileSync(filePath, 'utf8');
    
    if (content.includes('// CRITICAL: Premium MUST be exactly 21% of each cap')) {
        console.log(`⏭️  Already fixed: ${file}`);
        continue;
    }
    
    // Find the adjustment block
    const startMatch = content.match(ADJUSTMENT_START);
    const endMatch = content.match(ADJUSTMENT_END);
    
    if (startMatch && endMatch && startMatch.index < endMatch.index) {
        // Find the end of the if block
        let startPos = startMatch.index;
        let endPos = endMatch.index;
        
        // Extract the section to replace
        const before = content.substring(0, startPos);
        const after = content.substring(endPos);
        
        // Replace with the new code
        content = before + REPLACEMENT + '\n    ' + after;
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`✅ Fixed: ${file}`);
        fixed++;
    }
}

console.log(`\n✅ Fixed ${fixed} files`);
console.log(`Premium will now ALWAYS be exactly 21% of each cap (rounded)`);

