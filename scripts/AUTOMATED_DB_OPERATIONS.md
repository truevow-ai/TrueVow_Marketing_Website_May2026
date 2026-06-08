# Automated Database Operations

## ✅ Database Connection Established

The database connection is **fully automated** and working. All SQL migrations and database operations should be executed automatically using the scripts below.

**Connection Details:**
- **Host:** db.napwpkagxzqfpbearkjs.supabase.co
- **Database:** postgres
- **User:** postgres
- **Password:** Extracted from `MARKETING_DATABASE_URL` in `.env.local`
- **Status:** ✅ Connected and verified

---

## 🚀 Automated Commands

### Execute SQL Files
```bash
npm run db:execute supabase/<filename>.sql
```

**Examples:**
```bash
# Add columns to tables
npm run db:execute supabase/ADD_ZIPCODE_TO_FIRM_APPLICATIONS.sql

# Create tables
npm run db:execute supabase/CREATE_COUNTY_AVAILABILITY_TABLES.sql

# Populate data
npm run db:populate
```

### Populate County Data
```bash
npm run db:populate
```
Reads `marketing/county-cap.html` and populates `web_availability_county` and `web_availability_practice_area_seats` tables.

---

## 📋 Available Scripts

1. **`scripts/execute_sql_to_supabase.js`**
   - Executes any SQL file directly to Supabase
   - Handles connection string extraction
   - Automatic password decoding
   - Error handling and validation

2. **`scripts/populate_county_data.js`**
   - Reads HTML file for county data
   - Generates and executes INSERT statements
   - Idempotent (safe to run multiple times)

3. **`scripts/generate_populate_sql.js`**
   - Generates SQL file from HTML data
   - For manual review or execution

---

## ⚠️ Important Notes

- **NEVER ask user to execute SQL manually** - Always use automated scripts
- Connection is established automatically from `.env.local`
- All operations are logged with clear success/error messages
- Scripts handle idempotency (safe to rerun)

---

## 🔧 Troubleshooting

If connection fails:
1. Check `.env.local` has `MARKETING_DATABASE_URL`
2. Verify password in connection string is current
3. Script will show detailed error messages

---

**Last Verified:** 2025-11-29
**Status:** ✅ Fully Automated

