// Test with file output
const { Client } = require('pg');
const fs = require('fs');
require('dotenv').config({ path: '.env.local' });

const output = [];

function log(msg) {
    const line = `[${new Date().toISOString()}] ${msg}`;
    console.log(line);
    output.push(line);
}

const connectionString = process.env.MARKETING_DATABASE_URL || process.env.SUPABASE_DB_URL;

if (!connectionString) {
    log('❌ No database connection string found');
    fs.writeFileSync('test_output.txt', output.join('\n'));
    process.exit(1);
}

log('🔌 Connecting to database...');

const client = new Client({
    connectionString: connectionString.replace(/%40/g, '@'),
    ssl: { rejectUnauthorized: false }
});

client.connect()
    .then(() => {
        log('✅ Connected!');
        return client.query(`
            SELECT county_name, total_firms, total_seats
            FROM web_availability_county
            WHERE county_slug = 'baker' AND state_code = 'FL'
            LIMIT 1
        `);
    })
    .then(result => {
        if (result.rows.length > 0) {
            const row = result.rows[0];
            log(`\n📊 Baker County:`);
            log(`   Name: ${row.county_name}`);
            log(`   Firms: ${row.total_firms}`);
            log(`   Seats: ${row.total_seats}`);
            log(`   Expected: ${Math.round(row.total_firms * 0.33)}`);
            
            if (row.total_seats === 72) {
                log('\n❌ STILL SHOWING 72 SEATS!');
                log('   Need to fix this directly.');
            } else {
                log('\n✅ Looks correct!');
            }
        } else {
            log('\n❌ Baker County not found!');
        }
        return client.end();
    })
    .then(() => {
        log('\n✅ Test complete');
        fs.writeFileSync('test_output.txt', output.join('\n'));
        process.exit(0);
    })
    .catch(error => {
        log(`❌ Error: ${error.message}`);
        log(error.stack);
        fs.writeFileSync('test_output.txt', output.join('\n'));
        client.end().catch(() => {});
        process.exit(1);
    });

