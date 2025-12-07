// ============================================
// Execute migration: Rename firm_* to web_* and create new tables
// ============================================

const { Client } = require('pg');
const fs = require('fs');
const path = require('path');

const SUPABASE_DB_HOST = 'db.napwpkagxzqfpbearkjs.supabase.co';
const SUPABASE_DB_PORT = 5432;
const SUPABASE_DB_NAME = 'postgres';
const SUPABASE_DB_USER = 'postgres';
const SUPABASE_DB_PASSWORD = process.env.SUPABASE_DB_PASSWORD;

async function executeMigration() {
    try {
        console.log('🔧 Starting migration: Rename firm_* to web_* prefix\n');
        
        if (!SUPABASE_DB_PASSWORD) {
            console.log('❌ Database password not found.');
            console.log('💡 Set environment variable: SUPABASE_DB_PASSWORD=your_password');
            console.log('   Or run the SQL files manually in Supabase SQL Editor:\n');
            console.log('   1. supabase/RENAME_FIRM_TO_WEB_PREFIX.sql');
            console.log('   2. supabase/CREATE_COUNTY_AVAILABILITY_TABLES.sql\n');
            return;
        }
        
        const client = new Client({
            host: SUPABASE_DB_HOST,
            port: SUPABASE_DB_PORT,
            database: SUPABASE_DB_NAME,
            user: SUPABASE_DB_USER,
            password: SUPABASE_DB_PASSWORD,
            ssl: { rejectUnauthorized: false }
        });
        
        await client.connect();
        console.log('✅ Connected to Supabase database\n');
        
        // Step 1: Execute rename migration
        console.log('📝 Step 1: Renaming firm_* tables to web_*...\n');
        const renameSql = fs.readFileSync(
            path.join(__dirname, '..', 'supabase', 'RENAME_FIRM_TO_WEB_PREFIX.sql'),
            'utf8'
        );
        await client.query(renameSql);
        console.log('✅ Rename migration complete\n');
        
        // Step 2: Create new tables (if they don't exist)
        console.log('📝 Step 2: Creating web_availability tables...\n');
        const createSql = fs.readFileSync(
            path.join(__dirname, '..', 'supabase', 'CREATE_COUNTY_AVAILABILITY_TABLES.sql'),
            'utf8'
        );
        await client.query(createSql);
        console.log('✅ Table creation complete\n');
        
        // Step 3: Verify
        console.log('📝 Step 3: Verifying tables...\n');
        const verifyQuery = `
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public' 
            AND (table_name LIKE 'web_%' OR table_name LIKE 'firm_%')
            ORDER BY table_name;
        `;
        
        const result = await client.query(verifyQuery);
        
        console.log('📊 Current tables:');
        result.rows.forEach(row => {
            const status = row.table_name.startsWith('web_') ? '✅' : '❌';
            console.log(`   ${status} ${row.table_name}`);
        });
        
        const webTables = result.rows.filter(r => r.table_name.startsWith('web_'));
        const firmTables = result.rows.filter(r => r.table_name.startsWith('firm_'));
        
        console.log(`\n✅ Migration complete!`);
        console.log(`   Web tables: ${webTables.length}`);
        console.log(`   Firm tables (should be 0): ${firmTables.length}`);
        
        if (firmTables.length > 0) {
            console.log(`\n⚠️  Warning: ${firmTables.length} table(s) still have firm_ prefix:`);
            firmTables.forEach(t => console.log(`   - ${t.table_name}`));
        }
        
        await client.end();
        console.log('\n✅ Done!');
        
    } catch (error) {
        console.error('❌ Error:', error.message);
        
        if (error.code === '28P01') {
            console.log('\n💡 Authentication failed. Check your database password.');
        } else {
            console.log('\n📋 Fallback: Run SQL files manually in Supabase SQL Editor');
        }
    }
}

executeMigration();

