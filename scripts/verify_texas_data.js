/**
 * Verify Texas county data was inserted correctly
 */

const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

async function verifyTexas() {
    let password = process.env.SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD || process.env.DATABASE_PASSWORD;
    
    if (password && password.includes('%40')) {
        password = decodeURIComponent(password);
    }

    const client = new Client({
        host: 'db.napwpkagxzqfpbearkjs.supabase.co',
        port: 5432,
        database: 'postgres',
        user: 'postgres',
        password: password,
        ssl: { rejectUnauthorized: false },
    });

    try {
        await client.connect();
        console.log('✅ Connected to database\n');

        // Count Texas counties
        const countResult = await client.query(`
            SELECT COUNT(*) as count
            FROM web_availability_county
            WHERE state_code = 'TX'
        `);
        console.log(`📊 Total Texas counties: ${countResult.rows[0].count}\n`);

        // Show all Texas counties
        const counties = await client.query(`
            SELECT 
                county_name,
                county_slug,
                total_firms,
                total_seats,
                premium_total,
                standard_total
            FROM web_availability_county
            WHERE state_code = 'TX'
            ORDER BY total_seats DESC
        `);

        console.log('📋 Texas Counties (sorted by seats):\n');
        counties.rows.forEach((row, index) => {
            console.log(`${index + 1}. ${row.county_name} (${row.county_slug})`);
            console.log(`   Firms: ${row.total_firms} → Seats: ${row.total_seats} (Premium: ${row.premium_total}, Standard: ${row.standard_total})`);
        });

        // Check for counties with < 4 seats (should be 0)
        const smallCounties = await client.query(`
            SELECT county_name, total_seats
            FROM web_availability_county
            WHERE state_code = 'TX' AND total_seats < 4
        `);

        if (smallCounties.rows.length > 0) {
            console.log(`\n⚠️  Found ${smallCounties.rows.length} counties with < 4 seats (should be 0):`);
            smallCounties.rows.forEach(row => {
                console.log(`   ${row.county_name}: ${row.total_seats} seats`);
            });
        } else {
            console.log(`\n✅ No counties with < 4 seats (all filtered out correctly)`);
        }

        // Verify practice areas
        const practiceAreas = await client.query(`
            SELECT COUNT(DISTINCT county_availability_id) as counties_with_practice_areas
            FROM web_availability_practice_area_seats
            WHERE county_availability_id IN (
                SELECT id FROM web_availability_county WHERE state_code = 'TX'
            )
        `);
        console.log(`\n📊 Counties with practice area data: ${practiceAreas.rows[0].counties_with_practice_areas}`);

        // Show sample practice area data for largest county
        const sample = await client.query(`
            SELECT 
                c.county_name,
                pa.practice_area_name,
                pa.total_seats,
                pa.premium_seats,
                pa.standard_seats
            FROM web_availability_practice_area_seats pa
            JOIN web_availability_county c ON pa.county_availability_id = c.id
            WHERE c.state_code = 'TX'
            ORDER BY c.total_seats DESC, pa.display_order ASC
            LIMIT 9
        `);

        if (sample.rows.length > 0) {
            console.log(`\n📋 Sample practice areas for ${sample.rows[0].county_name}:`);
            sample.rows.forEach(row => {
                console.log(`   ${row.practice_area_name}: ${row.total_seats} seats (${row.premium_seats} premium, ${row.standard_seats} standard)`);
            });
        }

        await client.end();
        console.log('\n✅ Verification complete!');

    } catch (error) {
        console.error('❌ Error:', error.message);
        process.exit(1);
    }
}

verifyTexas();

