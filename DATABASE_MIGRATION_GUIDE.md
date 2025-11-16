# 🔄 Database Migration Guide
## TruthLine-Intake-Personal-Injury → TrueVow-Tenant-App-Development

**Date:** November 6, 2025  
**Status:** Ready to Execute  
**Estimated Time:** 45-60 minutes  
**Risk Level:** Low (old database kept as backup)

---

## 📋 Pre-Migration Checklist

Before starting:
- [ ] **Backup critical data** - Download exports of key tables
- [ ] **Stop all applications** - Ensure no apps are writing to TruthLine database
- [ ] **Clear time window** - Ensure uninterrupted 1 hour for migration
- [ ] **Verify access** - Confirm you can access both Supabase projects

---

## 🎯 **STEP 1: Export Schema from TruthLine Database**

### 1.1 Access TruthLine Database

1. Go to Supabase dashboard
2. Click on **`TruthLine-Intake-Personal-Injury`** project
3. Click **"SQL Editor"** in left sidebar
4. Click **"New query"**

### 1.2 Export Full Schema

Run this SQL to get your complete schema:

```sql
-- Get all table definitions
SELECT 
    'CREATE TABLE ' || table_name || ' (' || 
    string_agg(
        column_name || ' ' || data_type || 
        CASE 
            WHEN character_maximum_length IS NOT NULL 
            THEN '(' || character_maximum_length || ')'
            ELSE ''
        END || 
        CASE 
            WHEN is_nullable = 'NO' THEN ' NOT NULL' 
            ELSE '' 
        END,
        ', '
    ) || ');' AS create_statement
FROM information_schema.columns
WHERE table_schema = 'public'
GROUP BY table_name
ORDER BY table_name;
```

**Copy all output** - this is your schema backup.

### 1.3 Export Table Relationships (Foreign Keys)

```sql
-- Get all foreign key constraints
SELECT 
    'ALTER TABLE ' || tc.table_name || 
    ' ADD CONSTRAINT ' || tc.constraint_name || 
    ' FOREIGN KEY (' || kcu.column_name || ')' ||
    ' REFERENCES ' || ccu.table_name || '(' || ccu.column_name || ')' ||
    CASE 
        WHEN rc.delete_rule = 'CASCADE' THEN ' ON DELETE CASCADE'
        WHEN rc.delete_rule = 'SET NULL' THEN ' ON DELETE SET NULL'
        ELSE ''
    END || ';' AS alter_statement
FROM information_schema.table_constraints AS tc 
JOIN information_schema.key_column_usage AS kcu
  ON tc.constraint_name = kcu.constraint_name
  AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage AS ccu
  ON ccu.constraint_name = tc.constraint_name
  AND ccu.table_schema = tc.table_schema
JOIN information_schema.referential_constraints AS rc
  ON rc.constraint_name = tc.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY' 
  AND tc.table_schema = 'public';
```

**Copy all output** - you'll run this after creating tables.

### 1.4 Export Indexes

```sql
-- Get all indexes
SELECT indexdef || ';' AS index_statement
FROM pg_indexes
WHERE schemaname = 'public'
  AND indexname NOT LIKE '%_pkey'  -- Exclude primary keys
ORDER BY tablename, indexname;
```

**Copy all output** - these improve performance.

---

## 📦 **STEP 2: Export Data from TruthLine Database**

### 2.1 Download Data as CSV (Small Tables)

For tables with < 1000 rows:

1. Click **"Table Editor"** in left sidebar
2. Select a table (e.g., `contacts`)
3. Click **"..."** menu (top right)
4. Select **"Download as CSV"**
5. Save file as `contacts.csv`

**Repeat for each table:**
- `contacts` → `contacts.csv`
- `addresses` → `addresses.csv`
- `appointments` → `appointments.csv`
- `audit_logs` → `audit_logs.csv`
- etc.

### 2.2 Export Large Tables via SQL (>1000 rows)

For large tables, use `pg_dump` (if available) or export in chunks:

