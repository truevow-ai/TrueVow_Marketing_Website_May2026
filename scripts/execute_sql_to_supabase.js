// ============================================
// Execute SQL files to Supabase automatically
// Uses direct PostgreSQL connection with proper error handling
// ============================================

const { Client } = require('pg');
const fs = require('fs');
const path = require('path');
require('dotenv').config({ path: '.env.local' });

const SUPABASE_DB_HOST = process.env.SUPABASE_DB_HOST || process.env.MARKETING_DB_HOST || 'db.napwpkagxzqfpbearkjs.supabase.co';
const SUPABASE_DB_PORT = parseInt(process.env.SUPABASE_DB_PORT || process.env.MARKETING_DB_PORT || '5432');
const SUPABASE_DB_NAME = process.env.SUPABASE_DB_NAME || process.env.MARKETING_DB_NAME || 'postgres';
const SUPABASE_DB_USER = process.env.SUPABASE_DB_USER || process.env.MARKETING_DB_USER || 'postgres';
const SUPABASE_DB_PASSWORD = process.env.SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD;

async function executeSQLFile(sqlFilePath) {
    if (!SUPABASE_DB_PASSWORD) {
        console.error('❌ ERROR: SUPABASE_DB_PASSWORD not found in .env.local');
        console.error('   Get it from: Supabase Dashboard → Settings → Database');
        console.error('   Add to .env.local: SUPABASE_DB_PASSWORD=your_password');
        process.exit(1);
    }

    if (!fs.existsSync(sqlFilePath)) {
        console.error(`❌ ERROR: SQL file not found: ${sqlFilePath}`);
        process.exit(1);
    }

    const sql = fs.readFileSync(sqlFilePath, 'utf8');
    
    const client = new Client({
        host: SUPABASE_DB_HOST,
        port: SUPABASE_DB_PORT,
        database: SUPABASE_DB_NAME,
        user: SUPABASE_DB_USER,
        password: SUPABASE_DB_PASSWORD,
        ssl: { rejectUnauthorized: false },
        connectionTimeoutMillis: 10000, // 10 second timeout
        query_timeout: 30000, // 30 second query timeout
    });

    try {
        console.log(`🔌 Connecting to Supabase database...`);
        await client.connect();
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
            console.error(`\n💡 Authentication failed. Check your database password in .env.local`);
        } else if (error.code === 'ENOTFOUND' || error.code === 'ECONNREFUSED') {
            console.error(`\n💡 Connection failed. Check your network and database host.`);
        } else if (error.position) {
            const lineNum = sql.substring(0, error.position).split('\n').length;
            console.error(`\n💡 Error at line ${lineNum} in SQL file`);
        }
        
        await client.end().catch(() => {});
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

