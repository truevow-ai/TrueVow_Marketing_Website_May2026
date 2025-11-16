# 📊 Content Pillars Setup Guide

**For Non-Technical Users**

---

## 🎯 What Are Content Pillars?

Content pillars are the main categories or themes that organize your content strategy. Examples:
- Ethics & Compliance
- Zero-Knowledge Security
- Legal Tech Automation
- Practice Management
- Client Acquisition

These help you:
- ✅ Organize content in your calendar
- ✅ Plan automated content distribution
- ✅ Track what topics you're covering
- ✅ Balance your content mix

---

## 📋 Step 1: Run Database Migration

Before using content pillars, you need to create the database table.

### **In Supabase Dashboard:**

1. Go to **SQL Editor** (left sidebar)
2. Click **"+ New Query"**
3. **Copy and paste** the entire content from `supabase/content-pillars-migration.sql`
4. Click **"Run"**
5. You should see: "Content pillars table created successfully!"

---

## 🎨 Step 2: Use Content Pillars in Admin Form

### **Adding Content to a Pillar:**

1. Open: http://localhost:8000/admin/blog-manager.html
2. Fill out your content form
3. **Select Content Pillar** from the dropdown
4. Submit the form

### **Adding a New Content Pillar:**

1. Click the **"+" button** next to the Content Pillar dropdown
2. Fill in:
   - **Pillar Name** (required) - e.g., "Ethics & Compliance"
   - **Description** (optional) - Brief description
   - **Color** (optional) - For visual organization
3. Click **"Add Pillar"**
4. The new pillar will appear in the dropdown immediately!

---

## 📝 Default Content Pillars

The migration script creates these default pillars (you can customize them):

1. **Ethics & Compliance** - Legal ethics, bar compliance
2. **Zero-Knowledge Security** - Privacy-first architecture
3. **Legal Tech Automation** - Automating legal processes
4. **Practice Management** - Running a profitable law firm
5. **Client Acquisition** - Marketing and getting clients

---

## 🔧 Customizing Content Pillars

### **To Add More Default Pillars:**

Edit `supabase/content-pillars-migration.sql` and add more INSERT statements:

```sql
INSERT INTO content_pillars (name, description, color, display_order) VALUES
    ('Your New Pillar', 'Description here', '#HEXCOLOR', 6)
ON CONFLICT (name) DO NOTHING;
```

### **To Edit Existing Pillars:**

1. Go to Supabase Dashboard → Table Editor
2. Open `content_pillars` table
3. Edit the pillar name, description, or color
4. Save changes

---

## 🚀 Using Pillars for Content Calendar

Once content is tagged with pillars, you can:

1. **Query by pillar** to see all content in a category
2. **Balance your content mix** - see which pillars need more content
3. **Plan automated posting** - schedule content by pillar
4. **Track performance** - see which pillars perform best

### **Example Query:**

```sql
-- Get all content in "Ethics & Compliance" pillar
SELECT * FROM blog_content 
WHERE content_pillar_id = (
    SELECT id FROM content_pillars WHERE name = 'Ethics & Compliance'
)
AND status = 'published'
ORDER BY publish_date DESC;
```

---

## 🆘 Troubleshooting

### **"Content pillars table not found" Error:**

- Run the migration SQL script first (Step 1)

### **"No pillars found" in dropdown:**

- Click the "+" button to add your first pillar
- Or check if `is_active = true` in the database

### **Can't add new pillar:**

- Check browser console (F12) for errors
- Verify RLS policies allow INSERT on `content_pillars` table
- Make sure pillar name is unique

---

## 📌 Files Reference

- **Migration Script:** `supabase/content-pillars-migration.sql`
- **Admin Form:** `admin/blog-manager.html` (includes pillar dropdown)

---

**Ready to organize your content strategy!** 🎉

