// Quick verification script
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

async function verifyFix() {
    let client;
    let passwordToUse = SUPABASE_DB_PASSWORD;

    try {
        console.log('🔌 Connecting...');
        try {
            client = await tryConnection(SUPABASE_DB_PASSWORD);
        } catch (firstError) {
            if (decodedPassword && firstError.code === '28P01') {
                client = await tryConnection(decodedPassword);
                passwordToUse = decodedPassword;
            } else {
                throw firstError;
            }
        }
        console.log('✅ Connected\n');

        // Check problematic counties
        const counties = ['baker', 'calhoun'];
        const states = ['FL'];

        for (let i = 0; i < counties.length; i++) {
            const county = counties[i];
            const state = states[i];
            
            const result = await client.query(`
                SELECT 
                    c.county_name,
                    c.total_firms,
                    c.total_seats,
                    COUNT(pa.id) as practice_area_count,
                    SUM(pa.cap) as sum_practice_area_caps
                FROM web_availability_county c
                LEFT JOIN web_availability_practice_area_seats pa ON pa.county_availability_id = c.id AND pa.is_active = true
                WHERE c.county_slug = $1 AND c.state_code = $2 AND c.is_active = true
                GROUP BY c.id, c.county_name, c.total_firms, c.total_seats
            `, [county, state]);

            if (result.rows.length > 0) {
                const row = result.rows[0];
                console.log(`📍 ${row.county_name} County, ${state}:`);
                console.log(`   Total Firms: ${row.total_firms}`);
                console.log(`   Total Seats (stored): ${row.total_seats}`);
                console.log(`   Sum of Practice Area Caps: ${row.sum_practice_area_caps || 0}`);
                console.log(`   Practice Areas: ${row.practice_area_count}`);
                
                const status = row.total_seats > row.total_firms ? '❌ STILL BROKEN' : 
                              row.total_seats > Math.round(row.total_firms * 0.33) + 1 ? '⚠️  EXCEEDS 33%' : 
                              '✅ FIXED';
                console.log(`   Status: ${status}\n`);
            }
        }

        // Check for any counties still broken
        const broken = await client.query(`
            SELECT 
                c.county_name,
                c.state_code,
                c.total_firms,
                c.total_seats,
                ROUND((c.total_seats::NUMERIC / NULLIF(c.total_firms, 0)) * 100, 1) as percent
            FROM web_availability_county c
            WHERE c.is_active = true 
            AND c.total_seats > c.total_firms
            ORDER BY c.total_seats DESC
            LIMIT 10
        `);

        if (broken.rows.length > 0) {
            console.log('❌ COUNTIES STILL BROKEN:');
            broken.rows.forEach(row => {
                console.log(`   ${row.county_name}, ${row.state_code}: ${row.total_seats} seats for ${row.total_firms} firms (${row.percent}%)`);
            });
        } else {
            console.log('✅ All counties fixed! No counties have total seats exceeding total firms.');
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

verifyFix();

