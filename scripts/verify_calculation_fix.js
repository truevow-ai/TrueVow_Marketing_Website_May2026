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
        
        // Check problematic counties
        const counties = ['baker', 'calhoun', 'hardee', 'glades', 'suwannee', 'jefferson', 'washington', 'desoto', 'holmes', 'okeechobee'];
        
        console.log('🔍 Verifying calculation fixes:\n');
        console.log('County Name          | Total Firms | Total Seats | Expected (33%) | Status');
        console.log('-'.repeat(80));
        
        for (const slug of counties) {
            const result = await client.query(
                `SELECT county_name, total_firms, total_seats 
                 FROM web_availability_county 
                 WHERE state_code = 'FL' AND county_slug = $1`,
                [slug]
            );
            
            if (result.rows.length > 0) {
                const c = result.rows[0];
                const expected = Math.max(2, Math.round(c.total_firms * 0.33));
                const status = c.total_seats === expected ? '✅ CORRECT' : 
                              c.total_seats === 72 ? '❌ STILL 72' : 
                              '⚠️  WRONG';
                
                console.log(`${c.county_name.padEnd(20)} | ${String(c.total_firms).padStart(11)} | ${String(c.total_seats).padStart(12)} | ${String(expected).padStart(15)} | ${status}`);
            } else {
                console.log(`${slug.padEnd(20)} | NOT FOUND`);
            }
        }
        
        await client.end();
        console.log('\n✅ Done');
        
    } catch (err) {
        console.error('❌ Error:', err.message);
        await client.end();
        process.exit(1);
    }
}

verify();

