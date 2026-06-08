/**
 * Generate practice areas SQL for ALL Texas counties
 * Reads from database and generates SQL file
 */

const { Client } = require('pg');
const fs = require('fs');
require('dotenv').config({ path: '.env.local' });

const SOLO_SMALL_PERCENTAGE = 0.67;
const PREMIUM_PERCENTAGE = 0.21;
const FILLED_PERCENTAGE = 0.12;

const PRACTICE_AREA_DISTRIBUTION = {
    "personal-injury": 0.25, "family-law": 0.20, "immigration": 0.15,
    "criminal-defense": 0.12, "employment-law": 0.08, "real-estate": 0.07,
    "bankruptcy": 0.05, "estate-planning": 0.04, "workers-comp": 0.04
};

const PRACTICE_AREA_ORDER = {
    'personal-injury': 1, 'family-law': 2, 'immigration': 3, 'criminal-defense': 4,
    'employment-law': 5, 'bankruptcy': 6, 'real-estate': 7, 'estate-planning': 8, 'workers-comp': 9
};

const PRACTICE_AREA_NAMES = {
    'personal-injury': 'Personal Injury', 'family-law': 'Family Law', 'immigration': 'Immigration',
    'criminal-defense': 'Criminal Defense', 'employment-law': 'Employment Law', 'bankruptcy': 'Bankruptcy',
    'real-estate': 'Real Estate', 'estate-planning': 'Estate Planning', 'workers-comp': 'Workers Compensation'
};

function calculatePracticeAreas(totalLawOffices, totalSeats) {
    const totalSoloSmall = Math.round(totalLawOffices * SOLO_SMALL_PERCENTAGE);
    const practiceAreas = {};
    
    for (const [areaKey, distribution] of Object.entries(PRACTICE_AREA_DISTRIBUTION)) {
        const areaFirms = Math.round(totalSoloSmall * distribution);
        let cap = Math.round(totalSeats * distribution);
        if (cap < 1) cap = 0;
        
        const premium = cap > 0 ? Math.max(1, Math.round(cap * PREMIUM_PERCENTAGE)) : 0;
        const standard = Math.max(0, cap - premium);
        const filled = cap > 0 ? Math.round(cap * FILLED_PERCENTAGE) : 0;
        const premiumRemaining = cap > 0 ? Math.max(0, premium - Math.round(filled * (premium / cap))) : 0;
        const standardRemaining = cap > 0 ? Math.max(0, standard - Math.round(filled * (standard / cap))) : 0;
        
        practiceAreas[areaKey] = { totalFirms: areaFirms, cap, premium, standard, filled, premiumRemaining, standardRemaining };
    }
    
    let finalTotalCap = Object.values(practiceAreas).reduce((sum, a) => sum + a.cap, 0);
    if (finalTotalCap !== totalSeats) {
        const sortedAreas = Object.entries(practiceAreas).sort((a, b) => b[1].cap - a[1].cap);
        const diff = totalSeats - finalTotalCap;
        if (sortedAreas.length > 0 && sortedAreas[0][1].cap > 0) {
            const largestArea = sortedAreas[0][0];
            practiceAreas[largestArea].cap += diff;
            const adjustedArea = practiceAreas[largestArea];
            adjustedArea.premium = Math.max(1, Math.round(adjustedArea.cap * PREMIUM_PERCENTAGE));
            adjustedArea.standard = Math.max(0, adjustedArea.cap - adjustedArea.premium);
            adjustedArea.filled = Math.round(adjustedArea.cap * FILLED_PERCENTAGE);
            adjustedArea.premiumRemaining = Math.max(0, adjustedArea.premium - Math.round(adjustedArea.filled * (adjustedArea.premium / adjustedArea.cap)));
            adjustedArea.standardRemaining = Math.max(0, adjustedArea.standard - Math.round(adjustedArea.filled * (adjustedArea.standard / adjustedArea.cap)));
        }
    }
    
    return practiceAreas;
}

