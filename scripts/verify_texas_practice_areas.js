/**
 * Verify Texas practice area calculations
 */

const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

async function verify() {
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

        // Check Bell County
        const bell = await client.query(`
            SELECT id, county_name, total_firms, total_seats
            FROM web_availability_county
            WHERE state_code = 'TX' AND county_slug = 'bell'
        `);

        if (bell.rows.length === 0) {
            console.log('Bell County not found');
            await client.end();
            return;
        }

        const bellCounty = bell.rows[0];
        console.log(`Bell County: ${bellCounty.county_name}`);
        console.log(`  Total Firms: ${bellCounty.total_firms}`);
        console.log(`  Total Seats: ${bellCounty.total_seats}\n`);

        const bellPA = await client.query(`
            SELECT practice_area_name, cap, premium, standard, filled, premium_remaining, standard_remaining
            FROM web_availability_practice_area_seats
            WHERE county_availability_id = $1
            ORDER BY display_order
        `, [bellCounty.id]);

        console.log('Bell County Practice Areas:');
        let bellSum = 0;
        bellPA.rows.forEach(r => {
            bellSum += parseInt(r.cap);
            const available = parseInt(r.cap) - parseInt(r.filled);
            const remaining = parseInt(r.premium_remaining) + parseInt(r.standard_remaining);
            console.log(`  ${r.practice_area_name}:`);
            console.log(`    Cap: ${r.cap}, Premium: ${r.premium}, Standard: ${r.standard}`);
            console.log(`    Filled: ${r.filled}, Available: ${available}, Remaining: ${remaining}`);
        });
        console.log(`\n  Bell Sum of Caps: ${bellSum} (should be ${bellCounty.total_seats})`);
        console.log(`  Difference: ${bellSum - bellCounty.total_seats}\n`);

        // Check Harris County
        const harris = await client.query(`
            SELECT id, county_name, total_firms, total_seats
            FROM web_availability_county
            WHERE state_code = 'TX' AND county_slug = 'harris'
        `);

        const harrisCounty = harris.rows[0];
        console.log(`Harris County: ${harrisCounty.county_name}`);
        console.log(`  Total Firms: ${harrisCounty.total_firms}`);
        console.log(`  Total Seats: ${harrisCounty.total_seats}\n`);

        const harrisPA = await client.query(`
            SELECT practice_area_name, cap, premium, standard, filled, premium_remaining, standard_remaining
            FROM web_availability_practice_area_seats
            WHERE county_availability_id = $1
            ORDER BY display_order
        `, [harrisCounty.id]);

        console.log('Harris County Practice Areas:');
        let harrisSum = 0;
        harrisPA.rows.forEach(r => {
            harrisSum += parseInt(r.cap);
            const available = parseInt(r.cap) - parseInt(r.filled);
            const remaining = parseInt(r.premium_remaining) + parseInt(r.standard_remaining);
            console.log(`  ${r.practice_area_name}:`);
            console.log(`    Cap: ${r.cap}, Premium: ${r.premium}, Standard: ${r.standard}`);
            console.log(`    Filled: ${r.filled}, Available: ${available}, Remaining: ${remaining}`);
        });
        console.log(`\n  Harris Sum of Caps: ${harrisSum} (should be ${harrisCounty.total_seats})`);
        console.log(`  Difference: ${harrisSum - harrisCounty.total_seats}\n`);

        // Check Workers Compensation specifically
        const bellWC = bellPA.rows.find(r => r.practice_area_name === 'Workers Compensation');
        const harrisWC = harrisPA.rows.find(r => r.practice_area_name === 'Workers Compensation');

        console.log('Workers Compensation Check:');
        console.log(`  Bell: Cap=${bellWC.cap}, Expected=${Math.round(bellCounty.total_seats * 0.04)}`);
        console.log(`  Harris: Cap=${harrisWC.cap}, Expected=${Math.round(harrisCounty.total_seats * 0.04)}`);

        await client.end();
    } catch (error) {
        console.error('❌ ERROR:', error.message);
        console.error(error.stack);
        process.exit(1);
    }
}

verify();

