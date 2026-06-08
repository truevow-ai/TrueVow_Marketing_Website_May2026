require('dotenv').config({ path: '.env.local' });
const { Client } = require('pg');
const fs = require('fs');

const url = process.env.MARKETING_DATABASE_URL || '';
const match = url.match(/postgresql:\/\/([^:]+):([^@]+)@([^:]+):(\d+)\/(.+)/);

if (!match) {
    fs.writeFileSync('baker_fix_output.txt', 'ERROR: No connection string found\n');
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

let output = '';

function log(msg) {
    output += msg + '\n';
    console.log(msg);
}

async function fix() {
    try {
        await client.connect();
        log('✓ Connected to database');
        
        // Get current data
        const result = await client.query(
            'SELECT id, county_name, total_firms, total_seats FROM web_availability_county WHERE state_code = $1 AND county_slug = $2',
            ['FL', 'baker']
        );
        
        if (result.rows.length === 0) {
            log('❌ Baker County not found');
            await client.end();
            fs.writeFileSync('baker_fix_output.txt', output);
            return;
        }
        
        const data = result.rows[0];
        log(`Current: total_seats = ${data.total_seats}`);
        
        if (data.total_seats === 72) {
            log('Fixing...');
            
            // Fix county
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
                [data.id]
            );
            
            // Verify
            const verify = await client.query(
                'SELECT total_seats FROM web_availability_county WHERE state_code = $1 AND county_slug = $2',
                ['FL', 'baker']
            );
            
            log(`✓ Fixed! New total_seats = ${verify.rows[0].total_seats}`);
        } else {
            log(`✓ Already correct: ${data.total_seats}`);
        }
        
        await client.end();
        log('✓ Done');
        
    } catch (err) {
        log(`❌ Error: ${err.message}`);
    } finally {
        fs.writeFileSync('baker_fix_output.txt', output);
    }
}

fix();

