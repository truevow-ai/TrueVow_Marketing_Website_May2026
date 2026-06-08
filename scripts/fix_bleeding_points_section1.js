const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, '..', 'marketing', 'index.html');

console.log('🔧 Fixing Section 1: First bleeding point (You miss 24 calls)...\n');

let content = fs.readFileSync(filePath, 'utf8');
const before = content;

// Fix first bleeding point section
// Replace corrupted bullet at start
content = content.replace(/(<strong>)\s*\s*(You miss 24 calls)/g, '$1• $2');

// Replace corrupted dashes with em-dashes
content = content.replace(/(62% never call back)\s+\s+(they find)/g, '$1 — $2');
content = content.replace(/(24 missed calls)\s+\s+(62% lost)/g, '$1 — $2');
content = content.replace(/(the serious cases call)\s+\s+(right after)/g, '$1 — $2');
content = content.replace(/(bleeding your future)\s+\s+(one missed)/g, '$1 — $2');

// Replace corrupted multiplication signs
content = content.replace(/(15 cases)\s+\s+(\$5,150)/g, '$1 × $2');
content = content.replace(/(net\/case)\s+\s+(12 months)/g, '$1 × $2');

// Fix "not because" - replace corrupted character with em-dash
content = content.replace(/(24 calls every month<\/strong>)\s+\s+(not because)/g, '$1 — $2');

if (content !== before) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log('✅ Fixed Section 1: First bleeding point');
    console.log('  ✓ • bullet at start');
    console.log('  ✓ — dashes for separators');
    console.log('  ✓ × for multiplication');
} else {
    console.log('⚠️  No changes made - patterns may need adjustment');
}

