// Force delete counties with < 4 seats from FL and CA
const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

// Get connection details (same as execute_sql_to_supabase.js)
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
        console.log('📋 Extracted credentials from connection string');
    } catch (e) {
        console.log('⚠️  Could not parse connection string, using individual env vars');
    }
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

async function deleteSmallCounties() {
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

        // Find counties to delete
        const findResult = await client.query(`
            SELECT id, state_code, county_name, total_firms, total_seats
            FROM web_availability_county
            WHERE state_code IN ('FL', 'CA') AND total_seats < 4
            ORDER BY state_code, county_name
        `);

        console.log(`📋 Found ${findResult.rows.length} counties with < 4 seats:\n`);
        findResult.rows.forEach(r => {
            console.log(`   ${r.state_code} - ${r.county_name}: ${r.total_firms} firms → ${r.total_seats} seats`);
        });

        if (findResult.rows.length === 0) {
            console.log('\n✅ No counties to delete. Already clean!');
            await client.end();
            return;
        }

        const ids = findResult.rows.map(r => r.id);

        // Delete practice area seats
        console.log('\n🗑️  Deleting practice area seats...');
        const paResult = await client.query(`
            DELETE FROM web_availability_practice_area_seats
            WHERE county_availability_id = ANY($1::uuid[])
        `, [ids]);
        console.log(`   ✅ Deleted ${paResult.rowCount} practice area records`);

        // Delete counties
        console.log('\n🗑️  Deleting counties...');
        const countyResult = await client.query(`
            DELETE FROM web_availability_county
            WHERE id = ANY($1::uuid[])
        `, [ids]);
        console.log(`   ✅ Deleted ${countyResult.rowCount} county records`);

        // Verify
        const verify = await client.query(`
            SELECT COUNT(*) as count
            FROM web_availability_county
            WHERE state_code IN ('FL', 'CA') AND total_seats < 4
        `);
        console.log(`\n🔍 Verification: ${verify.rows[0].count} counties with < 4 seats remain`);

        // Summary
        const summary = await client.query(`
            SELECT state_code, COUNT(*) as total, MIN(total_seats) as min_seats, MAX(total_seats) as max_seats
            FROM web_availability_county
            WHERE state_code IN ('FL', 'CA')
            GROUP BY state_code
            ORDER BY state_code
        `);
        console.log('\n📊 Final Summary:');
        summary.rows.forEach(r => {
            console.log(`   ${r.state_code}: ${r.total} counties, seats: ${r.min_seats}-${r.max_seats}`);
        });

        console.log('\n✅ Done!');
        await client.end();

    } catch (error) {
        console.error('\n❌ ERROR:', error.message);
        if (error.code === '28P01') {
            console.error('   Authentication failed. Trying decoded password...');
            if (decodedPassword) {
                client.password = decodedPassword;
                await client.connect();
                return deleteSmallCounties();
            }
        }
        process.exit(1);
    }
}

deleteSmallCounties();

