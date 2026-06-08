const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, '..', 'marketing', 'index.html');

console.log('🔧 Cleaning up extra spaces and remaining corrupted characters...\n');

let content = fs.readFileSync(filePath, 'utf8');
const before = content;

// Remove extra spaces after em-dashes and multiplication signs
content = content.replace(/—\s{2,}/g, '— ');
content = content.replace(/×\s{2,}/g, '× ');

// Fix remaining corrupted characters in Section 2
content = content.replace(/(lost billable time)\s*[^\w\s—<]/g, '$1 — ');

// Fix any remaining corrupted characters that might be between words
// Match pattern: word + corrupted char + word, replace with word + proper separator + word
content = content.replace(/(\w+)\s*[^\w\s—×•<](time you)/g, '$1 — $2');
content = content.replace(/(\w+)\s*[^\w\s—×•<](while the)/g, '$1 — $2');
content = content.replace(/(\w+)\s*[^\w\s—×•<](because you)/g, '$1 — $2');

if (content !== before) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log('✅ Cleaned up extra spaces and remaining issues!');
} else {
    console.log('✅ No additional cleanup needed');
}

