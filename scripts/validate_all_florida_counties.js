// ============================================
// Comprehensive Florida Counties Validation
// Validates all 67 Florida counties using multi-source methodology
// ============================================

const { Client } = require('pg');
const fs = require('fs');
require('dotenv').config({ path: '.env.local' });

// Get connection details
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

// Florida county populations (2020 Census)
const FLORIDA_POPULATIONS = {
    'miami-dade': 2701767,
    'broward': 1952778,
    'palm-beach': 1496770,
    'hillsborough': 1459762,
    'orange': 1393452,
    'pinellas': 975280,
    'duval': 950029,
    'polk': 724777,
    'brevard': 606612,
    'volusia': 553284,
    'lee': 760822,
    'seminole': 471826,
    'sarasota': 434006,
    'manatee': 399710,
    'collier': 375752,
    'pasco': 539630,
    'osceola': 375751,
    'escambia': 321905,
    'marion': 365579,
    'leon': 292198,
    'alachua': 278468,
    'st-lucie': 329226,
    'indian-river': 159788,
    'okaloosa': 210738,
    'lake': 367118,
    'bay': 175216,
    'santa-rosa': 184313,
    'clay': 218866,
    'citrus': 153843,
    'hernando': 190863,
    'martin': 158828,
    'charlotte': 186847,
    'monroe': 74176,
    'highlands': 101235,
    'walton': 75068,
    'columbia': 69397,
    'putnam': 73721,
    'gadsden': 45660,
    'sumter': 129752,
    'flagler': 115081,
    'desoto': 37351,
    'hendry': 39140,
    'taylor': 21616,
    'calhoun': 14105,
    'holmes': 19653,
    'washington': 25073,
    'jefferson': 14246,
    'madison': 18893,
    'liberty': 8354,
    'dixie': 16826,
    'gilchrist': 18062,
    'union': 15237,
    'franklin': 11949,
    'lafayette': 8422,
    'wakulla': 33739,
    'hamilton': 14003,
    'baker': 27692,
    'glades': 12084,
    'hardee': 25210,
    'bradford': 26800,
    'levy': 42015,
    'nassau': 90420,
    'suwannee': 43474
};

function calculatePerCapitaRatio(lawOffices, population) {
    if (!population || population === 0) return null;
    return lawOffices / population;
}

function determineCountyType(population) {
    if (population < 50000) return 'rural';
    if (population < 200000) return 'small_metro';
    if (population < 1000000) return 'medium_metro';
    return 'major_metro';
}

