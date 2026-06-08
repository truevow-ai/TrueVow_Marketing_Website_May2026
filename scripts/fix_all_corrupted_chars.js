const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, '..', 'marketing', 'index.html');

console.log('🔧 Fixing all corrupted characters throughout the page...\n');

let content = fs.readFileSync(filePath, 'utf8');
const before = content;

// Replace corrupted characters by matching context - be very specific
// The corrupted char appears between words, so we match the words and replace what's between

// Section 1: First bleeding point
content = content.replace(/(<strong>)[^\w•<](You miss 24 calls)/g, '$1• $2');
content = content.replace(/(every month<\/strong>)[^\w\s—<](not because)/g, '$1 — $2');
content = content.replace(/(never call back<\/strong>)[^\w\s—<](they find)/g, '$1 — $2');
content = content.replace(/(24 missed calls)[^\w\s—<](62% lost)/g, '$1 — $2');
content = content.replace(/(15 cases)[^\w\s×<](\$5,150)/g, '$1 × $2');
content = content.replace(/(net\/case)[^\w\s×<](12 months)/g, '$1 × $2');
content = content.replace(/(serious cases call)[^\w\s—<](right after)/g, '$1 — $2');
content = content.replace(/(bleeding your future)[^\w\s—<](one missed)/g, '$1 — $2');

// Section 2: Second bleeding point
content = content.replace(/(<strong>)[^\w•<](You spend 12 hours)/g, '$1• $2');
content = content.replace(/(statute expired)[^\w\s—<](you can't help)/g, '$1 — $2');
content = content.replace(/(wrong jurisdiction)[^\w\s—<](not your license)/g, '$1 — $2');
content = content.replace(/(no liability)[^\w\s—<](no case)/g, '$1 — $2');
content = content.replace(/(wrong practice area)[^\w\s—<](you don't do that)/g, '$1 — $2');
content = content.replace(/(per call)[^\w\s—<](listening)/g, '$1 — $2');
content = content.replace(/(documenting)[^\w\s—<](only to say)/g, '$1 — $2');
content = content.replace(/(12 hours\/week)[^\w\s×<](48 weeks)/g, '$1 × $2');
content = content.replace(/(lost billable time)[^\w\s—<](time you)/g, '$1 — $2');
content = content.replace(/(never win)[^\w\s—<](while the)/g, '$1 — $2');

// Section 3: Third bleeding point
content = content.replace(/(<strong>)[^\w•<](2:47 a\.m\.)/g, '$1• $2');
content = content.replace(/(bleeding peace)[^\w\s—<](because you)/g, '$1 — $2');

// Section 4: Other sections
content = content.replace(/(24 missed calls)[^\w\s—<](62% lost)/g, '$1 — $2');
content = content.replace(/(lost cases)[^\w\s×<](\$5,150)/g, '$1 × $2');

// Fix "Average attorney results" bullets
content = content.replace(/(<p style="font-size: 16pt; line-height: 1\.8; margin-bottom: 8px;">)[^\w•<](<strong>)/g, '$1• $2');

if (content !== before) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log('✅ Fixed corrupted characters!');
    console.log('\n📋 Fixed sections:');
    console.log('  ✓ Section 1: First bleeding point');
    console.log('  ✓ Section 2: Second bleeding point');
    console.log('  ✓ Section 3: Third bleeding point');
    console.log('  ✓ Other sections');
} else {
    console.log('⚠️  No changes made');
    console.log('Trying alternative approach...');
    
    // Alternative: Replace any character that's not a standard ASCII or common Unicode
    // Match corrupted chars more broadly
    const replacements = [
        [/(<strong>)\s*[^\w•<]/g, '$1• '],
        [/(every month<\/strong>)\s*[^\w\s—<]/g, '$1 — '],
        [/(never call back<\/strong>)\s*[^\w\s—<]/g, '$1 — '],
        [/(24 missed calls)\s*[^\w\s—<]/g, '$1 — '],
        [/(15 cases)\s*[^\w\s×<]/g, '$1 × '],
        [/(net\/case)\s*[^\w\s×<]/g, '$1 × '],
        [/(serious cases call)\s*[^\w\s—<]/g, '$1 — '],
        [/(bleeding your future)\s*[^\w\s—<]/g, '$1 — '],
    ];
    
    let changed = false;
    replacements.forEach(([pattern, replacement]) => {
        const newContent = content.replace(pattern, replacement);
        if (newContent !== content) {
            content = newContent;
            changed = true;
        }
    });
    
    if (changed) {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log('✅ Fixed using alternative approach!');
    } else {
        console.log('⚠️  Still no changes - may need manual inspection');
    }
}

