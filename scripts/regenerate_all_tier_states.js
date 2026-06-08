/**
 * Regenerate SQL files for all Tier 1, 2, and 3 states
 */

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const TIER_STATES = {
    tier1: ['MD', 'MA', 'WA', 'AZ', 'CO', 'MN', 'MO', 'TN', 'CT', 'IN'],
    tier2: ['LA', 'AL', 'SC', 'KY', 'OK', 'UT', 'NV', 'OR', 'WI', 'KS'],
    tier3: ['NE', 'IA', 'AR', 'MS', 'WV', 'NH', 'RI', 'ME', 'VT', 'DE', 'HI', 'AK']
};

const STATE_SCRIPTS = {
    'MD': 'generate_maryland_sql.js',
    'MA': 'generate_massachusetts_sql.js',
    'WA': 'generate_washington_sql.js',
    'AZ': 'generate_arizona_sql.js',
    'CO': 'generate_colorado_sql.js',
    'MN': 'generate_minnesota_sql.js',
    'MO': 'generate_missouri_sql.js',
    'TN': 'generate_tennessee_sql.js',
    'CT': 'generate_connecticut_sql.js',
    'IN': 'generate_indiana_sql.js',
    'LA': 'generate_louisiana_sql.js',
    'AL': 'generate_alabama_sql.js',
    'SC': 'generate_southcarolina_sql.js',
    'KY': 'generate_kentucky_sql.js',
    'OK': 'generate_oklahoma_sql.js',
    'UT': 'generate_utah_sql.js',
    'NV': 'generate_nevada_sql.js',
    'OR': 'generate_oregon_sql.js',
    'WI': 'generate_wisconsin_sql.js',
    'KS': 'generate_kansas_sql.js',
    'NE': 'generate_nebraska_sql.js',
    'IA': 'generate_iowa_sql.js',
    'AR': 'generate_arkansas_sql.js',
    'MS': 'generate_mississippi_sql.js',
    'WV': 'generate_westvirginia_sql.js',
    'NH': 'generate_newhampshire_sql.js',
    'RI': 'generate_rhodeisland_sql.js',
    'ME': 'generate_maine_sql.js',
    'VT': 'generate_vermont_sql.js',
    'DE': 'generate_delaware_sql.js',
    'HI': 'generate_hawaii_sql.js',
    'AK': 'generate_alaska_sql.js'
};

const allStates = [...TIER_STATES.tier1, ...TIER_STATES.tier2, ...TIER_STATES.tier3];

console.log('🔄 Regenerating SQL files for all Tier 1, 2, and 3 states...\n');
console.log(`Total states: ${allStates.length}\n`);

const results = {
    success: [],
    failed: []
};

for (const stateCode of allStates) {
    const scriptName = STATE_SCRIPTS[stateCode];
    if (!scriptName) {
        console.log(`⚠️  ${stateCode}: No script found`);
        results.failed.push({ state: stateCode, error: 'No script found' });
        continue;
    }

    const scriptPath = path.join(__dirname, scriptName);
    if (!fs.existsSync(scriptPath)) {
        console.log(`⚠️  ${stateCode}: Script file not found: ${scriptName}`);
        results.failed.push({ state: stateCode, error: 'Script file not found' });
        continue;
    }

    try {
        console.log(`📝 ${stateCode}: Regenerating SQL files...`);
        const output = execSync(`node "${scriptPath}"`, { 
            encoding: 'utf8',
            stdio: 'pipe',
            cwd: __dirname
        });
        
        // Check if SQL files were generated
        const countyFile = path.join(__dirname, '..', 'supabase', `POPULATE_${stateCode}_COUNTIES.sql`);
        const practiceFile = path.join(__dirname, '..', 'supabase', `POPULATE_${stateCode}_PRACTICE_AREAS.sql`);
        
        // Handle state name variations
        const stateNameMap = {
            'MD': 'MARYLAND',
            'MA': 'MASSACHUSETTS',
            'WA': 'WASHINGTON',
            'AZ': 'ARIZONA',
            'CO': 'COLORADO',
            'MN': 'MINNESOTA',
            'MO': 'MISSOURI',
            'TN': 'TENNESSEE',
            'CT': 'CONNECTICUT',
            'IN': 'INDIANA',
            'LA': 'LOUISIANA',
            'AL': 'ALABAMA',
            'SC': 'SOUTHCAROLINA',
            'KY': 'KENTUCKY',
            'OK': 'OKLAHOMA',
            'UT': 'UTAH',
            'NV': 'NEVADA',
            'OR': 'OREGON',
            'WI': 'WISCONSIN',
            'KS': 'KANSAS',
            'NE': 'NEBRASKA',
            'IA': 'IOWA',
            'AR': 'ARKANSAS',
            'MS': 'MISSISSIPPI',
            'WV': 'WESTVIRGINIA',
            'NH': 'NEWHAMPSHIRE',
            'RI': 'RHODEISLAND',
            'ME': 'MAINE',
            'VT': 'VERMONT',
            'DE': 'DELAWARE',
            'HI': 'HAWAII',
            'AK': 'ALASKA'
        };
        
        const stateName = stateNameMap[stateCode];
        const countyFileAlt = path.join(__dirname, '..', 'supabase', `POPULATE_${stateName}_COUNTIES.sql`);
        const practiceFileAlt = path.join(__dirname, '..', 'supabase', `POPULATE_${stateName}_PRACTICE_AREAS.sql`);
        
        if (fs.existsSync(countyFile) || fs.existsSync(countyFileAlt)) {
            if (fs.existsSync(practiceFile) || fs.existsSync(practiceFileAlt)) {
                console.log(`   ✅ ${stateCode}: SQL files generated successfully`);
                results.success.push(stateCode);
            } else {
                console.log(`   ⚠️  ${stateCode}: County file generated but practice area file missing`);
                results.failed.push({ state: stateCode, error: 'Practice area file missing' });
            }
        } else {
            console.log(`   ❌ ${stateCode}: SQL files not generated`);
            results.failed.push({ state: stateCode, error: 'SQL files not generated' });
        }
    } catch (error) {
        console.log(`   ❌ ${stateCode}: Error - ${error.message}`);
        results.failed.push({ state: stateCode, error: error.message });
    }
}

console.log('\n' + '='.repeat(80));
console.log('REGENERATION SUMMARY');
console.log('='.repeat(80));
console.log(`✅ Success: ${results.success.length} states`);
console.log(`❌ Failed: ${results.failed.length} states`);

if (results.failed.length > 0) {
    console.log('\nFailed states:');
    results.failed.forEach(r => {
        console.log(`  - ${r.state}: ${r.error}`);
    });
}

console.log('\n' + '='.repeat(80));

