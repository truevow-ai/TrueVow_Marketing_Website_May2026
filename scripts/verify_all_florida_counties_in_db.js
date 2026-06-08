require('dotenv').config({ path: '.env.local' });
const { Client } = require('pg');

const url = process.env.MARKETING_DATABASE_URL || '';
const match = url.match(/postgresql:\/\/([^:]+):([^@]+)@([^:]+):(\d+)\/(.+)/);

if (!match) {
    console.error('No connection string');
    process.exit(1);
}

const [, user, pass, host, port, database] = match;
const decodedPass = decodeURIComponent(pass);

const client = new Client({
    host,
    port,
    database,
    user,
    password: decodedPass
});

async function verify() {
    try {
        await client.connect();
        console.log('✅ Connected\n');
        
        // Check ALL Florida counties - exactly what the API query does
        const result = await client.query(
            `SELECT county_slug, county_name, total_firms, total_seats, is_active, created_at
             FROM web_availability_county 
             WHERE state_code = 'FL'
             ORDER BY county_name ASC`
        );
        
        console.log(`Total Florida counties in database: ${result.rows.length}\n`);
        
        // Find Baker and Calhoun
        const baker = result.rows.find(c => c.county_slug === 'baker');
        const calhoun = result.rows.find(c => c.county_slug === 'calhoun');
        
        console.log('🔍 Baker County:');
        if (baker) {
            console.log(`  ✅ FOUND: ${baker.county_name}`);
            console.log(`     Slug: ${baker.county_slug}`);
            console.log(`     Total Firms: ${baker.total_firms}`);
            console.log(`     Total Seats: ${baker.total_seats}`);
            console.log(`     Is Active: ${baker.is_active}`);
            console.log(`     Created: ${baker.created_at}`);
        } else {
            console.log('  ❌ NOT FOUND');
        }
        
        console.log('\n🔍 Calhoun County:');
        if (calhoun) {
            console.log(`  ✅ FOUND: ${calhoun.county_name}`);
            console.log(`     Slug: ${calhoun.county_slug}`);
            console.log(`     Total Firms: ${calhoun.total_firms}`);
            console.log(`     Total Seats: ${calhoun.total_seats}`);
            console.log(`     Is Active: ${calhoun.is_active}`);
            console.log(`     Created: ${calhoun.created_at}`);
        } else {
            console.log('  ❌ NOT FOUND');
        }
        
        // Show first 5 and last 5 counties alphabetically
        console.log('\n📋 First 5 counties (alphabetically):');
        result.rows.slice(0, 5).forEach(c => {
            console.log(`  ${c.county_name} (${c.county_slug}): ${c.total_seats} seats, active: ${c.is_active}`);
        });
        
        console.log('\n📋 Last 5 counties (alphabetically):');
        result.rows.slice(-5).forEach(c => {
            console.log(`  ${c.county_name} (${c.county_slug}): ${c.total_seats} seats, active: ${c.is_active}`);
        });
        
        // Check if Baker/Calhoun would appear in API response
        console.log('\n🔍 API Query Simulation (what frontend sees):');
        const apiQuery = await client.query(
            `SELECT county_slug, county_name, total_seats, filled
             FROM web_availability_county 
             WHERE state_code = 'FL'
             ORDER BY county_name ASC`
        );
        
        const bakerInAPI = apiQuery.rows.find(c => c.county_slug === 'baker');
        const calhounInAPI = apiQuery.rows.find(c => c.county_slug === 'calhoun');
        
        console.log(`Total counties in API response: ${apiQuery.rows.length}`);
        console.log(`Baker in API: ${bakerInAPI ? 'YES' : 'NO'}`);
        console.log(`Calhoun in API: ${calhounInAPI ? 'YES' : 'NO'}`);
        
        await client.end();
        console.log('\n✅ Done');
        
    } catch (err) {
        console.error('❌ Error:', err.message);
        await client.end();
        process.exit(1);
    }
}

verify();

