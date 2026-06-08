/**
 * Complete verification of Texas data
 */

const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

let password = process.env.SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD;
if (password && password.includes('%40')) password = decodeURIComponent(password);

const client = new Client({
    host: 'db.napwpkagxzqfpbearkjs.supabase.co',
    port: 5432,
    database: 'postgres',
    user: 'postgres',
    password: password,
    ssl: { rejectUnauthorized: false },
});

async function verify() {
    try {
        await client.connect();
        console.log('✅ Connected to database\n');

        // 1. Check counties
        const counties = await client.query(`
            SELECT COUNT(*) as count
            FROM web_availability_county
            WHERE state_code = 'TX' AND is_active = true
        `);
        console.log(`📊 Texas Counties: ${counties.rows[0].count}`);

        // 2. Check practice areas
        const practiceAreas = await client.query(`
            SELECT COUNT(*) as count
            FROM web_availability_practice_area_seats
            WHERE county_availability_id IN (
                SELECT id FROM web_availability_county WHERE state_code = 'TX'
            ) AND is_active = true
        `);
        console.log(`📊 Practice Area Records: ${practiceAreas.rows[0].count}`);

        // 3. Check counties with practice areas
        const countiesWithPA = await client.query(`
            SELECT 
                c.county_name,
                c.total_seats,
                COUNT(pa.id) as practice_area_count
            FROM web_availability_county c
            LEFT JOIN web_availability_practice_area_seats pa ON pa.county_availability_id = c.id AND pa.is_active = true
            WHERE c.state_code = 'TX' AND c.is_active = true
            GROUP BY c.id, c.county_name, c.total_seats
            ORDER BY c.total_seats DESC
        `);

        console.log(`\n📋 Counties and Practice Areas:`);
        countiesWithPA.rows.forEach(row => {
            const status = row.practice_area_count > 0 ? '✅' : '❌';
            console.log(`  ${status} ${row.county_name}: ${row.total_seats} seats, ${row.practice_area_count} practice areas`);
        });

        // 4. Sample practice areas for Harris County
        const sample = await client.query(`
            SELECT 
                pa.practice_area_name,
                pa.cap,
                pa.premium,
                pa.standard,
                pa.is_active
            FROM web_availability_practice_area_seats pa
            JOIN web_availability_county c ON pa.county_availability_id = c.id
            WHERE c.state_code = 'TX' AND c.county_slug = 'harris' AND pa.is_active = true
            ORDER BY pa.display_order
            LIMIT 5
        `);

        if (sample.rows.length > 0) {
            console.log(`\n📋 Sample Practice Areas (Harris County):`);
            sample.rows.forEach(row => {
                console.log(`  ${row.practice_area_name}: ${row.cap} seats (${row.premium} premium, ${row.standard} standard)`);
            });
        } else {
            console.log(`\n⚠️  No practice areas found for Harris County`);
        }

        // 5. Check for any issues
        const missingPA = countiesWithPA.rows.filter(r => r.practice_area_count === 0);
        if (missingPA.length > 0) {
            console.log(`\n⚠️  Counties missing practice areas: ${missingPA.length}`);
            missingPA.forEach(row => {
                console.log(`  - ${row.county_name}`);
            });
        } else {
            console.log(`\n✅ All counties have practice areas!`);
        }

        await client.end();
        console.log('\n✅ Verification complete!');

    } catch (error) {
        console.error('❌ Error:', error.message);
        process.exit(1);
    }
}

verify();

