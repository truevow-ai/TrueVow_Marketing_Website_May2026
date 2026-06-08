/**
 * Test script to insert one Texas county and verify it works
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

async function testInsert() {
    try {
        await client.connect();
        console.log('✅ Connected to database\n');

        // Test insert one county
        console.log('Testing insert of Harris County (Houston)...');
        const result = await client.query(`
            INSERT INTO web_availability_county 
            (state_code, county_slug, county_name, total_firms, total_seats, 
             premium_total, standard_total, filled, premium_remaining, standard_remaining, is_active)
            VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
            RETURNING id, county_name, total_seats
        `, [
            'TX',
            'harris',
            'Harris',
            3200,
            1056,  // 33% of 3200
            222,   // 21% of 1056
            834,   // remaining
            127,   // 12% filled
            195,   // premium remaining
            707,   // standard remaining
            true   // is_active
        ]);

        console.log('✅ Inserted:', result.rows[0]);
        console.log(`   County: ${result.rows[0].county_name}`);
        console.log(`   Seats: ${result.rows[0].total_seats}`);
        console.log(`   ID: ${result.rows[0].id}\n`);

        // Verify it's accessible
        const verify = await client.query(`
            SELECT COUNT(*) as count
            FROM web_availability_county
            WHERE state_code = 'TX' AND is_active = true
        `);
        console.log(`✅ Verification: ${verify.rows[0].count} active Texas counties in database`);

        await client.end();
        console.log('\n✅ Test complete!');

    } catch (error) {
        console.error('\n❌ ERROR:', error.message);
        if (error.code) console.error('   Code:', error.code);
        if (error.detail) console.error('   Detail:', error.detail);
        process.exit(1);
    }
}

testInsert();