```sql
-- Example: Export contacts in chunks
COPY (
    SELECT * FROM contacts 
    ORDER BY contact_id 
    LIMIT 10000
) TO STDOUT WITH CSV HEADER;
```

**Save output to file.**

### 2.3 Create Data Manifest

Create a file `data_manifest.txt` listing all tables and row counts:

```sql
-- Get row counts for all tables
SELECT 
    schemaname,
    tablename,
    n_live_tup AS row_count
FROM pg_stat_user_tables
WHERE schemaname = 'public'
ORDER BY n_live_tup DESC;
```

**Save this** - you'll verify row counts after migration.

---

## 📥 **STEP 3: Import into TrueVow-Tenant-App-Development**

### 3.1 Access TrueVow Database

1. Go to Supabase dashboard
2. Click on **`TrueVow-Tenant-App-Development`** project
3. Click **"SQL Editor"** in left sidebar

### 3.2 Import Schema (Tables First)

1. Copy the CREATE TABLE statements from Step 1.2
2. Paste into SQL Editor
3. Click **"Run"**

⚠️ **Run tables in dependency order:**
- Tables with NO foreign keys first (e.g., `contacts`, `api_keys`)
- Then tables that reference them (e.g., `addresses` references `contacts`)

**If you get errors about missing tables:**
- Look at the error message
- Create the referenced table first
- Then retry

### 3.3 Import Foreign Keys

1. Copy the ALTER TABLE statements from Step 1.3
2. Paste into SQL Editor
3. Click **"Run"**

### 3.4 Import Indexes

1. Copy the CREATE INDEX statements from Step 1.4
2. Paste into SQL Editor
3. Click **"Run"**

### 3.5 Import Data (CSV Upload)

For each CSV file:

1. Click **"Table Editor"** in left sidebar
2. Select the table (e.g., `contacts`)
3. Click **"Insert"** → **"Import from CSV"**
4. Upload the CSV file
5. Map columns (should auto-detect)
6. Click **"Import"**
7. **Verify row count** matches your manifest

**Repeat for all tables.**

### 3.6 Alternative: SQL INSERT Statements

If CSV upload fails, use SQL inserts:

```sql
-- Example: Insert contacts
INSERT INTO contacts (contact_id, prefix, first_name, middle_name, last_name, ...)
VALUES 
    ('uuid1', NULL, 'John', NULL, 'Doe', ...),
    ('uuid2', NULL, 'Lisa', NULL, 'Smith', ...);
```

---

## ✅ **STEP 4: Verify Migration**

### 4.1 Compare Row Counts

Run this in **both databases** and compare:

```sql
SELECT 
    tablename,
    n_live_tup AS row_count
FROM pg_stat_user_tables
WHERE schemaname = 'public'
ORDER BY tablename;
```

**TruthLine counts should match TrueVow counts exactly.**

### 4.2 Spot Check Data

For critical tables, verify a few records:

```sql
-- Check first 5 contacts
SELECT * FROM contacts ORDER BY created_at LIMIT 5;
```

**Compare output in both databases** - should be identical.

### 4.3 Test Relationships

Verify foreign keys work:

```sql
-- Test join between contacts and addresses
SELECT 
    c.first_name,
    c.last_name,
    a.street_address,
    a.city,
    a.state
FROM contacts c
LEFT JOIN addresses a ON c.contact_id = a.contact_id
LIMIT 10;
```

**If this returns data, foreign keys are working.**

### 4.4 Check Indexes

```sql
-- Verify indexes exist
SELECT 
    tablename,
    indexname
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;
```

**Count should match TruthLine database.**

---

## ⏸️ **STEP 5: Archive TruthLine Database**

### 5.1 Pause the Project (Don't Delete)

1. Go to **`TruthLine-Intake-Personal-Injury`** project
2. Click **"Settings"** (gear icon in left sidebar)
3. Click **"General"**
4. Scroll to **"Pause project"** section
5. Click **"Pause project"** button
6. Confirm

**Result:**
- ✅ Database preserved (no data loss)
- ✅ No charges while paused
- ✅ Can unpause anytime within 30 days
- ✅ Automatic deletion after 30 days of inactivity (Supabase policy)

