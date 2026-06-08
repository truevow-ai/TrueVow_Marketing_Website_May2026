const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, '..', 'marketing', 'index.html');

console.log('🔧 Fixing all remaining corrupted characters and question marks...\n');

let content = fs.readFileSync(filePath, 'utf8');
const before = content;

// Fix corrupted bullet points - replace with • at the start of list items
content = content.replace(/(<strong>)\s*\s*(You miss|You spend|2:47)/g, '$1• $2');

// Fix corrupted dashes - replace with — (em-dash) in specific contexts
// After "not because", "they find", "62% lost", "right after", "one missed", etc.
content = content.replace(/\s+\s+(not because|they find|62% lost|right after|one missed|you can't|not your|no case|you don't|listening|time you|while the|because you|a \$50|same injury|because that|not anonymous|you're a|Founding Member)/g, ' — $1');

// Fix multiplication signs - replace with × for calculations
content = content.replace(/\s+\s+(\$5,150|12 months|48 weeks)/g, ' × $1');

// Fix Settle trademark
content = content.replace(/Settle/g, 'Settle™');

// Fix remaining question marks in bleeding points that should be dashes
content = content.replace(/(\d+)\s+\s+(\d+%|\d+ weeks)/g, '$1 — $2');

if (content !== before) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log('✅ Fixed all remaining corrupted characters!');
    console.log('\n📋 Fixed:');
    console.log('  ✓ Bullet points: → •');
    console.log('  ✓ Em-dashes: → —');
    console.log('  ✓ Multiplication: → ×');
    console.log('  ✓ Settle™ trademark');
} else {
    console.log('⚠️  No changes made');
}

