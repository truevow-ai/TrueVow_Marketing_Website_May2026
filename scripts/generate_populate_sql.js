// ============================================
// Generate SQL INSERT statements for county data
// Reads marketing/county-cap.html and generates SQL file
// ============================================

const fs = require('fs');
const path = require('path');

// Practice area order
const PRACTICE_AREA_ORDER = {
    'personal-injury': 1,
    'family-law': 2,
    'immigration': 3,
    'criminal-defense': 4,
    'employment-law': 5,
    'bankruptcy': 6,
    'real-estate': 7,
    'estate-planning': 8,
    'workers-comp': 9
};

// Florida counties
const FL_COUNTIES = new Set([
    'miami-dade', 'broward', 'palm-beach', 'hillsborough', 'orange', 'duval', 'pinellas',
    'brevard', 'volusia', 'polk', 'lee', 'sarasota', 'manatee', 'escambia', 'marion',
    'alachua', 'leon', 'okaloosa', 'seminole', 'pasco', 'hernando', 'citrus', 'lake',
    'st-lucie', 'collier', 'osceola', 'indian-river', 'charlotte', 'martin', 'bay',
    'okeechobee', 'highlands', 'walton', 'gulf', 'santa-rosa', 'clay', 'putnam',
    'flagler', 'sumter', 'monroe', 'columbia', 'jackson', 'taylor', 'gadsden',
    'madison', 'hamilton', 'jefferson', 'lafayette', 'liberty', 'franklin', 'wakulla',
    'calhoun', 'gilchrist', 'dixie', 'union', 'baker', 'bradford', 'hendry', 'hardee',
    'glades', 'de-soto'
]);

function formatCountyName(slug) {
    return slug
        .split('-')
        .map(word => word.charAt(0).toUpperCase() + word.slice(1))
        .join(' ');
}

function extractPracticeAreaData(htmlContent) {
    // Use the exact same method as populate_county_data.js - regex-based parsing
    const startMarker = 'const practiceAreaData = {';
    const startIdx = htmlContent.indexOf(startMarker);
    
    if (startIdx === -1) {
        throw new Error('Could not find practiceAreaData in HTML file');
    }
    
    // Find the end of the object (look for closing brace at same level)
    let braceCount = 0;
    let inString = false;
    let escapeNext = false;
    let i = startIdx + startMarker.length;
    
    while (i < htmlContent.length) {
        const char = htmlContent[i];
        
        if (escapeNext) {
            escapeNext = false;
            i++;
            continue;
        }
        
        if (char === '\\') {
            escapeNext = true;
            i++;
            continue;
        }
        
        if (char === '"') {
            inString = !inString;
        } else if (!inString) {
            if (char === '{') {
                braceCount++;
            } else if (char === '}') {
                braceCount--;
                if (braceCount === -1) {
                    break;
                }
            }
        }
        
        i++;
    }
    
    const objStr = htmlContent.substring(startIdx + startMarker.length, i);
    
    // Use the same regex-based parsing as populate_county_data.js
    return parseJSObject(objStr);
}

function parseJSObject(objStr) {
    const data = {};
    
    // Extract county blocks - handle nested objects properly
    // Match: "county-slug": { "overall": {...}, "practiceAreas": {...} }
    const countyPattern = /"([^"]+)":\s*\{[^}]*"overall":\s*\{([^}]+)\}[^}]*"practiceAreas":\s*\{([^}]+)\}/g;
    let match;
    
    while ((match = countyPattern.exec(objStr)) !== null) {
        const countySlug = match[1];
        const overallStr = match[2];
        const practiceAreasStr = match[3];
        
        // Parse overall
        const overall = {};
        const overallMatches = overallStr.matchAll(/"([^"]+)":\s*(\d+)/g);
        for (const m of overallMatches) {
            overall[m[1]] = parseInt(m[2]);
        }
        
        // Parse practice areas - handle nested objects
        const practiceAreas = {};
        // Match practice area objects that may contain nested structures
        const paPattern = /"([^"]+)":\s*\{([^}]+(?:\{[^}]*\}[^}]*)*)\}/g;
        let paMatch;
        
        while ((paMatch = paPattern.exec(practiceAreasStr)) !== null) {
            const paSlug = paMatch[1];
            const paDataStr = paMatch[2];
            const paData = {};
            
            // Extract name
            const nameMatch = paDataStr.match(/"name":\s*"([^"]+)"/);
            if (nameMatch) paData.name = nameMatch[1];
            
            // Extract numeric fields
            const numMatches = paDataStr.matchAll(/"([^"]+)":\s*(\d+)/g);
            for (const m of numMatches) {
                paData[m[1]] = parseInt(m[2]);
            }
            
            practiceAreas[paSlug] = paData;
        }
        
        data[countySlug] = { overall, practiceAreas };
    }
    
    return data;
}

