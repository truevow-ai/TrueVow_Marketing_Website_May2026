# 🔧 How to Fix RLS Policy Errors

**Error:** "new row violates row-level security policy for table 'blog_content'"

---

## 🚀 Quick Fix

### **STEP 1: Run the Fix Script**

1. **Open Supabase Dashboard** → SQL Editor
2. **Open file:** `supabase/fix-all-rls-policies.sql`
3. **Copy the entire file** (Ctrl+A, then Ctrl+C)
4. **Paste into SQL Editor** (Ctrl+V)
5. **Click "Run"**
6. **Verify:** You should see policies listed at the bottom

---

## ✅ What This Fixes

1. ✅ **Adds INSERT policy** for `blog_content` table (allows admin form to add content)
2. ✅ **Fixes SQL syntax errors** (removes invalid "IF NOT EXISTS" from CREATE POLICY)
3. ✅ **Verifies all policies** are correct

---

## 📋 Policies Created

### **blog_content:**
- ✅ **SELECT:** Public can view published content
- ✅ **INSERT:** Public can insert content (for admin form)

### **blog_analytics:**
- ✅ **INSERT:** Public can insert analytics events

### **content_pillars:**
- ✅ **SELECT:** Public can view active pillars
- ✅ **INSERT:** Public can insert new pillars

---

## 🧪 Test After Fixing

1. **Refresh admin form:** http://localhost:8000/admin/blog-manager.html
2. **Fill out the form** and submit
3. **Should work!** No more RLS errors

---

**Run the script and try submitting content again!** 🚀

