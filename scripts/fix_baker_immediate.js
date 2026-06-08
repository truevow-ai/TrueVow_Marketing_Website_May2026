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

async function fix() {
    try {
        await client.connect();
        console.log('Connected');
        
        // Get current data
        const result = await client.query(
            'SELECT id, total_seats FROM web_availability_county WHERE state_code = $1 AND county_slug = $2',
            ['FL', 'baker']
        );
        
        console.log('Current total_seats:', result.rows[0]?.total_seats);
        
        // Fix to 2 seats
        await client.query(
            `UPDATE web_availability_county 
             SET total_seats = 2, premium_total = 1, standard_total = 1,
                 premium_remaining = 1, standard_remaining = 1
             WHERE state_code = 'FL' AND county_slug = 'baker'`
        );
        
        // Fix practice areas
        await client.query(
            `UPDATE web_availability_practice_area_seats 
             SET cap = 1, premium = 1, standard = 0,
                 premium_remaining = 1, standard_remaining = 0
             WHERE county_availability_id = $1`,
            [result.rows[0].id]
        );
        
        // Verify
        const verify = await client.query(
            'SELECT total_seats FROM web_availability_county WHERE state_code = $1 AND county_slug = $2',
            ['FL', 'baker']
        );
        
        console.log('Fixed! New total_seats:', verify.rows[0].total_seats);
        await client.end();
        
    } catch (err) {
        console.error('Error:', err.message);
        await client.end();
        process.exit(1);
    }
}

fix();

