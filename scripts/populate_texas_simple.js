/**
 * Simple script to populate Texas counties
 * Uses the same connection method as execute_sql_to_supabase.js
 */

const { Client } = require('pg');
const fs = require('fs');
require('dotenv').config({ path: '.env.local' });

// Same connection logic as execute_sql_to_supabase.js
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

async function populateTexas() {
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

        // Read and execute SQL file
        const sql = fs.readFileSync('supabase/POPULATE_TEXAS_COUNTIES.sql', 'utf8');
        console.log('📝 Executing SQL file...\n');
        
        await client.query(sql);
        
        console.log('✅ SQL executed successfully\n');

        // Verify
        const result = await client.query("SELECT COUNT(*) as count FROM web_availability_county WHERE state_code = 'TX'");
        console.log(`✅ Texas counties in database: ${result.rows[0].count}`);

        await client.end();
        console.log('\n✅ Done!');

    } catch (error) {
        console.error('\n❌ ERROR:', error.message);
        if (error.code === '28P01' && decodedPassword) {
            console.log('Trying decoded password...');
            client.password = decodedPassword;
            await client.connect();
            return populateTexas();
        }
        process.exit(1);
    }
}

populateTexas();

