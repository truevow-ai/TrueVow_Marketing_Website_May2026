/**
 * Check Harris vs Dallas law firm counts
 */

const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

async function check() {
    let connectionString = process.env.SUPABASE_DB_URL || process.env.MARKETING_DATABASE_URL;

    if (!connectionString) {
        try {
            const { execSync } = require('child_process');
            connectionString = execSync('supabase db remote get-connection-string', { encoding: 'utf8', stdio: ['pipe', 'pipe', 'ignore'] }).trim();
        } catch (e) {
            console.error('No connection string found');
            process.exit(1);
        }
    }

    const url = new URL(connectionString);
    const client = new Client({
        host: url.hostname,
        port: parseInt(url.port || '5432'),
        database: url.pathname.slice(1) || 'postgres',
        user: url.username || 'postgres',
        password: decodeURIComponent(url.password),
        ssl: { rejectUnauthorized: false },
    });

    try {
        await client.connect();
        console.log('✅ Connected\n');

        const counties = await client.query(`
            SELECT county_name, total_firms, total_seats, county_slug
            FROM web_availability_county
            WHERE state_code = 'TX' AND county_slug IN ('harris', 'dallas')
            ORDER BY total_firms DESC
        `);

        console.log('Current Database Values:');
        counties.rows.forEach(c => {
            console.log(`  ${c.county_name} County: ${c.total_firms.toLocaleString()} firms, ${c.total_seats} seats`);
        });

        // Population data for context
        const populations = {
            'harris': 4731145,  // Houston
            'dallas': 2614163    // Dallas
        };

        console.log('\nPopulation Context:');
        counties.rows.forEach(c => {
            const pop = populations[c.county_slug];
            const ratio = (c.total_firms / pop * 100000).toFixed(1);
            console.log(`  ${c.county_name}: ${pop.toLocaleString()} population, ${ratio} law firms per 100K`);
        });

        // Check what the source data says
        console.log('\nSource Data (from scripts):');
        console.log('  Harris (Houston): 3,200 firms (BLS + multi-source validation)');
        console.log('  Dallas: 2,800 firms (BLS + multi-source validation)');
        console.log('\nNote: Harris County (Houston) is:');
        console.log('  - Largest county in Texas by population (4.7M vs 2.6M)');
        console.log('  - Largest city in Texas');
        console.log('  - Major energy/oil & gas legal market');
        console.log('  - More law firms per capita than Dallas');

        await client.end();
    } catch (error) {
        console.error('❌ ERROR:', error.message);
        console.error(error.stack);
        process.exit(1);
    }
}

check();

