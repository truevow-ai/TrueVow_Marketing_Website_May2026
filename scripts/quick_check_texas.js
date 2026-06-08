const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

let password = process.env.SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD;
if (password && password.includes('%40')) password = decodeURIComponent(password);

const client = new Client({
    host: 'db.napwpkagxzqfpbearkjs.supabase.co',
    port: 5432,
    database: 'postgres',
    user: 'postgres',
    password: password,
    ssl: { rejectUnauthorized: false },
});

client.connect()
    .then(() => client.query("SELECT COUNT(*) as count FROM web_availability_county WHERE state_code = 'TX'"))
    .then(result => {
        console.log(`Texas counties in database: ${result.rows[0].count}`);
        return client.query("SELECT county_name, total_firms, total_seats FROM web_availability_county WHERE state_code = 'TX' ORDER BY total_seats DESC LIMIT 10");
    })
    .then(result => {
        console.log('\nTop 10 Texas counties:');
        result.rows.forEach(r => console.log(`  ${r.county_name}: ${r.total_firms} firms → ${r.total_seats} seats`));
        return client.end();
    })
    .then(() => process.exit(0))
    .catch(err => {
        console.error('Error:', err.message);
        process.exit(1);
    });

