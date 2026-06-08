// Comprehensive script to populate counties and fix RLS
const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

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
    } catch (e) {}
}

SUPABASE_DB_HOST = SUPABASE_DB_HOST || process.env.MARKETING_DB_HOST || 'db.napwpkagxzqfpbearkjs.supabase.co';
SUPABASE_DB_PORT = SUPABASE_DB_PORT || parseInt(process.env.MARKETING_DB_PORT || '5432');
SUPABASE_DB_NAME = SUPABASE_DB_NAME || process.env.MARKETING_DB_NAME || 'postgres';
SUPABASE_DB_USER = SUPABASE_DB_USER || process.env.MARKETING_DB_USER || 'postgres';

const rawPassword = SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD;
SUPABASE_DB_PASSWORD = rawPassword;

if (rawPassword && rawPassword.includes('%')) {
    try {
        decodedPassword = decodeURIComponent(rawPassword);
    } catch (e) {}
}

async function tryConnection(password) {
    const testClient = new Client({
        host: SUPABASE_DB_HOST,
        port: SUPABASE_DB_PORT,
        database: SUPABASE_DB_NAME,
        user: SUPABASE_DB_USER,
        password: password,
        ssl: { rejectUnauthorized: false },
        connectionTimeoutMillis: 30000
    });
    await testClient.connect();
    return testClient;
}

async function fixAndPopulate() {
    let client;
    let passwordToUse = SUPABASE_DB_PASSWORD;

    try {
        console.log('🔌 Connecting to database...');
        try {
            client = await tryConnection(SUPABASE_DB_PASSWORD);
            console.log('✅ Connected\n');
        } catch (firstError) {
            if (decodedPassword && firstError.code === '28P01') {
                console.log('⚠️  Trying decoded password...');
                client = await tryConnection(decodedPassword);
                passwordToUse = decodedPassword;
                console.log('✅ Connected with decoded password\n');
            } else {
                throw firstError;
            }
        }

        // Step 1: Check current data
        console.log('📊 Checking current data...');
        const checkResult = await client.query(`
            SELECT state_code, COUNT(*) as count
            FROM web_availability_county
            WHERE is_active = true
            GROUP BY state_code
            ORDER BY state_code
        `);
        
        console.log('Current counties in database:');
        checkResult.rows.forEach(row => {
            console.log(`  ${row.state_code}: ${row.count} counties`);
        });

        // Step 2: Ensure RLS policies are correct
        console.log('\n🔒 Ensuring RLS policies are set...');
        await client.query(`
            -- Enable RLS
            ALTER TABLE web_availability_county ENABLE ROW LEVEL SECURITY;
            ALTER TABLE web_availability_practice_area_seats ENABLE ROW LEVEL SECURITY;
            
            -- Drop and recreate public read policy
            DROP POLICY IF EXISTS "Allow public read web availability county" ON web_availability_county;
            CREATE POLICY "Allow public read web availability county"
                ON web_availability_county
                FOR SELECT
                TO public
                USING (is_active = TRUE);
            
            DROP POLICY IF EXISTS "Allow public read web availability practice area seats" ON web_availability_practice_area_seats;
            CREATE POLICY "Allow public read web availability practice area seats"
                ON web_availability_practice_area_seats
                FOR SELECT
                TO public
                USING (is_active = TRUE);
        `);
        console.log('✅ RLS policies updated\n');

        // Step 3: Run the populate script logic
        console.log('🚀 Running population script...');
        // Import and run the calculate script
        const { exec } = require('child_process');
        const { promisify } = require('util');
        const execAsync = promisify(exec);
        
        try {
            const { stdout, stderr } = await execAsync('node scripts/calculate_all_states_county_data.js');
            if (stdout) console.log(stdout);
            if (stderr) console.error(stderr);
        } catch (error) {
            console.log('Population script output captured');
        }

        // Step 4: Verify Texas counties
        console.log('\n✅ Verifying Texas counties...');
        const texasResult = await client.query(`
            SELECT county_slug, county_name, total_firms, total_seats
            FROM web_availability_county
            WHERE state_code = 'TX' AND is_active = true
            ORDER BY county_name
            LIMIT 10
        `);

        if (texasResult.rows.length === 0) {
            console.log('❌ No Texas counties found. Data may not have been populated.');
            console.log('   Run: npm run db:calculate-all-states');
        } else {
            console.log(`✅ Found ${texasResult.rows.length} Texas counties (showing first 10):`);
            texasResult.rows.forEach(row => {
                console.log(`   - ${row.county_name} (${row.county_slug})`);
            });
        }

        await client.end();
        console.log('\n✅ Done!');

    } catch (error) {
        console.error('❌ Error:', error.message);
        if (client) {
            await client.end().catch(() => {});
        }
        process.exit(1);
    }
}

fixAndPopulate();

