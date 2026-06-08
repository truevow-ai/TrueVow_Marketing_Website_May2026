const { Client } = require('pg');
const fs = require('fs');
require('dotenv').config({ path: '.env.local' });

const output = [];
function log(msg) {
    const str = typeof msg === 'string' ? msg : JSON.stringify(msg, null, 2);
    output.push(str);
    console.log(str);
}

async function main() {
    let password = process.env.SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD || process.env.DATABASE_PASSWORD;
    if (password && password.includes('%40')) {
        password = decodeURIComponent(password);
    }

    if (!password) {
        log('ERROR: No password found');
        process.exit(1);
    }

    const client = new Client({
        host: 'db.napwpkagxzqfpbearkjs.supabase.co',
        port: 5432,
        database: 'postgres',
        user: 'postgres',
        password: password,
        ssl: { rejectUnauthorized: false },
    });

    try {
        await client.connect();
        log('Connected to database');

        // Find counties to delete
        const findResult = await client.query(`
            SELECT id, state_code, county_name, total_firms, total_seats
            FROM web_availability_county
            WHERE state_code IN ('FL', 'CA') AND total_seats < 4
            ORDER BY state_code, county_name
        `);

        log(`\nFound ${findResult.rows.length} counties with < 4 seats:`);
        findResult.rows.forEach(r => {
            log(`  ${r.state_code} - ${r.county_name}: ${r.total_seats} seats`);
        });

        if (findResult.rows.length === 0) {
            log('\nNo counties to delete');
            await client.end();
            fs.writeFileSync('delete_results.txt', output.join('\n'));
            return;
        }

        // Delete practice area seats
        const paResult = await client.query(`
            DELETE FROM web_availability_practice_area_seats
            WHERE county_availability_id = ANY($1::uuid[])
        `, [findResult.rows.map(r => r.id)]);

        log(`\nDeleted ${paResult.rowCount} practice area records`);

        // Delete counties
        const countyResult = await client.query(`
            DELETE FROM web_availability_county
            WHERE id = ANY($1::uuid[])
        `, [findResult.rows.map(r => r.id)]);

        log(`Deleted ${countyResult.rowCount} county records`);

        // Verify
        const verify = await client.query(`
            SELECT COUNT(*) as count
            FROM web_availability_county
            WHERE state_code IN ('FL', 'CA') AND total_seats < 4
        `);

        log(`\nVerification: ${verify.rows[0].count} counties with < 4 seats remain`);

        // Summary
        const summary = await client.query(`
            SELECT state_code, COUNT(*) as total, MIN(total_seats) as min_seats
            FROM web_availability_county
            WHERE state_code IN ('FL', 'CA')
            GROUP BY state_code
        `);

        log('\nSummary:');
        summary.rows.forEach(r => {
            log(`  ${r.state_code}: ${r.total} counties, min seats: ${r.min_seats}`);
        });

        await client.end();
        fs.writeFileSync('delete_results.txt', output.join('\n'));
        log('\nResults saved to delete_results.txt');

    } catch (error) {
        log(`ERROR: ${error.message}`);
        if (error.code) log(`Code: ${error.code}`);
        fs.writeFileSync('delete_results.txt', output.join('\n'));
        process.exit(1);
    }
}

main();

