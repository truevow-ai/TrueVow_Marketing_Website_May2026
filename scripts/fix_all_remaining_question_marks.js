const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, '..', 'marketing', 'index.html');

console.log('🔧 Fixing all remaining question marks and bullet points...\n');

let content = fs.readFileSync(filePath, 'utf8');
const before = content;

// Fix bullet points in INCLUDED section - replace corrupted char with •
content = content.replace(/(<p style="font-size: 15pt; line-height: 2;">)\s*[^\w•<](<strong style="color: #10B981;">11 FREE)/g, '$1                • $2');
content = content.replace(/(<br>)\s*[^\w•<](24\/7 phone answering)/g, '$1                • 24/7 phone answering');
content = content.replace(/(<br>)\s*[^\w•<](Up to 16 practice)/g, '$1                • Up to 16 practice');
content = content.replace(/(<br>)\s*[^\w•<](Dangerous admission)/g, '$1                • Dangerous admission');
content = content.replace(/(<br>)\s*[^\w•<](Automatic calendar)/g, '$1                • Automatic calendar');
content = content.replace(/(<br>)\s*[^\w•<](Spanish included)/g, '$1                • Spanish included');
content = content.replace(/(<br>)\s*[^\w•<](Real-time analytics)/g, '$1                • Real-time analytics');
content = content.replace(/(<br>)\s*[^\w•<](Website chatbot)/g, '$1                • Website chatbot');
content = content.replace(/(<br>)\s*[^\w•<](CRM integration)/g, '$1                • CRM integration');

// Fix bullet points in NEVER PAY FOR section
content = content.replace(/(<p style="font-size: 15pt; line-height: 2;">)\s*[^\w•<](Monthly minimums)/g, '$1                • Monthly minimums');
content = content.replace(/(<br>)\s*[^\w•<](Setup fees)/g, '$1                • Setup fees');
content = content.replace(/(<br>)\s*[^\w•<](Contracts \(Cancel)/g, '$1                • Contracts (Cancel');
content = content.replace(/(<br>)\s*[^\w•<](Spam calls)/g, '$1                • Spam calls');
content = content.replace(/(<br>)\s*[^\w•<](Wrong practice areas)/g, '$1                • Wrong practice areas');
content = content.replace(/(<br>)\s*[^\w•<](Expired statutes)/g, '$1                • Expired statutes');

// Fix any remaining question marks that should be icons
// Look for patterns like "? text" and replace based on context
content = content.replace(/(\s|^)\?\s+(INCLUDED|NEVER PAY FOR|BONUS|Protected)/g, '$1✅ $2');
content = content.replace(/(\s|^)\?\s+(11 FREE bookings|No credit card|5-minute demo)/g, '$1✅ $2');

if (content !== before) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log('✅ Fixed all remaining question marks and bullets!');
} else {
    console.log('⚠️  No changes made');
}

