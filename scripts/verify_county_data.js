// ============================================
// Verify county data was populated in database
// ============================================

const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

const connectionString = process.env.MARKETING_DATABASE_URL;
if (!connectionString) {
    console.error('❌ MARKETING_DATABASE_URL not found in .env.local');
    process.exit(1);
}

const url = new URL(connectionString);
const client = new Client({
    host: url.hostname,
    port: parseInt(url.port || '5432'),
    database: url.pathname.slice(1) || 'postgres',
    user: url.username || 'postgres',
    password: decodeURIComponent(url.password),
    ssl: { rejectUnauthorized: false },
    connectionTimeoutMillis: 30000,
});

async function verifyData() {
    try {
        console.log('🔌 Connecting to database...');
        await client.connect();
        console.log('✅ Connected\n');

        // Check county count
        const countyResult = await client.query('SELECT COUNT(*) as count FROM web_availability_county');
        console.log(`📊 Counties in database: ${countyResult.rows[0].count}`);

        // Check practice area count
        const paResult = await client.query('SELECT COUNT(*) as count FROM web_availability_practice_area_seats');
        console.log(`📊 Practice area records: ${paResult.rows[0].count}\n`);

        // Sample counties
        const sampleCounties = await client.query(`
            SELECT state_code, county_slug, county_name, total_firms, total_seats 
            FROM web_availability_county 
            WHERE state_code IN ('FL', 'CA')
            ORDER BY state_code, county_name
            LIMIT 10
        `);
        console.log('📋 Sample counties:');
        sampleCounties.rows.forEach(c => {
            console.log(`   ${c.state_code} - ${c.county_name} (${c.county_slug}): ${c.total_firms} firms, ${c.total_seats} seats`);
        });

        // Check for Miami-Dade specifically
        const miamiDade = await client.query(`
            SELECT * FROM web_availability_county 
            WHERE state_code = 'FL' AND county_slug = 'miami-dade'
        `);
        if (miamiDade.rows.length > 0) {
            console.log('\n✅ Miami-Dade found:', miamiDade.rows[0]);
            
            // Check practice areas for Miami-Dade
            const miamiDadePA = await client.query(`
                SELECT pas.* 
                FROM web_availability_practice_area_seats pas
                JOIN web_availability_county c ON pas.county_availability_id = c.id
                WHERE c.state_code = 'FL' AND c.county_slug = 'miami-dade'
                ORDER BY pas.display_order
            `);
            console.log(`\n📋 Miami-Dade practice areas: ${miamiDadePA.rows.length}`);
            miamiDadePA.rows.forEach(pa => {
                console.log(`   - ${pa.practice_area_name} (${pa.practice_area_slug}): ${pa.total_firms} firms, cap: ${pa.cap}`);
            });
        } else {
            console.log('\n❌ Miami-Dade NOT found in database');
        }

        await client.end();
        console.log('\n✅ Verification complete');
    } catch (error) {
        console.error('❌ Error:', error.message);
        if (client) await client.end().catch(() => {});
        process.exit(1);
    }
}

verifyData();



