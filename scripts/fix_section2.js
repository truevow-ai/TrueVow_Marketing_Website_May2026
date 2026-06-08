const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, '..', 'marketing', 'index.html');

console.log('🔧 Fixing Section 2: Second bleeding point...\n');

let content = fs.readFileSync(filePath, 'utf8');
const before = content;

// Fix Section 2 corrupted characters
// Match the corrupted char by matching surrounding text more precisely

content = content.replace(/(statute expired)[^\w\s—<](you can't help)/g, '$1 — $2');
content = content.replace(/(wrong jurisdiction)[^\w\s—<](not your license)/g, '$1 — $2');
content = content.replace(/(no liability)[^\w\s—<](no case)/g, '$1 — $2');
content = content.replace(/(wrong practice area)[^\w\s—<](you don't do that)/g, '$1 — $2');
content = content.replace(/(per call)[^\w\s—<](listening)/g, '$1 — $2');
content = content.replace(/(documenting)[^\w\s—<](only to say)/g, '$1 — $2');
content = content.replace(/(12 hours\/week)[^\w\s×<](48 weeks)/g, '$1 × $2');
content = content.replace(/(lost billable time)[^\w\s—<](time you)/g, '$1 — $2');
content = content.replace(/(never win)[^\w\s—<](while the)/g, '$1 — $2');
content = content.replace(/(bleeding peace)[^\w\s—<](because you)/g, '$1 — $2');

if (content !== before) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log('✅ Fixed Section 2!');
    console.log('  ✓ — dashes for separators');
    console.log('  ✓ × for multiplication');
} else {
    console.log('⚠️  No changes - trying more aggressive pattern...');
    // More aggressive: replace any non-standard char
    content = content.replace(/(statute expired)\s*[^\w\s—<]/g, '$1 — ');
    content = content.replace(/(wrong jurisdiction)\s*[^\w\s—<]/g, '$1 — ');
    content = content.replace(/(no liability)\s*[^\w\s—<]/g, '$1 — ');
    content = content.replace(/(wrong practice area)\s*[^\w\s—<]/g, '$1 — ');
    content = content.replace(/(per call)\s*[^\w\s—<]/g, '$1 — ');
    content = content.replace(/(documenting)\s*[^\w\s—<]/g, '$1 — ');
    content = content.replace(/(12 hours\/week)\s*[^\w\s×<]/g, '$1 × ');
    content = content.replace(/(lost billable time)\s*[^\w\s—<]/g, '$1 — ');
    content = content.replace(/(never win)\s*[^\w\s—<]/g, '$1 — ');
    content = content.replace(/(bleeding peace)\s*[^\w\s—<]/g, '$1 — ');
    
    if (content !== before) {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log('✅ Fixed Section 2 (aggressive pattern)!');
    }
}

