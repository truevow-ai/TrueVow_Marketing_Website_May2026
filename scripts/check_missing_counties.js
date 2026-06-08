require('dotenv').config({ path: '.env.local' });
const { Client } = require('pg');

const url = process.env.MARKETING_DATABASE_URL || '';
const match = url.match(/postgresql:\/\/([^:]+):([^@]+)@([^:]+):(\d+)\/(.+)/);

if (!match) {
    console.error('No connection string');
    process.exit(1);
}

const [, user, pass, host, port, database] = match;
const decodedPass = decodeURIComponent(pass);

const client = new Client({
    host,
    port,
    database,
    user,
    password: decodedPass
});

async function check() {
    try {
        await client.connect();
        console.log('✅ Connected\n');
        
        // Check if Baker and other small counties exist
        const smallCounties = ['baker', 'calhoun', 'hardee', 'glades', 'suwannee', 'hamilton', 'lafayette', 'franklin', 'union', 'gilchrist'];
        
        console.log('🔍 Checking small counties:\n');
        
        for (const slug of smallCounties) {
            const result = await client.query(
                `SELECT county_name, total_firms, total_seats, is_active
                 FROM web_availability_county 
                 WHERE state_code = 'FL' AND county_slug = $1`,
                [slug]
            );
            
            if (result.rows.length > 0) {
                const c = result.rows[0];
                console.log(`✅ ${c.county_name.padEnd(20)} (${slug}): ${c.total_firms} firms, ${c.total_seats} seats, active: ${c.is_active}`);
            } else {
                console.log(`❌ ${slug.padEnd(20)}: NOT FOUND in database`);
            }
        }
        
        // Check total Florida counties
        const total = await client.query(
            `SELECT COUNT(*) as count FROM web_availability_county WHERE state_code = 'FL'`
        );
        console.log(`\n📊 Total Florida counties in database: ${total.rows[0].count}`);
        
        // Check active vs inactive
        const active = await client.query(
            `SELECT COUNT(*) as count FROM web_availability_county WHERE state_code = 'FL' AND is_active = true`
        );
        console.log(`📊 Active Florida counties: ${active.rows[0].count}`);
        
        // Check Calhoun practice areas
        console.log('\n🔍 Calhoun County Practice Areas:');
        const calhounPA = await client.query(
            `SELECT pas.practice_area_slug, pas.practice_area_name, pas.cap, pas.premium, pas.standard
             FROM web_availability_practice_area_seats pas
             INNER JOIN web_availability_county c ON pas.county_availability_id = c.id
             WHERE c.state_code = 'FL' AND c.county_slug = 'calhoun'
             ORDER BY pas.display_order`
        );
        
        calhounPA.rows.forEach(pa => {
            console.log(`  ${pa.practice_area_name.padEnd(25)}: cap=${pa.cap}, premium=${pa.premium}, standard=${pa.standard}`);
        });
        
        await client.end();
        console.log('\n✅ Done');
        
    } catch (err) {
        console.error('❌ Error:', err.message);
        await client.end();
        process.exit(1);
    }
}

check();

