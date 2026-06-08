/**
 * Add missing closing brace to all state files
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
    
    const openBraces = (content.match(/{/g) || []).length;
    const closeBraces = (content.match(/}/g) || []).length;
    
    if (openBraces !== closeBraces) {
        const diff = openBraces - closeBraces;
        if (diff > 0) {
            // Add missing closing brace(s)
            content += '\n' + '}'.repeat(diff);
            fs.writeFileSync(filePath, content, 'utf8');
            console.log(`✅ Fixed: ${file} (added ${diff} closing brace(s))`);
            fixed++;
        } else {
            console.log(`⚠️  ${file} has ${Math.abs(diff)} extra closing brace(s) - manual review needed`);
        }
    }
}

console.log(`\n✅ Fixed ${fixed} files`);

