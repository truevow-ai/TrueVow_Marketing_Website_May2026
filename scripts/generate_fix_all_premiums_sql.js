/**
 * Generate SQL to fix all premium calculations
 * Sets premium = ROUND(cap * 0.21) for all practice areas
 */

const { Client } = require('pg');
require('dotenv').config({ path: '.env.local' });

// Get connection details
let SUPABASE_DB_HOST, SUPABASE_DB_PORT, SUPABASE_DB_NAME, SUPABASE_DB_USER, SUPABASE_DB_PASSWORD;

const connectionString = process.env.SUPABASE_DB_URL || process.env.MARKETING_DATABASE_URL;
if (connectionString && connectionString.startsWith('postgresql://')) {
    try {
        const url = new URL(connectionString);
        SUPABASE_DB_USER = url.username || 'postgres';
        SUPABASE_DB_PASSWORD = url.password ? decodeURIComponent(url.password) : null;
        SUPABASE_DB_HOST = url.hostname;
        SUPABASE_DB_PORT = parseInt(url.port || '5432');
        SUPABASE_DB_NAME = url.pathname.slice(1) || 'postgres';
    } catch (e) {
        console.log(`⚠️  Could not parse connection string`);
    }
}

SUPABASE_DB_HOST = SUPABASE_DB_HOST || process.env.SUPABASE_DB_HOST || 'db.napwpkagxzqfpbearkjs.supabase.co';
SUPABASE_DB_PORT = SUPABASE_DB_PORT || parseInt(process.env.SUPABASE_DB_PORT || '5432');
SUPABASE_DB_NAME = SUPABASE_DB_NAME || process.env.SUPABASE_DB_NAME || 'postgres';
SUPABASE_DB_USER = SUPABASE_DB_USER || process.env.SUPABASE_DB_USER || 'postgres';
SUPABASE_DB_PASSWORD = SUPABASE_DB_PASSWORD || process.env.SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD;

async function generateFixSQL() {
    const client = new Client({
        host: SUPABASE_DB_HOST,
        port: SUPABASE_DB_PORT,
        database: SUPABASE_DB_NAME,
        user: SUPABASE_DB_USER,
        password: SUPABASE_DB_PASSWORD,
        ssl: { rejectUnauthorized: false }
    });
    
    await client.connect();
    
    try {
        // Get all practice area records
        const result = await client.query(`
            SELECT 
                pa.id,
                pa.county_availability_id,
                pa.practice_area_slug,
                pa.cap,
                pa.premium,
                pa.standard,
                pa.filled,
                ROUND(pa.cap * 0.21) as correct_premium,
                pa.cap - ROUND(pa.cap * 0.21) as correct_standard
            FROM web_availability_practice_area_seats pa
            WHERE pa.is_active = true
            AND pa.cap > 0
            ORDER BY pa.county_availability_id, pa.display_order
        `);
        
        let sql = `-- Fix All Premium Calculations
-- Generated: ${new Date().toISOString()}
-- This script sets premium = ROUND(cap * 0.21) for all practice areas
-- Standard = cap - premium

BEGIN;

`;

        let updateCount = 0;
        for (const row of result.rows) {
            const correctPremium = parseInt(row.correct_premium);
            const correctStandard = parseInt(row.correct_standard);
            
            // Only update if premium is wrong
            if (row.premium !== correctPremium) {
                sql += `-- Fixing ${row.practice_area_slug}: cap=${row.cap}, old_premium=${row.premium}, new_premium=${correctPremium}
UPDATE web_availability_practice_area_seats
SET 
    premium = ${correctPremium},
    standard = ${correctStandard},
    premium_remaining = GREATEST(0, ${correctPremium} - ROUND(filled * (${correctPremium}::numeric / NULLIF(cap, 0)))),
    standard_remaining = GREATEST(0, ${correctStandard} - ROUND(filled * (${correctStandard}::numeric / NULLIF(cap, 0))))
WHERE id = '${row.id}';

`;
                updateCount++;
            }
        }
        
        sql += `COMMIT;

-- Summary: Updated ${updateCount} practice area records
`;
        
        const fs = require('fs');
        fs.writeFileSync('supabase/FIX_ALL_PREMIUM_CALCULATIONS.sql', sql);
        
        console.log(`✅ Generated SQL file: supabase/FIX_ALL_PREMIUM_CALCULATIONS.sql`);
        console.log(`   Will update ${updateCount} practice area records`);
        console.log(`   Premium will be set to exactly 21% of each cap (rounded)`);
        
    } finally {
        await client.end();
    }
}

generateFixSQL().catch(console.error);

