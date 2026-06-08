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

async function validateAndFix() {
    try {
        await client.connect();
        console.log('✓ Connected to database\n');
        
        // Check Baker County
        const result = await client.query(
            'SELECT county_name, total_firms, total_seats, premium_total, standard_total FROM web_availability_county WHERE state_code = $1 AND county_slug = $2',
            ['FL', 'baker']
        );
        
        if (result.rows.length === 0) {
            console.log('Baker County not found in database');
            return;
        }
        
        const baker = result.rows[0];
        console.log('Current Baker County data:');
        console.log(JSON.stringify(baker, null, 2));
        console.log('');
        
        // Baker has 8 firms, so 33% = 2.64, rounded to 3, but we'll use 2 to be conservative
        if (baker.total_seats !== 2) {
            console.log('⚠️  Baker County has incorrect total_seats:', baker.total_seats);
            console.log('   Expected: 2 (33% of 8 firms = 2.64, rounded to 2)');
            console.log('   Fixing...\n');
            
            await client.query(
                `UPDATE web_availability_county 
                 SET total_seats = 2, 
                     premium_total = 1, 
                     standard_total = 1,
                     premium_remaining = 1,
                     standard_remaining = 1,
                     updated_at = NOW()
                 WHERE state_code = 'FL' AND county_slug = 'baker'`
            );
            
            // Update practice area seats
            await client.query(
                `UPDATE web_availability_practice_area_seats
                 SET cap = 1,
                     premium = 1,
                     standard = 0,
                     premium_remaining = 1,
                     standard_remaining = 0,
                     updated_at = NOW()
                 WHERE county_availability_id IN (
                     SELECT id FROM web_availability_county 
                     WHERE state_code = 'FL' AND county_slug = 'baker'
                 )`
            );
            
            console.log('✓ Fixed Baker County data\n');
            
            // Verify
            const verify = await client.query(
                'SELECT county_name, total_firms, total_seats FROM web_availability_county WHERE state_code = $1 AND county_slug = $2',
                ['FL', 'baker']
            );
            console.log('Verified Baker County data:');
            console.log(JSON.stringify(verify.rows[0], null, 2));
        } else {
            console.log('✓ Baker County data is correct');
        }
        
    } catch (error) {
        console.error('Error:', error.message);
    } finally {
        await client.end();
    }
}

validateAndFix();

