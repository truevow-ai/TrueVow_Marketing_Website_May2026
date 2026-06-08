const { Client } = require('pg');
const fs = require('fs');
require('dotenv').config({ path: '.env.local' });

const outputFile = 'validation_test.txt';

fs.writeFileSync(outputFile, 'Test script started\n');

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
        fs.appendFileSync(outputFile, 'Parsed connection string\n');
    } catch (e) {
        fs.appendFileSync(outputFile, 'Error parsing connection string: ' + e.message + '\n');
    }
}

SUPABASE_DB_HOST = SUPABASE_DB_HOST || process.env.MARKETING_DB_HOST || 'db.napwpkagxzqfpbearkjs.supabase.co';
SUPABASE_DB_PORT = SUPABASE_DB_PORT || parseInt(process.env.MARKETING_DB_PORT || '5432');
SUPABASE_DB_NAME = SUPABASE_DB_NAME || process.env.MARKETING_DB_NAME || 'postgres';
SUPABASE_DB_USER = SUPABASE_DB_USER || process.env.MARKETING_DB_USER || 'postgres';

const rawPassword = SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD;
SUPABASE_DB_PASSWORD = rawPassword;

if (rawPassword && rawPassword.includes('%')) {
    try {
        SUPABASE_DB_PASSWORD = decodeURIComponent(rawPassword);
        fs.appendFileSync(outputFile, 'Decoded password\n');
    } catch (e) {
        fs.appendFileSync(outputFile, 'Error decoding password: ' + e.message + '\n');
    }
}

fs.appendFileSync(outputFile, `Host: ${SUPABASE_DB_HOST}\n`);
fs.appendFileSync(outputFile, `Port: ${SUPABASE_DB_PORT}\n`);
fs.appendFileSync(outputFile, `Database: ${SUPABASE_DB_NAME}\n`);
fs.appendFileSync(outputFile, `User: ${SUPABASE_DB_USER}\n`);
fs.appendFileSync(outputFile, `Password: ${SUPABASE_DB_PASSWORD ? 'SET (' + SUPABASE_DB_PASSWORD.length + ' chars)' : 'NOT SET'}\n`);

if (!SUPABASE_DB_PASSWORD) {
    fs.appendFileSync(outputFile, 'ERROR: No password found\n');
    process.exit(1);
}

const client = new Client({
    host: SUPABASE_DB_HOST,
    port: SUPABASE_DB_PORT,
    database: SUPABASE_DB_NAME,
    user: SUPABASE_DB_USER,
    password: SUPABASE_DB_PASSWORD,
    ssl: { rejectUnauthorized: false },
    connectionTimeoutMillis: 10000
});

fs.appendFileSync(outputFile, 'Attempting connection...\n');

client.connect()
    .then(() => {
        fs.appendFileSync(outputFile, '✅ Connected successfully\n');
        return client.query('SELECT COUNT(*) as count FROM web_availability_county WHERE is_active = true');
    })
    .then(result => {
        fs.appendFileSync(outputFile, `Found ${result.rows[0].count} active counties\n`);
        return client.end();
    })
    .then(() => {
        fs.appendFileSync(outputFile, 'Connection closed\n');
        fs.appendFileSync(outputFile, 'Test complete\n');
    })
    .catch(error => {
        fs.appendFileSync(outputFile, 'ERROR: ' + error.message + '\n');
        fs.appendFileSync(outputFile, error.stack + '\n');
        process.exit(1);
    });

