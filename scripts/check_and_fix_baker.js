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

async function checkAndFix() {
    try {
        console.log('Attempting to connect to database...');
        console.log('Host:', host);
        console.log('Port:', port);
        console.log('Database:', database);
        console.log('User:', user);
        await client.connect();
        console.log('✓ Connected to database');
        
        // Check current data
        const result = await client.query(
            'SELECT id, county_name, total_firms, total_seats, premium_total, standard_total FROM web_availability_county WHERE state_code = $1 AND county_slug = $2',
            ['FL', 'baker']
        );
        
        if (result.rows.length === 0) {
            console.log('Baker County not found in database');
            await client.end();
            return;
        }
        
        const row = result.rows[0];
        console.log('\nCurrent Baker County Data:');
        console.log(JSON.stringify(row, null, 2));
        
        // Calculate correct values
        const totalFirms = row.total_firms;
        const correctTotalSeats = Math.min(totalFirms, Math.round(totalFirms * 0.33));
        const correctPremium = Math.max(1, Math.round(correctTotalSeats * 0.21));
        const correctStandard = correctTotalSeats - correctPremium;
        
        console.log(`\nCalculated correct values:`);
        console.log(`  Total Firms: ${totalFirms}`);
        console.log(`  Total Seats (33% cap): ${correctTotalSeats}`);
        console.log(`  Premium (21%): ${correctPremium}`);
        console.log(`  Standard: ${correctStandard}`);
        
        if (row.total_seats !== correctTotalSeats) {
            console.log(`\nFixing: total_seats ${row.total_seats} -> ${correctTotalSeats}`);
            
            // Update county table
            await client.query(
                `UPDATE web_availability_county 
                 SET total_seats = $1,
                     premium_total = $2,
                     standard_total = $3,
                     premium_remaining = $2,
                     standard_remaining = $3
                 WHERE id = $4`,
                [correctTotalSeats, correctPremium, correctStandard, row.id]
            );
            
            // Update practice area seats proportionally
            const practiceAreas = await client.query(
                'SELECT id, cap, premium, standard FROM web_availability_practice_area_seats WHERE county_availability_id = $1',
                [row.id]
            );
            
            console.log(`\nUpdating ${practiceAreas.rows.length} practice areas...`);
            
            for (const pa of practiceAreas.rows) {
                // Scale down if total exceeds firms
                const scaleFactor = correctTotalSeats / (row.total_seats || 1);
                const newCap = Math.max(1, Math.round(pa.cap * scaleFactor));
                const newPremium = Math.max(1, Math.round(newCap * 0.21));
                const newStandard = newCap - newPremium;
                
                await client.query(
                    `UPDATE web_availability_practice_area_seats 
                     SET cap = $1,
                         premium = $2,
                         standard = $3,
                         premium_remaining = $2,
                         standard_remaining = $3
                     WHERE id = $4`,
                    [newCap, newPremium, newStandard, pa.id]
                );
            }
            
            console.log('✓ Fix applied successfully');
            
            // Verify
            const verify = await client.query(
                'SELECT county_name, total_firms, total_seats, premium_total, standard_total FROM web_availability_county WHERE id = $1',
                [row.id]
            );
            console.log('\nVerified data:');
            console.log(JSON.stringify(verify.rows[0], null, 2));
        } else {
            console.log('\n✓ Data is already correct');
        }
        
        await client.end();
    } catch (error) {
        console.error('Error:', error.message);
        await client.end();
        process.exit(1);
    }
}

checkAndFix();

