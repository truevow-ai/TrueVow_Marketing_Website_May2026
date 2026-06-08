const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, '..', 'marketing', 'index.html');

console.log('🔧 Fixing bullet points in INCLUDED and NEVER PAY FOR lists...\n');

let content = fs.readFileSync(filePath, 'utf8');
const before = content;

// Fix bullet points in INCLUDED section - replace corrupted char with •
content = content.replace(/(<p style="font-size: 15pt; line-height: 2;">)\s*[^\w•<](<strong style="color: #10B981;">11 FREE)/g, '$1                • $2');
content = content.replace(/(<\/strong><br>)\s*[^\w•<](24\/7 phone)/g, '$1                • $2');
content = content.replace(/(<\/strong><br>)\s*[^\w•<](Up to 16)/g, '$1                • $2');
content = content.replace(/(<\/strong><br>)\s*[^\w•<](Dangerous)/g, '$1                • $2');
content = content.replace(/(<\/strong><br>)\s*[^\w•<](Automatic)/g, '$1                • $2');
content = content.replace(/(<\/strong><br>)\s*[^\w•<](Spanish)/g, '$1                • $2');
content = content.replace(/(<\/strong><br>)\s*[^\w•<](Real-time)/g, '$1                • $2');
content = content.replace(/(<\/strong><br>)\s*[^\w•<](Website)/g, '$1                • $2');
content = content.replace(/(<\/strong><br>)\s*[^\w•<](CRM)/g, '$1                • $2');

// Fix bullet points in NEVER PAY FOR section
content = content.replace(/(<p style="font-size: 15pt; line-height: 2;">)\s*[^\w•<](Monthly minimums)/g, '$1                • $2');
content = content.replace(/(ZERO!\)<br>)\s*[^\w•<](Setup fees)/g, '$1                • $2');
content = content.replace(/(ZERO!\)<br>)\s*[^\w•<](Contracts)/g, '$1                • $2');
content = content.replace(/(ZERO!\)<br>)\s*[^\w•<](Spam calls)/g, '$1                • $2');
content = content.replace(/(ZERO!\)<br>)\s*[^\w•<](Wrong practice)/g, '$1                • $2');
content = content.replace(/(ZERO!\)<br>)\s*[^\w•<](Expired statutes)/g, '$1                • $2');

// More aggressive: replace any corrupted char at start of list items
content = content.replace(/(<br>)\s*[^\w•<](24\/7|Up to|Dangerous|Automatic|Spanish|Real-time|Website|CRM|Monthly|Setup|Contracts|Spam|Wrong|Expired)/g, '$1                • $2');

if (content !== before) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log('✅ Fixed bullet points in pricing lists!');
} else {
    console.log('⚠️  No changes - trying direct replacement...');
    // Direct replacement approach
    content = content.replace(/\s*[^\w•<](24\/7 phone answering)/g, '                • 24/7 phone answering');
    content = content.replace(/\s*[^\w•<](Up to 16 practice)/g, '                • Up to 16 practice');
    content = content.replace(/\s*[^\w•<](Dangerous admission)/g, '                • Dangerous admission');
    content = content.replace(/\s*[^\w•<](Automatic calendar)/g, '                • Automatic calendar');
    content = content.replace(/\s*[^\w•<](Spanish included)/g, '                • Spanish included');
    content = content.replace(/\s*[^\w•<](Real-time analytics)/g, '                • Real-time analytics');
    content = content.replace(/\s*[^\w•<](Website chatbot)/g, '                • Website chatbot');
    content = content.replace(/\s*[^\w•<](CRM integration)/g, '                • CRM integration');
    content = content.replace(/\s*[^\w•<](Monthly minimums)/g, '                • Monthly minimums');
    content = content.replace(/\s*[^\w•<](Setup fees)/g, '                • Setup fees');
    content = content.replace(/\s*[^\w•<](Contracts \(Cancel)/g, '                • Contracts (Cancel');
    content = content.replace(/\s*[^\w•<](Spam calls)/g, '                • Spam calls');
    content = content.replace(/\s*[^\w•<](Wrong practice areas)/g, '                • Wrong practice areas');
    content = content.replace(/\s*[^\w•<](Expired statutes)/g, '                • Expired statutes');
    
    if (content !== before) {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log('✅ Fixed using direct replacement!');
    }
}

