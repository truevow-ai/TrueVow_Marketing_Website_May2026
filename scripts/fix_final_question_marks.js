const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, '..', 'marketing', 'index.html');

console.log('🔧 Fixing final remaining question marks...\n');

let content = fs.readFileSync(filePath, 'utf8');
const before = content;

// Fix remaining question marks in step flow
content = content.replace(/"Broken wrist\."<\/em>\s*\?/g, '"Broken wrist."</em> ✅');
content = content.replace(/"Thursday at 2 p\.m\.\?"<\/em>\s*\?\s*<em>/g, '"Thursday at 2 p.m.?"</em> ✅ <em>');

// Fix bullet points - ensure all questions have bullets
content = content.replace(/(\s+)\s+"When did it happen\?"/g, '$1• "When did it happen?"');
content = content.replace(/(\s+)\s+"Where\?"/g, '$1• "Where?"');
content = content.replace(/(\s+)\s+"Who at fault\?"/g, '$1• "Who at fault?"');
content = content.replace(/(\s+)\s+"Injuries\?"/g, '$1• "Injuries?"');

if (content !== before) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log('✅ Fixed final question marks!');
} else {
    console.log('⚠️  No changes made');
}

