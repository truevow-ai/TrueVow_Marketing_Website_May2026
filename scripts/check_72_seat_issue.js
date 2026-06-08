// Check why so many counties show exactly 72 seats
const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

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

SUPABASE_DB_HOST = SUPABASE_DB_HOST || process.env.MARKETING_DB_HOST || 'db.napwpkagxzqfpbearkjs.supabase.co';
SUPABASE_DB_PORT = SUPABASE_DB_PORT || parseInt(process.env.MARKETING_DB_PORT || '5432');
SUPABASE_DB_NAME = SUPABASE_DB_NAME || process.env.MARKETING_DB_NAME || 'postgres';
SUPABASE_DB_USER = SUPABASE_DB_USER || process.env.MARKETING_DB_USER || 'postgres';

const rawPassword = SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD;
SUPABASE_DB_PASSWORD = rawPassword;

if (rawPassword && rawPassword.includes('%')) {
    try {
        decodedPassword = decodeURIComponent(rawPassword);
    } catch (e) {}
}

async function tryConnection(password) {
    const testClient = new Client({
        host: SUPABASE_DB_HOST,
        port: SUPABASE_DB_PORT,
        database: SUPABASE_DB_NAME,
        user: SUPABASE_DB_USER,
        password: password,
        ssl: { rejectUnauthorized: false },
        connectionTimeoutMillis: 30000
    });
    await testClient.connect();
    return testClient;
}

async function check72SeatIssue() {
    let client;
    
    try {
        console.log('🔌 Connecting...');
        try {
            client = await tryConnection(SUPABASE_DB_PASSWORD);
        } catch (firstError) {
            if (decodedPassword && firstError.code === '28P01') {
                client = await tryConnection(decodedPassword);
            } else {
                throw firstError;
            }
        }
        console.log('✅ Connected\n');

        // Find all counties with exactly 72 seats
        const result = await client.query(`
            SELECT 
                c.county_name,
                c.state_code,
                c.total_firms,
                c.total_seats,
                COUNT(pa.id) as practice_area_count,
                STRING_AGG(pa.practice_area_name || ': ' || pa.cap || ' seats', ', ' ORDER BY pa.display_order) as practice_areas
            FROM web_availability_county c
            LEFT JOIN web_availability_practice_area_seats pa ON pa.county_availability_id = c.id AND pa.is_active = true
            WHERE c.is_active = true AND c.total_seats = 72
            GROUP BY c.id, c.county_name, c.state_code, c.total_firms, c.total_seats
            ORDER BY c.total_firms
        `);

        console.log(`🚨 FOUND ${result.rows.length} COUNTIES WITH EXACTLY 72 SEATS:\n`);
        
        result.rows.forEach((row, i) => {
            const expected = Math.round(row.total_firms * 0.33);
            console.log(`${i + 1}. ${row.county_name} County, ${row.state_code}:`);
            console.log(`   Firms: ${row.total_firms} → Seats: ${row.total_seats} (Expected: ~${expected})`);
            console.log(`   Practice Areas: ${row.practice_area_count}`);
            if (row.practice_areas) {
                const areas = row.practice_areas.split(', ');
                console.log(`   Breakdown: ${areas.slice(0, 3).join(', ')}${areas.length > 3 ? '...' : ''}`);
            }
            console.log('');
        });

        // Check practice area caps
        console.log('\n🔍 Checking practice area caps for a sample county...');
        const sample = await client.query(`
            SELECT 
                pa.practice_area_name,
                pa.total_firms,
                pa.cap,
                pa.premium,
                pa.standard
            FROM web_availability_practice_area_seats pa
            JOIN web_availability_county c ON c.id = pa.county_availability_id
            WHERE c.county_slug = 'baker' AND c.state_code = 'FL' AND pa.is_active = true
            ORDER BY pa.display_order
        `);

        if (sample.rows.length > 0) {
            console.log('\nBaker County Practice Areas:');
            sample.rows.forEach(pa => {
                console.log(`   ${pa.practice_area_name}: ${pa.total_firms} firms → ${pa.cap} seats`);
            });
            const sum = sample.rows.reduce((s, pa) => s + pa.cap, 0);
            console.log(`   Sum: ${sum} seats`);
        }

        await client.end();

    } catch (error) {
        console.error('❌ Error:', error.message);
        if (client) {
            await client.end().catch(() => {});
        }
        process.exit(1);
    }
}

check72SeatIssue();

