// Quick test to verify practice area data in database
const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

// Extract connection details
let SUPABASE_DB_HOST, SUPABASE_DB_PORT, SUPABASE_DB_NAME, SUPABASE_DB_USER, SUPABASE_DB_PASSWORD;

const connectionString = process.env.SUPABASE_DB_URL || process.env.MARKETING_DATABASE_URL;
if (connectionString && connectionString.startsWith('postgresql://')) {
    try {
        const url = new URL(connectionString);
        SUPABASE_DB_USER = url.username || 'postgres';
        SUPABASE_DB_PASSWORD = url.password ? decodeURIComponent(url.password) : null;
        SUPABASE_DB_HOST = url.hostname;
        SUPABASE_DB_PORT = parseInt(url.port || '5432');
        SUPABASE_DB_NAME = url.pathname.slice(1) || 'postgres';
    } catch (e) {
        console.log('Could not parse connection string');
    }
}

SUPABASE_DB_HOST = SUPABASE_DB_HOST || process.env.MARKETING_DB_HOST || 'db.napwpkagxzqfpbearkjs.supabase.co';
SUPABASE_DB_PORT = SUPABASE_DB_PORT || parseInt(process.env.MARKETING_DB_PORT || '5432');
SUPABASE_DB_NAME = SUPABASE_DB_NAME || process.env.MARKETING_DB_NAME || 'postgres';
SUPABASE_DB_USER = SUPABASE_DB_USER || process.env.MARKETING_DB_USER || 'postgres';

const rawPassword = SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD;
SUPABASE_DB_PASSWORD = rawPassword;

if (rawPassword && rawPassword.includes('%')) {
    try {
        SUPABASE_DB_PASSWORD = decodeURIComponent(rawPassword);
    } catch (e) {}
}

async function testPracticeAreas() {
    const client = new Client({
        host: SUPABASE_DB_HOST,
        port: SUPABASE_DB_PORT,
        database: SUPABASE_DB_NAME,
        user: SUPABASE_DB_USER,
        password: SUPABASE_DB_PASSWORD,
        ssl: { rejectUnauthorized: false }
    });

    try {
        await client.connect();
        console.log('✅ Connected to database\n');

        // Test 1: Get a county ID
        const countyResult = await client.query(
            `SELECT id, state_code, county_slug, county_name 
             FROM web_availability_county 
             WHERE state_code = 'CA' AND county_slug = 'los-angeles' 
             LIMIT 1`
        );

        if (countyResult.rows.length === 0) {
            console.log('❌ No Los Angeles county found');
            await client.end();
            return;
        }

        const county = countyResult.rows[0];
        console.log('📍 County found:');
        console.log(`   ID: ${county.id}`);
        console.log(`   State: ${county.state_code}`);
        console.log(`   Slug: ${county.county_slug}`);
        console.log(`   Name: ${county.county_name}\n`);

        // Test 2: Get practice areas for this county
        const paResult = await client.query(
            `SELECT practice_area_slug, practice_area_name, display_order
             FROM web_availability_practice_area_seats
             WHERE county_availability_id = $1
             ORDER BY display_order ASC`,
            [county.id]
        );

        console.log(`📊 Practice areas found: ${paResult.rows.length}\n`);
        
        if (paResult.rows.length > 0) {
            console.log('Practice area details:');
            paResult.rows.forEach(pa => {
                console.log(`   - ${pa.practice_area_slug} (${pa.practice_area_name}) - Order: ${pa.display_order}`);
            });
        } else {
            console.log('❌ No practice areas found for this county!');
        }

        await client.end();
        console.log('\n✅ Test complete');
    } catch (error) {
        console.error('❌ Error:', error.message);
        if (client) await client.end();
        process.exit(1);
    }
}

testPracticeAreas();

