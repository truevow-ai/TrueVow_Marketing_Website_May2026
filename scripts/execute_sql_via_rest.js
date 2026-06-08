// ============================================
// Execute SQL via Supabase REST API (alternative method)
// Uses Supabase JS client with service role key
// ============================================

const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');
require('dotenv').config({ path: '.env.local' });

const SUPABASE_URL = process.env.MARKETING_SUPABASE_URL || process.env.NEXT_PUBLIC_SUPABASE_URL;
const SUPABASE_SERVICE_KEY = process.env.MARKETING_SUPABASE_SERVICE_KEY || process.env.SUPABASE_SERVICE_ROLE_KEY;

async function executeSQLFile(sqlFilePath) {
    if (!SUPABASE_URL || !SUPABASE_SERVICE_KEY) {
        console.error('❌ ERROR: SUPABASE_URL and SUPABASE_SERVICE_KEY required in .env.local');
        console.error('   Get service role key from: Supabase Dashboard → Settings → API');
        process.exit(1);
    }

    if (!fs.existsSync(sqlFilePath)) {
        console.error(`❌ ERROR: SQL file not found: ${sqlFilePath}`);
        process.exit(1);
    }

    const sql = fs.readFileSync(sqlFilePath, 'utf8');
    
    console.log(`📝 Executing SQL from: ${sqlFilePath}`);
    console.log(`📊 SQL size: ${(sql.length / 1024).toFixed(2)} KB\n`);

    try {
        // Create Supabase client with service role key (has admin privileges)
        const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY, {
            auth: {
                autoRefreshToken: false,
                persistSession: false
            }
        });

        // Split SQL into individual statements (semicolon-separated)
        const statements = sql
            .split(';')
            .map(s => s.trim())
            .filter(s => s.length > 0 && !s.startsWith('--') && !s.startsWith('/*'));

        console.log(`📋 Found ${statements.length} SQL statements to execute\n`);

        // Execute each statement via RPC (if available) or direct query
        // Note: Supabase REST API doesn't support arbitrary SQL execution
        // We need to use the PostgreSQL connection or Supabase Dashboard
        
        console.log('⚠️  Supabase REST API cannot execute arbitrary SQL statements.');
        console.log('   Use one of these methods instead:');
        console.log('   1. Supabase Dashboard SQL Editor (recommended)');
        console.log('   2. Direct PostgreSQL connection (requires correct password)');
        console.log('   3. Supabase CLI (if linked to project)');
        
        process.exit(1);

    } catch (error) {
        console.error(`\n❌ ERROR executing SQL:`);
        console.error(`   ${error.message}`);
        process.exit(1);
    }
}

// Main execution
const sqlFile = process.argv[2];

if (!sqlFile) {
    console.error('Usage: node scripts/execute_sql_via_rest.js <path-to-sql-file>');
    console.error('Example: node scripts/execute_sql_via_rest.js supabase/ADD_ZIPCODE_TO_FIRM_APPLICATIONS.sql');
    process.exit(1);
}

const sqlFilePath = path.isAbsolute(sqlFile) ? sqlFile : path.join(__dirname, '..', sqlFile);
executeSQLFile(sqlFilePath).catch(error => {
    console.error('Fatal error:', error);
    process.exit(1);
});

