# 🚀 Parallel Deployment Guide
**Task 1 + Task 2 Running Simultaneously**

---

## ⚡ **Quick Overview**

You'll have **2 browser tabs open**:
- **Tab 1:** TrueVow-Marketing-Website (deploying schema)
- **Tab 2:** TrueVow-Tenant-App-Development (running migration)

**Total Time:** 15-20 minutes (both running in parallel)

---

## 📋 **TASK 1: Deploy Marketing Schema** (Tab 1)

### **Step 1: Open Marketing Database**
1. Go to [Supabase Dashboard](https://supabase.com/dashboard)
2. Click on **`TrueVow-Marketing-Website`** project
3. Click **"SQL Editor"** in left sidebar
4. Click **"New query"** button

### **Step 2: Copy Schema File**
1. Open this file on your computer:
   ```
   C:\Users\yasha\OneDrive\Documents\TRUTHLINE\Cursor\2025-TrueVow-Website\supabase\migrations\001_phase1_website_schema.sql
   ```
2. Select ALL (Ctrl+A)
3. Copy (Ctrl+C)

### **Step 3: Paste and Run**
1. Go back to Supabase SQL Editor (Tab 1)
2. Paste (Ctrl+V)
3. Click **"Run"** button (bottom right)
4. **Wait 30-60 seconds** for completion

### **Step 4: Verify Success**
✅ You should see:
```
NOTICE: TrueVow Phase 1 Website Schema Migration Complete!
NOTICE: Tables created: 9
NOTICE: Views created: 2
NOTICE: Triggers created: 4
NOTICE: RLS policies: 19
```

**If successful:** Leave this tab open and move to Task 2!

---

## 🔄 **TASK 2: Migrate TruthLine Database** (Tab 2)

### **Method A: Supabase Backup/Restore** ✅ RECOMMENDED

#### **Part 1: Create Backup (5 minutes)**

1. Open NEW browser tab
2. Go to Supabase Dashboard
3. Click on **`TruthLine-Intake-Personal-Injury`** project
4. Click **"Database"** in left sidebar
5. Click **"Backups"** tab
6. Click **"Create backup now"** button
7. Enter name: `pre-migration-backup-nov-6`
8. Click **"Create backup"**
9. **Wait 2-5 minutes** (watch progress bar)
10. Once complete, you'll see the backup in the list

#### **Part 2: Download Backup**

11. Click **"..."** menu next to the backup
12. Click **"Download"**
13. Save file: `truthline-backup.sql.gz`
14. Wait for download to complete (~1-5 minutes depending on data size)

#### **Part 3: Restore to TrueVow Database**

15. In same browser window, click **"Projects"** (top left)
16. Click on **`TrueVow-Tenant-App-Development`** project
17. Click **"Database"** → **"Backups"** tab
18. Click **"Restore from backup"** button
19. Click **"Upload backup file"**
20. Select the `truthline-backup.sql.gz` file you just downloaded
21. Click **"Restore"**
22. **Wait 5-15 minutes** (progress bar will show status)

---

### **Method B: Manual SQL Export** (If Backup/Restore Unavailable)

If your Supabase plan doesn't have backup/restore:

1. In **TruthLine database**, SQL Editor
2. Run this query:
   ```sql
   -- Export all table definitions
   SELECT string_agg(
     'CREATE TABLE ' || schemaname || '.' || tablename || ' AS SELECT * FROM ' || 
     schemaname || '.' || tablename || ';',
     E'\n'
   ) FROM pg_tables WHERE schemaname = 'public';
   ```
3. Copy output
4. Go to **TrueVow database**, SQL Editor
5. Paste and run

---

## ✅ **Verification: Test Both Databases**

Once both tasks are complete, run test script:

```bash
cd C:\Users\yasha\OneDrive\Documents\TRUTHLINE\Cursor\2025-TrueVow-Website
node scripts/test-db-connections.js
```

### **Expected Output:**

```
1️⃣  Testing Marketing Website Database...
   ✅ CONNECTED: Marketing Website database is accessible
   📊 URL: https://napwpkagxzqfpbearkjs.supabase.co

2️⃣  Testing Tenant Application Database...
   ✅ CONNECTED: Tenant App database is accessible
   📊 URL: https://flhnyyreaxkmwmexchla.supabase.co

3️⃣  Testing SaaS Admin Database...
   ✅ But database connection works!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ ALL DATABASES ACCESSIBLE!
```

---

## 🎯 **Success Checklist**

### Task 1: Marketing Schema
- [ ] Opened TrueVow-Marketing-Website project
- [ ] Pasted 001_phase1_website_schema.sql into SQL Editor
- [ ] Clicked "Run"
- [ ] Saw success message (9 tables created)
- [ ] Can see tables: blog_content, newsletter_subscribers, etc.

### Task 2: TruthLine Migration
- [ ] Created backup in TruthLine database
- [ ] Downloaded backup file (.sql.gz)
- [ ] Uploaded backup to TrueVow-Tenant-App-Development
- [ ] Restore completed successfully
- [ ] Can see tables: contacts, appointments, calendar_*, etc.

### Final Verification
- [ ] Ran `node scripts/test-db-connections.js`
- [ ] All 3 databases show ✅ CONNECTED
- [ ] Marketing database has blog_content table
- [ ] Tenant database has contacts table

---

## 🚨 **Troubleshooting**

### **Issue: Marketing Schema Failed**
**Error:** "relation already exists"
**Solution:** Tables already exist, skip to verification

**Error:** "permission denied"
**Solution:** Check you're in correct database (TrueVow-Marketing-Website)

---

### **Issue: Backup/Restore Not Available**
**Solution:** Use Method B (Manual SQL Export) or upgrade Supabase plan

**Alternative:** Export tables one-by-one:
```sql
-- In TruthLine database
COPY (SELECT * FROM contacts) TO STDOUT WITH CSV HEADER;
```
Save output, then import in TrueVow database.

---

### **Issue: Restore Taking Too Long**
**Normal:** Restore can take 5-15 minutes for large databases
**Check Progress:** Look at progress bar in Supabase UI
**Wait Time:** Up to 30 minutes for databases with lots of data

---

## ⏱️ **Timeline**

| Time | Task 1 (Marketing) | Task 2 (Migration) |
|------|--------------------|--------------------|
| 0:00 | Open SQL Editor | Open TruthLine project |
| 0:30 | Paste schema | Create backup |
| 1:00 | Click Run | Wait for backup |
| 2:00 | ✅ Complete | Backup creating... |
| 5:00 | | Download backup |
| 7:00 | | Upload to TrueVow |
| 10:00 | | Restore running... |
| 15:00 | | ✅ Complete |
| 16:00 | Run test script | |
| 17:00 | ✅✅ Both Complete! | |

---

**Ready to start?** Open 2 browser tabs and let's go! 🚀

