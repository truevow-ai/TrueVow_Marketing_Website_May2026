# 🔄 Simple Database Migration (No Backup Feature Needed)
**Works on Supabase Free Tier**

---

## ⚡ **Quick Summary**

Instead of backup/restore, we'll:
1. Export schema as SQL (2 minutes)
2. Run schema in new database (1 minute)
3. Copy data table-by-table (5-10 minutes depending on data size)

**Total Time:** 10-15 minutes

---

## 📋 **STEP 1: Export Schema from TruthLine** (2 minutes)

### **1A. Run Export Script**

1. Open **TruthLine-Intake-Personal-Injury** in Supabase
2. Click **SQL Editor** → **New query**
3. Open file: `supabase/EXPORT_TRUTHLINE_SCHEMA.sql`
4. Copy ALL contents
5. Paste into Supabase SQL Editor
6. Click **"Run"**

### **1B. Copy Output**

You'll see output like:
```sql
-- Table: contacts
CREATE TABLE IF NOT EXISTS contacts (
    contact_id UUID NOT NULL DEFAULT uuid_generate_v4(),
    first_name VARCHAR(100) NOT NULL,
    ...
);

-- Table: appointments
CREATE TABLE IF NOT EXISTS appointments (
    ...
);
```

7. **Copy EVERYTHING** from the output window
8. Save to file: `truthline_schema_export.sql`

---

## 📋 **STEP 2: Import Schema to TrueVow** (1 minute)

1. Open **TrueVow-Tenant-App-Development** in Supabase
2. Click **SQL Editor** → **New query**
3. Paste the schema export (from step 1B)
4. Click **"Run"**

✅ **All tables are now created!**

---

## 📋 **STEP 3: Check Your Data Size** (30 seconds)

Before copying data, let's see how much you have:

1. In **TruthLine** database, SQL Editor
2. Run this:

```sql
SELECT 
    tablename,
    n_live_tup AS row_count
FROM pg_stat_user_tables
WHERE schemaname = 'public'
  AND n_live_tup > 0
ORDER BY n_live_tup DESC;
```

**This shows which tables have data and how many rows.**

---

## 📋 **STEP 4: Copy Data** (Method depends on data size)

### **Method A: Small Data (< 100 rows per table)** ✅ EASIEST

For each table with data:

#### **Using Table Editor:**
1. In **TruthLine**, go to **Table Editor**
2. Click on table (e.g., `contacts`)
3. Select all rows:
   - Click first row
   - Scroll to last row
   - Shift+Click last row
   - Or use "Select all" if available
4. Copy data (Ctrl+C or right-click → Copy)
5. Go to **TrueVow** database, same table
6. Click **"Insert"** → **"Insert row"**
7. Paste data (Ctrl+V)
8. Click **"Save"**

Repeat for each table that has data.

---

### **Method B: Medium Data (100-1000 rows)** 

Use SQL INSERT generation:

1. In **TruthLine** database, for each table run:

```sql
-- Example for contacts table
-- Replace 'contacts' with actual table name
DO $$
DECLARE
    row_record RECORD;
    insert_stmt TEXT;
BEGIN
    FOR row_record IN 
        SELECT * FROM contacts
        LIMIT 1000  -- Process in batches if needed
    LOOP
        -- This generates INSERT statements
        -- (simplified - actual query would build proper INSERT)
        RAISE NOTICE 'INSERT INTO contacts VALUES (...);';
    END LOOP;
END $$;
```

2. Copy output
3. Run in **TrueVow** database

---

### **Method C: Large Data (> 1000 rows)** 

For large tables, export as CSV:

1. In **TruthLine**, Table Editor
2. Click table
3. Click **"..."** menu (top right)
4. Click **"Download as CSV"**
5. Save file
6. In **TrueVow**, same table
7. Click **"Insert"** → **"Import from CSV"**
8. Upload CSV file
9. Map columns
10. Click **"Import"**

---

## 📋 **STEP 5: Verify Migration** (2 minutes)

### **5A. Compare Row Counts**

Run this in **both databases** and compare:

```sql
SELECT 
    tablename,
    n_live_tup AS row_count
FROM pg_stat_user_tables
WHERE schemaname = 'public'
ORDER BY tablename;
```

**Numbers should match!**

### **5B. Spot Check Data**

Pick a critical table (e.g., `contacts`) and run in both:

```sql
SELECT * FROM contacts ORDER BY created_at LIMIT 5;
```

**Data should be identical.**

### **5C. Run Connection Test**

```bash
cd C:\Users\yasha\OneDrive\Documents\TRUTHLINE\Cursor\2025-TrueVow-Website
node scripts/test-db-connections.js
```

Should show:
```
2️⃣  Testing Tenant Application Database...
   ✅ CONNECTED: Tenant App database is accessible
```

---

## 🎯 **Quick Decision Tree**

**How many rows of data do you have?**

- **< 100 total rows** → Method A (Table Editor copy/paste) - 5 minutes
- **100-1000 rows** → Method B (SQL INSERT) or CSV export - 10 minutes
- **> 1000 rows** → Method C (CSV export/import per table) - 20 minutes

**Don't know?** Run Step 3 to check!

---

## ❓ **Which Method Should You Use?**

From your screenshot earlier, I saw:
- `contacts` table: 9 records

**This suggests small data → Use Method A** ✅

**Estimated time for your database:** 5-10 minutes total

---

## 🚀 **Let's Start!**

**Tell me:**
1. Did you run Step 1 (schema export) successfully?
2. How many tables have data? (from Step 3 query)
3. Which method do you want to use for data copy?

Or just say "auto" and I'll guide you through Method A (easiest)! 🎯

