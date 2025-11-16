# 📊 Content Pillars Setup - Quick Guide

**Step-by-Step Instructions for Non-Technical Users**

---

## 🚀 Step 1: Run Database Migration (One-Time Setup)

**This only needs to be done once!**

1. **Open Supabase Dashboard:** https://supabase.com/dashboard
2. **Select your project:** `TrueVow-Marketing-Website`
3. **Click "SQL Editor"** (left sidebar)
4. **Click "+ New Query"**
5. **Open the file:** `supabase/content-pillars-migration.sql`
6. **Copy the entire file content** (Ctrl+A, then Ctrl+C)
7. **Paste into SQL Editor** (Ctrl+V)
8. **Click "Run"** button
9. **Verify success:** You should see "Content pillars table created successfully!"

---

## ✅ Step 2: Use Content Pillars in Admin Form

### **Adding Content with a Pillar:**

1. **Open admin form:** http://localhost:8000/admin/blog-manager.html
2. **Login** with password: `truevow2025`
3. **Fill out the form** as usual
4. **Select Content Pillar** from the dropdown (required field)
5. **Submit** the form

### **Adding a New Content Pillar:**

1. Click the **"+" button** (green button) next to the Content Pillar dropdown
2. **Fill in the form:**
   - **Pillar Name** (required) - e.g., "Ethics & Compliance"
   - **Description** (optional) - Brief description
   - **Color** (optional) - Click to pick a color for visual organization
3. **Click "Add Pillar"**
4. **Success!** The new pillar appears in the dropdown immediately
5. **Select it** and continue with your content form

---

## 📝 Default Content Pillars

After running the migration, you'll have these default pillars:

1. **Ethics & Compliance** - Legal ethics, bar compliance
2. **Zero-Knowledge Security** - Privacy-first architecture  
3. **Legal Tech Automation** - Automating legal processes
4. **Practice Management** - Running a profitable law firm
5. **Client Acquisition** - Marketing and getting clients

**You can add more using the "+" button!**

---

## 🎯 How Content Pillars Help

Content pillars help you:

- ✅ **Organize content** by strategic themes
- ✅ **Balance your content mix** - see which topics you're covering
- ✅ **Plan content calendar** - schedule content by pillar
- ✅ **Track performance** - see which pillars perform best
- ✅ **Automate distribution** - filter content by pillar for scheduling

---

## 🆘 Troubleshooting

### **"Content pillars table not found" Error:**

✅ **Solution:** Run the migration SQL script (Step 1 above)

### **"No pillars found" in dropdown:**

✅ **Solution:** Click the "+" button to add your first pillar

### **Can't add new pillar:**

1. Check browser console (F12 → Console) for errors
2. Make sure you ran the migration SQL
3. Verify the pillar name is unique (no duplicates)

---

## 📌 Files Reference

- **Migration Script:** `supabase/content-pillars-migration.sql`
- **Admin Form:** `admin/blog-manager.html` (includes pillar dropdown + button)
- **Setup Guide:** `HOW_TO_SETUP_CONTENT_PILLARS.md`

---

**Ready to organize your content strategy!** 🎉

**Next:** Run the migration SQL, then refresh the admin form!

