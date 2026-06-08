/**
 * Directly remove counties with < 4 seats from FL and CA
 */

const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

async function removeSmallCounties() {
    process.stdout.write('Starting script...\n');
    
    let password = process.env.SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD || process.env.DATABASE_PASSWORD;
    
    if (!password) {
        console.error('❌ ERROR: No password found in environment variables');
        process.exit(1);
    }
    
    process.stdout.write(`Password found (length: ${password.length})\n`);
    
    // Decode URL-encoded password
    if (password && password.includes('%40')) {
        password = decodeURIComponent(password);
        process.stdout.write('Password decoded\n');
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
        console.log('✅ Connected to database\n');

        // First, show what will be deleted
        console.log('📋 Finding counties with < 4 seats...');
        const toDelete = await client.query(`
            SELECT 
                id,
                state_code,
                county_name,
                county_slug,
                total_firms,
                total_seats
            FROM web_availability_county
            WHERE state_code IN ('FL', 'CA') 
              AND total_seats < 4
            ORDER BY state_code, county_name
        `);

        console.log(`\n🔍 Found ${toDelete.rows.length} counties to delete:\n`);
        toDelete.rows.forEach(row => {
            console.log(`  ${row.state_code} - ${row.county_name}: ${row.total_firms} firms → ${row.total_seats} seats`);
        });

        if (toDelete.rows.length === 0) {
            console.log('\n✅ No counties with < 4 seats found. Already cleaned up!');
            await client.end();
            return;
        }

        // Delete practice area seats first
        console.log('\n🗑️  Step 1: Deleting practice area seats...');
        const practiceAreaResult = await client.query(`
            DELETE FROM web_availability_practice_area_seats
            WHERE county_availability_id IN (
                SELECT id FROM web_availability_county
                WHERE state_code IN ('FL', 'CA') 
                  AND total_seats < 4
            )
        `);
        console.log(`   ✅ Deleted ${practiceAreaResult.rowCount} practice area seat records`);

        // Delete counties
        console.log('\n🗑️  Step 2: Deleting counties...');
        const countyResult = await client.query(`
            DELETE FROM web_availability_county
            WHERE state_code IN ('FL', 'CA') 
              AND total_seats < 4
        `);
        console.log(`   ✅ Deleted ${countyResult.rowCount} county records`);

        // Verify deletion
        console.log('\n🔍 Verifying deletion...');
        const remaining = await client.query(`
            SELECT COUNT(*) as count
            FROM web_availability_county
            WHERE state_code IN ('FL', 'CA') 
              AND total_seats < 4
        `);

        if (remaining.rows[0].count === '0') {
            console.log('   ✅ Verification passed: No counties with < 4 seats remain');
        } else {
            console.log(`   ⚠️  Warning: ${remaining.rows[0].count} counties with < 4 seats still exist`);
        }

        // Show summary
        console.log('\n📊 Final Summary:');
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

        summary.rows.forEach(row => {
            console.log(`  ${row.state_code}: ${row.total} counties, seats range: ${row.min_seats}-${row.max_seats}`);
        });

        console.log('\n✅ Done!');

    } catch (error) {
        console.error('\n❌ Error:', error.message);
        if (error.code === '28P01') {
            console.error('   Authentication failed. Check password in .env.local');
        }
        process.exit(1);
    } finally {
        await client.end();
    }
}

removeSmallCounties();

