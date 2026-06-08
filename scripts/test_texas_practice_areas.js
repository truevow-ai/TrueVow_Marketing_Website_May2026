/**
 * Quick test to check if Texas practice areas exist
 */

const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

async function test() {
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
        console.log('✅ Connected');
        
        const result = await client.query(`
            SELECT 
                c.county_name,
                COUNT(pa.id) as practice_area_count
            FROM web_availability_county c
            LEFT JOIN web_availability_practice_area_seats pa ON pa.county_availability_id = c.id
            WHERE c.state_code = 'TX'
            GROUP BY c.id, c.county_name
            ORDER BY practice_area_count DESC
            LIMIT 10
        `);
        
        console.log('\nTexas Counties Practice Area Count:');
        result.rows.forEach(row => {
            console.log(`  ${row.county_name}: ${row.practice_area_count} practice areas`);
        });
        
        await client.end();
    } catch (error) {
        console.error('Error:', error.message);
        process.exit(1);
    }
}

test();

