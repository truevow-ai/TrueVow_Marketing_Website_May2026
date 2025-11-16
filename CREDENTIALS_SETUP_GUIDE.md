# 🔐 Credentials Setup Guide for Namecheap Deployment

**Status:** ✅ Database Schema Verified  
**Database URL:** `https://napwpkagxzqfpbearkjs.supabase.co`  
**Tables Verified:** `blog_content`, `blog_analytics`, `newsletter_subscribers`, etc.

---

## 📋 What I Need From You

### **1. Supabase Anon Key (Public Key)**

The anon key is **safe for client-side use** - it's designed to be public and works with your RLS policies.

**Where to find it:**
1. Go to Supabase Dashboard: https://supabase.com/dashboard
2. Select your project: `TrueVow-Marketing-Website` (or the one with URL `napwpkagxzqfpbearkjs`)
3. Go to **Settings** → **API**
4. Copy the **`anon` `public`** key (NOT the `service_role` key)

**Format:** `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...` (long JWT token)

---

## ✅ What's Already Done

1. ✅ **Database schema verified** - Connected and confirmed all tables exist
2. ✅ **Table names fixed** - All code updated from `content_items` → `blog_content`
3. ✅ **Code structure ready** - `js/blog-content.js` is configured correctly

---

## 🚀 Deployment Options for Namecheap (Static Hosting)

Since Namecheap is static hosting, you have **3 options**:

### **Option 1: Direct Configuration (Simplest for Static Hosting)**

**For static hosting, it's safe to include the anon key directly in the JavaScript file** because:
- The anon key is **designed to be public**
- Your RLS policies protect the data
- Only SELECT operations are allowed for published content

**Steps:**
1. Update `js/blog-content.js` line 11-12:
```javascript
const SUPABASE_URL = 'https://napwpkagxzqfpbearkjs.supabase.co';
const SUPABASE_ANON_KEY = 'your-anon-key-here'; // Paste your anon key here
```

2. Upload to Namecheap - done!

**Security Note:** The anon key is visible in the browser, but that's by design. Your RLS policies prevent unauthorized access.

---

### **Option 2: Environment Variable Injection (If Using Build Process)**

If you're using a build process (e.g., Vite, Webpack), you can inject env vars:

1. Create `.env.production` file:
```
NEXT_PUBLIC_SUPABASE_URL=https://napwpkagxzqfpbearkjs.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key-here
```

2. Update `js/blog-content.js`:
```javascript
const SUPABASE_URL = window.SUPABASE_URL || 'https://napwpkagxzqfpbearkjs.supabase.co';
const SUPABASE_ANON_KEY = window.SUPABASE_ANON_KEY || 'your-anon-key-here';
```

3. Inject at build time or via a config script

---

### **Option 3: Config File (Gitignored)**

1. Create `config/supabase-config.js` (add to `.gitignore`):
```javascript
window.SUPABASE_CONFIG = {
  url: 'https://napwpkagxzqfpbearkjs.supabase.co',
  anonKey: 'your-anon-key-here'
};
```

2. Include it in `marketing/blog.html` before `js/blog-content.js`:
```html
<script src="../config/supabase-config.js"></script>
<script src="../js/blog-content.js"></script>
```

3. Update `js/blog-content.js`:
```javascript
const config = window.SUPABASE_CONFIG || {};
const SUPABASE_URL = config.url || 'https://napwpkagxzqfpbearkjs.supabase.co';
const SUPABASE_ANON_KEY = config.anonKey || 'your-anon-key-here';
```

---

## ⚠️ Important Notes

### **1. Table Name Discrepancy (Already Fixed)**

Your code snippet showed `blog_posts`, but the actual database table is `blog_content`.  
✅ **Already fixed** - All code now uses `blog_content`

### **2. Never Commit Service Role Key**

- ✅ **Anon Key** - Safe for client-side (already in your code)
- ❌ **Service Role Key** - NEVER use in client-side code (bypasses RLS)

### **3. RLS Policies Must Be Configured**

Make sure your Supabase RLS policies allow:
- **Public SELECT** on `blog_content` where `status = 'published'`
- **Public INSERT** on `blog_analytics` (for tracking)
- **Public INSERT** on `newsletter_subscribers` (for subscriptions)

---

## 🧪 Testing Before Deployment

1. **Update credentials** in `js/blog-content.js`
2. **Test locally:**
   ```bash
   # Open marketing/blog.html in browser
   # Check browser console for any errors
   # Verify content loads from Supabase
   ```
3. **Verify RLS policies** allow public access to published content

---

## 📝 Summary

**What you need to provide:**
- ✅ Supabase Anon Key (from Supabase Dashboard → Settings → API)

**What I've already done:**
- ✅ Verified database schema
- ✅ Fixed all table name discrepancies
- ✅ Updated all code files
- ✅ Prepared configuration guide

**Next step:**
- Share your anon key (or I can help you set it up securely)
- I'll update `js/blog-content.js` with the key
- Ready for Namecheap deployment!

---

**Security Best Practice:** Even though the anon key is public, consider using Option 3 (config file) so the key isn't in your Git repository if you plan to make the repo public later.

