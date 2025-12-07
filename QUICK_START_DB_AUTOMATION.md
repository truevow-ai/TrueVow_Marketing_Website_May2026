# Quick Start: Automated Database Updates

## One-Time Setup (2 minutes)

### 1. Install Dependencies
```bash
npm install
```

### 2. Get Database Password
- Go to: Supabase Dashboard → Settings → Database
- Copy the database password

### 3. Create `.env.local` File
```bash
SUPABASE_DB_HOST=db.napwpkagxzqfpbearkjs.supabase.co
SUPABASE_DB_PORT=5432
SUPABASE_DB_NAME=postgres
SUPABASE_DB_USER=postgres
SUPABASE_DB_PASSWORD=paste_your_password_here
```

## Usage

### Execute SQL Files
```bash
npm run db:execute supabase/CREATE_COUNTY_AVAILABILITY_TABLES.sql
npm run db:execute supabase/RENAME_ALL_TABLES_TO_WEB_PREFIX.sql
```

### Populate County Data
```bash
npm run db:populate
```
This automatically reads `marketing/county-cap.html` and populates the database.

## That's It!

Now all database updates are automated. No more manual SQL Editor needed! 🎉

