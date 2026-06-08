const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

// Get connection details
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
    } catch (e) {}
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

async function runValidation() {
    const client = new Client({
        host: SUPABASE_DB_HOST,
        port: SUPABASE_DB_PORT,
        database: SUPABASE_DB_NAME,
        user: SUPABASE_DB_USER,
        password: SUPABASE_DB_PASSWORD,
        ssl: { rejectUnauthorized: false }
    });

    try {
        console.log('Connecting to database...');
        await client.connect();
        console.log('Connected!\n');

        // Get counties
        const countiesResult = await client.query(`
            SELECT c.*, 
                   COUNT(pa.id) as practice_area_count
            FROM web_availability_county c
            LEFT JOIN web_availability_practice_area_seats pa ON pa.county_availability_id = c.id
            WHERE c.is_active = true
            GROUP BY c.id
            ORDER BY c.state_code, c.county_name
            LIMIT 10
        `);

        console.log(`Found ${countiesResult.rows.length} counties (showing first 10):\n`);

        for (const county of countiesResult.rows) {
            console.log(`${county.county_name} County, ${county.state_code}`);
            console.log(`  Total firms: ${county.total_firms}`);
            console.log(`  Practice areas: ${county.practice_area_count}\n`);

            // Get practice areas
            const paResult = await client.query(`
                SELECT * FROM web_availability_practice_area_seats
                WHERE county_availability_id = $1 AND is_active = true
                ORDER BY display_order
            `, [county.id]);

            let totalDistributed = 0;
            for (const pa of paResult.rows) {
                totalDistributed += pa.total_firms;
                console.log(`    ${pa.practice_area_name}: ${pa.total_firms} firms, cap: ${pa.cap}, premium: ${pa.premium}`);
            }

            const sumCheck = Math.abs(totalDistributed - county.total_firms);
            if (sumCheck > county.total_firms * 0.05) {
                console.log(`  ⚠️  WARNING: Practice areas sum to ${totalDistributed} but total is ${county.total_firms} (difference: ${sumCheck})`);
            } else {
                console.log(`  ✅ Practice areas sum correctly (${totalDistributed})`);
            }
            console.log('');
        }

        await client.end();
        console.log('Validation complete!');

    } catch (error) {
        console.error('Error:', error.message);
        console.error(error.stack);
        if (client) {
            await client.end().catch(() => {});
        }
        process.exit(1);
    }
}

runValidation();

