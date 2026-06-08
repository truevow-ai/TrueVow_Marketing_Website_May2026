/**
 * Generate SQL file for Texas practice areas
 * This replicates the EXACT structure used for Florida
 */

const { Client } = require('pg');
const fs = require('fs');
require('dotenv').config({ path: '.env.local' });

const STATE_CODE = 'TX';
const SOLO_SMALL_PERCENTAGE = 0.67;
const PREMIUM_PERCENTAGE = 0.21;
const FILLED_PERCENTAGE = 0.12;

const PRACTICE_AREA_DISTRIBUTION = {
    "personal-injury": 0.25,
    "family-law": 0.20,
    "immigration": 0.15,
    "criminal-defense": 0.12,
    "employment-law": 0.08,
    "real-estate": 0.07,
    "bankruptcy": 0.05,
    "estate-planning": 0.04,
    "workers-comp": 0.04
};

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

const PRACTICE_AREA_NAMES = {
    'personal-injury': 'Personal Injury',
    'family-law': 'Family Law',
    'immigration': 'Immigration',
    'criminal-defense': 'Criminal Defense',
    'employment-law': 'Employment Law',
    'bankruptcy': 'Bankruptcy',
    'real-estate': 'Real Estate',
    'estate-planning': 'Estate Planning',
    'workers-comp': 'Workers Compensation'
};

// Get connection
let connectionString = process.env.SUPABASE_DB_URL || process.env.MARKETING_DATABASE_URL;

if (!connectionString) {
    try {
        const { execSync } = require('child_process');
        connectionString = execSync('supabase db remote get-connection-string', { encoding: 'utf8', stdio: ['pipe', 'pipe', 'ignore'] }).trim();
    } catch (e) {}
}

const url = new URL(connectionString);
const client = new Client({
    host: url.hostname,
    port: parseInt(url.port || '5432'),
    database: url.pathname.slice(1) || 'postgres',
    user: url.username || 'postgres',
    password: decodeURIComponent(url.password),
    ssl: { rejectUnauthorized: false },
});

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
        
        practiceAreas[areaKey] = {
            totalFirms: areaFirms,
            cap: cap,
            premium: premium,
            standard: standard,
            filled: filled,
            premiumRemaining: premiumRemaining,
            standardRemaining: standardRemaining
        };
    }
    
    // Fix rounding errors
        let finalTotalCap = Object.values(practiceAreas).reduce((sum, a) => sum + a.cap, 0);
    if (finalTotalCap !== totalSeats) {
        const diff = totalSeats - finalTotalCap;
        // Use a better distribution: prioritize areas by percentage, not just current cap
        // This ensures Personal Injury (25%) gets priority over smaller areas
        const sortedAreas = Object.entries(practiceAreas)
            .sort((a, b) => {
                // First sort by percentage (descending), then by cap (descending)
                if (Math.abs(a[1].areaPercentage - b[1].areaPercentage) > 0.001) {
                    return b[1].areaPercentage - a[1].areaPercentage;
                }
                return b[1].cap - a[1].cap;
            });
        
        if (diff > 0) {
            // Need to add seats - add to highest percentage areas first
            let remaining = diff;
            for (const [areaKey, areaData] of sortedAreas) {
                if (remaining <= 0) break;
                practiceAreas[areaKey].cap += 1;
                remaining -= 1;
            }
        } else {
            // Need to remove seats - remove from lowest percentage areas first
            let remaining = -diff;
            for (let i = sortedAreas.length - 1; i >= 0 && remaining > 0; i--) {
                const [areaKey, areaData] = sortedAreas[i];
                if (practiceAreas[areaKey].cap > 1) {
                    practiceAreas[areaKey].cap -= 1;
                    remaining -= 1;
                }
            }
            // If still need to remove, remove from smallest caps
            if (remaining > 0) {
                const sortedByCap = Object.entries(practiceAreas)
                    .sort((a, b) => a[1].cap - b[1].cap);
                for (const [areaKey, areaData] of sortedByCap) {
                    if (remaining <= 0) break;
                    if (practiceAreas[areaKey].cap > 1) {
                        practiceAreas[areaKey].cap -= 1;
                        remaining -= 1;
                    }
                }
            }
        }
        
        // Recalculate premium/standard for all adjusted areas
        for (const [areaKey, areaData] of Object.entries(practiceAreas)) {
            const cap = areaData.cap;
            areaData.premium = Math.max(1, Math.round(cap * PREMIUM_PERCENTAGE));
            areaData.standard = Math.max(0, cap - areaData.premium);
            areaData.filled = Math.round(cap * FILLED_PERCENTAGE);
            areaData.premiumRemaining = Math.max(0, areaData.premium - Math.round(areaData.filled * (areaData.premium / Math.max(1, cap))));
            areaData.standardRemaining = Math.max(0, areaData.standard - Math.round(areaData.filled * (areaData.standard / Math.max(1, cap))));
        }
    }
    
    return practiceAreas;
}

async function generateSQL() {
    await client.connect();
    console.log('✅ Connected to database');
    
    const counties = await client.query(`
        SELECT id, county_slug, county_name, total_firms, total_seats
        FROM web_availability_county
        WHERE state_code = $1 AND is_active = true
        ORDER BY total_seats DESC
    `, [STATE_CODE]);
    
    console.log(`Found ${counties.rows.length} counties`);
    
    const sql = [];
    sql.push('BEGIN;');
    sql.push('');
    sql.push(`-- Delete existing ${STATE_CODE} practice areas`);
    sql.push(`DELETE FROM web_availability_practice_area_seats`);
    sql.push(`WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = '${STATE_CODE}');`);
    sql.push('');
    sql.push(`-- Insert practice areas for ${STATE_CODE} counties`);
    sql.push('');
    
    for (const county of counties.rows) {
        const practiceAreas = calculatePracticeAreas(county.total_firms, county.total_seats);
        
        for (const [areaKey, areaData] of Object.entries(practiceAreas)) {
            if (areaData.cap > 0) {
                sql.push(`INSERT INTO web_availability_practice_area_seats`);
                sql.push(`(county_availability_id, practice_area_slug, practice_area_name, total_firms,`);
                sql.push(` cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)`);
                sql.push(`VALUES (`);
                sql.push(`  '${county.id}'::uuid,`);
                sql.push(`  '${areaKey}',`);
                sql.push(`  '${PRACTICE_AREA_NAMES[areaKey].replace(/'/g, "''")}',`);
                sql.push(`  ${areaData.totalFirms},`);
                sql.push(`  ${areaData.cap},`);
                sql.push(`  ${areaData.premium},`);
                sql.push(`  ${areaData.standard},`);
                sql.push(`  ${areaData.filled},`);
                sql.push(`  ${areaData.premiumRemaining},`);
                sql.push(`  ${areaData.standardRemaining},`);
                sql.push(`  ${PRACTICE_AREA_ORDER[areaKey]},`);
                sql.push(`  true`);
                sql.push(`);`);
                sql.push('');
            }
        }
    }
    
    sql.push('COMMIT;');
    
    const sqlContent = sql.join('\n');
    fs.writeFileSync(`supabase/POPULATE_TEXAS_PRACTICE_AREAS.sql`, sqlContent);
    
    console.log(`\n✅ Generated supabase/POPULATE_TEXAS_PRACTICE_AREAS.sql`);
    console.log(`   Total counties: ${counties.rows.length}`);
    console.log(`   Total practice area records: ${sqlContent.split('INSERT INTO').length - 1}`);
    
    await client.end();
}

generateSQL().catch(console.error);

