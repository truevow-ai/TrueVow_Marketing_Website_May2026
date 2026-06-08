/**
 * Update all navigation CTAs across all landing pages
 * Change to "See Benjamin Live (8 min)" linking to index.html#form
 */

const fs = require('fs');
const path = require('path');

const marketingDir = path.join(__dirname, '..', 'marketing');
const files = fs.readdirSync(marketingDir)
    .filter(f => f.endsWith('.html') && !f.includes('backup') && !f.includes('extend'));

const OLD_CTA_PATTERNS = [
    /Start Capturing Every Call →/g,
    /Get a Demo &rarr;/g,
    /Apply Now &rarr;/g,
    /Apply Now →/g
];

const NEW_CTA_TEXT = 'See Benjamin Live (8 min) →';

let updated = 0;

for (const file of files) {
    const filePath = path.join(marketingDir, file);
    let content = fs.readFileSync(filePath, 'utf8');
    let modified = false;
    
    // Update CTA text
    for (const pattern of OLD_CTA_PATTERNS) {
        if (content.match(pattern)) {
            content = content.replace(pattern, NEW_CTA_TEXT);
            modified = true;
        }
    }
    
    // Update href to point to index.html#form (or #form if on index.html)
    if (file === 'index.html') {
        // On index.html, use #form
        content = content.replace(
            /href=["']#form["'].*?See Benjamin Live \(8 min\)/g,
            'href="#form" style="background: #0A2463; color: #FFFFFF !important; padding: 12px 24px; border-radius: 8px; font-size: 16px; font-weight: 600; text-decoration: none; transition: background 0.2s ease; font-family: inherit;" onmouseover="this.style.background=\'#0052CC\'" onmouseout="this.style.background=\'#0A2463\'">See Benjamin Live (8 min)'
        );
        // Also update any that might link to apply.html
        content = content.replace(
            /href=["']apply\.html["'].*?See Benjamin Live \(8 min\)/g,
            'href="#form" style="background: #0A2463; color: #FFFFFF !important; padding: 12px 24px; border-radius: 8px; font-size: 16px; font-weight: 600; text-decoration: none; transition: background 0.2s ease; font-family: inherit;" onmouseover="this.style.background=\'#0052CC\'" onmouseout="this.style.background=\'#0A2463\'">See Benjamin Live (8 min)'
        );
    } else {
        // On other pages, link to index.html#form
        content = content.replace(
            /href=["']apply\.html["'].*?See Benjamin Live \(8 min\)/g,
            'href="index.html#form" style="background: #0A2463; color: #FFFFFF !important; padding: 12px 24px; border-radius: 8px; font-size: 16px; font-weight: 600; text-decoration: none; transition: background 0.2s ease; font-family: inherit;" onmouseover="this.style.background=\'#0052CC\'" onmouseout="this.style.background=\'#0A2463\'">See Benjamin Live (8 min)'
        );
    }
    
    // Also catch any navigation CTA that might have different structure
    const navCtaPattern = /<a href=["'](?:apply\.html|#form)["'][^>]*style=["'][^"']*background:[^"']*#0A2463[^"']*["'][^>]*>(?:Start Capturing Every Call|Get a Demo|Apply Now)[^<]*<\/a>/g;
    if (content.match(navCtaPattern)) {
        if (file === 'index.html') {
            content = content.replace(navCtaPattern, 
                '<a href="#form" style="background: #0A2463; color: #FFFFFF !important; padding: 12px 24px; border-radius: 8px; font-size: 16px; font-weight: 600; text-decoration: none; transition: background 0.2s ease; font-family: inherit;" onmouseover="this.style.background=\'#0052CC\'" onmouseout="this.style.background=\'#0A2463\'">See Benjamin Live (8 min) →</a>'
            );
        } else {
            content = content.replace(navCtaPattern, 
                '<a href="index.html#form" style="background: #0A2463; color: #FFFFFF !important; padding: 12px 24px; border-radius: 8px; font-size: 16px; font-weight: 600; text-decoration: none; transition: background 0.2s ease; font-family: inherit;" onmouseover="this.style.background=\'#0052CC\'" onmouseout="this.style.background=\'#0A2463\'">See Benjamin Live (8 min) →</a>'
            );
        }
        modified = true;
    }
    
    if (modified) {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`✅ Updated: ${file}`);
        updated++;
    }
}

console.log(`\n✅ Updated ${updated} files`);
console.log(`All navigation CTAs now say: "See Benjamin Live (8 min)"`);
console.log(`All CTAs link to: index.html#form (or #form on index.html)`);

