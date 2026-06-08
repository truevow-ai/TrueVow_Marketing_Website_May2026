/**
 * Verify that small counties (< 4 seats) have been removed from FL and CA
 */

const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

async function verifyRemoval() {
    const client = new Client({
        host: 'db.napwpkagxzqfpbearkjs.supabase.co',
        port: 5432,
        database: 'postgres',
        user: 'postgres',
        password: process.env.SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD || process.env.DATABASE_PASSWORD,
    });

    try {
        await client.connect();
        console.log('✅ Connected to database\n');

        // Check for any remaining counties with < 4 seats
        const smallCounties = await client.query(`
            SELECT 
                state_code,
                county_name,
                total_firms,
                total_seats
            FROM web_availability_county
            WHERE state_code IN ('FL', 'CA') 
              AND total_seats < 4
            ORDER BY state_code, county_name
        `);

        if (smallCounties.rows.length > 0) {
            console.log('❌ FOUND COUNTIES WITH < 4 SEATS (should be 0):');
            smallCounties.rows.forEach(row => {
                console.log(`  ${row.state_code} - ${row.county_name}: ${row.total_firms} firms, ${row.total_seats} seats`);
            });
        } else {
            console.log('✅ No counties with < 4 seats found (all removed)\n');
        }

        // Show summary by state
        const summary = await client.query(`
            SELECT 
                state_code,
                COUNT(*) as total_counties,
                MIN(total_seats) as min_seats,
                MAX(total_seats) as max_seats,
                AVG(total_seats)::INTEGER as avg_seats
            FROM web_availability_county
            WHERE state_code IN ('FL', 'CA')
            GROUP BY state_code
            ORDER BY state_code
        `);

        console.log('\n📊 SUMMARY BY STATE:');
        summary.rows.forEach(row => {
            console.log(`\n${row.state_code}:`);
            console.log(`  Total counties: ${row.total_counties}`);
            console.log(`  Min seats: ${row.min_seats}`);
            console.log(`  Max seats: ${row.max_seats}`);
            console.log(`  Avg seats: ${row.avg_seats}`);
        });

        // Show smallest counties (first 10)
        const smallest = await client.query(`
            SELECT 
                state_code,
                county_name,
                total_firms,
                total_seats
            FROM web_availability_county
            WHERE state_code IN ('FL', 'CA')
            ORDER BY total_seats ASC
            LIMIT 10
        `);

        console.log('\n\n🔍 SMALLEST COUNTIES (first 10):');
        smallest.rows.forEach(row => {
            console.log(`  ${row.state_code} - ${row.county_name}: ${row.total_firms} firms → ${row.total_seats} seats`);
        });

    } catch (error) {
        console.error('❌ Error:', error.message);
        process.exit(1);
    } finally {
        await client.end();
    }
}

verifyRemoval();

