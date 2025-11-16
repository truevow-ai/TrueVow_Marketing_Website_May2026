# 📖 How to Set Up RLS Policies (Step-by-Step)

**For Non-Technical Users**  
**Time:** 5 minutes  
**Difficulty:** Easy - Just copy and paste!

---

## 🎯 What We're Doing

Setting up 2 security rules so your website can:
1. ✅ Show blog posts to visitors
2. ✅ Track analytics (views and clicks)

**We're skipping newsletter** since you're not using it right now.

---

## 📝 Step-by-Step Instructions

### **STEP 1: Open Supabase Dashboard**

1. Go to your web browser
2. Visit: **https://supabase.com/dashboard**
3. Sign in if needed
4. Click on your project (should say something like "TrueVow" or show URL `napwpkagxzqfpbearkjs`)

**✅ You should now see your project dashboard**

---

### **STEP 2: Open SQL Editor**

1. Look at the **left sidebar** (the menu on the left side of the screen)
2. Find **"SQL Editor"** - it has an icon that looks like a code/terminal window
3. Click on it

**✅ You should now see a big text box where you can type SQL**

---

### **STEP 3: Run Script 1 (Blog Content Policy)**

1. **Click the "+ New Query" button** (usually at the top left of the SQL editor)

2. **Open the file:** `supabase/script-1-blog-content-policy.sql` in this folder
   - Or copy this code:

```sql
-- Enable RLS on blog_content table
ALTER TABLE blog_content ENABLE ROW LEVEL SECURITY;

-- Drop existing policy if it exists
DROP POLICY IF EXISTS "Public can view published content" ON blog_content;

-- Create policy to allow public SELECT for published content only
CREATE POLICY "Public can view published content"
ON blog_content
FOR SELECT
TO public
USING (status = 'published');

-- Verify it worked
SELECT 
    tablename,
    policyname,
    cmd as command
FROM pg_policies 
WHERE tablename = 'blog_content';
```

3. **Select ALL the text above** (click and drag, or press Ctrl+A / Cmd+A)
4. **Copy it** (Ctrl+C / Cmd+C)
5. **Paste it into the SQL editor** (Ctrl+V / Cmd+V)
6. **Click the "Run" button** (usually at the bottom right, or press Ctrl+Enter)

**✅ You should see:**
- A success message saying "Success"
- A table showing the policy was created
- No error messages

---

### **STEP 4: Run Script 2 (Analytics Policy)**

1. **Click "+ New Query" again** to create a new query

2. **Open the file:** `supabase/script-2-analytics-policy.sql` in this folder
   - Or copy this code:

```sql
-- Enable RLS on blog_analytics table
ALTER TABLE blog_analytics ENABLE ROW LEVEL SECURITY;

-- Drop existing policy if it exists
DROP POLICY IF EXISTS "Public can insert analytics" ON blog_analytics;

-- Create policy to allow public INSERT for analytics tracking
CREATE POLICY "Public can insert analytics"
ON blog_analytics
FOR INSERT
TO public
WITH CHECK (true);

-- Verify it worked
SELECT 
    tablename,
    policyname,
    cmd as command
FROM pg_policies 
WHERE tablename = 'blog_analytics';
```

3. **Select ALL the text above**
4. **Copy it**
5. **Paste it into the SQL editor**
6. **Click "Run"**

**✅ You should see:**
- Success message
- A table showing the analytics policy was created

---

## ✅ You're Done!

Both policies are now set up. Your website should be able to:
- ✅ Display blog posts to visitors
- ✅ Track analytics events

---

## 🧪 Test It Works

1. Open your blog page (`marketing/blog.html` locally or after deployment)
2. Press **F12** to open browser developer tools
3. Click the **"Console"** tab
4. Look for any **red error messages**

**Expected:** No errors about permissions or Supabase access.

---

## 🆘 Troubleshooting

### **If you see an error:**

**Error: "relation does not exist"**
- Make sure you're in the correct Supabase project
- Check that the table names are correct: `blog_content` and `blog_analytics`

**Error: "permission denied"**
- You might not have admin access to the project
- Contact your Supabase project owner for admin access

**Error: "already exists"**
- This is fine! The script will replace the existing policy
- Just continue - it should still work

### **If you're not sure what to do:**

1. **Take a screenshot** of what you see
2. **Copy the error message** (if any)
3. **Tell me what step you're on**
4. I can help you fix it!

---

## 📋 Quick Checklist

- [ ] Opened Supabase Dashboard
- [ ] Opened SQL Editor
- [ ] Created new query
- [ ] Ran Script 1 (blog_content)
- [ ] Saw success message for Script 1
- [ ] Created another new query
- [ ] Ran Script 2 (blog_analytics)
- [ ] Saw success message for Script 2
- [ ] Tested website - no errors

---

## 📌 Files Reference

- **`supabase/script-1-blog-content-policy.sql`** - Script 1
- **`supabase/script-2-analytics-policy.sql`** - Script 2
- **`supabase/rls-policies.sql`** - Both scripts combined (if you prefer)

---

**Need help?** Let me know what you see or where you're stuck! 🚀

