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

async function check() {
    try {
        await client.connect();
        console.log('✅ Connected to database\n');
        
        // Check Baker County
        console.log('🔍 Checking Baker County...');
        const baker = await client.query(
            `SELECT id, state_code, county_slug, county_name, total_firms, total_seats, 
                    premium_total, standard_total, is_active, created_at, updated_at
             FROM web_availability_county 
             WHERE state_code = 'FL' AND county_slug = 'baker'`
        );
        
        if (baker.rows.length > 0) {
            console.log('✅ Baker County FOUND in database:');
            console.log(JSON.stringify(baker.rows[0], null, 2));
        } else {
            console.log('❌ Baker County NOT FOUND in database');
        }
        
        console.log('\n');
        
        // Check Calhoun County
        console.log('🔍 Checking Calhoun County...');
        const calhoun = await client.query(
            `SELECT id, state_code, county_slug, county_name, total_firms, total_seats, 
                    premium_total, standard_total, is_active, created_at, updated_at
             FROM web_availability_county 
             WHERE state_code = 'FL' AND county_slug = 'calhoun'`
        );
        
        if (calhoun.rows.length > 0) {
            console.log('✅ Calhoun County FOUND in database:');
            console.log(JSON.stringify(calhoun.rows[0], null, 2));
        } else {
            console.log('❌ Calhoun County NOT FOUND in database');
        }
        
        console.log('\n');
        
        // Check all Florida counties
        console.log('🔍 Checking all Florida counties...');
        const allFL = await client.query(
            `SELECT county_slug, county_name, total_firms, total_seats, is_active
             FROM web_availability_county 
             WHERE state_code = 'FL'
             ORDER BY county_name`
        );
        
        console.log(`Total Florida counties in database: ${allFL.rows.length}`);
        console.log('\nFirst 10 counties:');
        allFL.rows.slice(0, 10).forEach(c => {
            console.log(`  ${c.county_name} (${c.county_slug}): ${c.total_firms} firms, ${c.total_seats} seats, active: ${c.is_active}`);
        });
        
        // Check if Baker/Calhoun are in the list
        const bakerInList = allFL.rows.find(c => c.county_slug === 'baker');
        const calhounInList = allFL.rows.find(c => c.county_slug === 'calhoun');
        
        console.log('\n');
        console.log(`Baker in list: ${bakerInList ? 'YES' : 'NO'}`);
        console.log(`Calhoun in list: ${calhounInList ? 'YES' : 'NO'}`);
        
        await client.end();
        console.log('\n✅ Disconnected');
        
    } catch (err) {
        console.error('❌ Error:', err.message);
        console.error(err.stack);
        await client.end();
        process.exit(1);
    }
}

check();

