// ============================================
// Find ALL Counties with Critical Errors
// Checks every county for: total seats > total firms
// ============================================

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

async function findAllCriticalErrors() {
    let client;
    
    try {
        console.log('🔌 Connecting to database...');
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

        console.log('='.repeat(80));
        console.log('CRITICAL ERROR SCAN: ALL COUNTIES');
        console.log('='.repeat(80));
        console.log('\n');

        // Find ALL counties with critical errors
        const criticalErrors = await client.query(`
            SELECT 
                c.id,
                c.county_name,
                c.state_code,
                c.county_slug,
                c.total_firms,
                c.total_seats,
                COUNT(pa.id) as practice_area_count,
                SUM(pa.cap) as sum_practice_area_caps,
                ROUND((c.total_seats::NUMERIC / NULLIF(c.total_firms, 0)) * 100, 1) as seats_percent,
                ROUND(c.total_firms * 0.33) as expected_max_seats
            FROM web_availability_county c
            LEFT JOIN web_availability_practice_area_seats pa ON pa.county_availability_id = c.id AND pa.is_active = true
            WHERE c.is_active = true
            GROUP BY c.id, c.county_name, c.state_code, c.county_slug, c.total_firms, c.total_seats
            HAVING c.total_seats > c.total_firms OR c.total_seats > ROUND(c.total_firms * 0.33) + 1
            ORDER BY 
                CASE 
                    WHEN c.total_seats > c.total_firms THEN 1
                    ELSE 2
                END,
                c.total_seats DESC
        `);

        if (criticalErrors.rows.length === 0) {
            console.log('✅ NO CRITICAL ERRORS FOUND!');
            console.log('   All counties have valid seat counts.\n');
        } else {
            console.log(`🚨 FOUND ${criticalErrors.rows.length} COUNTIES WITH CRITICAL ERRORS:\n`);

            const catastrophic = criticalErrors.rows.filter(r => r.total_seats > r.total_firms);
            const warnings = criticalErrors.rows.filter(r => r.total_seats <= r.total_firms);

            if (catastrophic.length > 0) {
                console.log('❌ CATASTROPHIC ERRORS (Total Seats > Total Firms):');
                console.log('='.repeat(80));
                catastrophic.forEach((row, index) => {
                    console.log(`\n${index + 1}. ${row.county_name} County, ${row.state_code}:`);
                    console.log(`   Total Firms: ${row.total_firms}`);
                    console.log(`   Total Seats: ${row.total_seats} ❌`);
                    console.log(`   Excess: ${row.total_seats - row.total_firms} seats`);
                    console.log(`   Percentage: ${row.seats_percent}% (should be ≤33%)`);
                    console.log(`   Expected Max: ${row.expected_max_seats} seats`);
                    console.log(`   Practice Areas: ${row.practice_area_count}`);
                    console.log(`   Sum of PA Caps: ${row.sum_practice_area_caps || 0}`);
                });
            }

            if (warnings.length > 0) {
                console.log('\n\n⚠️  WARNINGS (Total Seats > 33% Cap):');
                console.log('='.repeat(80));
                warnings.forEach((row, index) => {
                    console.log(`\n${index + 1}. ${row.county_name} County, ${row.state_code}:`);
                    console.log(`   Total Firms: ${row.total_firms}`);
                    console.log(`   Total Seats: ${row.total_seats}`);
                    console.log(`   Expected Max: ${row.expected_max_seats} seats`);
                    console.log(`   Excess: ${row.total_seats - row.expected_max_seats} seats`);
                    console.log(`   Percentage: ${row.seats_percent}%`);
                });
            }

            // Generate fix list
            console.log('\n\n📋 COUNTIES THAT NEED FIXING:');
            console.log('='.repeat(80));
            criticalErrors.rows.forEach(row => {
                console.log(`   - ${row.county_name} County, ${row.state_code} (${row.total_firms} firms, ${row.total_seats} seats)`);
            });
        }

        // Also check for counties where practice area caps sum incorrectly
        const sumMismatches = await client.query(`
            SELECT 
                c.county_name,
                c.state_code,
                c.total_seats as county_total_seats,
                COALESCE(SUM(pa.cap), 0) as sum_practice_area_caps,
                ABS(c.total_seats - COALESCE(SUM(pa.cap), 0)) as difference
            FROM web_availability_county c
            LEFT JOIN web_availability_practice_area_seats pa ON pa.county_availability_id = c.id AND pa.is_active = true
            WHERE c.is_active = true
            GROUP BY c.id, c.county_name, c.state_code, c.total_seats
            HAVING ABS(c.total_seats - COALESCE(SUM(pa.cap), 0)) > 1
            ORDER BY difference DESC
            LIMIT 20
        `);

        if (sumMismatches.rows.length > 0) {
            console.log('\n\n⚠️  PRACTICE AREA SUM MISMATCHES:');
            console.log('='.repeat(80));
            sumMismatches.rows.forEach(row => {
                console.log(`   ${row.county_name}, ${row.state_code}: County shows ${row.county_total_seats} but practice areas sum to ${row.sum_practice_area_caps} (diff: ${row.difference})`);
            });
        }

        // Summary statistics
        const stats = await client.query(`
            SELECT 
                COUNT(*) as total_counties,
                COUNT(CASE WHEN total_seats > total_firms THEN 1 END) as catastrophic_count,
                COUNT(CASE WHEN total_seats > ROUND(total_firms * 0.33) + 1 THEN 1 END) as warning_count,
                COUNT(CASE WHEN total_seats <= total_firms AND total_seats <= ROUND(total_firms * 0.33) + 1 THEN 1 END) as valid_count
            FROM web_availability_county
            WHERE is_active = true
        `);

        console.log('\n\n📊 SUMMARY STATISTICS:');
        console.log('='.repeat(80));
        console.log(`   Total Counties: ${stats.rows[0].total_counties}`);
        console.log(`   ✅ Valid: ${stats.rows[0].valid_count}`);
        console.log(`   ❌ Catastrophic Errors: ${stats.rows[0].catastrophic_count}`);
        console.log(`   ⚠️  Warnings: ${stats.rows[0].warning_count}`);
        console.log(`   Pass Rate: ${((stats.rows[0].valid_count / stats.rows[0].total_counties) * 100).toFixed(1)}%`);

        await client.end();

        // Exit with error if catastrophic errors found
        if (criticalErrors.rows.length > 0) {
            console.log('\n\n❌ CRITICAL ERRORS FOUND - FIX REQUIRED');
            process.exit(1);
        } else {
            console.log('\n\n✅ ALL COUNTIES VALIDATED');
            process.exit(0);
        }

    } catch (error) {
        console.error('❌ Error:', error.message);
        if (client) {
            await client.end().catch(() => {});
        }
        process.exit(1);
    }
}

findAllCriticalErrors();

