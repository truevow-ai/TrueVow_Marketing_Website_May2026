// ============================================
// Script to create county_availability and practice_area_seats tables in Supabase
// ============================================

const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');

// Supabase connection (from marketing/index.html)
const SUPABASE_URL = 'https://napwpkagxzqfpbearkjs.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5hcHdwa2FneHpxZnBiZWFya2pzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI0NDg3ODcsImV4cCI6MjA3ODAyNDc4N30.OSHgEylvGsDBwi4xI7Rs0_hpWtULmqadCr_m_eV_EgE';

// For SQL execution, we need the service role key or use RPC
// Since we only have anon key, we'll use Supabase's REST API with SQL execution
// Actually, we need to use the PostgREST API or connect directly to PostgreSQL

async function createTables() {
    try {
        console.log('🔧 Creating county availability tables in Supabase...\n');
        
        // Read the SQL file
        const sqlPath = path.join(__dirname, '..', 'supabase', 'CREATE_COUNTY_AVAILABILITY_TABLES.sql');
        const sql = fs.readFileSync(sqlPath, 'utf8');
        
        console.log('📄 SQL file loaded:', sqlPath);
        console.log('📊 SQL length:', sql.length, 'characters\n');
        
        // Supabase client
        const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
        
        // Note: Supabase JS client doesn't support raw SQL execution directly
        // We need to use the REST API with service role key or use rpc
        // For now, let's try using the REST API endpoint for SQL execution
        
        // Alternative: Use fetch to call Supabase REST API with SQL
        // But this requires service_role key which we don't have
        
        // Best approach: Use Supabase's SQL execution via REST API
        // We'll need to make a POST request to the REST API
        
        const response = await fetch(`${SUPABASE_URL}/rest/v1/rpc/exec_sql`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'apikey': SUPABASE_ANON_KEY,
                'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
            },
            body: JSON.stringify({ sql: sql })
        });
        
        if (!response.ok) {
            // If RPC doesn't exist, we'll output the SQL for manual execution
            console.log('⚠️  Direct SQL execution not available via API.');
            console.log('📋 Please run the SQL manually in Supabase SQL Editor:\n');
            console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
            console.log(sql);
            console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
            console.log('📍 File location:', sqlPath);
            console.log('\n✅ SQL file is ready. Please copy and paste it into Supabase SQL Editor.');
            return;
        }
        
        const result = await response.json();
        console.log('✅ Tables created successfully!');
        console.log('📊 Result:', result);
        
    } catch (error) {
        console.error('❌ Error:', error.message);
        console.log('\n📋 Fallback: Please run the SQL manually in Supabase SQL Editor.');
        console.log('📍 File location:', path.join(__dirname, '..', 'supabase', 'CREATE_COUNTY_AVAILABILITY_TABLES.sql'));
    }
}

// Execute
createTables();

