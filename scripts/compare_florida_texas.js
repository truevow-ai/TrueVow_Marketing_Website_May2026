/**
 * Compare Florida and Texas practice area calculations
 */

const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

async function compare() {
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

        // Get a Florida county with similar total seats to Bell (63)
        const flCounty = await client.query(`
            SELECT id, county_name, total_firms, total_seats
            FROM web_availability_county
            WHERE state_code = 'FL' AND total_seats BETWEEN 50 AND 80
            ORDER BY ABS(total_seats - 63)
            LIMIT 1
        `);

        if (flCounty.rows.length === 0) {
            console.log('No Florida county found for comparison');
            await client.end();
            return;
        }

        const fl = flCounty.rows[0];
        console.log(`Florida County: ${fl.county_name}`);
        console.log(`  Total Firms: ${fl.total_firms}, Total Seats: ${fl.total_seats}\n`);

        const flPA = await client.query(`
            SELECT practice_area_name, cap, premium, standard, filled, premium_remaining, standard_remaining
            FROM web_availability_practice_area_seats
            WHERE county_availability_id = $1
            ORDER BY display_order
        `, [fl.id]);

        console.log('Florida Practice Areas:');
        let flSum = 0;
        flPA.rows.forEach(r => {
            flSum += parseInt(r.cap);
            const available = parseInt(r.cap) - parseInt(r.filled);
            const remaining = parseInt(r.premium_remaining) + parseInt(r.standard_remaining);
            const pct = (r.cap / fl.total_seats * 100).toFixed(2);
            console.log(`  ${r.practice_area_name}: Cap=${r.cap} (${pct}%), Available=${available}, Remaining=${remaining}`);
        });
        console.log(`  Sum: ${flSum}\n`);

        // Get Bell County
        const bell = await client.query(`
            SELECT id, county_name, total_firms, total_seats
            FROM web_availability_county
            WHERE state_code = 'TX' AND county_slug = 'bell'
        `);

        const bellCounty = bell.rows[0];
        console.log(`Texas Bell County: ${bellCounty.county_name}`);
        console.log(`  Total Firms: ${bellCounty.total_firms}, Total Seats: ${bellCounty.total_seats}\n`);

        const bellPA = await client.query(`
            SELECT practice_area_name, cap, premium, standard, filled, premium_remaining, standard_remaining
            FROM web_availability_practice_area_seats
            WHERE county_availability_id = $1
            ORDER BY display_order
        `, [bellCounty.id]);

        console.log('Texas Bell Practice Areas:');
        let bellSum = 0;
        bellPA.rows.forEach(r => {
            bellSum += parseInt(r.cap);
            const available = parseInt(r.cap) - parseInt(r.filled);
            const remaining = parseInt(r.premium_remaining) + parseInt(r.standard_remaining);
            const pct = (r.cap / bellCounty.total_seats * 100).toFixed(2);
            console.log(`  ${r.practice_area_name}: Cap=${r.cap} (${pct}%), Available=${available}, Remaining=${remaining}`);
        });
        console.log(`  Sum: ${bellSum}\n`);

        // Compare Workers Compensation specifically
        const flWC = flPA.rows.find(r => r.practice_area_name === 'Workers Compensation');
        const bellWC = bellPA.rows.find(r => r.practice_area_name === 'Workers Compensation');

        console.log('Workers Compensation Comparison:');
        console.log(`  Florida ${fl.county_name}: Cap=${flWC.cap}, %=${(flWC.cap / fl.total_seats * 100).toFixed(2)}%`);
        console.log(`  Texas Bell: Cap=${bellWC.cap}, %=${(bellWC.cap / bellCounty.total_seats * 100).toFixed(2)}%`);
        console.log(`  Expected %: 4.00%`);

        await client.end();
    } catch (error) {
        console.error('❌ ERROR:', error.message);
        console.error(error.stack);
        process.exit(1);
    }
}

compare();

