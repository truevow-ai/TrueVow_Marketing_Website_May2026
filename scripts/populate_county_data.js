// ============================================
// Populate county availability tables from HTML data
// Reads marketing/county-cap.html and generates SQL, then executes it
// ============================================

const fs = require('fs');
const path = require('path');
const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

const SUPABASE_DB_HOST = process.env.SUPABASE_DB_HOST || process.env.MARKETING_DB_HOST || 'db.napwpkagxzqfpbearkjs.supabase.co';
const SUPABASE_DB_PORT = parseInt(process.env.SUPABASE_DB_PORT || process.env.MARKETING_DB_PORT || '5432');
const SUPABASE_DB_NAME = process.env.SUPABASE_DB_NAME || process.env.MARKETING_DB_NAME || 'postgres';
const SUPABASE_DB_USER = process.env.SUPABASE_DB_USER || process.env.MARKETING_DB_USER || 'postgres';
const SUPABASE_DB_PASSWORD = process.env.SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD;

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
    'st-lucie', 'indian-river', 'martin', 'charlotte', 'collier', 'bay', 'osceola',
    'clay', 'santa-rosa', 'walton', 'highlands', 'putnam', 'flagler', 'monroe',
    'gadsden', 'sumter', 'taylor', 'columbia', 'suwannee', 'washington', 'calhoun',
    'franklin', 'gulf', 'holmes', 'jackson', 'jefferson', 'lafayette', 'liberty',
    'madison', 'union', 'wakulla', 'baker', 'bradford', 'dixie', 'gilchrist',
    'hamilton', 'hardee', 'hendry', 'levy', 'desoto', 'glades', 'nassau', 'okeechobee', 'st-johns'
]);

function formatCountyName(slug) {
    const specialCases = {
        'miami-dade': 'Miami-Dade',
        'st-lucie': 'St. Lucie',
        'st-johns': 'St. Johns',
        'los-angeles': 'Los Angeles',
        'san-diego': 'San Diego',
        'san-bernardino': 'San Bernardino',
        'santa-clara': 'Santa Clara',
        'orange-ca': 'Orange',
        'contra-costa': 'Contra Costa',
        'del-norte': 'Del Norte',
        'el-dorado': 'El Dorado',
        'san-francisco': 'San Francisco',
        'san-joaquin': 'San Joaquin',
        'san-luis-obispo': 'San Luis Obispo',
        'san-mateo': 'San Mateo',
        'santa-barbara': 'Santa Barbara'
    };
    
    if (specialCases[slug]) return specialCases[slug];
    
    return slug.replace(/-/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
}

function extractPracticeAreaData(htmlContent) {
    // Find the practiceAreaData object
    const startMarker = 'const practiceAreaData = {';
    const endMarker = '};';
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
    
    // Use eval to parse (safe in this context - we control the input)
    // Actually, let's use a safer approach - extract with regex
    return parseJSObject(objStr);
}

function parseJSObject(objStr) {
    const data = {};
    
    // Extract county blocks using regex
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
        
        data[countySlug] = { overall, practiceAreas };
    }
    
    return data;
}

