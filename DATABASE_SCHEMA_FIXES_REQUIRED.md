# 🔧 Database Schema Fixes Required

**Date:** January 8, 2026  
**Status:** ✅ VERIFIED - CRITICAL DISCREPANCIES FOUND  
**Action Required:** Update code to match actual database schema

---

## ❌ CRITICAL DISCREPANCIES FOUND

### **1. Blog Content Table**

**Code Uses:** `content_items` ❌  
**Database Has:** `blog_content` ✅

**Files That Need Updating:**
- `js/blog-content.js` (line 28)
- `lib/supabaseClient.ts` (line 97, 107)
- `components/admin/AddContentForm.tsx` (line 97)
- `admin/blog-manager.html` (line 558)
- `pages/api/blog/content.ts` (references `getPublishedContent` which uses wrong table)

---

### **2. Analytics Table**

**Code Uses:** `content_analytics` ❌  
**Database Has:** `blog_analytics` ✅

**Files That Need Updating:**
- `js/blog-content.js` (line 74)
- `lib/supabaseClient.ts` (line 146)
- `pages/api/blog/track.ts` (references `trackContentAnalytics` which uses wrong table)

---

### **3. Newsletter Table**

**Code Uses:** `notify_list` ❌  
**Database Has:** `newsletter_subscribers` ✅

**Files That Need Updating:**
- `lib/supabaseClient.ts` (line 170)

---

## ✅ ACTUAL DATABASE SCHEMA

### **EXISTING TABLES:**

1. **`blog_content`** ✅ (17 columns)
   - Columns: `id, title, teaser, canonical_url, publish_date, thumbnail_url, type, status, platform_name, read_time_minutes, watch_time_minutes, is_featured, view_count, click_count, created_at, updated_at, published_at`

2. **`blog_analytics`** ✅ (empty table)
   - Used for: Tracking views, clicks, shares

3. **`newsletter_subscribers`** ✅ (empty table)
   - Used for: Newsletter email list

4. **`firm_applications`** ✅ (empty table)
   - Used for: Law firm application forms

5. **`contact_submissions`** ✅ (empty table)
   - Used for: Contact form submissions

6. **`platforms`** ✅ (6 columns)
   - Columns: `name, display_name, icon_class, outbound_label, base_url, created_at`

7. **`blog_tags`** ✅ (6 columns)
   - Columns: `id, name, slug, description, color, created_at`

8. **`blog_content_tags`** ✅ (empty table)
   - Used for: Many-to-many relationships

9. **`page_analytics`** ✅ (empty table)
   - Used for: Website traffic tracking

---

## 🔧 FIXES TO APPLY

### **Fix 1: Update `js/blog-content.js`**

**Change:**
- Line 28: `content_items` → `blog_content`
- Line 74: `content_analytics` → `blog_analytics`

### **Fix 2: Update `lib/supabaseClient.ts`**

**Changes:**
- Line 107: `published_content` → Check if this view exists or use `blog_content` directly
- Line 146: `content_analytics` → `blog_analytics`
- Line 170: `notify_list` → `newsletter_subscribers`
- Line 97: `content_items` → `blog_content`

### **Fix 3: Update `components/admin/AddContentForm.tsx`**

**Change:**
- Line 97: `content_items` → `blog_content`

### **Fix 4: Update `admin/blog-manager.html`**

**Change:**
- Line 558: `content_items` → `blog_content`

### **Fix 5: Update Documentation**

**Files to update:**
- `supabase/DATABASE_SCHEMA_README.md` - Update table names
- `MIGRATION_SUCCESS_REPORT.md` - Already correct (`blog_content`)
- `DATABASE_STATUS_REPORT.md` - Update to match actual schema
- `README.md` - Update table references

---

## 📋 ACTION PLAN

1. ✅ **Verify schema** (DONE - script confirmed actual tables)
2. ⏳ **Update code files** (NEXT)
3. ⏳ **Update documentation** (NEXT)
4. ⏳ **Test all endpoints** (NEXT)
5. ⏳ **Verify blog hub works** (NEXT)

---

**Status:** Ready to apply fixes