async function main() {
    let connectionString = process.env.SUPABASE_DB_URL || process.env.MARKETING_DATABASE_URL;
    if (!connectionString) {
        try {
            const { execSync } = require('child_process');
            connectionString = execSync('supabase db remote get-connection-string', { encoding: 'utf8', stdio: ['pipe', 'pipe', 'ignore'] }).trim();
            console.log('Using Supabase CLI connection');
        } catch (e) {
            console.error('No connection string found');
            process.exit(1);
        }
    }
    
    const url = new URL(connectionString);
    const client = new Client({
        host: url.hostname, port: parseInt(url.port || '5432'),
        database: url.pathname.slice(1) || 'postgres',
        user: url.username || 'postgres',
        password: decodeURIComponent(url.password),
        ssl: { rejectUnauthorized: false },
    });
    
    try {
        await client.connect();
        console.log('✅ Connected to database');
        process.stdout.write('Querying counties... ');
        
        const counties = await client.query(`
            SELECT id, county_slug, county_name, total_firms, total_seats
            FROM web_availability_county 
            WHERE state_code = 'TX' AND is_active = true
            ORDER BY total_seats DESC
        `);
        
        console.log(`Found ${counties.rows.length} Texas counties`);
        if (counties.rows.length === 0) {
            console.error('❌ No counties found! Make sure Texas county data is populated first.');
            await client.end();
            process.exit(1);
        }
        
        const sql = [];
        sql.push('BEGIN;');
        sql.push('');
        sql.push('-- Delete existing Texas practice areas');
        sql.push("DELETE FROM web_availability_practice_area_seats WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = 'TX');");
        sql.push('');
        sql.push('-- Insert practice areas for all Texas counties');
        sql.push('-- EXACT same structure as Florida (cap, premium, standard columns)');
        sql.push('');
        
        let totalInserts = 0;
        for (const county of counties.rows) {
            process.stdout.write(`Processing ${county.county_name}... `);
            const practiceAreas = calculatePracticeAreas(county.total_firms, county.total_seats);
            let countyInserts = 0;
            
            for (const [areaKey, areaData] of Object.entries(practiceAreas)) {
                if (areaData.cap > 0) {
                    sql.push(`INSERT INTO web_availability_practice_area_seats`);
                    sql.push(`(county_availability_id, practice_area_slug, practice_area_name, total_firms,`);
                    sql.push(` cap, premium, standard, filled, premium_remaining, standard_remaining, display_order)`);
                    sql.push(`SELECT id, '${areaKey}', '${PRACTICE_AREA_NAMES[areaKey].replace(/'/g, "''")}', ${areaData.totalFirms}, ${areaData.cap}, ${areaData.premium}, ${areaData.standard}, ${areaData.filled}, ${areaData.premiumRemaining}, ${areaData.standardRemaining}, ${PRACTICE_AREA_ORDER[areaKey]}`);
                    sql.push(`FROM web_availability_county WHERE state_code = 'TX' AND county_slug = '${county.county_slug}';`);
                    sql.push('');
                    countyInserts++;
                    totalInserts++;
                }
            }
            console.log(`${countyInserts} practice areas`);
        }
        
        sql.push('COMMIT;');
        
        fs.writeFileSync('supabase/POPULATE_TEXAS_PRACTICE_AREAS.sql', sql.join('\n'));
        console.log(`\n✅ Generated supabase/POPULATE_TEXAS_PRACTICE_AREAS.sql`);
        console.log(`   Counties processed: ${counties.rows.length}`);
        console.log(`   Total practice area records: ${totalInserts}`);
        
        await client.end();
        console.log('\n✅ Script completed successfully');
    } catch (error) {
        console.error('\n❌ ERROR:', error.message);
        console.error(error.stack);
        process.exit(1);
    }
}

main().catch(err => {
    console.error('Unhandled error:', err);
    process.exit(1);
});

