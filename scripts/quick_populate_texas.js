/**
 * Quick script to populate Texas practice areas with explicit logging
 */

const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

const STATE_CODE = 'TX';

// Get connection
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
    host: url.hostname,
    port: parseInt(url.port || '5432'),
    database: url.pathname.slice(1) || 'postgres',
    user: url.username || 'postgres',
    password: decodeURIComponent(url.password),
    ssl: { rejectUnauthorized: false },
});

async function main() {
    try {
        console.log('Connecting to database...');
        await client.connect();
        console.log('✅ Connected\n');

        const counties = await client.query(`
            SELECT id, county_slug, county_name, total_firms, total_seats
            FROM web_availability_county
            WHERE state_code = $1 AND is_active = true
            ORDER BY total_seats DESC
        `, [STATE_CODE]);

        console.log(`Found ${counties.rows.length} counties\n`);

        // Delete existing
        const deleteResult = await client.query(`
            DELETE FROM web_availability_practice_area_seats
            WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = $1)
        `, [STATE_CODE]);
        console.log(`Deleted ${deleteResult.rowCount || 0} existing practice area records\n`);

        // Use the same logic as populate_practice_areas_for_state.js
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

        let totalInserted = 0;

        for (const county of counties.rows) {
            const totalLawOffices = county.total_firms;
            const totalSeats = county.total_seats;
            const totalSoloSmall = Math.round(totalLawOffices * SOLO_SMALL_PERCENTAGE);

            // Calculate practice area breakdowns using the same method as Florida
            const practiceAreas = {};
            let totalCalculatedCap = 0;

            // First pass: Calculate ideal caps (proportional to totalSeats)
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

            // Scale to match totalSeats exactly
            let scaleFactor = 1;
            if (totalCalculatedCap > 0) {
                scaleFactor = totalSeats / totalCalculatedCap;
            }

            // Apply scaling and calculate premium/standard
            for (const [areaKey, areaData] of Object.entries(practiceAreas)) {
                let cap = Math.round(areaData.idealCap * scaleFactor);
                
                // For very small counties, ensure at least 1 seat for the largest practice areas
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
                    cap = 1; // Minimum 1 seat per practice area for larger counties
                }

                const premium = cap > 0 ? Math.max(1, Math.round(cap * PREMIUM_PERCENTAGE)) : 0;
                const standard = Math.max(0, cap - premium);
                const filled = cap > 0 ? Math.round(cap * FILLED_PERCENTAGE) : 0;
                const premiumRemaining = cap > 0 ? Math.max(0, premium - Math.round(filled * (premium / cap))) : 0;
                const standardRemaining = cap > 0 ? Math.max(0, standard - Math.round(filled * (standard / cap))) : 0;

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

            // Fix rounding errors to ensure exact sum
            let finalTotalCap = Object.values(practiceAreas).reduce((sum, a) => sum + a.cap, 0);
            if (finalTotalCap !== totalSeats) {
                const sortedAreas = Object.entries(practiceAreas)
                    .sort((a, b) => b[1].cap - a[1].cap);
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

            // Insert practice areas
            let countyInserted = 0;
            for (const [areaKey, areaData] of Object.entries(practiceAreas)) {
                if (areaData.cap > 0) {
                    await client.query(`
                        INSERT INTO web_availability_practice_area_seats
                        (county_availability_id, practice_area_slug, practice_area_name, total_firms,
                         cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active)
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
                    countyInserted++;
                    totalInserted++;
                }
            }
            console.log(`  ${county.county_name}: ${countyInserted} practice areas`);
        }

        console.log(`\n✅ Complete! Inserted ${totalInserted} practice area records for ${counties.rows.length} counties`);

        // Verify
        const verify = await client.query(`
            SELECT COUNT(*) as count
            FROM web_availability_practice_area_seats
            WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = $1)
        `, [STATE_CODE]);
        console.log(`   Verified: ${verify.rows[0].count} practice area records in database`);

        await client.end();
    } catch (error) {
        console.error('❌ ERROR:', error.message);
        console.error(error.stack);
        process.exit(1);
    }
}

main();

