// ============================================
// Execute SQL to create firm_availability tables in Supabase
// Uses direct PostgreSQL connection
// ============================================

const { Client } = require('pg');
const fs = require('fs');
const path = require('path');

// Supabase PostgreSQL connection
// Format: postgresql://postgres:[PASSWORD]@[HOST]:5432/postgres
// Host: db.napwpkagxzqfpbearkjs.supabase.co
// We need the database password from Supabase Settings → Database

const SUPABASE_DB_HOST = 'db.napwpkagxzqfpbearkjs.supabase.co';
const SUPABASE_DB_PORT = 5432;
const SUPABASE_DB_NAME = 'postgres';
const SUPABASE_DB_USER = 'postgres';

// Try to get password from environment or prompt
const SUPABASE_DB_PASSWORD = process.env.SUPABASE_DB_PASSWORD;

async function createTables() {
    try {
        console.log('🔧 Creating firm_availability tables in Supabase...\n');
        
        if (!SUPABASE_DB_PASSWORD) {
            console.log('❌ Database password not found.');
            console.log('💡 To execute SQL automatically, you need:');
            console.log('   1. Go to Supabase Dashboard → Settings → Database');
            console.log('   2. Copy the database password');
            console.log('   3. Set environment variable: SUPABASE_DB_PASSWORD=your_password');
            console.log('   4. Or run: export SUPABASE_DB_PASSWORD=your_password\n');
            console.log('📋 Alternatively, run the SQL manually in Supabase SQL Editor:');
            console.log('   File:', path.join(__dirname, '..', 'supabase', 'CREATE_COUNTY_AVAILABILITY_TABLES.sql'));
            return;
        }
        
        // Read the SQL file
        const sqlPath = path.join(__dirname, '..', 'supabase', 'CREATE_COUNTY_AVAILABILITY_TABLES.sql');
        const sql = fs.readFileSync(sqlPath, 'utf8');
        
        console.log('📄 SQL file loaded:', sqlPath);
        console.log('📊 Connecting to Supabase PostgreSQL...\n');
        
        // Create PostgreSQL client
        const client = new Client({
            host: SUPABASE_DB_HOST,
            port: SUPABASE_DB_PORT,
            database: SUPABASE_DB_NAME,
            user: SUPABASE_DB_USER,
            password: SUPABASE_DB_PASSWORD,
            ssl: {
                rejectUnauthorized: false // Supabase requires SSL
            }
        });
        
        // Connect
        await client.connect();
        console.log('✅ Connected to Supabase database\n');
        
        // Execute SQL
        console.log('📝 Executing SQL statements...\n');
        await client.query(sql);
        
        console.log('✅ Tables created successfully!\n');
        
        // Verify tables exist
        const verifyQuery = `
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public' 
            AND table_name IN ('firm_availability_county', 'firm_availability_practice_area_seats')
            ORDER BY table_name;
        `;
        
        const result = await client.query(verifyQuery);
        
        if (result.rows.length === 2) {
            console.log('✅ Verification: Both tables exist');
            result.rows.forEach(row => {
                console.log(`   - ${row.table_name}`);
            });
        } else {
            console.log('⚠️  Verification: Some tables may be missing');
            console.log(`   Found ${result.rows.length} of 2 expected tables`);
        }
        
        // Close connection
        await client.end();
        console.log('\n✅ Done!');
        
    } catch (error) {
        console.error('❌ Error:', error.message);
        
        if (error.code === '28P01') {
            console.log('\n💡 Authentication failed. Please check your database password.');
        } else if (error.code === 'ENOTFOUND' || error.code === 'ECONNREFUSED') {
            console.log('\n💡 Connection failed. Please check your network connection.');
        } else {
            console.log('\n📋 Fallback: Please run the SQL manually in Supabase SQL Editor:');
            console.log('   File:', path.join(__dirname, '..', 'supabase', 'CREATE_COUNTY_AVAILABILITY_TABLES.sql'));
        }
    }
}

// Execute
createTables();

