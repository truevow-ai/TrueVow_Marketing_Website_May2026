/**
 * Check specific database record to see actual values
 */

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
    } catch (e) {
        console.log(`⚠️  Could not parse connection string`);
    }
}

SUPABASE_DB_HOST = SUPABASE_DB_HOST || process.env.SUPABASE_DB_HOST || 'db.napwpkagxzqfpbearkjs.supabase.co';
SUPABASE_DB_PORT = SUPABASE_DB_PORT || parseInt(process.env.SUPABASE_DB_PORT || '5432');
SUPABASE_DB_NAME = SUPABASE_DB_NAME || process.env.SUPABASE_DB_NAME || 'postgres';
SUPABASE_DB_USER = SUPABASE_DB_USER || process.env.SUPABASE_DB_USER || 'postgres';
SUPABASE_DB_PASSWORD = SUPABASE_DB_PASSWORD || process.env.SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD;

async function checkRecord() {
    const client = new Client({
        host: SUPABASE_DB_HOST,
        port: SUPABASE_DB_PORT,
        database: SUPABASE_DB_NAME,
        user: SUPABASE_DB_USER,
        password: SUPABASE_DB_PASSWORD,
        ssl: { rejectUnauthorized: false }
    });
    
    await client.connect();
    
    try {
        // Find records with cap = 230 and practice_area = personal-injury
        const result = await client.query(`
            SELECT 
                c.state_code,
                c.county_name,
                c.county_slug,
                pa.practice_area_name,
                pa.cap,
                pa.premium,
                pa.standard,
                pa.filled,
                pa.premium_remaining,
                pa.standard_remaining,
                ROUND(pa.cap * 0.21) as expected_premium,
                CASE 
                    WHEN pa.premium = ROUND(pa.cap * 0.21) THEN '✅ CORRECT'
                    ELSE '❌ WRONG'
                END as status
            FROM web_availability_practice_area_seats pa
            JOIN web_availability_county c ON pa.county_availability_id = c.id
            WHERE pa.cap = 230 
            AND pa.practice_area_slug = 'personal-injury'
            AND pa.is_active = true
            ORDER BY c.state_code, c.county_name
        `);
        
        console.log(`\n🔍 Found ${result.rows.length} record(s) with cap 230 for Personal Injury:\n`);
        
        for (const row of result.rows) {
            console.log(`State: ${row.state_code}`);
            console.log(`County: ${row.county_name} (${row.county_slug})`);
            console.log(`Practice Area: ${row.practice_area_name}`);
            console.log(`Cap: ${row.cap}`);
            console.log(`Premium: ${row.premium} (Expected: ${row.expected_premium}) ${row.status}`);
            console.log(`Standard: ${row.standard}`);
            console.log(`Filled: ${row.filled}`);
            console.log(`Premium Remaining: ${row.premium_remaining}`);
            console.log(`Standard Remaining: ${row.standard_remaining}`);
            console.log(`---`);
        }
        
    } finally {
        await client.end();
    }
}

checkRecord().catch(console.error);

