// ============================================
// Comprehensive Validation Script
// Validates all data and creates detailed report
// ============================================

const { Client } = require('pg');
const fs = require('fs');
require('dotenv').config({ path: '.env.local' });

// Get connection details (same pattern as working scripts)
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

const PRACTICE_AREA_RANGES = {
    'personal-injury': { min: 0.20, max: 0.30 },
    'family-law': { min: 0.15, max: 0.25 },
    'immigration': { min: 0.10, max: 0.20 },
    'criminal-defense': { min: 0.10, max: 0.15 },
    'employment-law': { min: 0.06, max: 0.10 },
    'real-estate': { min: 0.05, max: 0.10 },
    'bankruptcy': { min: 0.03, max: 0.07 },
    'estate-planning': { min: 0.03, max: 0.06 },
    'workers-comp': { min: 0.02, max: 0.06 }
};

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

async function validateAll() {
    console.log('🚀 Starting comprehensive validation...\n');
    
    let client;
    let passwordToUse = SUPABASE_DB_PASSWORD;

    try {
        console.log('🔌 Connecting to database...');
        try {
            client = await tryConnection(SUPABASE_DB_PASSWORD);
            console.log('✅ Connected with original password format\n');
        } catch (firstError) {
            if (decodedPassword && firstError.code === '28P01') {
                console.log('⚠️  Original password failed, trying decoded version...');
                client = await tryConnection(decodedPassword);
                passwordToUse = decodedPassword;
                console.log('✅ Connected with decoded password format\n');
            } else {
                throw firstError;
            }
        }

        // Get all counties
        console.log('📊 Fetching county data...');
        const countiesResult = await client.query(`
            SELECT c.*
            FROM web_availability_county c
            WHERE c.is_active = true
            ORDER BY c.state_code, c.county_name
        `);

        const counties = countiesResult.rows;
        console.log(`Found ${counties.length} counties\n`);

        let totalIssues = 0;
        let fixedIssues = 0;
        let countiesWithIssues = 0;
        const report = [];

        console.log('🔍 Validating each county...\n');

        for (const county of counties) {
            const countyIssues = {
                county: `${county.county_name}, ${county.state_code}`,
                distributionIssues: [],
                sumIssue: false,
                capacityIssues: []
            };

            // Get practice areas
            const paResult = await client.query(`
                SELECT * FROM web_availability_practice_area_seats
                WHERE county_availability_id = $1 AND is_active = true
                ORDER BY display_order
            `, [county.id]);

            let totalDistributed = 0;

            // Check each practice area
            for (const pa of paResult.rows) {
                totalDistributed += pa.total_firms;

                // Check distribution range
                const percentage = pa.total_firms / county.total_firms;
                const range = PRACTICE_AREA_RANGES[pa.practice_area_slug];
                if (range && (percentage < range.min || percentage > range.max)) {
                    countyIssues.distributionIssues.push({
                        practiceArea: pa.practice_area_name,
                        percentage: (percentage * 100).toFixed(2) + '%',
                        expected: `${(range.min * 100).toFixed(0)}-${(range.max * 100).toFixed(0)}%`
                    });
                }

                // Check capacity calculations
                const expectedCap = Math.max(8, Math.round(pa.total_firms * 0.33));
                const expectedPremium = Math.max(2, Math.round(expectedCap * 0.21));
                const expectedStandard = expectedCap - expectedPremium;

                if (Math.abs(pa.cap - expectedCap) > 1) {
                    countyIssues.capacityIssues.push({
                        practiceArea: pa.practice_area_name,
                        issue: 'cap',
                        current: pa.cap,
                        expected: expectedCap
                    });
                }

                if (Math.abs(pa.premium - expectedPremium) > 1) {
                    countyIssues.capacityIssues.push({
                        practiceArea: pa.practice_area_name,
                        issue: 'premium',
                        current: pa.premium,
                        expected: expectedPremium
                    });
                }

                if (pa.standard !== expectedStandard) {
                    countyIssues.capacityIssues.push({
                        practiceArea: pa.practice_area_name,
                        issue: 'standard',
                        current: pa.standard,
                        expected: expectedStandard
                    });
                }
            }

            // Check sum consistency
            const sumPercentage = totalDistributed / county.total_firms;
            if (sumPercentage < 0.95 || sumPercentage > 1.05) {
                countyIssues.sumIssue = true;
            }

            // Count issues
            const issueCount = countyIssues.distributionIssues.length + 
                             (countyIssues.sumIssue ? 1 : 0) + 
                             countyIssues.capacityIssues.length;

            if (issueCount > 0) {
                countiesWithIssues++;
                totalIssues += issueCount;
                report.push(countyIssues);
            }
        }

        // Summary
        console.log('\n' + '='.repeat(60));
        console.log('VALIDATION SUMMARY');
        console.log('='.repeat(60));
        console.log(`Total counties: ${counties.length}`);
        console.log(`Counties with issues: ${countiesWithIssues}`);
        console.log(`Total issues found: ${totalIssues}`);
        console.log(`Pass rate: ${((counties.length - countiesWithIssues) / counties.length * 100).toFixed(1)}%`);

        if (report.length > 0) {
            console.log('\n⚠️  COUNTIES WITH ISSUES:');
            report.forEach(({ county, distributionIssues, sumIssue, capacityIssues }) => {
                console.log(`\n${county}:`);
                if (distributionIssues.length > 0) {
                    console.log(`  Distribution: ${distributionIssues.length} issue(s)`);
                }
                if (sumIssue) {
                    console.log(`  Sum mismatch`);
                }
                if (capacityIssues.length > 0) {
                    console.log(`  Capacity: ${capacityIssues.length} issue(s) - WILL BE FIXED`);
                }
            });
        }

        // Fix capacity issues
        if (report.some(r => r.capacityIssues.length > 0)) {
            console.log('\n🔧 Fixing capacity calculations...');
            const fixResult = await client.query(`
                UPDATE web_availability_practice_area_seats
                SET 
                    cap = GREATEST(8, ROUND(total_firms * 0.33)),
                    premium = GREATEST(2, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21)),
                    standard = GREATEST(8, ROUND(total_firms * 0.33)) - GREATEST(2, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21)),
                    filled = ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.12),
                    premium_remaining = GREATEST(2, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21)) - ROUND(GREATEST(2, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21)) * 0.12),
                    standard_remaining = (GREATEST(8, ROUND(total_firms * 0.33)) - GREATEST(2, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21))) - ROUND((GREATEST(8, ROUND(total_firms * 0.33)) - GREATEST(2, ROUND(GREATEST(8, ROUND(total_firms * 0.33)) * 0.21)) * 0.12)),
                    updated_at = NOW()
                WHERE is_active = true
            `);
            fixedIssues = report.reduce((sum, r) => sum + r.capacityIssues.length, 0);
            console.log(`✅ Fixed ${fixedIssues} capacity calculation issue(s)\n`);
        }

        console.log('='.repeat(60));
        console.log('✅ VALIDATION COMPLETE');
        console.log('='.repeat(60));
        console.log(`Issues fixed: ${fixedIssues}`);
        console.log(`Remaining issues: ${totalIssues - fixedIssues} (distribution/sum issues need manual review)`);

        await client.end();
        return {
            totalCounties: counties.length,
            countiesWithIssues,
            totalIssues,
            fixedIssues,
            remainingIssues: totalIssues - fixedIssues
        };

    } catch (error) {
        console.error('\n❌ ERROR:', error.message);
        if (client) {
            await client.end().catch(() => {});
        }
        throw error;
    }
}

validateAll()
    .then(() => {
        console.log('\n✅ All done!');
        process.exit(0);
    })
    .catch(error => {
        console.error('Fatal error:', error);
        process.exit(1);
    });

