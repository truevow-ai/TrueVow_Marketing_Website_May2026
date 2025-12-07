// ============================================
// Execute migration: Rename all tables to web_* prefix
// ============================================

const { Client } = require('pg');
const fs = require('fs');
const path = require('path');

const SUPABASE_DB_HOST = 'db.napwpkagxzqfpbearkjs.supabase.co';
const SUPABASE_DB_PORT = 5432;
const SUPABASE_DB_NAME = 'postgres';
const SUPABASE_DB_USER = 'postgres';
const SUPABASE_DB_PASSWORD = process.env.SUPABASE_DB_PASSWORD;

async function renameAllTables() {
    try {
        console.log('🔧 Renaming all tables to web_* prefix...\n');
        
        if (!SUPABASE_DB_PASSWORD) {
            console.log('❌ Database password not found.');
            console.log('💡 Set environment variable: SUPABASE_DB_PASSWORD=your_password');
            console.log('   Or run the SQL manually in Supabase SQL Editor:');
            console.log('   File: supabase/RENAME_ALL_TABLES_TO_WEB_PREFIX.sql\n');
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
        
        // Execute rename SQL
        const renameSql = fs.readFileSync(
            path.join(__dirname, '..', 'supabase', 'RENAME_ALL_TABLES_TO_WEB_PREFIX.sql'),
            'utf8'
        );
        
        await client.query(renameSql);
        console.log('✅ Rename migration complete!\n');
        
        // Verify
        const verifyQuery = `
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public' 
            AND table_type = 'BASE TABLE'
            AND table_name NOT LIKE 'pg_%'
            AND table_name NOT LIKE '_%'
            ORDER BY table_name;
        `;
        
        const result = await client.query(verifyQuery);
        
        console.log('📊 Current tables:');
        const webTables = [];
        const nonWebTables = [];
        
        result.rows.forEach(row => {
            if (row.table_name.startsWith('web_')) {
                webTables.push(row.table_name);
                console.log(`   ✅ ${row.table_name}`);
            } else {
                nonWebTables.push(row.table_name);
                console.log(`   ❌ ${row.table_name}`);
            }
        });
        
        console.log(`\n✅ Migration complete!`);
        console.log(`   Tables with web_ prefix: ${webTables.length}`);
        console.log(`   Tables without web_ prefix: ${nonWebTables.length}`);
        
        if (nonWebTables.length > 0) {
            console.log(`\n⚠️  Warning: ${nonWebTables.length} table(s) still missing web_ prefix:`);
            nonWebTables.forEach(t => console.log(`   - ${t}`));
        }
        
        await client.end();
        console.log('\n✅ Done!');
        
    } catch (error) {
        console.error('❌ Error:', error.message);
        
        if (error.code === '28P01') {
            console.log('\n💡 Authentication failed. Check your database password.');
        } else {
            console.log('\n📋 Fallback: Run SQL manually in Supabase SQL Editor');
            console.log('   File: supabase/RENAME_ALL_TABLES_TO_WEB_PREFIX.sql');
        }
    }
}

renameAllTables();