### 5.2 Document Pause Date

Create a reminder:
```
TruthLine Database Paused: November 6, 2025
Auto-deletion: December 6, 2025 (if not unpaused)
```

**After 30 days:** If migration is successful, let it auto-delete OR manually delete.

---

## 🔄 **STEP 6: Update Application Configuration**

### 6.1 Update Environment Variables

In your application's `.env.local`:

**OLD (TruthLine):**
```bash
NEXT_PUBLIC_SUPABASE_URL=https://ehlxgvswsqjimnhmlvqx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=old-key-here
```

**NEW (TrueVow):**
```bash
NEXT_PUBLIC_SUPABASE_URL=https://flhnyyreaxkmwmexchla.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=new-key-here
```

**Get the new keys:**
1. Go to `TrueVow-Tenant-App-Development` project
2. Click **"Settings"** → **"API"**
3. Copy **Project URL** and **anon/public key**

### 6.2 Restart Your Application

```bash
# Stop current dev server
# Update .env.local
# Restart
npm run dev
```

### 6.3 Test Application

- [ ] Log in
- [ ] View contacts list
- [ ] Create new contact
- [ ] View appointments
- [ ] Check calendar
- [ ] Verify all CRUD operations work

---

## 🚨 **Rollback Plan (If Migration Fails)**

### If Something Goes Wrong:

**Step 1: Unpause TruthLine Database**
1. Go to `TruthLine-Intake-Personal-Injury` project
2. Settings → General → **"Resume project"**

**Step 2: Revert Environment Variables**
- Change `.env.local` back to old database URL/keys

**Step 3: Restart Application**
- Your app will reconnect to TruthLine database
- No data lost

**Step 4: Debug Migration Issue**
- Review error logs
- Fix schema issues
- Retry migration

---

## 📊 **Migration Checklist**

### Pre-Migration
- [ ] All apps stopped
- [ ] Schema exported from TruthLine
- [ ] Foreign keys exported
- [ ] Indexes exported
- [ ] Data exported (CSV files)
- [ ] Row counts documented

### During Migration
- [ ] Tables created in TrueVow database
- [ ] Foreign keys added
- [ ] Indexes created
- [ ] Data imported
- [ ] Row counts verified
- [ ] Spot checks passed
- [ ] Foreign key relationships tested

### Post-Migration
- [ ] Application `.env.local` updated
- [ ] Application tested (all features work)
- [ ] TruthLine database paused
- [ ] Team notified of new database
- [ ] Documentation updated

### 30 Days Later
- [ ] Confirm migration successful (no issues)
- [ ] Manually delete TruthLine database OR let it auto-delete

---

## 💡 **Tips & Best Practices**

### Tip 1: Migrate During Low-Traffic Hours
- Best time: Late night or weekend
- Minimize disruption to any testing

### Tip 2: Take Screenshots
- Screenshot TruthLine schema before export
- Screenshot row counts before export
- Compare with TrueVow after import

### Tip 3: Test Incrementally
- Migrate 5-10 tables at a time
- Test relationships after each batch
- Easier to debug if something fails

### Tip 4: Keep Credentials Secure
- Store old database credentials in password manager
- Keep for 60 days in case of emergency rollback

---

## 📞 **Support Resources**

**Supabase Documentation:**
- Migrations: https://supabase.com/docs/guides/database/migrations
- pg_dump: https://supabase.com/docs/guides/database/import-data

**If You Need Help:**
- Supabase Discord: https://discord.supabase.com
- Supabase Support: support@supabase.com

---

## ✅ **Migration Success Criteria**

**Migration is successful when:**
- ✅ All tables exist in TrueVow database
- ✅ Row counts match exactly
- ✅ All foreign keys work
- ✅ All indexes created
- ✅ Application connects and functions normally
- ✅ No data loss
- ✅ Performance is same or better

**Then you can safely:**
- ✅ Pause TruthLine database
- ✅ Continue development on TrueVow database
- ✅ Plan to delete TruthLine after 30 days

---

**Ready to start migration?** Follow the steps above in order. Good luck! 🚀

