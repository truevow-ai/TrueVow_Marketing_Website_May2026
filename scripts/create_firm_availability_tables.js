// ============================================
// Script to create firm_availability tables in Supabase
// Executes SQL directly via PostgreSQL connection
// ============================================

const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');

// Supabase connection
const SUPABASE_URL = 'https://napwpkagxzqfpbearkjs.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5hcHdwa2FneHpxZnBiZWFya2pzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI0NDg3ODcsImV4cCI6MjA3ODAyNDc4N30.OSHgEylvGsDBwi4xI7Rs0_hpWtULmqadCr_m_eV_EgE';

async function createTables() {
    try {
        console.log('🔧 Creating firm_availability tables in Supabase...\n');
        
        // Read the SQL file
        const sqlPath = path.join(__dirname, '..', 'supabase', 'CREATE_COUNTY_AVAILABILITY_TABLES.sql');
        const sql = fs.readFileSync(sqlPath, 'utf8');
        
        console.log('📄 SQL file loaded:', sqlPath);
        console.log('📊 SQL length:', sql.length, 'characters\n');
        
        // Supabase client
        const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
        
        // Split SQL into individual statements
        const statements = sql
            .split(';')
            .map(s => s.trim())
            .filter(s => s.length > 0 && !s.startsWith('--') && !s.match(/^\s*SELECT/i));
        
        console.log(`📝 Found ${statements.length} SQL statements to execute\n`);
        
        // Try to execute via RPC (if available)
        // Note: Supabase REST API doesn't support arbitrary SQL execution
        // We'll need to use a different approach
        
        // Alternative: Use Supabase Management API or direct PostgreSQL connection
        // For now, we'll output instructions and attempt via REST API
        
        console.log('⚠️  Supabase REST API (anon key) does not support DDL operations.');
        console.log('📋 Attempting alternative method...\n');
        
        // Try to create tables using Supabase client's table operations
        // This won't work for DDL, but let's try a workaround
        
        // Actually, we need to use the Supabase Management API or direct PostgreSQL
        // Since we don't have service role key, we'll need to use psql or provide instructions
        
        console.log('❌ Cannot execute DDL via Supabase REST API with anon key.');
        console.log('✅ SQL file is ready at:', sqlPath);
        console.log('\n📋 Please run the SQL manually in Supabase SQL Editor:');
        console.log('   1. Go to https://supabase.com/dashboard');
        console.log('   2. Select your project');
        console.log('   3. Click SQL Editor → New Query');
        console.log('   4. Copy contents of:', sqlPath);
        console.log('   5. Paste and click Run\n');
        
        // However, let's try to use a PostgreSQL connection if possible
        // Check if we can use node-postgres
        
        try {
            const { Client } = require('pg');
            
            // Supabase PostgreSQL connection string format:
            // postgresql://postgres:[PASSWORD]@[HOST]:5432/postgres
            // We don't have the password, so we can't connect directly
            
            console.log('💡 To automate this, you would need:');
            console.log('   - Supabase database password (from Settings → Database)');
            console.log('   - Or Supabase service_role key (from Settings → API)\n');
            
        } catch (e) {
            // pg module not available
            console.log('💡 Install pg module to enable direct PostgreSQL connection:');
            console.log('   npm install pg\n');
        }
        
    } catch (error) {
        console.error('❌ Error:', error.message);
        console.log('\n📋 Fallback: Please run the SQL manually in Supabase SQL Editor.');
        console.log('📍 File location:', path.join(__dirname, '..', 'supabase', 'CREATE_COUNTY_AVAILABILITY_TABLES.sql'));
    }
}

// Execute
createTables();

