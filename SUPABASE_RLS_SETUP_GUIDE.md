# 🔐 Supabase RLS Policy Setup Guide

**For Non-Technical Users**  
**Status:** Step-by-step instructions with copy-paste SQL scripts

---

## 📋 What You Need to Do

We need to set up **3 security rules** (called "RLS Policies") so your website can:
1. ✅ **Display blog content** to visitors (read published articles/videos)
2. ✅ **Track analytics** (count views and clicks)
3. ⏭️ **Skip newsletter** (we're not using it right now)

---

## 🚀 Step-by-Step Instructions

### **STEP 1: Open Supabase Dashboard**

1. Go to: **https://supabase.com/dashboard**
2. **Sign in** to your account
3. Click on your project: **`TrueVow-Marketing-Website`** (or the project with URL `napwpkagxzqfpbearkjs`)

---

### **STEP 2: Open SQL Editor**

1. Look at the **left sidebar** menu
2. Find and click **"SQL Editor"** (it has an icon that looks like a terminal/code window)
3. You should see a big text box where you can type SQL commands

---

### **STEP 3: Copy and Paste SQL Scripts**

I've created **2 SQL scripts** for you. Follow these steps:

#### **Script 1: Allow Public to View Published Blog Content**

1. **Click the "+ New Query" button** (or create a new query)
2. **Copy the entire script below** (Ctrl+C or Cmd+C):
3. **Paste it into the SQL editor** (Ctrl+V or Cmd+V)
4. **Click "Run"** button (or press Ctrl+Enter)

```sql
-- ============================================
-- Policy 1: Allow public to view published blog content
-- ============================================

-- First, enable RLS on the table (if not already enabled)
ALTER TABLE blog_content ENABLE ROW LEVEL SECURITY;

-- Drop the policy if it already exists (to avoid errors)
DROP POLICY IF EXISTS "Public can view published content" ON blog_content;

-- Create the policy to allow public SELECT for published content
CREATE POLICY "Public can view published content"
ON blog_content
FOR SELECT
TO public
USING (status = 'published');

-- Verify it worked
SELECT * FROM pg_policies WHERE tablename = 'blog_content';
```

**What this does:** Allows anyone visiting your website to see blog posts that have `status = 'published'`. Draft posts won't be visible.

---

#### **Script 2: Allow Public to Insert Analytics Events**

1. **Create another new query** (click "+ New Query" again)
2. **Copy the entire script below**:
3. **Paste it into the SQL editor**
4. **Click "Run"** button

```sql
-- ============================================
-- Policy 2: Allow public to insert analytics events
-- ============================================

-- First, enable RLS on the table (if not already enabled)
ALTER TABLE blog_analytics ENABLE ROW LEVEL SECURITY;

-- Drop the policy if it already exists (to avoid errors)
DROP POLICY IF EXISTS "Public can insert analytics" ON blog_analytics;

-- Create the policy to allow public INSERT
CREATE POLICY "Public can insert analytics"
ON blog_analytics
FOR INSERT
TO public
WITH CHECK (true);

-- Verify it worked
SELECT * FROM pg_policies WHERE tablename = 'blog_analytics';
```

**What this does:** Allows your website to track when people view or click on blog posts. This is needed for analytics.

---

## ✅ How to Verify It Worked

After running each script, you should see a **success message** at the bottom saying something like:
- ✅ "Success. No rows returned" 
- ✅ Or a table showing the policy was created

**If you see an error:**
- Don't worry! The scripts are designed to work even if policies already exist
- Just let me know what the error message says

---

## 🧪 Test It Works

After setting up the policies, test your website:

1. **Open your blog page** (`marketing/blog.html` locally or after deployment)
2. **Check the browser console** (F12 → Console tab)
3. **Look for any errors** related to Supabase or permissions

**Expected behavior:**
- ✅ Blog content should load
- ✅ No permission errors in console
- ✅ Analytics tracking should work

---

## 📝 Summary Checklist

- [ ] Opened Supabase Dashboard
- [ ] Opened SQL Editor
- [ ] Ran Script 1 (blog_content policy)
- [ ] Ran Script 2 (blog_analytics policy)
- [ ] Verified both scripts ran successfully
- [ ] Tested website to confirm it works

---

## 🆘 Need Help?

If you get stuck:

1. **Take a screenshot** of the error message (if any)
2. **Tell me what step you're on**
3. **Describe what you see** in the Supabase dashboard

I can help troubleshoot!

---

## 📌 Quick Reference

**Supabase Dashboard:** https://supabase.com/dashboard  
**SQL Editor Location:** Left sidebar → "SQL Editor"  
**Project URL:** `https://napwpkagxzqfpbearkjs.supabase.co`

---

**Note:** We're skipping newsletter policies since you're not using that feature right now. You can set it up later if needed.

