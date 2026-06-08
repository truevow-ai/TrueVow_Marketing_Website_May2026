/**
 * Verify all states for calculation errors like DC
 * Checks: cap sums, premium calculations, percentage accuracy
 */

const fs = require('fs');
const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

// Get connection details (same method as execute_sql_to_supabase.js)
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
    } catch (e) {
        // Fall through to env vars
    }
}

// Fallback to individual environment variables
SUPABASE_DB_HOST = SUPABASE_DB_HOST || process.env.SUPABASE_DB_HOST || process.env.MARKETING_DB_HOST || 'db.napwpkagxzqfpbearkjs.supabase.co';
SUPABASE_DB_PORT = SUPABASE_DB_PORT || parseInt(process.env.SUPABASE_DB_PORT || process.env.MARKETING_DB_PORT || '5432');
SUPABASE_DB_NAME = SUPABASE_DB_NAME || process.env.SUPABASE_DB_NAME || process.env.MARKETING_DB_NAME || 'postgres';
SUPABASE_DB_USER = SUPABASE_DB_USER || process.env.SUPABASE_DB_USER || process.env.MARKETING_DB_USER || 'postgres';
SUPABASE_DB_PASSWORD = SUPABASE_DB_PASSWORD || process.env.SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD;

const TIER_STATES = {
    tier1: ['MD', 'MA', 'WA', 'AZ', 'CO', 'MN', 'MO', 'TN', 'CT', 'IN'],
    tier2: ['LA', 'AL', 'SC', 'KY', 'OK', 'UT', 'NV', 'OR', 'WI', 'KS'],
    tier3: ['NE', 'IA', 'AR', 'MS', 'WV', 'NH', 'RI', 'ME', 'VT', 'DE', 'HI', 'AK']
};

const PRACTICE_AREA_DISTRIBUTION = {
    "personal-injury": 0.25,
    "family-law": 0.20,
    "immigration": 0.15,
    "criminal-defense": 0.12,
    "employment-law": 0.08,
    "real-estate": 0.07,
    "bankruptcy": 0.05,
    "estate-planning": 0.04,
    "workers-comp": 0.04
};

async function verifyState(stateCode) {
    if (!SUPABASE_DB_PASSWORD) {
        throw new Error('Database password not found. Please set SUPABASE_DB_PASSWORD or SUPABASE_DB_URL in .env.local');
    }

    const client = new Client({
        host: SUPABASE_DB_HOST,
        port: SUPABASE_DB_PORT,
        database: SUPABASE_DB_NAME,
        user: SUPABASE_DB_USER,
        password: SUPABASE_DB_PASSWORD,
        ssl: { rejectUnauthorized: false }
    });
    
    await client.connect();

    try {
        // Get county data
        const countyResult = await client.query(`
            SELECT id, county_slug, county_name, total_firms, total_seats, premium_total, standard_total
            FROM web_availability_county
            WHERE state_code = $1 AND is_active = true
            ORDER BY county_name
        `, [stateCode]);

        const issues = [];

        for (const county of countyResult.rows) {
            // Get practice area data
            const practiceResult = await client.query(`
                SELECT practice_area_slug, practice_area_name, cap, premium, standard, total_firms
                FROM web_availability_practice_area_seats
                WHERE county_availability_id = $1 AND is_active = true
                ORDER BY display_order
            `, [county.id]);

            // Check 1: Practice area caps sum to total_seats
            const totalCaps = practiceResult.rows.reduce((sum, row) => sum + row.cap, 0);
            if (totalCaps !== county.total_seats) {
                issues.push({
                    county: county.county_name,
                    type: 'CAP_SUM_MISMATCH',
                    expected: county.total_seats,
                    actual: totalCaps,
                    difference: totalCaps - county.total_seats,
                    message: `Practice area caps sum to ${totalCaps}, but total_seats is ${county.total_seats}`
                });
            }

            // Check 2: Premium is 21% of cap (rounded) for each practice area
            for (const area of practiceResult.rows) {
                const expectedPremium = Math.round(area.cap * 0.21);
                if (area.premium !== expectedPremium) {
                    issues.push({
                        county: county.county_name,
                        practiceArea: area.practice_area_name,
                        type: 'PREMIUM_CALCULATION_ERROR',
                        cap: area.cap,
                        expectedPremium: expectedPremium,
                        actualPremium: area.premium,
                        difference: area.premium - expectedPremium,
                        message: `${area.practice_area_name}: Premium should be ${expectedPremium} (21% of ${area.cap}), but is ${area.premium}`
                    });
                }

                // Check 3: Premium + Standard = Cap
                if (area.premium + area.standard !== area.cap) {
                    issues.push({
                        county: county.county_name,
                        practiceArea: area.practice_area_name,
                        type: 'PREMIUM_STANDARD_MISMATCH',
                        cap: area.cap,
                        premium: area.premium,
                        standard: area.standard,
                        sum: area.premium + area.standard,
                        message: `${area.practice_area_name}: Premium (${area.premium}) + Standard (${area.standard}) = ${area.premium + area.standard}, but Cap is ${area.cap}`
                    });
                }

                // Check 4: Practice area cap matches expected percentage
                const expectedPercentage = PRACTICE_AREA_DISTRIBUTION[area.practice_area_slug];
                if (expectedPercentage) {
                    const expectedCap = Math.round(county.total_seats * expectedPercentage);
                    // Allow ±1 for rounding differences
                    if (Math.abs(area.cap - expectedCap) > 1) {
                        issues.push({
                            county: county.county_name,
                            practiceArea: area.practice_area_name,
                            type: 'PERCENTAGE_MISMATCH',
                            expectedCap: expectedCap,
                            actualCap: area.cap,
                            percentage: expectedPercentage,
                            message: `${area.practice_area_name}: Expected ${expectedCap} seats (${(expectedPercentage*100).toFixed(0)}% of ${county.total_seats}), but got ${area.cap}`
                        });
                    }
                }
            }

            // Check 5: Total premium matches 21% of total_seats
            const totalPremium = practiceResult.rows.reduce((sum, row) => sum + row.premium, 0);
            const expectedTotalPremium = Math.round(county.total_seats * 0.21);
            if (totalPremium !== expectedTotalPremium) {
                issues.push({
                    county: county.county_name,
                    type: 'TOTAL_PREMIUM_MISMATCH',
                    expected: expectedTotalPremium,
                    actual: totalPremium,
                    difference: totalPremium - expectedTotalPremium,
                    message: `Total premium is ${totalPremium}, but should be ${expectedTotalPremium} (21% of ${county.total_seats})`
                });
            }

            // Check 6: County premium_total matches sum of practice area premiums
            if (county.premium_total !== totalPremium) {
                issues.push({
                    county: county.county_name,
                    type: 'COUNTY_PREMIUM_MISMATCH',
                    countyPremium: county.premium_total,
                    sumOfAreaPremiums: totalPremium,
                    difference: county.premium_total - totalPremium,
                    message: `County premium_total (${county.premium_total}) doesn't match sum of practice area premiums (${totalPremium})`
                });
            }
        }

        return {
            state: stateCode,
            counties: countyResult.rows.length,
            issues: issues,
            hasIssues: issues.length > 0
        };
    } finally {
        await client.end();
    }
}

