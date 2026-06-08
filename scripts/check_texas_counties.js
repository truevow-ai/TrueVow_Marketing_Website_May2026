// Quick script to check if Texas counties exist in database
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

async function checkTexasCounties() {
    let client;
    
    try {
        console.log('Connecting to database...');
        client = new Client({
            host: SUPABASE_DB_HOST,
            port: SUPABASE_DB_PORT,
            database: SUPABASE_DB_NAME,
            user: SUPABASE_DB_USER,
            password: SUPABASE_DB_PASSWORD,
            ssl: { rejectUnauthorized: false }
        });
        
        await client.connect();
        console.log('✅ Connected\n');
        
        // Check all states
        const statesResult = await client.query(`
            SELECT state_code, COUNT(*) as county_count
            FROM web_availability_county
            WHERE is_active = true
            GROUP BY state_code
            ORDER BY state_code
        `);
        
        console.log('States in database:');
        statesResult.rows.forEach(row => {
            console.log(`  ${row.state_code}: ${row.county_count} counties`);
        });
        
        // Check Texas specifically
        console.log('\n📊 Texas Counties:');
        const texasResult = await client.query(`
            SELECT county_slug, county_name, total_firms, total_seats, is_active
            FROM web_availability_county
            WHERE state_code = 'TX' AND is_active = true
            ORDER BY county_name
            LIMIT 20
        `);
        
        if (texasResult.rows.length === 0) {
            console.log('❌ No Texas counties found in database!');
        } else {
            console.log(`Found ${texasResult.rows.length} Texas counties:`);
            texasResult.rows.forEach(row => {
                console.log(`  - ${row.county_name} (${row.county_slug}): ${row.total_firms} firms, ${row.total_seats} seats`);
            });
        }
        
        // Check total count
        const totalResult = await client.query(`
            SELECT COUNT(*) as total FROM web_availability_county WHERE is_active = true
        `);
        console.log(`\n📈 Total active counties in database: ${totalResult.rows[0].total}`);
        
        await client.end();
        
    } catch (error) {
        console.error('❌ Error:', error.message);
        if (client) {
            await client.end().catch(() => {});
        }
        process.exit(1);
    }
}

checkTexasCounties();

