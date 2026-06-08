/**
 * Test connection and insert one Texas county
 */

const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

// Try to get connection string from Supabase CLI first
let connectionString = process.env.SUPABASE_DB_URL || process.env.MARKETING_DATABASE_URL;

if (!connectionString) {
    try {
        const { execSync } = require('child_process');
        const cliConnection = execSync('supabase db remote get-connection-string', { encoding: 'utf8', stdio: ['pipe', 'pipe', 'ignore'] }).trim();
        if (cliConnection && cliConnection.startsWith('postgresql://')) {
            connectionString = cliConnection;
            console.log('✅ Using connection string from Supabase CLI');
        }
    } catch (e) {
        console.log('⚠️  Could not get connection from CLI, using env vars');
    }
}

let SUPABASE_DB_HOST, SUPABASE_DB_PORT, SUPABASE_DB_NAME, SUPABASE_DB_USER, SUPABASE_DB_PASSWORD;

if (connectionString && connectionString.startsWith('postgresql://')) {
    try {
        const url = new URL(connectionString);
        SUPABASE_DB_USER = url.username || 'postgres';
        SUPABASE_DB_PASSWORD = url.password ? decodeURIComponent(url.password) : null;
        SUPABASE_DB_HOST = url.hostname;
        SUPABASE_DB_PORT = parseInt(url.port || '5432');
        SUPABASE_DB_NAME = url.pathname.slice(1) || 'postgres';
        console.log('✅ Parsed connection string');
    } catch (e) {
        console.log('❌ Error parsing connection string:', e.message);
    }
}

SUPABASE_DB_HOST = SUPABASE_DB_HOST || process.env.MARKETING_DB_HOST || 'db.napwpkagxzqfpbearkjs.supabase.co';
SUPABASE_DB_PORT = SUPABASE_DB_PORT || parseInt(process.env.MARKETING_DB_PORT || '5432');
SUPABASE_DB_NAME = SUPABASE_DB_NAME || process.env.MARKETING_DB_NAME || 'postgres';
SUPABASE_DB_USER = SUPABASE_DB_USER || process.env.MARKETING_DB_USER || 'postgres';

const rawPassword = SUPABASE_DB_PASSWORD || process.env.SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD;
SUPABASE_DB_PASSWORD = rawPassword;

if (rawPassword && rawPassword.includes('%')) {
    try {
        SUPABASE_DB_PASSWORD = decodeURIComponent(rawPassword);
    } catch (e) {}
}

if (!SUPABASE_DB_PASSWORD) {
    console.error('❌ ERROR: No password found');
    process.exit(1);
}

console.log(`📋 Connecting to: ${SUPABASE_DB_HOST}:${SUPABASE_DB_PORT}/${SUPABASE_DB_NAME}`);
console.log(`📋 User: ${SUPABASE_DB_USER}`);
console.log(`📋 Password length: ${SUPABASE_DB_PASSWORD.length}\n`);

const client = new Client({
    host: SUPABASE_DB_HOST,
    port: SUPABASE_DB_PORT,
    database: SUPABASE_DB_NAME,
    user: SUPABASE_DB_USER,
    password: SUPABASE_DB_PASSWORD,
    ssl: { rejectUnauthorized: false },
});

async function testInsert() {
    try {
        await client.connect();
        console.log('✅ Connected to database\n');

        // Test insert Harris County
        console.log('Testing insert of Harris County...');
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
            1056,
            222,
            834,
            127,
            195,
            707,
            true
        ]);

        console.log('✅ Inserted:', result.rows[0]);
        console.log(`   County: ${result.rows[0].county_name}`);
        console.log(`   Seats: ${result.rows[0].total_seats}`);
        console.log(`   ID: ${result.rows[0].id}\n`);

        // Verify
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
        if (error.hint) console.error('   Hint:', error.hint);
        process.exit(1);
    }
}

testInsert();

