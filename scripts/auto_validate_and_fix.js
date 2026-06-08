// ============================================
// Automated Validation and Fix Script
// Validates all data, fixes issues, and reports completion
// ============================================

const { Client } = require('pg');
const fs = require('fs');
require('dotenv').config({ path: '.env.local' });

// Get connection details
let SUPABASE_DB_HOST, SUPABASE_DB_PORT, SUPABASE_DB_NAME, SUPABASE_DB_USER, SUPABASE_DB_PASSWORD;

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
        SUPABASE_DB_PASSWORD = decodeURIComponent(rawPassword);
    } catch (e) {}
}

const reportFile = 'validation_report.txt';

function writeReport(message) {
    const timestamp = new Date().toISOString();
    const logMessage = `[${timestamp}] ${message}`;
    fs.appendFileSync(reportFile, logMessage + '\n');
    console.log(message);
}

function writeReportSection(title) {
    writeReport(`\n${'='.repeat(60)}`);
    writeReport(title);
    writeReport('='.repeat(60));
}

// Practice area distribution ranges
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

async function validateAndFix() {
    // Clear previous report
    if (fs.existsSync(reportFile)) {
        fs.unlinkSync(reportFile);
    }
    fs.writeFileSync(reportFile, `Validation Report - ${new Date().toISOString()}\n\n`);

    const client = new Client({
        host: SUPABASE_DB_HOST,
        port: SUPABASE_DB_PORT,
        database: SUPABASE_DB_NAME,
        user: SUPABASE_DB_USER,
        password: SUPABASE_DB_PASSWORD,
        ssl: { rejectUnauthorized: false }
    });

    try {
        writeReportSection('CONNECTING TO DATABASE');
        await client.connect();
        writeReport('✅ Connected to database\n');

        // Get all counties
        writeReportSection('FETCHING COUNTY DATA');
        const countiesResult = await client.query(`
            SELECT c.*
            FROM web_availability_county c
            WHERE c.is_active = true
            ORDER BY c.state_code, c.county_name
        `);

        const counties = countiesResult.rows;
        writeReport(`Found ${counties.length} counties to validate\n`);

        let totalIssues = 0;
        let fixedIssues = 0;
        let countiesWithIssues = 0;
        const issues = [];

        writeReportSection('VALIDATING COUNTIES');

        for (const county of counties) {
            writeReport(`\n📍 ${county.county_name} County, ${county.state_code}`);

            // Get practice areas
            const paResult = await client.query(`
                SELECT * FROM web_availability_practice_area_seats
                WHERE county_availability_id = $1 AND is_active = true
                ORDER BY display_order
            `, [county.id]);

            const practiceAreas = paResult.rows;
            writeReport(`  Practice areas: ${practiceAreas.length}`);

            // Validation 1: Check practice area distribution
            let totalDistributed = 0;
            const distributionIssues = [];

            for (const pa of practiceAreas) {
                totalDistributed += pa.total_firms;
                const percentage = pa.total_firms / county.total_firms;
                const range = PRACTICE_AREA_RANGES[pa.practice_area_slug];

                if (range) {
                    if (percentage < range.min || percentage > range.max) {
                        distributionIssues.push({
                            practiceArea: pa.practice_area_name,
                            percentage: (percentage * 100).toFixed(2) + '%',
                            expected: `${(range.min * 100).toFixed(0)}-${(range.max * 100).toFixed(0)}%`,
                            current: pa.total_firms,
                            total: county.total_firms
                        });
                    }
                }
            }

            // Check sum consistency
            const sumDifference = Math.abs(totalDistributed - county.total_firms);
            const sumPercentage = totalDistributed / county.total_firms;
            const sumIssue = sumPercentage < 0.95 || sumPercentage > 1.05;

            // Validation 2: Check capacity calculations
            const capacityIssues = [];

            for (const pa of practiceAreas) {
                const expectedCap = Math.max(8, Math.round(pa.total_firms * 0.33));
                const expectedPremium = Math.max(2, Math.round(expectedCap * 0.21));
                const expectedStandard = expectedCap - expectedPremium;
                const expectedFilled = Math.round(expectedCap * 0.12);
                const expectedPremiumRemaining = expectedPremium - Math.round(expectedPremium * 0.12);
                const expectedStandardRemaining = expectedStandard - Math.round(expectedStandard * 0.12);

                if (Math.abs(pa.cap - expectedCap) > 1) {
                    capacityIssues.push({
                        practiceArea: pa.practice_area_name,
                        issue: 'cap_mismatch',
                        calculated: pa.cap,
                        expected: expectedCap
                    });
                }

                if (Math.abs(pa.premium - expectedPremium) > 1) {
                    capacityIssues.push({
                        practiceArea: pa.practice_area_name,
                        issue: 'premium_mismatch',
                        calculated: pa.premium,
                        expected: expectedPremium
                    });
                }

                if (pa.standard !== expectedStandard) {
                    capacityIssues.push({
                        practiceArea: pa.practice_area_name,
                        issue: 'standard_mismatch',
                        calculated: pa.standard,
                        expected: expectedStandard
                    });
                }

                // Fix capacity issues automatically
                if (capacityIssues.length > 0) {
                    writeReport(`  ⚠️  Fixing capacity calculations for ${pa.practice_area_name}...`);
                    
                    await client.query(`
                        UPDATE web_availability_practice_area_seats
                        SET 
                            cap = $1,
                            premium = $2,
                            standard = $3,
                            filled = $4,
                            premium_remaining = $5,
                            standard_remaining = $6,
                            updated_at = NOW()
                        WHERE id = $7
                    `, [
                        expectedCap,
                        expectedPremium,
                        expectedStandard,
                        expectedFilled,
                        expectedPremiumRemaining,
                        expectedStandardRemaining,
                        pa.id
                    ]);

                    fixedIssues += capacityIssues.length;
                    writeReport(`  ✅ Fixed ${capacityIssues.length} capacity calculation(s)`);
                }
            }

            // Report issues
            if (distributionIssues.length > 0 || sumIssue || capacityIssues.length > 0) {
                countiesWithIssues++;
                totalIssues += distributionIssues.length + (sumIssue ? 1 : 0) + capacityIssues.length;

                if (distributionIssues.length > 0) {
                    writeReport(`  ⚠️  Distribution issues:`);
                    distributionIssues.forEach(issue => {
                        writeReport(`     - ${issue.practiceArea}: ${issue.percentage} (expected: ${issue.expected})`);
                    });
                }

                if (sumIssue) {
                    writeReport(`  ⚠️  Sum mismatch: ${totalDistributed} firms distributed vs ${county.total_firms} total`);
                }

                issues.push({
                    county: `${county.county_name}, ${county.state_code}`,
                    distributionIssues,
                    sumIssue,
                    capacityIssues: capacityIssues.length
                });
            } else {
                writeReport(`  ✅ All validations passed`);
            }
        }

        // Summary
        writeReportSection('VALIDATION SUMMARY');
        writeReport(`Total counties validated: ${counties.length}`);
        writeReport(`Counties with issues: ${countiesWithIssues}`);
        writeReport(`Total issues found: ${totalIssues}`);
        writeReport(`Issues fixed automatically: ${fixedIssues}`);
        writeReport(`Remaining issues: ${totalIssues - fixedIssues}`);
        writeReport(`Validation pass rate: ${((counties.length - countiesWithIssues) / counties.length * 100).toFixed(1)}%`);

        if (issues.length > 0) {
            writeReportSection('COUNTIES WITH REMAINING ISSUES');
            issues.forEach(({ county, distributionIssues, sumIssue, capacityIssues }) => {
                writeReport(`\n${county}:`);
                if (distributionIssues.length > 0) {
                    writeReport(`  - Distribution: ${distributionIssues.length} issue(s)`);
                }
                if (sumIssue) {
                    writeReport(`  - Sum mismatch`);
                }
                if (capacityIssues > 0) {
                    writeReport(`  - Capacity: ${capacityIssues} issue(s) (should be fixed)`);
                }
            });
        }

        writeReportSection('VALIDATION COMPLETE');
        writeReport(`✅ Validation and fixes completed!`);
        writeReport(`📄 Full report saved to: ${reportFile}`);

        await client.end();

        // Return summary
        return {
            totalCounties: counties.length,
            countiesWithIssues,
            totalIssues,
            fixedIssues,
            remainingIssues: totalIssues - fixedIssues,
            passRate: ((counties.length - countiesWithIssues) / counties.length * 100).toFixed(1)
        };

    } catch (error) {
        writeReport(`\n❌ ERROR: ${error.message}`);
        writeReport(error.stack);
        if (client) {
            await client.end().catch(() => {});
        }
        throw error;
    }
}

// Run validation
validateAndFix()
    .then(summary => {
        console.log('\n' + '='.repeat(60));
        console.log('VALIDATION COMPLETE');
        console.log('='.repeat(60));
        console.log(`Total counties: ${summary.totalCounties}`);
        console.log(`Counties with issues: ${summary.countiesWithIssues}`);
        console.log(`Issues fixed: ${summary.fixedIssues}`);
        console.log(`Remaining issues: ${summary.remainingIssues}`);
        console.log(`Pass rate: ${summary.passRate}%`);
        console.log(`\n📄 Full report: validation_report.txt`);
        process.exit(0);
    })
    .catch(error => {
        console.error('Fatal error:', error.message);
        process.exit(1);
    });

