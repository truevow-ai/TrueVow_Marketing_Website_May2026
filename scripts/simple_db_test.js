// Simple database test
const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

const connectionString = process.env.MARKETING_DATABASE_URL || process.env.SUPABASE_DB_URL;

if (!connectionString) {
    console.error('❌ No database connection string found');
    process.exit(1);
}

console.log('🔌 Connecting to database...');
console.log('Connection string length:', connectionString.length);

let password = '';
try {
    const url = new URL(connectionString);
    password = url.password ? decodeURIComponent(url.password) : '';
    console.log('Password length:', password.length);
} catch (e) {
    console.error('Error parsing URL:', e.message);
    process.exit(1);
}

const client = new Client({
    connectionString: connectionString.replace(/%40/g, '@'),
    ssl: { rejectUnauthorized: false }
});

client.connect()
    .then(() => {
        console.log('✅ Connected!');
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
            console.log('\n📊 Baker County:');
            console.log(`   Name: ${row.county_name}`);
            console.log(`   Firms: ${row.total_firms}`);
            console.log(`   Seats: ${row.total_seats}`);
            console.log(`   Expected: ${Math.round(row.total_firms * 0.33)}`);
        } else {
            console.log('\n❌ Baker County not found!');
        }
        return client.end();
    })
    .then(() => {
        console.log('\n✅ Test complete');
        process.exit(0);
    })
    .catch(error => {
        console.error('❌ Error:', error.message);
        client.end().catch(() => {});
        process.exit(1);
    });

