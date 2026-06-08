// Verify the specific counties the user showed
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

async function verifySpecificCounties() {
    let client;
    
    try {
        console.log('🔌 Connecting...');
        try {
            client = await tryConnection(SUPABASE_DB_PASSWORD);
        } catch (firstError) {
            if (decodedPassword && firstError.code === '28P01') {
                client = await tryConnection(decodedPassword);
            } else {
                throw firstError;
            }
        }
        console.log('✅ Connected\n');

        // Counties the user showed
        const counties = [
            'bradford', 'columbia', 'desoto', 'dixie', 'flagler', 
            'franklin', 'gadsden', 'gilchrist', 'glades', 'gulf',
            'calhoun', 'hamilton', 'hardee', 'hendry', 'highlands'
        ];

        console.log('='.repeat(80));
        console.log('VERIFICATION: Counties You Showed');
        console.log('='.repeat(80));
        console.log('\n');

        let fixed = 0;
        let stillBroken = 0;

        for (const slug of counties) {
            const result = await client.query(`
                SELECT 
                    c.county_name,
                    c.total_firms,
                    c.total_seats,
                    ROUND((c.total_seats::NUMERIC / NULLIF(c.total_firms, 0)) * 100, 1) as percent,
                    ROUND(c.total_firms * 0.33) as expected_max,
                    COUNT(pa.id) as practice_area_count,
                    SUM(pa.cap) as sum_pa_caps
                FROM web_availability_county c
                LEFT JOIN web_availability_practice_area_seats pa ON pa.county_availability_id = c.id AND pa.is_active = true
                WHERE c.county_slug = $1 AND c.state_code = 'FL' AND c.is_active = true
                GROUP BY c.id, c.county_name, c.total_firms, c.total_seats
            `, [slug]);

            if (result.rows.length > 0) {
                const row = result.rows[0];
                const status = row.total_seats > row.total_firms ? '❌ BROKEN' :
                              row.total_seats === 72 ? '⚠️  STILL 72' :
                              row.total_seats > row.expected_max + 1 ? '⚠️  WARNING' :
                              '✅ FIXED';
                
                console.log(`${row.county_name} County:`);
                console.log(`   Firms: ${row.total_firms} → Seats: ${row.total_seats} (Expected: ~${row.expected_max})`);
                console.log(`   Status: ${status}`);
                
                if (row.total_seats === 72) {
                    console.log(`   ⚠️  Still showing 72 seats!`);
                    stillBroken++;
                } else if (row.total_seats <= row.total_firms && row.total_seats <= row.expected_max + 1) {
                    fixed++;
                }
                console.log('');
            }
        }

        console.log('='.repeat(80));
        console.log(`✅ Fixed: ${fixed}`);
        console.log(`❌ Still Broken: ${stillBroken}`);
        console.log('='.repeat(80));

        if (stillBroken > 0) {
            console.log('\n⚠️  Some counties still need fixing. The nuclear fix may need to be run again.');
        }

        await client.end();

    } catch (error) {
        console.error('❌ Error:', error.message);
        if (client) {
            await client.end().catch(() => {});
        }
        process.exit(1);
    }
}

verifySpecificCounties();