async function populateDatabase(data) {
    if (!SUPABASE_DB_PASSWORD) {
        console.error('❌ ERROR: SUPABASE_DB_PASSWORD not found in .env.local');
        process.exit(1);
    }
    
    const client = new Client({
        host: SUPABASE_DB_HOST,
        port: SUPABASE_DB_PORT,
        database: SUPABASE_DB_NAME,
        user: SUPABASE_DB_USER,
        password: SUPABASE_DB_PASSWORD,
        ssl: { rejectUnauthorized: false },
        connectionTimeoutMillis: 10000,
    });
    
    try {
        console.log('🔌 Connecting to Supabase...');
        await client.connect();
        console.log('✅ Connected\n');
        
        // Insert counties
        console.log(`📝 Inserting ${Object.keys(data).length} counties...`);
        for (const [countySlug, countyData] of Object.entries(data)) {
            const overall = countyData.overall;
            const stateCode = FL_COUNTIES.has(countySlug) ? 'FL' : 'CA';
            const countyName = formatCountyName(countySlug);
            
            await client.query(`
                INSERT INTO web_availability_county (
                    state_code, county_slug, county_name,
                    total_firms, total_seats, premium_total, standard_total,
                    filled, premium_remaining, standard_remaining, is_active
                ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
                ON CONFLICT (state_code, county_slug) DO UPDATE SET
                    total_firms = EXCLUDED.total_firms,
                    total_seats = EXCLUDED.total_seats,
                    premium_total = EXCLUDED.premium_total,
                    standard_total = EXCLUDED.standard_total,
                    filled = EXCLUDED.filled,
                    premium_remaining = EXCLUDED.premium_remaining,
                    standard_remaining = EXCLUDED.standard_remaining,
                    updated_at = now()
            `, [
                stateCode, countySlug, countyName,
                overall.totalFirms || 0, overall.totalSeats || 0,
                overall.premiumTotal || 0, overall.standardTotal || 0,
                overall.filled || 0, overall.premiumRemaining || 0,
                overall.standardRemaining || 0, true
            ]);
        }
        
        console.log('✅ Counties inserted\n');
        
        // Insert practice areas
        console.log('📝 Inserting practice areas...');
        let paCount = 0;
        for (const [countySlug, countyData] of Object.entries(data)) {
            const practiceAreas = countyData.practiceAreas || {};
            const stateCode = FL_COUNTIES.has(countySlug) ? 'FL' : 'CA';
            
            // Get county ID
            const countyResult = await client.query(
                'SELECT id FROM web_availability_county WHERE state_code = $1 AND county_slug = $2',
                [stateCode, countySlug]
            );
            
            if (countyResult.rows.length === 0) {
                console.warn(`⚠️  County not found: ${countySlug}`);
                continue;
            }
            
            const countyId = countyResult.rows[0].id;
            
            for (const [paSlug, paData] of Object.entries(practiceAreas)) {
                const displayOrder = PRACTICE_AREA_ORDER[paSlug] || 0;
                const totalFirms = paData.totalFirms || paData.firms || 0;
                
                await client.query(`
                    INSERT INTO web_availability_practice_area_seats (
                        county_availability_id, practice_area_slug, practice_area_name,
                        total_firms, cap, premium, standard,
                        filled, premium_remaining, standard_remaining,
                        display_order, is_active
                    ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)
                    ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
                        total_firms = EXCLUDED.total_firms,
                        cap = EXCLUDED.cap,
                        premium = EXCLUDED.premium,
                        standard = EXCLUDED.standard,
                        filled = EXCLUDED.filled,
                        premium_remaining = EXCLUDED.premium_remaining,
                        standard_remaining = EXCLUDED.standard_remaining,
                        display_order = EXCLUDED.display_order,
                        updated_at = now()
                `, [
                    countyId, paSlug, paData.name || '',
                    totalFirms, paData.cap || 0, paData.premium || 0, paData.standard || 0,
                    paData.filled || 0, paData.premiumRemaining || paData.premium_remaining || 0,
                    paData.standardRemaining || paData.standard_remaining || 0,
                    displayOrder, true
                ]);
                
                paCount++;
            }
        }
        
        console.log(`✅ ${paCount} practice area records inserted\n`);
        
        // Verify
        const countyCount = await client.query('SELECT COUNT(*) FROM web_availability_county');
        const paCountResult = await client.query('SELECT COUNT(*) FROM web_availability_practice_area_seats');
        
        console.log('📊 Verification:');
        console.log(`   Counties: ${countyCount.rows[0].count}`);
        console.log(`   Practice areas: ${paCountResult.rows[0].count}`);
        
        await client.end();
        console.log('\n✅ Done!');
        
    } catch (error) {
        console.error('❌ Error:', error.message);
        await client.end().catch(() => {});
        process.exit(1);
    }
}

// Main execution
const htmlFile = path.join(__dirname, '..', 'marketing', 'county-cap.html');

if (!fs.existsSync(htmlFile)) {
    console.error(`❌ HTML file not found: ${htmlFile}`);
    process.exit(1);
}

console.log('📄 Reading HTML file...');
const htmlContent = fs.readFileSync(htmlFile, 'utf8');

console.log('🔍 Extracting practiceAreaData...');
const data = extractPracticeAreaData(htmlContent);

console.log(`✅ Found ${Object.keys(data).length} counties\n`);

populateDatabase(data).catch(error => {
    console.error('Fatal error:', error);
    process.exit(1);
});

