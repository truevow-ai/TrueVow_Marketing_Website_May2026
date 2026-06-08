const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, '..', 'marketing', 'index.html');

console.log('🔧 Cleaning corrupted characters before bullets...\n');

let content = fs.readFileSync(filePath, 'utf8');
const before = content;

// Remove corrupted char followed by spaces and bullet
content = content.replace(/[^\w\s•✅❌🎁🛡️→<>\n\r]/g, '');

// Fix specific patterns: corrupted char + spaces + bullet
content = content.replace(/\s*•/g, '•');
content = content.replace(/\s+/g, '');
content = content.replace(/\s+•\s+/g, ' • ');

// Fix the INCLUDED section specifically
content = content.replace(/(<p style="font-size: 15pt; line-height: 2;">)\s*[^\w•<](<strong)/g, '$1                • $2');
content = content.replace(/(<br>)\s*[^\w•<](\s*•)/g, '$1                $2');

// Fix the NEVER PAY FOR section
content = content.replace(/(<p style="font-size: 15pt; line-height: 2;">)\s*[^\w•<](Monthly)/g, '$1                • Monthly');

if (content !== before) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log('✅ Cleaned corrupted characters!');
} else {
    console.log('⚠️  No changes - trying different approach...');
    
    // More aggressive: find and replace the exact pattern
    const lines = content.split('\n');
    let changed = false;
    
    for (let i = 0; i < lines.length; i++) {
        const line = lines[i];
        // If line has corrupted char followed by bullet
        if (line.includes('') && line.includes('•')) {
            lines[i] = line.replace(/\s*/g, '');
            changed = true;
        }
        // If line starts with corrupted char before text
        if (line.match(/^\s*\s*[A-Z]/)) {
            lines[i] = line.replace(/^\s*\s*/, '                • ');
            changed = true;
        }
    }
    
    if (changed) {
        content = lines.join('\n');
        fs.writeFileSync(filePath, content, 'utf8');
        console.log('✅ Fixed using line-by-line approach!');
    } else {
        console.log('⚠️  No corrupted characters found');
    }
}