function validatePerCapitaRatio(ratio, countyType) {
    const benchmarks = {
        'rural': { min: 0.0003, max: 0.0010 },
        'small_metro': { min: 0.0008, max: 0.0015 },
        'medium_metro': { min: 0.0010, max: 0.0018 },
        'major_metro': { min: 0.0012, max: 0.0020 }
    };
    
    const range = benchmarks[countyType] || benchmarks.rural;
    return {
        valid: ratio >= range.min && ratio <= range.max,
        range: range,
        ratio: ratio
    };
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

async function validateAllFloridaCounties() {
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

        // Get all Florida counties from database
        const countiesResult = await client.query(`
            SELECT 
                c.id,
                c.county_slug,
                c.county_name,
                c.total_firms,
                c.total_seats,
                c.state_code
            FROM web_availability_county c
            WHERE c.state_code = 'FL' AND c.is_active = true
            ORDER BY c.county_name
        `);

        const counties = countiesResult.rows;
        console.log(`📊 Found ${counties.length} Florida counties to validate\n`);

        const report = {
            total: counties.length,
            validated: 0,
            flagged: [],
            passed: [],
            missing_population: []
        };

        console.log('='.repeat(80));
        console.log('FLORIDA COUNTIES VALIDATION REPORT');
        console.log('='.repeat(80));
        console.log('\n');

        for (const county of counties) {
            const population = FLORIDA_POPULATIONS[county.county_slug];
            const estimatedBLS = Math.round(county.total_firms / 0.67);
            
            const validation = {
                county: county.county_name,
                slug: county.county_slug,
                totalFirms: county.total_firms,
                totalSeats: county.total_seats,
                estimatedBLS: estimatedBLS,
                population: population,
                issues: []
            };

            // Validation 1: Total seats should not exceed total firms
            if (county.total_seats > county.total_firms) {
                validation.issues.push({
                    type: 'critical',
                    message: `Total seats (${county.total_seats}) exceeds total firms (${county.total_firms})`
                });
            }

            // Validation 2: Total seats should not exceed 33% cap by more than 1
            const expectedMaxSeats = Math.round(county.total_firms * 0.33);
            if (county.total_seats > expectedMaxSeats + 1) {
                validation.issues.push({
                    type: 'warning',
                    message: `Total seats (${county.total_seats}) exceeds 33% cap (${expectedMaxSeats})`
                });
            }

            // Validation 3: Per-capita ratio validation
            if (population) {
                const ratio = calculatePerCapitaRatio(estimatedBLS, population);
                const countyType = determineCountyType(population);
                const perCapitaCheck = validatePerCapitaRatio(ratio, countyType);
                
                validation.perCapita = {
                    ratio: ratio,
                    countyType: countyType,
                    valid: perCapitaCheck.valid,
                    expectedRange: `${perCapitaCheck.range.min.toFixed(6)} - ${perCapitaCheck.range.max.toFixed(6)}`
                };

                if (!perCapitaCheck.valid) {
                    validation.issues.push({
                        type: 'warning',
                        message: `Per-capita ratio ${ratio.toFixed(6)} outside expected range for ${countyType} county (${validation.perCapita.expectedRange})`
                    });
                }
            } else {
                validation.issues.push({
                    type: 'info',
                    message: 'Population data not available for per-capita validation'
                });
                report.missing_population.push(county.county_name);
            }

            // Categorize
            if (validation.issues.some(i => i.type === 'critical')) {
                report.flagged.push(validation);
            } else if (validation.issues.length === 0) {
                report.passed.push(validation);
            } else {
                report.flagged.push(validation);
            }

            report.validated++;
        }

        // Print summary
        console.log('📊 VALIDATION SUMMARY');
        console.log('='.repeat(80));
        console.log(`Total Counties: ${report.total}`);
        console.log(`✅ Passed: ${report.passed.length}`);
        console.log(`⚠️  Flagged: ${report.flagged.length}`);
        console.log(`📋 Missing Population Data: ${report.missing_population.length}`);
        console.log(`\nPass Rate: ${((report.passed.length / report.total) * 100).toFixed(1)}%\n`);

        // Print flagged counties
        if (report.flagged.length > 0) {
            console.log('⚠️  FLAGGED COUNTIES (Need Review):');
            console.log('='.repeat(80));
            
            const critical = report.flagged.filter(c => c.issues.some(i => i.type === 'critical'));
            const warnings = report.flagged.filter(c => !c.issues.some(i => i.type === 'critical'));

            if (critical.length > 0) {
                console.log('\n🚨 CRITICAL ISSUES:');
                critical.forEach(county => {
                    console.log(`\n📍 ${county.county} County:`);
                    console.log(`   Total Firms: ${county.totalFirms}`);
                    console.log(`   Total Seats: ${county.totalSeats}`);
                    console.log(`   Estimated BLS: ${county.estimatedBLS}`);
                    if (county.population) {
                        console.log(`   Population: ${county.population.toLocaleString()}`);
                        console.log(`   Per-Capita: ${county.perCapita.ratio.toFixed(6)}`);
                    }
                    county.issues.forEach(issue => {
                        console.log(`   ❌ ${issue.message}`);
                    });
                });
            }

            if (warnings.length > 0) {
                console.log('\n⚠️  WARNINGS:');
                warnings.forEach(county => {
                    console.log(`\n📍 ${county.county} County:`);
                    console.log(`   Total Firms: ${county.totalFirms}`);
                    console.log(`   Total Seats: ${county.totalSeats}`);
                    console.log(`   Estimated BLS: ${county.estimatedBLS}`);
                    if (county.population) {
                        console.log(`   Population: ${county.population.toLocaleString()}`);
                        console.log(`   Per-Capita: ${county.perCapita.ratio.toFixed(6)} (${county.perCapita.valid ? '✅' : '⚠️'})`);
                    }
                    county.issues.forEach(issue => {
                        console.log(`   ⚠️  ${issue.message}`);
                    });
                });
            }
        }

        // Generate detailed report file
        const reportFile = 'florida_counties_validation_report.json';
        fs.writeFileSync(reportFile, JSON.stringify({
            date: new Date().toISOString(),
            summary: {
                total: report.total,
                passed: report.passed.length,
                flagged: report.flagged.length,
                passRate: ((report.passed.length / report.total) * 100).toFixed(1) + '%'
            },
            flagged: report.flagged,
            passed: report.passed.map(c => ({
                county: c.county,
                totalFirms: c.totalFirms,
                totalSeats: c.totalSeats,
                estimatedBLS: c.estimatedBLS
            }))
        }, null, 2));

        console.log(`\n📄 Detailed report saved to: ${reportFile}`);

        // Generate validation templates for flagged counties
        if (report.flagged.length > 0) {
            console.log('\n📋 Generating validation templates for flagged counties...');
            const templateDir = 'validation_templates';
            if (!fs.existsSync(templateDir)) {
                fs.mkdirSync(templateDir);
            }

            report.flagged.forEach(county => {
                const template = `# Validation Template: ${county.county} County, FL

## County Information
- **County**: ${county.county} County, FL
- **Slug**: ${county.county_slug}
- **Population**: ${county.population ? county.population.toLocaleString() : 'Unknown'}
- **Current Total Firms**: ${county.totalFirms}
- **Current Total Seats**: ${county.totalSeats}
- **Estimated BLS Offices**: ${county.estimatedBLS}

## Issues Found
${county.issues.map(i => `- **${i.type.toUpperCase()}**: ${i.message}`).join('\n')}

${county.perCapita ? `## Per-Capita Validation
- **Ratio**: ${county.perCapita.ratio.toFixed(6)}
- **County Type**: ${county.perCapita.countyType}
- **Expected Range**: ${county.perCapita.expectedRange}
- **Status**: ${county.perCapita.valid ? '✅ Valid' : '⚠️ Outside Range'}
` : ''}

## Source 1: BLS QCEW Database
- **URL**: https://www.bls.gov/cew/
- **Steps**:
  1. Go to "Single Screen Data Search"
  2. Select: NAICS 54111 (Offices of Lawyers)
  3. Select: Florida → ${county.county} County
  4. Period: Q1 2024
  5. Download establishment count
- **Value**: __________
- **Date Verified**: __________

## Source 2: Florida Bar Association
- **URL**: https://www.floridabar.org/
- **Method**: Search member directory by county
- **Value**: __________
- **Date Verified**: __________

## Source 3: Martindale-Hubbell
- **URL**: https://www.martindale.com/
- **Method**: Search attorneys by location (${county.county} County, FL)
- **Value**: __________
- **Date Verified**: __________

## Source 4: Avvo
- **URL**: https://www.avvo.com/
- **Method**: Search attorneys by location
- **Value**: __________
- **Date Verified**: __________

## Source 5: FindLaw
- **URL**: https://www.findlaw.com/
- **Method**: Search attorneys by county
- **Value**: __________
- **Date Verified**: __________

## Source 6: Census County Business Patterns
- **URL**: https://www.census.gov/data/datasets.html
- **Method**: Download County Business Patterns, filter by NAICS 5411
- **Value**: __________
- **Date Verified**: __________

## Validation Results
- **Consensus Value**: __________
- **Per-Capita Ratio**: __________
- **Status**: __________
- **Action Required**: ${county.issues.some(i => i.type === 'critical') ? 'URGENT - Fix calculation errors' : 'Review and verify data'}
`;
                
                const filename = `${templateDir}/${county.county_slug}_fl_validation.md`;
                fs.writeFileSync(filename, template);
            });

            console.log(`✅ Generated ${report.flagged.length} validation templates in ${templateDir}/`);
        }

        await client.end();

        // Return status
        const hasCritical = report.flagged.some(c => c.issues.some(i => i.type === 'critical'));
        if (hasCritical) {
            console.log('\n❌ VALIDATION FAILED: Critical issues found. Fix before proceeding.');
            process.exit(1);
        } else if (report.flagged.length > 0) {
            console.log('\n⚠️  VALIDATION WARNINGS: Some counties need review but no critical issues.');
            process.exit(0);
        } else {
            console.log('\n✅ VALIDATION PASSED: All counties validated successfully.');
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

validateAllFloridaCounties();

