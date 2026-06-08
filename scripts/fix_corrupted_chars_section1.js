const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, '..', 'marketing', 'index.html');

console.log('🔧 Fixing Section 1: First bleeding point...\n');

let content = fs.readFileSync(filePath, 'utf8');
const before = content;

// Fix corrupted characters - match any non-standard whitespace or special char
// Pattern: match corrupted char (any char that's not normal space, dash, or letter) between specific phrases

// Fix bullet at start - replace any non-letter char before "You miss"
content = content.replace(/(<strong>)[^\w•](You miss 24 calls)/g, '$1• $2');

// Fix "not because" - replace corrupted char with em-dash
content = content.replace(/(every month<\/strong>)[^\w\s—](not because)/g, '$1 — $2');

// Fix "62% never call back" - replace corrupted char with em-dash
content = content.replace(/(never call back<\/strong>)[^\w\s—](they find)/g, '$1 — $2');

// Fix "24 missed calls" - replace corrupted char with em-dash
content = content.replace(/(24 missed calls)[^\w\s—](62% lost)/g, '$1 — $2');

// Fix "15 cases" - replace first corrupted char with ×
content = content.replace(/(15 cases)[^\w\s×](\$5,150)/g, '$1 × $2');

// Fix "net/case" - replace corrupted char with ×
content = content.replace(/(net\/case)[^\w\s×](12 months)/g, '$1 × $2');

// Fix "serious cases call" - replace corrupted char with em-dash
content = content.replace(/(serious cases call)[^\w\s—](right after)/g, '$1 — $2');

// Fix "bleeding your future" - replace corrupted char with em-dash
content = content.replace(/(bleeding your future)[^\w\s—](one missed)/g, '$1 — $2');

if (content !== before) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log('✅ Fixed Section 1!');
} else {
    // Try more aggressive pattern - match any Unicode character that's not standard
    content = content.replace(/(<strong>)[\u0080-\uFFFF](You miss)/g, '$1• $2');
    content = content.replace(/(every month<\/strong>)[\u0080-\uFFFF](not because)/g, '$1 — $2');
    content = content.replace(/(never call back<\/strong>)[\u0080-\uFFFF](they find)/g, '$1 — $2');
    content = content.replace(/(24 missed calls)[\u0080-\uFFFF](62% lost)/g, '$1 — $2');
    content = content.replace(/(15 cases)[\u0080-\uFFFF](\$5,150)/g, '$1 × $2');
    content = content.replace(/(net\/case)[\u0080-\uFFFF](12 months)/g, '$1 × $2');
    content = content.replace(/(serious cases call)[\u0080-\uFFFF](right after)/g, '$1 — $2');
    content = content.replace(/(bleeding your future)[\u0080-\uFFFF](one missed)/g, '$1 — $2');
    
    if (content !== before) {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log('✅ Fixed Section 1 (using Unicode pattern)!');
    } else {
        console.log('⚠️  No changes - checking exact characters...');
        // Show what's actually there
        const match = content.match(/(<strong>)[^\w•](You miss)/);
        if (match) {
            console.log('Found char code:', match[1].charCodeAt(1));
        }
    }
}

