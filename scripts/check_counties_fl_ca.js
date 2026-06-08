/**
 * Check counties in FL and CA to see what remains
 */

const { Client } = require('pg');
const fs = require('fs');
require('dotenv').config({ path: '.env.local' });

let output = [];
function log(msg) {
    const msgStr = typeof msg === 'string' ? msg : JSON.stringify(msg, null, 2);
    console.log(msgStr);
    output.push(msgStr);
}

async function checkCounties() {
    let password = process.env.SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD || process.env.DATABASE_PASSWORD;
    
    // Decode URL-encoded password
    if (password && password.includes('%40')) {
        password = decodeURIComponent(password);
    }

    const client = new Client({
        host: 'db.napwpkagxzqfpbearkjs.supabase.co',
        port: 5432,
        database: 'postgres',
        user: 'postgres',
        password: password,
    });

    try {
        await client.connect();
        log('✅ Connected to database\n');

        // Check for small counties
        const smallCounties = await client.query(`
            SELECT state_code, county_name, total_firms, total_seats
            FROM web_availability_county
            WHERE state_code IN ('FL', 'CA') AND total_seats < 4
            ORDER BY state_code, county_name
        `);

        log(`\n📊 Counties with < 4 seats: ${smallCounties.rows.length}`);
        if (smallCounties.rows.length > 0) {
            smallCounties.rows.forEach(row => {
                log(`  ${row.state_code} - ${row.county_name}: ${row.total_seats} seats`);
            });
        } else {
            log('  ✅ All small counties have been removed!');
        }

        // Summary by state
        const summary = await client.query(`
            SELECT 
                state_code,
                COUNT(*) as total,
                MIN(total_seats) as min_seats,
                MAX(total_seats) as max_seats
            FROM web_availability_county
            WHERE state_code IN ('FL', 'CA')
            GROUP BY state_code
            ORDER BY state_code
        `);

        log('\n📈 Summary:');
        summary.rows.forEach(row => {
            log(`  ${row.state_code}: ${row.total} counties, seats range: ${row.min_seats}-${row.max_seats}`);
        });

        // Smallest 10 counties
        const smallest = await client.query(`
            SELECT state_code, county_name, total_firms, total_seats
            FROM web_availability_county
            WHERE state_code IN ('FL', 'CA')
            ORDER BY total_seats ASC
            LIMIT 10
        `);

        log('\n🔍 Smallest 10 counties:');
        smallest.rows.forEach(row => {
            log(`  ${row.state_code} - ${row.county_name}: ${row.total_firms} firms → ${row.total_seats} seats`);
        });

        // Write to file
        fs.writeFileSync('county_removal_verification.txt', output.join('\n'));
        log('\n✅ Results saved to county_removal_verification.txt');

    } catch (error) {
        log(`❌ Error: ${error.message}`);
        fs.writeFileSync('county_removal_verification.txt', output.join('\n'));
        process.exit(1);
    } finally {
        await client.end();
    }
}

checkCounties();

