/**
 * Generate practice area seats for Texas counties
 */

const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

// Same connection logic as execute_sql_to_supabase.js
let SUPABASE_DB_HOST, SUPABASE_DB_PORT, SUPABASE_DB_NAME, SUPABASE_DB_USER, SUPABASE_DB_PASSWORD;
let decodedPassword = null;

const connectionString = process.env.SUPABASE_DB_URL || process.env.MARKETING_DATABASE_URL;
if (connectionString && connectionString.startsWith('postgresql://')) {
    try {
        const url = new URL(connectionString);
        SUPABASE_DB_USER = url.username || 'postgres';
        SUPABASE_DB_PASSWORD = url.password ? decodeURIComponent(url.password) : null;
        SUPABASE_DB_HOST = url.hostname;
        SUPABASE_DB_PORT = parseInt(url.port || '5432');
        SUPABASE_DB_NAME = url.pathname.slice(1) || 'postgres';
    } catch (e) {}
}

SUPABASE_DB_HOST = SUPABASE_DB_HOST || process.env.SUPABASE_DB_HOST || process.env.MARKETING_DB_HOST || 'db.napwpkagxzqfpbearkjs.supabase.co';
SUPABASE_DB_PORT = SUPABASE_DB_PORT || parseInt(process.env.SUPABASE_DB_PORT || process.env.MARKETING_DB_PORT || '5432');
SUPABASE_DB_NAME = SUPABASE_DB_NAME || process.env.SUPABASE_DB_NAME || process.env.MARKETING_DB_NAME || 'postgres';
SUPABASE_DB_USER = SUPABASE_DB_USER || process.env.SUPABASE_DB_USER || process.env.MARKETING_DB_USER || 'postgres';

const rawPassword = SUPABASE_DB_PASSWORD || process.env.SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD;
SUPABASE_DB_PASSWORD = rawPassword;

if (rawPassword && rawPassword.includes('%')) {
    try {
        decodedPassword = decodeURIComponent(rawPassword);
    } catch (e) {}
}

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

const SOLO_SMALL_PERCENTAGE = 0.67;
const PREMIUM_PERCENTAGE = 0.21;
const FILLED_PERCENTAGE = 0.12;

async function populatePracticeAreas() {
    if (!SUPABASE_DB_PASSWORD) {
        console.error('❌ ERROR: No password found');
        process.exit(1);
    }

    const client = new Client({
        host: SUPABASE_DB_HOST,
        port: SUPABASE_DB_PORT,
        database: SUPABASE_DB_NAME,
        user: SUPABASE_DB_USER,
        password: SUPABASE_DB_PASSWORD,
        ssl: { rejectUnauthorized: false },
    });

    try {
        await client.connect();
        console.log('✅ Connected to database\n');

        // Get all Texas counties
        const counties = await client.query(`
            SELECT id, county_slug, county_name, total_firms, total_seats
            FROM web_availability_county
            WHERE state_code = 'TX' AND is_active = true
            ORDER BY total_seats DESC
        `);

        console.log(`📊 Found ${counties.rows.length} Texas counties\n`);

        // Delete existing practice area seats for Texas
        await client.query(`
            DELETE FROM web_availability_practice_area_seats
            WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = 'TX')
        `);
        console.log('🗑️  Deleted existing practice area seats for Texas\n');

        let processed = 0;

        for (const county of counties.rows) {
            const totalLawOffices = county.total_firms;
            const totalSeats = county.total_seats;
            const totalSoloSmall = Math.round(totalLawOffices * SOLO_SMALL_PERCENTAGE);

            console.log(`Processing ${county.county_name} County (${totalSeats} seats)...`);

            // Calculate practice area breakdowns
            const practiceAreas = {};
            let totalCalculatedCap = 0;

            // First pass: Calculate ideal caps
            for (const [areaKey, percentage] of Object.entries(PRACTICE_AREA_DISTRIBUTION)) {
                const areaFirms = Math.max(1, Math.round(totalSoloSmall * percentage));
                const idealCap = Math.round(totalSeats * percentage);
                
                practiceAreas[areaKey] = {
                    totalFirms: areaFirms,
                    idealCap: idealCap,
                    areaPercentage: percentage
                };
                
                totalCalculatedCap += idealCap;
            }

            // Scale to match totalSeats
            let scaleFactor = 1;
            if (totalCalculatedCap > 0) {
                scaleFactor = totalSeats / totalCalculatedCap;
            }

            // Apply scaling and calculate premium/standard
            for (const [areaKey, areaData] of Object.entries(practiceAreas)) {
                let cap = Math.round(areaData.idealCap * scaleFactor);
                
                if (totalSeats < 9 && cap === 0) {
                    const sortedAreas = Object.entries(practiceAreas)
                        .sort((a, b) => b[1].areaPercentage - a[1].areaPercentage);
                    const areaIndex = sortedAreas.findIndex(a => a[0] === areaKey);
                    if (areaIndex < totalSeats) {
                        cap = 1;
                    } else {
                        cap = 0;
                    }
                } else if (cap === 0 && totalSeats >= 9) {
                    cap = 1;
                }

                const premium = Math.max(1, Math.round(cap * PREMIUM_PERCENTAGE));
                const standard = Math.max(0, cap - premium);
                const filled = Math.round(cap * FILLED_PERCENTAGE);
                const premiumRemaining = Math.max(0, premium - Math.round(filled * (premium / cap)));
                const standardRemaining = Math.max(0, standard - Math.round(filled * (standard / cap)));

                practiceAreas[areaKey] = {
                    ...areaData,
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
                const sortedAreas = Object.entries(practiceAreas)
                    .sort((a, b) => b[1].cap - a[1].cap);
                const diff = totalSeats - finalTotalCap;
                if (sortedAreas.length > 0) {
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

            // Insert practice area seats
            let areasInserted = 0;
            for (const [areaKey, areaData] of Object.entries(practiceAreas)) {
                if (areaData.cap > 0) {
                    await client.query(`
                        INSERT INTO web_availability_practice_area_seats
                        (county_availability_id, practice_area_slug, practice_area_name, 
                         total_firms, cap, premium, standard,
                         filled, premium_remaining, standard_remaining, display_order, is_active)
                        VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)
                    `, [
                        county.id,
                        areaKey,
                        PRACTICE_AREA_NAMES[areaKey],
                        areaData.totalFirms,
                        areaData.cap,
                        areaData.premium,
                        areaData.standard,
                        areaData.filled,
                        areaData.premiumRemaining,
                        areaData.standardRemaining,
                        PRACTICE_AREA_ORDER[areaKey],
                        true
                    ]);
                    areasInserted++;
                }
            }

            console.log(`  ✅ Inserted ${areasInserted} practice areas\n`);
            processed++;
        }

        console.log(`\n✅ Practice area population complete!`);
        console.log(`   Processed: ${processed} counties`);

        // Verify
        const verify = await client.query(`
            SELECT COUNT(*) as count
            FROM web_availability_practice_area_seats
            WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = 'TX')
        `);
        console.log(`   Total practice area records: ${verify.rows[0].count}`);

        await client.end();
        console.log('\n✅ Done!');

    } catch (error) {
        console.error('\n❌ ERROR:', error.message);
        if (error.code === '28P01' && decodedPassword) {
            console.log('Trying decoded password...');
            client.password = decodedPassword;
            await client.connect();
            return populatePracticeAreas();
        }
        process.exit(1);
    }
}

populatePracticeAreas();

