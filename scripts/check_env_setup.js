// Check .env.local setup and guide user
const fs = require('fs');
const path = require('path');

const envFile = path.join(__dirname, '..', '.env.local');

console.log('🔍 Checking .env.local setup...\n');

if (!fs.existsSync(envFile)) {
    console.log('❌ .env.local file not found!');
    console.log('\n📝 Create .env.local file in project root with:');
    console.log(`
SUPABASE_DB_HOST=db.napwpkagxzqfpbearkjs.supabase.co
SUPABASE_DB_PORT=5432
SUPABASE_DB_NAME=postgres
SUPABASE_DB_USER=postgres
SUPABASE_DB_PASSWORD=your_password_here
`);
    console.log('💡 Get password from: Supabase Dashboard → Settings → Database');
    process.exit(1);
}

const envContent = fs.readFileSync(envFile, 'utf8');
const lines = envContent.split('\n').filter(line => line.trim() && !line.trim().startsWith('#'));

const envVars = {};
lines.forEach(line => {
    const match = line.match(/^([^=]+)=(.*)$/);
    if (match) {
        envVars[match[1].trim()] = match[2].trim();
    }
});

console.log('📋 Current .env.local variables:');
Object.keys(envVars).forEach(key => {
    const value = key.includes('PASSWORD') ? '***hidden***' : envVars[key];
    console.log(`   ✅ ${key} = ${value}`);
});

console.log('\n🔍 Checking required variables...\n');

// Check for both SUPABASE_ and MARKETING_ prefixed variables
const required = [
    { key: 'SUPABASE_DB_HOST', alt: 'MARKETING_DB_HOST', default: 'db.napwpkagxzqfpbearkjs.supabase.co' },
    { key: 'SUPABASE_DB_PORT', alt: 'MARKETING_DB_PORT', default: '5432' },
    { key: 'SUPABASE_DB_NAME', alt: 'MARKETING_DB_NAME', default: 'postgres' },
    { key: 'SUPABASE_DB_USER', alt: 'MARKETING_DB_USER', default: 'postgres' },
    { key: 'SUPABASE_DB_PASSWORD', alt: 'MARKETING_DATABASE_PASSWORD', default: null }
];

let missing = [];
required.forEach(({ key, alt, default: defaultValue }) => {
    const value = envVars[key] || envVars[alt];
    if (!value) {
        missing.push({ key, alt, defaultValue });
        console.log(`   ❌ ${key} (or ${alt}) - MISSING`);
    } else {
        const source = envVars[key] ? key : alt;
        console.log(`   ✅ ${key} - Found (using ${source})`);
    }
});

if (missing.length > 0) {
    console.log(`\n❌ Missing ${missing.length} required variable(s)\n`);
    console.log('📝 Add these to .env.local (or use MARKETING_ prefix):');
    missing.forEach(({ key, alt, defaultValue }) => {
        if (key === 'SUPABASE_DB_PASSWORD') {
            console.log(`   ${key}=your_database_password_here`);
            console.log(`   OR: ${alt}=your_database_password_here`);
            console.log('      💡 Get from: Supabase Dashboard → Settings → Database');
        } else {
            console.log(`   ${key}=${defaultValue}`);
            console.log(`   OR: ${alt}=${defaultValue}`);
        }
    });
    process.exit(1);
} else {
    console.log('\n✅ All required variables are set!');
    console.log('🚀 You can now run: npm run db:execute <sql-file>');
    console.log('🚀 Or: npm run db:populate');
}