function generateSQL(practiceAreaData) {
    let sql = `-- ============================================\n`;
    sql += `-- Populate County Availability Tables\n`;
    sql += `-- Generated from marketing/county-cap.html\n`;
    sql += `-- ============================================\n\n`;
    
    sql += `BEGIN;\n\n`;
    
    // Generate INSERT statements for counties
    sql += `-- Insert Counties\n`;
    for (const [countySlug, countyData] of Object.entries(practiceAreaData)) {
        const overall = countyData.overall || {};
        const stateCode = FL_COUNTIES.has(countySlug) ? 'FL' : 'CA';
        const countyName = formatCountyName(countySlug);
        
        sql += `INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    '${stateCode}', '${countySlug}', '${countyName.replace(/'/g, "''")}',
    ${overall.totalFirms || 0}, ${overall.totalSeats || 0},
    ${overall.premiumTotal || 0}, ${overall.standardTotal || 0},
    ${overall.filled || 0}, ${overall.premiumRemaining || 0},
    ${overall.standardRemaining || 0}, true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();

`;
    }
    
    // Generate INSERT statements for practice areas
    sql += `\n-- Insert Practice Area Seats\n`;
    for (const [countySlug, countyData] of Object.entries(practiceAreaData)) {
        const practiceAreas = countyData.practiceAreas || {};
        const stateCode = FL_COUNTIES.has(countySlug) ? 'FL' : 'CA';
        
        for (const [paSlug, paData] of Object.entries(practiceAreas)) {
            const paName = paData.name || paSlug;
            const displayOrder = PRACTICE_AREA_ORDER[paSlug] || 0;
            
            sql += `INSERT INTO web_availability_practice_area_seats (
    county_availability_id, practice_area_slug, practice_area_name,
    total_firms, cap, premium, standard,
    filled, premium_remaining, standard_remaining, display_order, is_active
)
SELECT 
    id, '${paSlug}', '${paName.replace(/'/g, "''")}',
    ${paData.totalFirms || paData.firms || 0}, ${paData.cap || 0},
    ${paData.premium || 0}, ${paData.standard || 0},
    ${paData.filled || 0}, ${paData.premiumRemaining || 0},
    ${paData.standardRemaining || 0}, ${displayOrder}, true
FROM web_availability_county
WHERE state_code = '${stateCode}' AND county_slug = '${countySlug}'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    updated_at = now();

`;
        }
    }
    
    sql += `COMMIT;\n`;
    
    return sql;
}

// Main execution
const htmlPath = path.join(__dirname, '..', 'marketing', 'county-cap.html');
console.log(`📖 Reading ${htmlPath}...`);

const htmlContent = fs.readFileSync(htmlPath, 'utf8');
console.log(`✅ HTML file read (${(htmlContent.length / 1024).toFixed(2)} KB)\n`);

console.log(`🔍 Extracting practiceAreaData...`);
const practiceAreaData = extractPracticeAreaData(htmlContent);
console.log(`✅ Found ${Object.keys(practiceAreaData).length} counties\n`);

console.log(`📝 Generating SQL...`);
const sql = generateSQL(practiceAreaData);

const outputPath = path.join(__dirname, '..', 'supabase', 'POPULATE_COUNTY_AVAILABILITY_DATA.sql');
fs.writeFileSync(outputPath, sql, 'utf8');

console.log(`✅ SQL file generated: ${outputPath}`);
console.log(`📊 File size: ${(sql.length / 1024).toFixed(2)} KB`);
console.log(`\n💡 Next step: Copy the contents of ${outputPath} and execute it in Supabase Dashboard SQL Editor`);

