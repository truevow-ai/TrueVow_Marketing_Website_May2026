// Simple script to generate SQL INSERT statements from county-cap.html
// Reads the file and extracts data directly

const fs = require('fs');
const path = require('path');

const htmlFile = path.join(__dirname, '..', 'marketing', 'county-cap.html');
const outputFile = path.join(__dirname, '..', 'supabase', 'POPULATE_COUNTY_AVAILABILITY_DATA.sql');

console.log('Reading HTML file...');
const content = fs.readFileSync(htmlFile, 'utf8');

// Find the practiceAreaData object
const startMarker = 'const practiceAreaData = {';
const endMarker = '};';
const startIdx = content.indexOf(startMarker);
const endIdx = content.indexOf(endMarker, startIdx) + 2;

if (startIdx === -1 || endIdx === 1) {
    console.error('Could not find practiceAreaData object');
    process.exit(1);
}

const dataStr = content.substring(startIdx + startMarker.length, endIdx - 2);

// Practice area order
const practiceAreaOrder = {
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

// Florida counties list
const flCounties = new Set([
    'miami-dade', 'broward', 'palm-beach', 'hillsborough', 'orange', 'duval', 'pinellas',
    'brevard', 'volusia', 'polk', 'lee', 'sarasota', 'manatee', 'escambia', 'marion',
    'alachua', 'leon', 'okaloosa', 'seminole', 'pasco', 'hernando', 'citrus', 'lake',
    'st-lucie', 'indian-river', 'martin', 'charlotte', 'collier', 'bay', 'osceola',
    'clay', 'santa-rosa', 'walton', 'highlands', 'putnam', 'flagler', 'monroe',
    'gadsden', 'sumter', 'taylor', 'columbia', 'suwannee', 'washington', 'calhoun',
    'franklin', 'gulf', 'holmes', 'jackson', 'jefferson', 'lafayette', 'liberty',
    'madison', 'union', 'wakulla', 'baker', 'bradford', 'dixie', 'gilchrist',
    'hamilton', 'hardee', 'hendry', 'levy'
]);

// Extract county data using regex
const countyPattern = /"([^"]+)":\s*\{[^}]*"overall":\s*\{([^}]+)\}[^}]*"practiceAreas":\s*\{([^}]+)\}/g;
const counties = [];

let match;
while ((match = countyPattern.exec(dataStr)) !== null) {
    const countySlug = match[1];
    const overallStr = match[2];
    const practiceAreasStr = match[3];
    
    // Parse overall data
    const overall = {};
    const overallMatches = overallStr.matchAll(/"([^"]+)":\s*(\d+)/g);
    for (const m of overallMatches) {
        overall[m[1]] = parseInt(m[2]);
    }
    
    // Parse practice areas
    const practiceAreas = {};
    const paPattern = /"([^"]+)":\s*\{([^}]+)\}/g;
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
    
    counties.push({ countySlug, overall, practiceAreas });
}

console.log(`Found ${counties.length} counties`);

// Generate SQL
const sql = [];
sql.push('-- ============================================');
sql.push('-- POPULATE WEB_AVAILABILITY_COUNTY AND WEB_AVAILABILITY_PRACTICE_AREA_SEATS');
sql.push('-- Generated from marketing/county-cap.html practiceAreaData');
sql.push('-- ============================================\n');

sql.push('-- Clear existing data (optional)');
sql.push('-- TRUNCATE TABLE web_availability_practice_area_seats CASCADE;');
sql.push('-- TRUNCATE TABLE web_availability_county CASCADE;\n');

// Generate county inserts
sql.push('-- ============================================');
sql.push('-- INSERT COUNTY DATA');
sql.push('-- ============================================\n');

counties.forEach(({ countySlug, overall }) => {
    const stateCode = flCounties.has(countySlug) ? 'FL' : 'CA';
    let countyName = countySlug.replace(/-/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
    
    // Special cases
    if (countySlug === 'miami-dade') countyName = 'Miami-Dade';
    else if (countySlug === 'st-lucie') countyName = 'St. Lucie';
    else if (countySlug === 'los-angeles') countyName = 'Los Angeles';
    else if (countySlug === 'san-diego') countyName = 'San Diego';
    else if (countySlug === 'san-bernardino') countyName = 'San Bernardino';
    else if (countySlug === 'santa-clara') countyName = 'Santa Clara';
    else if (countySlug === 'orange-ca') countyName = 'Orange';
    
    sql.push(`-- ${countyName} County, ${stateCode}`);
    sql.push(`INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    '${stateCode}',
    '${countySlug}',
    '${countyName}',
    ${overall.totalFirms || 0},
    ${overall.totalSeats || 0},
    ${overall.premiumTotal || 0},
    ${overall.standardTotal || 0},
    ${overall.filled || 0},
    ${overall.premiumRemaining || 0},
    ${overall.standardRemaining || 0},
    true
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
`);
});

// Generate practice area inserts
sql.push('\n-- ============================================');
sql.push('-- INSERT PRACTICE AREA DATA');
sql.push('-- ============================================\n');

counties.forEach(({ countySlug, practiceAreas }) => {
    const stateCode = flCounties.has(countySlug) ? 'FL' : 'CA';
    
    if (!practiceAreas || Object.keys(practiceAreas).length === 0) {
        return;
    }
    
    sql.push(`-- Practice areas for ${countySlug}`);
    
    Object.entries(practiceAreas).forEach(([paSlug, paData]) => {
        const displayOrder = practiceAreaOrder[paSlug] || 0;
        const totalFirms = paData.totalFirms || paData.firms || 0;
        const name = (paData.name || '').replace(/'/g, "''"); // Escape single quotes
        
        sql.push(`INSERT INTO web_availability_practice_area_seats (
    county_availability_id, practice_area_slug, practice_area_name,
    total_firms, cap, premium, standard,
    filled, premium_remaining, standard_remaining,
    display_order, is_active
) 
SELECT 
    id,
    '${paSlug}',
    '${name}',
    ${totalFirms},
    ${paData.cap || 0},
    ${paData.premium || 0},
    ${paData.standard || 0},
    ${paData.filled || 0},
    ${paData.premiumRemaining || paData.premium_remaining || 0},
    ${paData.standardRemaining || paData.standard_remaining || 0},
    ${displayOrder},
    true
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
`);
    });
});

sql.push('\n-- ============================================');
sql.push('-- VERIFICATION');
sql.push('-- ============================================\n');
sql.push('SELECT \'County records:\' AS type, COUNT(*) AS count FROM web_availability_county;');
sql.push('SELECT \'Practice area records:\' AS type, COUNT(*) AS count FROM web_availability_practice_area_seats;');
sql.push('SELECT state_code, COUNT(*) AS county_count FROM web_availability_county GROUP BY state_code;\n');

// Write SQL file
fs.writeFileSync(outputFile, sql.join('\n'), 'utf8');
console.log(`✅ SQL file generated: ${outputFile}`);
console.log(`   Counties: ${counties.length}`);
console.log(`   Ready to run in Supabase SQL Editor`);

