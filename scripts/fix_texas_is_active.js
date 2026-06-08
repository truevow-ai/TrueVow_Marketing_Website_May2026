/**
 * Fix Texas counties to ensure is_active = true
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

async function fixTexas() {
    try {
        await client.connect();
        console.log('✅ Connected to database\n');

        // Check current state
        const check = await client.query(`
            SELECT 
                COUNT(*) as total,
                COUNT(*) FILTER (WHERE is_active = true) as active,
                COUNT(*) FILTER (WHERE is_active = false OR is_active IS NULL) as inactive
            FROM web_availability_county
            WHERE state_code = 'TX'
        `);

        console.log('📊 Current Texas counties:');
        console.log(`   Total: ${check.rows[0].total}`);
        console.log(`   Active: ${check.rows[0].active}`);
        console.log(`   Inactive: ${check.rows[0].inactive}\n`);

        if (check.rows[0].inactive > 0) {
            // Fix inactive counties
            const update = await client.query(`
                UPDATE web_availability_county
                SET is_active = true
                WHERE state_code = 'TX' AND (is_active = false OR is_active IS NULL)
            `);
            console.log(`✅ Updated ${update.rowCount} counties to is_active = true\n`);
        }

        // Also fix practice area seats
        const paCheck = await client.query(`
            SELECT 
                COUNT(*) as total,
                COUNT(*) FILTER (WHERE is_active = true) as active,
                COUNT(*) FILTER (WHERE is_active = false OR is_active IS NULL) as inactive
            FROM web_availability_practice_area_seats
            WHERE county_availability_id IN (SELECT id FROM web_availability_county WHERE state_code = 'TX')
        `);

        console.log('📊 Texas practice area seats:');
        console.log(`   Total: ${paCheck.rows[0].total}`);
        console.log(`   Active: ${paCheck.rows[0].active}`);
        console.log(`   Inactive: ${paCheck.rows[0].inactive}\n`);

        if (paCheck.rows[0].inactive > 0) {
            const paUpdate = await client.query(`
                UPDATE web_availability_practice_area_seats
                SET is_active = true
                WHERE county_availability_id IN (
                    SELECT id FROM web_availability_county WHERE state_code = 'TX'
                ) AND (is_active = false OR is_active IS NULL)
            `);
            console.log(`✅ Updated ${paUpdate.rowCount} practice area seats to is_active = true\n`);
        }

        // Verify final state
        const verify = await client.query(`
            SELECT COUNT(*) as count
            FROM web_availability_county
            WHERE state_code = 'TX' AND is_active = true
        `);
        console.log(`✅ Final count: ${verify.rows[0].count} active Texas counties`);

        await client.end();
        console.log('\n✅ Done!');

    } catch (error) {
        console.error('❌ Error:', error.message);
        process.exit(1);
    }
}

fixTexas();

