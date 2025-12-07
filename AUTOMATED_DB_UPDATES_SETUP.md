# Automated Database Updates Setup

## Overview

This setup allows you to automatically execute SQL files and populate database tables without manual intervention.

## Quick Setup (5 minutes)

### Step 1: Install Dependencies

```bash
npm install pg dotenv
```

### Step 2: Get Database Password

1. Go to Supabase Dashboard → Settings → Database
2. Find "Connection string" section
3. Copy the password (or reset it if needed)
4. The connection string looks like: `postgresql://postgres:[YOUR-PASSWORD]@db.napwpkagxzqfpbearkjs.supabase.co:5432/postgres`

### Step 3: Create `.env.local` File

Create `.env.local` in project root:

```bash
SUPABASE_DB_HOST=db.napwpkagxzqfpbearkjs.supabase.co
SUPABASE_DB_PORT=5432
SUPABASE_DB_NAME=postgres
SUPABASE_DB_USER=postgres
SUPABASE_DB_PASSWORD=your_actual_password_here
```

**Important:** Add `.env.local` to `.gitignore` to keep password secure!

### Step 4: Test Connection

```bash
node scripts/execute_sql_to_supabase.js supabase/CREATE_COUNTY_AVAILABILITY_TABLES.sql
```

## Usage

### Execute Any SQL File

```bash
node scripts/execute_sql_to_supabase.js <path-to-sql-file>
```

Examples:
```bash
# Create tables
node scripts/execute_sql_to_supabase.js supabase/CREATE_COUNTY_AVAILABILITY_TABLES.sql

# Rename tables
node scripts/execute_sql_to_supabase.js supabase/RENAME_ALL_TABLES_TO_WEB_PREFIX.sql

# Populate county data
node scripts/populate_county_data.js
```

### Populate County Data Automatically

This script reads from `marketing/county-cap.html` and populates the database:

```bash
node scripts/populate_county_data.js
```

This will:
1. Extract `practiceAreaData` from HTML
2. Insert all counties into `web_availability_county`
3. Insert all practice areas into `web_availability_practice_area_seats`
4. Use `ON CONFLICT` to update existing records

## Continuous Updates

Once set up, you can:

1. **Update HTML file** → Run `node scripts/populate_county_data.js` → Database updates automatically
2. **Create new SQL migration** → Run `node scripts/execute_sql_to_supabase.js <file>` → Executes immediately
3. **No manual SQL Editor needed** → Everything automated

## Troubleshooting

### "SUPABASE_DB_PASSWORD not found"
- Check `.env.local` exists in project root
- Verify password is correct (no quotes needed)
- Get password from Supabase Dashboard → Settings → Database

### "Connection timeout"
- Check your internet connection
- Verify database host is correct
- Try resetting database password in Supabase

### "Authentication failed"
- Password is incorrect
- Get fresh password from Supabase Dashboard

## Security Notes

- ✅ `.env.local` is in `.gitignore` (password stays local)
- ✅ Uses SSL connection (secure)
- ✅ Password never logged or displayed
- ❌ Never commit `.env.local` to git

