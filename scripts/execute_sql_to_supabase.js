// ============================================
// Execute SQL files to Supabase automatically
// Uses direct PostgreSQL connection with proper error handling
// ============================================

const { Client } = require('pg');
const fs = require('fs');
const path = require('path');
require('dotenv').config({ path: '.env.local' });

// Try to extract connection details from connection string first
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
        console.log(`📋 Extracted credentials from connection string`);
    } catch (e) {
        console.log(`⚠️  Could not parse connection string, using individual env vars`);
    }
}

// Fallback to individual environment variables
SUPABASE_DB_HOST = SUPABASE_DB_HOST || process.env.SUPABASE_DB_HOST || process.env.MARKETING_DB_HOST || 'db.napwpkagxzqfpbearkjs.supabase.co';
SUPABASE_DB_PORT = SUPABASE_DB_PORT || parseInt(process.env.SUPABASE_DB_PORT || process.env.MARKETING_DB_PORT || '5432');
SUPABASE_DB_NAME = SUPABASE_DB_NAME || process.env.SUPABASE_DB_NAME || process.env.MARKETING_DB_NAME || 'postgres';
SUPABASE_DB_USER = SUPABASE_DB_USER || process.env.SUPABASE_DB_USER || process.env.MARKETING_DB_USER || 'postgres';

// Get password - prefer connection string, then env vars
const rawPassword = SUPABASE_DB_PASSWORD || process.env.SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD;
SUPABASE_DB_PASSWORD = rawPassword;

// If password contains URL encoding, try both versions
if (rawPassword && rawPassword.includes('%')) {
    try {
        decodedPassword = decodeURIComponent(rawPassword);
    } catch (e) {
        // Decoding failed, keep original
    }
}

async function executeSQLFile(sqlFilePath) {
    if (!SUPABASE_DB_PASSWORD) {
        console.error('❌ ERROR: SUPABASE_DB_PASSWORD not found in .env.local');
        console.error('   Get it from: Supabase Dashboard → Settings → Database');
        console.error('   Add to .env.local: SUPABASE_DB_PASSWORD=your_password');
        process.exit(1);
    }
    
    // Debug: Show password info
    console.log(`🔐 Password found (length: ${SUPABASE_DB_PASSWORD.length} chars)`);
    if (decodedPassword && decodedPassword !== SUPABASE_DB_PASSWORD) {
        console.log(`   Will try: original format first, then decoded if needed`);
    }

    if (!fs.existsSync(sqlFilePath)) {
        console.error(`❌ ERROR: SQL file not found: ${sqlFilePath}`);
        process.exit(1);
    }

    const sql = fs.readFileSync(sqlFilePath, 'utf8');
    
    // Try connection with original password first, then decoded if it fails
    let client;
    let passwordToUse = SUPABASE_DB_PASSWORD;
    
    const tryConnection = async (password) => {
        const testClient = new Client({
            host: SUPABASE_DB_HOST,
            port: SUPABASE_DB_PORT,
            database: SUPABASE_DB_NAME,
            user: SUPABASE_DB_USER,
            password: password,
            ssl: { rejectUnauthorized: false },
            connectionTimeoutMillis: 30000, // Increased to 30 seconds
            query_timeout: 60000, // Increased to 60 seconds
            keepAlive: true,
            keepAliveInitialDelayMillis: 10000,
        });
        
        await testClient.connect();
        return testClient;
    };

    try {
        console.log(`🔌 Connecting to Supabase database...`);
        
        // Try original password first
        try {
            client = await tryConnection(SUPABASE_DB_PASSWORD);
            console.log(`✅ Connected with original password format`);
        } catch (firstError) {
            // If original fails and we have a decoded version, try that
            if (decodedPassword && firstError.code === '28P01') {
                console.log(`⚠️  Original password failed, trying decoded version...`);
                client = await tryConnection(decodedPassword);
                passwordToUse = decodedPassword;
                console.log(`✅ Connected with decoded password format`);
            } else {
                throw firstError;
            }
        }
        console.log(`✅ Connected successfully\n`);

        console.log(`📝 Executing SQL from: ${sqlFilePath}`);
        console.log(`📊 SQL size: ${(sql.length / 1024).toFixed(2)} KB\n`);

        // Execute SQL
        const startTime = Date.now();
        await client.query(sql);
        const duration = ((Date.now() - startTime) / 1000).toFixed(2);

        console.log(`✅ SQL executed successfully in ${duration}s\n`);

        // Verify connection still works
        const { rows } = await client.query('SELECT NOW() as current_time');
        console.log(`✅ Database connection verified: ${rows[0].current_time}`);

        await client.end();
        console.log(`\n✅ Done!`);
        return true;

    } catch (error) {
        console.error(`\n❌ ERROR executing SQL:`);
        console.error(`   ${error.message}`);
        
        if (error.code === '28P01') {
            console.error(`\n💡 Authentication failed. Password might be incorrect.`);
            console.error(`   Current password format: ${rawPassword ? 'URL-encoded' : 'plain'}`);
            console.error(`   Try these options:`);
            console.error(`   1. If password has %40, it will be decoded to @ automatically`);
            console.error(`   2. If still fails, try the password WITHOUT URL encoding in .env.local`);
            console.error(`   3. Or reset password in Supabase Dashboard → Settings → Database`);
            console.error(`\n   Example: MARKETING_DATABASE_PASSWORD=Intakely@786 (use @ directly, not %40)`);
        } else if (error.code === 'ENOTFOUND' || error.code === 'ECONNREFUSED') {
            console.error(`\n💡 Connection failed. Check your network and database host.`);
        } else if (error.position) {
            const lineNum = sql.substring(0, error.position).split('\n').length;
            console.error(`\n💡 Error at line ${lineNum} in SQL file`);
        }
        
        // Only close connection if it was successfully established
        if (client) {
            await client.end().catch(() => {});
        }
        process.exit(1);
    }
}

// Main execution
const sqlFile = process.argv[2];

if (!sqlFile) {
    console.error('Usage: node scripts/execute_sql_to_supabase.js <path-to-sql-file>');
    console.error('Example: node scripts/execute_sql_to_supabase.js supabase/CREATE_COUNTY_AVAILABILITY_TABLES.sql');
    process.exit(1);
}

const sqlFilePath = path.isAbsolute(sqlFile) ? sqlFile : path.join(__dirname, '..', sqlFile);
executeSQLFile(sqlFilePath).catch(error => {
    console.error('Fatal error:', error);
    process.exit(1);
});