async function main() {
    console.log('🔍 Verifying all Tier 1, 2, and 3 states for calculation errors...\n');

    const allStates = [...TIER_STATES.tier1, ...TIER_STATES.tier2, ...TIER_STATES.tier3];
    const results = [];

    for (const stateCode of allStates) {
        try {
            console.log(`Checking ${stateCode}...`);
            const result = await verifyState(stateCode);
            results.push(result);
            
            if (result.hasIssues) {
                console.log(`  ⚠️  Found ${result.issues.length} issue(s)`);
            } else {
                console.log(`  ✅ No issues found`);
            }
        } catch (error) {
            console.log(`  ❌ Error: ${error.message}`);
            results.push({
                state: stateCode,
                error: error.message,
                hasIssues: true
            });
        }
    }

    console.log('\n' + '='.repeat(80));
    console.log('VERIFICATION SUMMARY');
    console.log('='.repeat(80) + '\n');

    const statesWithIssues = results.filter(r => r.hasIssues);
    const statesClean = results.filter(r => !r.hasIssues);

    console.log(`✅ States with NO issues: ${statesClean.length}`);
    statesClean.forEach(r => {
        console.log(`   ${r.state}: ${r.counties} counties`);
    });

    console.log(`\n❌ States with issues: ${statesWithIssues.length}`);
    
    if (statesWithIssues.length > 0) {
        for (const result of statesWithIssues) {
            if (result.error) {
                console.log(`\n${result.state}: ERROR - ${result.error}`);
                continue;
            }

            console.log(`\n${result.state} (${result.counties} counties):`);
            
            // Group issues by type
            const byType = {};
            result.issues.forEach(issue => {
                if (!byType[issue.type]) byType[issue.type] = [];
                byType[issue.type].push(issue);
            });

            for (const [type, issues] of Object.entries(byType)) {
                console.log(`  ${type}: ${issues.length} occurrence(s)`);
                // Show first 3 examples
                issues.slice(0, 3).forEach(issue => {
                    console.log(`    - ${issue.county}${issue.practiceArea ? ` (${issue.practiceArea})` : ''}: ${issue.message}`);
                });
                if (issues.length > 3) {
                    console.log(`    ... and ${issues.length - 3} more`);
                }
            }
        }
    }

    console.log('\n' + '='.repeat(80));
    console.log(`Total states checked: ${allStates.length}`);
    console.log(`States with issues: ${statesWithIssues.length}`);
    console.log(`States clean: ${statesClean.length}`);
    console.log('='.repeat(80) + '\n');

    if (statesWithIssues.length > 0) {
        process.exit(1);
    }
}

main().catch(console.error);

