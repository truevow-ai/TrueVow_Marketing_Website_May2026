// Validation script for Baker and Calhoun counties
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

async function validateCounties() {
    let client;
    let passwordToUse = SUPABASE_DB_PASSWORD;

    try {
        console.log('🔌 Connecting to database...');
        try {
            client = await tryConnection(SUPABASE_DB_PASSWORD);
        } catch (firstError) {
            if (decodedPassword && firstError.code === '28P01') {
                client = await tryConnection(decodedPassword);
                passwordToUse = decodedPassword;
            } else {
                throw firstError;
            }
        }
        console.log('✅ Connected\n');

        const counties = [
            { slug: 'baker', name: 'Baker', state: 'FL' },
            { slug: 'calhoun', name: 'Calhoun', state: 'FL' }
        ];

        console.log('='.repeat(70));
        console.log('VALIDATION REPORT: Baker & Calhoun Counties, Florida');
        console.log('='.repeat(70));
        console.log('\n📊 CURRENT DATABASE VALUES:\n');

        for (const county of counties) {
            const result = await client.query(`
                SELECT 
                    c.id,
                    c.county_name,
                    c.state_code,
                    c.total_firms,
                    c.total_seats,
                    c.premium_total,
                    c.standard_total,
                    COUNT(pa.id) as practice_area_count,
                    SUM(pa.total_firms) as sum_practice_area_firms,
                    SUM(pa.cap) as sum_practice_area_caps,
                    STRING_AGG(pa.practice_area_name || ': ' || pa.total_firms || ' firms, ' || pa.cap || ' seats', ', ' ORDER BY pa.display_order) as practice_areas
                FROM web_availability_county c
                LEFT JOIN web_availability_practice_area_seats pa ON pa.county_availability_id = c.id AND pa.is_active = true
                WHERE c.county_slug = $1 AND c.state_code = $2 AND c.is_active = true
                GROUP BY c.id, c.county_name, c.state_code, c.total_firms, c.total_seats, c.premium_total, c.standard_total
            `, [county.slug, county.state]);

            if (result.rows.length > 0) {
                const row = result.rows[0];
                console.log(`📍 ${row.county_name} County, ${row.state_code}:`);
                console.log(`   Total Firms (stored): ${row.total_firms}`);
                console.log(`   Total Seats (stored): ${row.total_seats}`);
                console.log(`   Sum of Practice Area Firms: ${row.sum_practice_area_firms || 0}`);
                console.log(`   Sum of Practice Area Caps: ${row.sum_practice_area_caps || 0}`);
                console.log(`   Practice Areas: ${row.practice_area_count}`);
                console.log(`   Seats as % of Firms: ${((row.total_seats / row.total_firms) * 100).toFixed(1)}%`);
                
                // Calculate what BLS data would be (reverse of 67%)
                const estimatedBLS = Math.round(row.total_firms / 0.67);
                console.log(`   Estimated BLS Law Offices: ${estimatedBLS} (${row.total_firms} ÷ 0.67)`);
                
                console.log(`\n   Practice Area Breakdown:`);
                if (row.practice_areas) {
                    const areas = row.practice_areas.split(', ');
                    areas.forEach(area => {
                        console.log(`     - ${area}`);
                    });
                }
                
                // Validation checks
                const issues = [];
                if (row.total_seats > row.total_firms) {
                    issues.push(`❌ Total seats (${row.total_seats}) exceeds total firms (${row.total_firms})`);
                }
                if (row.total_seats > Math.round(row.total_firms * 0.33) + 1) {
                    issues.push(`⚠️  Total seats (${row.total_seats}) exceeds 33% cap (${Math.round(row.total_firms * 0.33)})`);
                }
                if (Math.abs((row.sum_practice_area_firms || 0) - row.total_firms) > row.total_firms * 0.05) {
                    issues.push(`⚠️  Practice area firms sum (${row.sum_practice_area_firms}) doesn't match total firms (${row.total_firms})`);
                }
                
                if (issues.length > 0) {
                    console.log(`\n   ⚠️  ISSUES FOUND:`);
                    issues.forEach(issue => console.log(`     ${issue}`));
                } else {
                    console.log(`\n   ✅ All validations passed`);
                }
                console.log('\n');
            } else {
                console.log(`❌ ${county.name} County not found in database\n`);
            }
        }

        console.log('='.repeat(70));
        console.log('📋 VALIDATION NOTES:');
        console.log('='.repeat(70));
        console.log(`
1. BLS DATA SOURCES TO VERIFY:
   - BLS QCEW Database: https://www.bls.gov/cew/
   - Search for NAICS 54111 (Offices of Lawyers)
   - Filter by Florida → County level
   - Period: Q1 2024

2. ALTERNATIVE SOURCES:
   - Florida Bar Association member directory (if accessible)
   - County business license records
   - Legal directories (Martindale-Hubbell, Avvo, FindLaw)
   - Census Bureau County Business Patterns

3. EXPECTED VALUES FOR SMALL COUNTIES:
   - Baker County: Very rural, population ~27,000
     * Estimated BLS offices: 12-18
     * Solo/small firms (67%): 8-12
     * Total seats (33%): 2-4
   
   - Calhoun County: Rural, population ~14,000
     * Estimated BLS offices: 10-15
     * Solo/small firms (67%): 7-10
     * Total seats (33%): 2-3

4. CURRENT SCRIPT VALUES:
   - Baker: 12 BLS offices → 8 solo/small firms → 2-3 total seats
   - Calhoun: 70 BLS offices → 47 solo/small firms → 15 total seats

5. VERIFICATION NEEDED:
   - Verify BLS QCEW data for these specific counties
   - Check if Calhoun's 70 offices is accurate (seems high for 14K population)
   - Validate that practice area distribution makes sense for rural counties
        `);

        await client.end();

    } catch (error) {
        console.error('❌ Error:', error.message);
        if (client) {
            await client.end().catch(() => {});
        }
        process.exit(1);
    }
}

validateCounties();

