const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, '..', 'marketing', 'index.html');

console.log('🔧 Fixing remaining question marks and corrupted characters...\n');

let content = fs.readFileSync(filePath, 'utf8');
const before = content;

// Fix time ranges
content = content.replace(/Minutes 1[^\d-]3/g, 'Minutes 1-3');
content = content.replace(/Minutes 3[^\d-]8/g, 'Minutes 3-8');
content = content.replace(/Minutes 10[^\d-]11/g, 'Minutes 10-11');

// Fix numbered icons
content = content.replace(/1\?\?/g, '1️⃣');
content = content.replace(/2\?\?/g, '2️⃣');
content = content.replace(/3\?\?/g, '3️⃣');

// Fix question mark separators (but not in JavaScript code like ?.value)
content = content.replace(/(?<!→)\s*\?\s*(?!\.|value|message|hint|<!--)/g, ' → ');

// Fix Settle trademark
content = content.replace(/Settle([^\w™])/g, 'Settle™$1');

// Fix corrupted characters - replace common Unicode issues
// These are the actual corrupted characters that appear as in the file
const replacements = [
    // Bullet points
    [/(?=\s*You miss)/g, '•'],
    [/(?=\s*You spend)/g, '•'],
    [/(?=\s*2:47)/g, '•'],
    // Dashes/em-dashes
    [/(?=\s*not because)/g, '—'],
    [/(?=\s*they find)/g, '—'],
    [/(?=\s*62% lost)/g, '—'],
    [/(?=\s*\$5,150)/g, ' × '],
    [/(?=\s*12 months)/g, ' × '],
    [/(?=\s*right after)/g, '—'],
    [/(?=\s*one missed)/g, '—'],
    [/(?=\s*you can't)/g, '—'],
    [/(?=\s*not your)/g, '—'],
    [/(?=\s*no case)/g, '—'],
    [/(?=\s*you don't)/g, '—'],
    [/(?=\s*listening)/g, '—'],
    [/(?=\s*48 weeks)/g, ' × '],
    [/(?=\s*time you)/g, '—'],
    [/(?=\s*while the)/g, '—'],
    [/(?=\s*because you)/g, '—'],
    [/(?=\s*a \$50)/g, '—'],
    [/(?=\s*same injury)/g, '—'],
    [/(?=\s*because that)/g, '—'],
    [/(?=\s*not anonymous)/g, '—'],
    [/(?=\s*you're a)/g, '—'],
    [/(?=\s*Founding Member)/g, '—'],
];

replacements.forEach(([pattern, replacement]) => {
    content = content.replace(pattern, replacement);
});

// Fix step flow dialogue checkmarks
content = content.replace(/"When did it happen?"\s*\?\s*<em>/g, '"When did it happen?" ✅ <em>');
content = content.replace(/<\/em>\s*\?\s*<br>/g, '</em> ✅<br>');
content = content.replace(/"Where?"\s*\?\s*<em>/g, '"Where?" ✅ <em>');
content = content.replace(/"Who at fault?"\s*\?\s*<em>/g, '"Who at fault?" ✅ <em>');
content = content.replace(/"Injuries?"\s*\?\s*<em>/g, '"Injuries?" ✅ <em>');
content = content.replace(/"Thursday at 2 p\.m\?"\s*\?\s*<em>/g, '"Thursday at 2 p.m.?" ✅ <em>');

// Fix bullet points in step flow
content = content.replace(/\s*"When did it happen?"/g, '• "When did it happen?"');
content = content.replace(/\s*"Where?"/g, '• "Where?"');
content = content.replace(/\s*"Who at fault?"/g, '• "Who at fault?"');
content = content.replace(/\s*"Injuries?"/g, '• "Injuries?"');

// Fix Miami-Dade arrow
content = content.replace(/Miami-Dade\s*\?\s*<strong/g, 'Miami-Dade → <strong');

if (content !== before) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log('✅ Fixed all remaining question marks and corrupted characters!');
    console.log('\n📋 Summary:');
    console.log('  ✓ Time ranges: Minutes 1-3, 3-8, 10-11');
    console.log('  ✓ Numbered icons: 1️⃣, 2️⃣, 3️⃣');
    console.log('  ✓ Separators: → (arrows)');
    console.log('  ✓ Bullet points: •');
    console.log('  ✓ Em-dashes: —');
    console.log('  ✓ Checkmarks: ✅');
    console.log('  ✓ Settle™ trademark');
} else {
    console.log('⚠️  No changes made');
}

