require('dotenv').config({ path: '.env.local' });
const { Client } = require('pg');

const url = process.env.MARKETING_DATABASE_URL || '';
const match = url.match(/postgresql:\/\/([^:]+):([^@]+)@([^:]+):(\d+)\/(.+)/);

if (!match) {
    console.error('No connection string found');
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
        console.log('✓ Connected to database\n');
        
        // Check current data
        const result = await client.query(
            'SELECT county_name, total_firms, total_seats, premium_total, standard_total FROM web_availability_county WHERE state_code = $1 AND county_slug = $2',
            ['FL', 'baker']
        );
        
        if (result.rows.length === 0) {
            console.log('❌ Baker County not found in database');
            await client.end();
            return;
        }
        
        const data = result.rows[0];
        console.log('Current Baker County Data:');
        console.log(JSON.stringify(data, null, 2));
        console.log('');
        
        if (data.total_seats === 72) {
            console.log('❌ ERROR: total_seats is still 72! Applying fix...\n');
            
            // Apply fix
            await client.query(
                `UPDATE web_availability_county 
                 SET total_seats = 2, premium_total = 1, standard_total = 1,
                     premium_remaining = 1, standard_remaining = 1,
                     updated_at = NOW()
                 WHERE state_code = 'FL' AND county_slug = 'baker'`
            );
            
            // Verify fix
            const verifyResult = await client.query(
                'SELECT county_name, total_firms, total_seats, premium_total, standard_total FROM web_availability_county WHERE state_code = $1 AND county_slug = $2',
                ['FL', 'baker']
            );
            
            console.log('✓ Fix applied. New data:');
            console.log(JSON.stringify(verifyResult.rows[0], null, 2));
        } else {
            console.log('✓ total_seats is correct:', data.total_seats);
        }
        
        await client.end();
    } catch (err) {
        console.error('Error:', err.message);
        await client.end();
        process.exit(1);
    }
}

verify();

