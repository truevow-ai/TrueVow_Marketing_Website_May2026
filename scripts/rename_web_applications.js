// ============================================
// Execute rename: web_applications → web_firm_applications
// ============================================

const { Client } = require('pg');
const fs = require('fs');
const path = require('path');

const SUPABASE_DB_HOST = 'db.napwpkagxzqfpbearkjs.supabase.co';
const SUPABASE_DB_PORT = 5432;
const SUPABASE_DB_NAME = 'postgres';
const SUPABASE_DB_USER = 'postgres';
const SUPABASE_DB_PASSWORD = process.env.SUPABASE_DB_PASSWORD;

async function renameTable() {
    try {
        console.log('🔧 Renaming web_applications → web_firm_applications...\n');
        
        if (!SUPABASE_DB_PASSWORD) {
            console.log('❌ Database password not found.');
            console.log('💡 Set environment variable: SUPABASE_DB_PASSWORD=your_password');
            console.log('   Or run the SQL manually in Supabase SQL Editor:');
            console.log('   File: supabase/RENAME_WEB_APPLICATIONS_TO_WEB_FIRM_APPLICATIONS.sql\n');
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
            path.join(__dirname, '..', 'supabase', 'RENAME_WEB_APPLICATIONS_TO_WEB_FIRM_APPLICATIONS.sql'),
            'utf8'
        );
        
        await client.query(renameSql);
        console.log('✅ Rename complete!\n');
        
        // Verify
        const verifyQuery = `
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public' 
            AND (table_name = 'web_applications' OR table_name = 'web_firm_applications')
            ORDER BY table_name;
        `;
        
        const result = await client.query(verifyQuery);
        
        console.log('📊 Verification:');
        result.rows.forEach(row => {
            const status = row.table_name === 'web_firm_applications' ? '✅' : '❌';
            console.log(`   ${status} ${row.table_name}`);
        });
        
        await client.end();
        console.log('\n✅ Done!');
        
    } catch (error) {
        console.error('❌ Error:', error.message);
        
        if (error.code === '28P01') {
            console.log('\n💡 Authentication failed. Check your database password.');
        } else {
            console.log('\n📋 Fallback: Run SQL manually in Supabase SQL Editor');
            console.log('   File: supabase/RENAME_WEB_APPLICATIONS_TO_WEB_FIRM_APPLICATIONS.sql');
        }
    }
}

renameTable();

