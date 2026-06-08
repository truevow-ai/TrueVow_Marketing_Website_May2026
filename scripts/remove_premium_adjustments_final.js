/**
 * Remove premium adjustment logic - disable the if block that adjusts premiums
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
    
    // Replace the if condition to disable adjustments
    if (content.includes('if (currentPremiumTotal !== expectedPremiumTotal) {')) {
        content = content.replace(
            /if \(currentPremiumTotal !== expectedPremiumTotal\) \{/g,
            'if (false) { // DISABLED: Premium MUST be exactly 21% of each cap - no adjustments allowed'
        );
        modified = true;
    }
    
    // Also add comment before the check
    if (content.includes('// Check if total premium matches expected') && !content.includes('CRITICAL: Premium MUST be exactly')) {
        content = content.replace(
            /\/\/ Check if total premium matches expected/,
            '// CRITICAL: Premium MUST be exactly 21% of each cap (rounded)\n    // DO NOT adjust individual premiums - this breaks the 21% per-cap rule\n    // Total premium may be off by ±1-2 seats due to rounding - that\'s acceptable\n    // Check if total premium matches expected (for info only, no adjustment)'
        );
        modified = true;
    }
    
    if (modified) {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`✅ Fixed: ${file}`);
        fixed++;
    }
}

console.log(`\n✅ Fixed ${fixed} files`);
console.log(`Premium adjustments are now DISABLED - premium will always be 21% of each cap`);

