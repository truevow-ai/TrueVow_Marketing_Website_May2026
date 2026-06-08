// Final verification report for all counties
const { Client } = require('pg');
const fs = require('fs');
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

async function generateReport() {
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

        // Get all counties with issues
        const issues = await client.query(`
            SELECT 
                c.county_name,
                c.state_code,
                c.total_firms,
                c.total_seats,
                ROUND((c.total_seats::NUMERIC / NULLIF(c.total_firms, 0)) * 100, 1) as seats_percent,
                ROUND(c.total_firms * 0.33) as expected_max,
                CASE 
                    WHEN c.total_seats > c.total_firms THEN 'CATASTROPHIC'
                    WHEN c.total_seats > ROUND(c.total_firms * 0.33) + 1 THEN 'WARNING'
                    ELSE 'OK'
                END as status
            FROM web_availability_county c
            WHERE c.is_active = true
            ORDER BY 
                CASE 
                    WHEN c.total_seats > c.total_firms THEN 1
                    WHEN c.total_seats > ROUND(c.total_firms * 0.33) + 1 THEN 2
                    ELSE 3
                END,
                c.total_seats DESC
        `);

        // Statistics
        const stats = await client.query(`
            SELECT 
                COUNT(*) as total,
                COUNT(CASE WHEN total_seats > total_firms THEN 1 END) as catastrophic,
                COUNT(CASE WHEN total_seats > ROUND(total_firms * 0.33) + 1 AND total_seats <= total_firms THEN 1 END) as warnings,
                COUNT(CASE WHEN total_seats <= total_firms AND total_seats <= ROUND(total_firms * 0.33) + 1 THEN 1 END) as valid
            FROM web_availability_county
            WHERE is_active = true
        `);

        const s = stats.rows[0];

        console.log('='.repeat(80));
        console.log('FINAL VERIFICATION REPORT - ALL COUNTIES');
        console.log('='.repeat(80));
        console.log(`\nTotal Counties: ${s.total}`);
        console.log(`✅ Valid: ${s.valid} (${((s.valid / s.total) * 100).toFixed(1)}%)`);
        console.log(`❌ Catastrophic Errors: ${s.catastrophic}`);
        console.log(`⚠️  Warnings: ${s.warnings}`);
        console.log('\n');

        if (s.catastrophic > 0) {
            console.log('🚨 CATASTROPHIC ERRORS (MUST FIX):');
            console.log('='.repeat(80));
            issues.rows.filter(r => r.status === 'CATASTROPHIC').forEach((row, i) => {
                console.log(`${i + 1}. ${row.county_name}, ${row.state_code}:`);
                console.log(`   ${row.total_firms} firms → ${row.total_seats} seats (${row.seats_percent}%)`);
                console.log(`   Expected max: ${row.expected_max} seats`);
                console.log(`   EXCESS: ${row.total_seats - row.total_firms} seats\n`);
            });
        }

        if (s.warnings > 0) {
            console.log('\n⚠️  WARNINGS:');
            console.log('='.repeat(80));
            issues.rows.filter(r => r.status === 'WARNING').slice(0, 10).forEach((row, i) => {
                console.log(`${i + 1}. ${row.county_name}, ${row.state_code}:`);
                console.log(`   ${row.total_firms} firms → ${row.total_seats} seats (${row.seats_percent}%)`);
                console.log(`   Expected max: ${row.expected_max} seats\n`);
            });
            if (s.warnings > 10) {
                console.log(`   ... and ${s.warnings - 10} more\n`);
            }
        }

        // Save report
        const report = {
            date: new Date().toISOString(),
            summary: {
                total: s.total,
                valid: s.valid,
                catastrophic: s.catastrophic,
                warnings: s.warnings,
                passRate: ((s.valid / s.total) * 100).toFixed(1) + '%'
            },
            catastrophic: issues.rows.filter(r => r.status === 'CATASTROPHIC').map(r => ({
                county: `${r.county_name}, ${r.state_code}`,
                firms: r.total_firms,
                seats: r.total_seats,
                percent: r.seats_percent,
                expected: r.expected_max
            })),
            warnings: issues.rows.filter(r => r.status === 'WARNING').map(r => ({
                county: `${r.county_name}, ${r.state_code}`,
                firms: r.total_firms,
                seats: r.total_seats,
                percent: r.seats_percent,
                expected: r.expected_max
            }))
        };

        fs.writeFileSync('final_verification_report.json', JSON.stringify(report, null, 2));
        console.log(`\n📄 Report saved to: final_verification_report.json`);

        await client.end();

        if (s.catastrophic > 0) {
            console.log('\n❌ CRITICAL ERRORS FOUND - FIX REQUIRED');
            process.exit(1);
        } else {
            console.log('\n✅ ALL COUNTIES VALIDATED - NO CRITICAL ERRORS');
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

generateReport();

