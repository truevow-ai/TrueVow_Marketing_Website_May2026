// Direct fix for Baker County - force the correct values
const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

let SUPABASE_DB_HOST, SUPABASE_DB_PORT, SUPABASE_DB_NAME, SUPABASE_DB_USER, SUPABASE_DB_PASSWORD;
let decodedPassword = null;

const connectionString = process.env.SUPABASE_DB_URL || process.env.MARKETING_DATABASE_URL;
if (connectionString && connectionString.startsWith('postgresql://')) {
    try {
        const url = new URL(connectionString);
        SUPABASE_DB_USER = url.username || 'postgres';
        SUPABASE_DB_PASSWORD = url.password ? decodeURIComponent(url.password) : null;
        SUPABASE_DB_HOST = url.hostname;
        SUPABASE_DB_PORT = parseInt(url.port || '5432');
        SUPABASE_DB_NAME = url.pathname.slice(1) || 'postgres';
    } catch (e) {}
}

SUPABASE_DB_HOST = SUPABASE_DB_HOST || process.env.MARKETING_DB_HOST || 'db.napwpkagxzqfpbearkjs.supabase.co';
SUPABASE_DB_PORT = SUPABASE_DB_PORT || parseInt(process.env.MARKETING_DB_PORT || '5432');
SUPABASE_DB_NAME = SUPABASE_DB_NAME || process.env.MARKETING_DB_NAME || 'postgres';
SUPABASE_DB_USER = SUPABASE_DB_USER || process.env.MARKETING_DB_USER || 'postgres';

const rawPassword = SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD;
SUPABASE_DB_PASSWORD = rawPassword;

if (rawPassword && rawPassword.includes('%')) {
    try {
        decodedPassword = decodeURIComponent(rawPassword);
    } catch (e) {}
}

async function tryConnection(password) {
    const testClient = new Client({
        host: SUPABASE_DB_HOST,
        port: SUPABASE_DB_PORT,
        database: SUPABASE_DB_NAME,
        user: SUPABASE_DB_USER,
        password: password,
        ssl: { rejectUnauthorized: false },
        connectionTimeoutMillis: 30000
    });
    await testClient.connect();
    return testClient;
}

