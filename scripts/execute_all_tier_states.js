/**
 * Execute SQL files for all Tier 1, 2, and 3 states
 */

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const TIER_STATES = {
    tier1: ['MD', 'MA', 'WA', 'AZ', 'CO', 'MN', 'MO', 'TN', 'CT', 'IN'],
    tier2: ['LA', 'AL', 'SC', 'KY', 'OK', 'UT', 'NV', 'OR', 'WI', 'KS'],
    tier3: ['NE', 'IA', 'AR', 'MS', 'WV', 'NH', 'RI', 'ME', 'VT', 'DE', 'HI', 'AK']
};

const STATE_NAMES = {
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

const allStates = [...TIER_STATES.tier1, ...TIER_STATES.tier2, ...TIER_STATES.tier3];
const supabaseDir = path.join(__dirname, '..', 'supabase');
const executeScript = path.join(__dirname, 'execute_sql_to_supabase.js');

console.log('🚀 Executing SQL files for all Tier 1, 2, and 3 states...\n');
console.log(`Total states: ${allStates.length}\n`);

const results = {
    success: [],
    failed: []
};

for (const stateCode of allStates) {
    const stateName = STATE_NAMES[stateCode];
    const countyFile = path.join(supabaseDir, `POPULATE_${stateName}_COUNTIES.sql`);
    const practiceFile = path.join(supabaseDir, `POPULATE_${stateName}_PRACTICE_AREAS.sql`);
    
    if (!fs.existsSync(countyFile)) {
        console.log(`⚠️  ${stateCode}: County SQL file not found`);
        results.failed.push({ state: stateCode, error: 'County file not found' });
        continue;
    }
    
    if (!fs.existsSync(practiceFile)) {
        console.log(`⚠️  ${stateCode}: Practice area SQL file not found`);
        results.failed.push({ state: stateCode, error: 'Practice area file not found' });
        continue;
    }

    try {
        console.log(`📤 ${stateCode}: Executing county SQL...`);
        execSync(`node "${executeScript}" "${countyFile}"`, {
            encoding: 'utf8',
            stdio: 'inherit',
            cwd: __dirname
        });
        
        console.log(`📤 ${stateCode}: Executing practice area SQL...`);
        execSync(`node "${executeScript}" "${practiceFile}"`, {
            encoding: 'utf8',
            stdio: 'inherit',
            cwd: __dirname
        });
        
        console.log(`   ✅ ${stateCode}: SQL files executed successfully\n`);
        results.success.push(stateCode);
    } catch (error) {
        console.log(`   ❌ ${stateCode}: Error - ${error.message}\n`);
        results.failed.push({ state: stateCode, error: error.message });
    }
}

console.log('\n' + '='.repeat(80));
console.log('EXECUTION SUMMARY');
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

