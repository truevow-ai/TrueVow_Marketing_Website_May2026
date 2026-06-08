const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, '..', 'marketing', 'index.html');

console.log('🔧 Fixing time ranges and remaining question marks...\n');

let content = fs.readFileSync(filePath, 'utf8');
const before = content;

// Fix time ranges - match any non-digit character between numbers
content = content.replace(/Minutes 1[^\d-]3:/g, 'Minutes 1-3:');
content = content.replace(/Minutes 3[^\d-]8:/g, 'Minutes 3-8:');
content = content.replace(/Minutes 10[^\d-]11:/g, 'Minutes 10-11:');

// Fix step flow dialogue - replace ? with ✅ after quotes and before </em>
content = content.replace(/"When did it happen\?"\s*\?\s*<em>/g, '"When did it happen?" ✅ <em>');
content = content.replace(/"Where\?"\s*\?\s*<em>/g, '"Where?" ✅ <em>');
content = content.replace(/"Who at fault\?"\s*\?\s*<em>/g, '"Who at fault?" ✅ <em>');
content = content.replace(/"Injuries\?"\s*\?\s*<em>/g, '"Injuries?" ✅ <em>');
content = content.replace(/"Thursday at 2 p\.m\.\?"\s*\?\s*<em>/g, '"Thursday at 2 p.m.?" ✅ <em>');
content = content.replace(/<\/em>\s*\?\s*<br>/g, '</em> ✅<br>');

// Fix bullet points in step flow - add • before questions
content = content.replace(/(\s+)\s+"When did it happen\?"/g, '$1• "When did it happen?"');
content = content.replace(/(\s+)\s+"Where\?"/g, '$1• "Where?"');
content = content.replace(/(\s+)\s+"Who at fault\?"/g, '$1• "Who at fault?"');
content = content.replace(/(\s+)\s+"Injuries\?"/g, '$1• "Injuries?"');

// Fix CTA button
content = content.replace(/Start My Demo Call Now \?/g, 'Start My Demo Call Now 📞');

if (content !== before) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log('✅ Fixed time ranges and step flow question marks!');
} else {
    console.log('⚠️  No changes made');
}