async function directFixBaker() {
    let client;
    
    try {
        console.log('🔌 Connecting...');
        try {
            client = await tryConnection(SUPABASE_DB_PASSWORD);
        } catch (firstError) {
            if (decodedPassword && firstError.code === '28P01') {
                client = await tryConnection(decodedPassword);
            } else {
                throw firstError;
            }
        }
        console.log('✅ Connected\n');

        // Get Baker County
        const countyResult = await client.query(`
            SELECT id, total_firms, total_seats
            FROM web_availability_county
            WHERE county_slug = 'baker' AND state_code = 'FL' AND is_active = true
        `);

        if (countyResult.rows.length === 0) {
            console.log('❌ Baker County not found in database!');
            await client.end();
            return;
        }

        const county = countyResult.rows[0];
        console.log(`Current Baker County:`);
        console.log(`  Total Firms: ${county.total_firms}`);
        console.log(`  Total Seats: ${county.total_seats}`);
        console.log(`  Expected: ${Math.round(county.total_firms * 0.33)}`);
        console.log('');

        // Calculate correct values
        const totalFirms = county.total_firms; // Should be 8
        const maxTotalSeats = Math.max(2, Math.round(totalFirms * 0.33)); // Should be 2-3
        
        console.log(`Calculating correct values:`);
        console.log(`  Total Firms: ${totalFirms}`);
        console.log(`  Max Total Seats (33%): ${maxTotalSeats}`);
        console.log('');

        // Get practice areas
        const paResult = await client.query(`
            SELECT id, practice_area_slug, total_firms, cap
            FROM web_availability_practice_area_seats
            WHERE county_availability_id = $1 AND is_active = true
            ORDER BY display_order
        `, [county.id]);

        console.log(`Practice Areas: ${paResult.rows.length}`);
        
        // Calculate proportional caps
        let totalPAFirms = paResult.rows.reduce((sum, pa) => sum + pa.total_firms, 0);
        if (totalPAFirms === 0) totalPAFirms = totalFirms; // Fallback
        
        let totalCaps = 0;
        const updates = [];
        
        for (const pa of paResult.rows) {
            const percentage = pa.total_firms / totalPAFirms;
            let newCap = Math.round(maxTotalSeats * percentage);
            if (newCap === 0 && pa.total_firms > 0) newCap = 1;
            
            const newPremium = newCap >= 5 ? Math.max(1, Math.round(newCap * 0.21)) : 0;
            const newStandard = newCap - newPremium;
            const newFilled = Math.max(0, Math.round(newCap * 0.12));
            
            updates.push({
                id: pa.id,
                cap: newCap,
                premium: newPremium,
                standard: newStandard,
                filled: newFilled,
                premiumRemaining: Math.max(0, newPremium - Math.round(newPremium * 0.12)),
                standardRemaining: Math.max(0, newStandard - Math.round(newStandard * 0.12))
            });
            
            totalCaps += newCap;
            console.log(`  ${pa.practice_area_slug}: ${pa.total_firms} firms → ${newCap} seats`);
        }
        
        // Ensure total doesn't exceed max
        if (totalCaps > maxTotalSeats) {
            const scale = maxTotalSeats / totalCaps;
            totalCaps = 0;
            for (const update of updates) {
                update.cap = Math.max(1, Math.round(update.cap * scale));
                update.premium = update.cap >= 5 ? Math.max(1, Math.round(update.cap * 0.21)) : 0;
                update.standard = update.cap - update.premium;
                update.filled = Math.max(0, Math.round(update.cap * 0.12));
                update.premiumRemaining = Math.max(0, update.premium - Math.round(update.premium * 0.12));
                update.standardRemaining = Math.max(0, update.standard - Math.round(update.standard * 0.12));
                totalCaps += update.cap;
            }
        }
        
        console.log(`\nTotal Caps: ${totalCaps}`);
        console.log(`Max Allowed: ${maxTotalSeats}`);
        console.log('');

        // Update practice areas
        console.log('Updating practice areas...');
        for (const update of updates) {
            await client.query(`
                UPDATE web_availability_practice_area_seats
                SET 
                    cap = $1,
                    premium = $2,
                    standard = $3,
                    filled = $4,
                    premium_remaining = $5,
                    standard_remaining = $6,
                    updated_at = NOW()
                WHERE id = $7
            `, [
                update.cap,
                update.premium,
                update.standard,
                update.filled,
                update.premiumRemaining,
                update.standardRemaining,
                update.id
            ]);
        }

        // Update county totals
        const finalPremium = updates.reduce((sum, u) => sum + u.premium, 0);
        const finalStandard = updates.reduce((sum, u) => sum + u.standard, 0);
        const finalFilled = updates.reduce((sum, u) => sum + u.filled, 0);
        const finalPremiumRemaining = updates.reduce((sum, u) => sum + u.premiumRemaining, 0);
        const finalStandardRemaining = updates.reduce((sum, u) => sum + u.standardRemaining, 0);

        await client.query(`
            UPDATE web_availability_county
            SET 
                total_seats = $1,
                premium_total = $2,
                standard_total = $3,
                filled = $4,
                premium_remaining = $5,
                standard_remaining = $6,
                updated_at = NOW()
            WHERE id = $7
        `, [
            totalCaps,
            finalPremium,
            finalStandard,
            finalFilled,
            finalPremiumRemaining,
            finalStandardRemaining,
            county.id
        ]);

        console.log('✅ Baker County fixed!');
        console.log(`   New Total Seats: ${totalCaps} (was ${county.total_seats})`);

        await client.end();

    } catch (error) {
        console.error('❌ Error:', error.message);
        console.error(error.stack);
        if (client) {
            await client.end().catch(() => {});
        }
        process.exit(1);
    }
}

directFixBaker();

