# 🔌 Environment Configuration Setup

## Quick Setup (3 Minutes)

### **Step 1: Get Your Supabase Credentials**

For each database, go to **Settings → API** and copy:
- **Project URL** (starts with `https://`)
- **anon/public key** (starts with `eyJhbGci...`)

---

### **Step 2: Create `.env.local` File**

Create this file in your project root:

```bash
# .env.local (DO NOT commit to git)

# =====================================================
# MARKETING WEBSITE DATABASE
# =====================================================
NEXT_PUBLIC_SUPABASE_URL=https://your-marketing-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

# =====================================================
# TENANT APPLICATION DATABASE  
# =====================================================
TENANT_APP_SUPABASE_URL=https://flhnyyreaxkmwmexchla.supabase.co
TENANT_APP_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

# =====================================================
# SAAS ADMIN DATABASE
# =====================================================
ADMIN_SUPABASE_URL=https://your-admin-project.supabase.co
ADMIN_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

---

### **Step 3: Share Credentials With Me**

**Option A: Paste Here (Safe - I won't store)**
Just paste the 6 values above and I'll configure everything.

**Option B: Tell Me Where They Are**
Tell me the file path where you've saved them, and I'll read and configure.

---

## 🔐 **Security Notes:**

✅ **Safe to share with me:**
- `anon/public` keys (designed for client-side use)
- Project URLs (public information)

❌ **NEVER share:**
- `service_role` keys (full database access)
- Personal passwords
- API secrets for production

---

## 🧪 **What I'll Test Once Connected:**

### **Marketing Website Database:**
- [ ] Blog content API works
- [ ] Newsletter signup works
- [ ] Contact form submission works
- [ ] Firm application form works
- [ ] Analytics tracking works

### **Tenant App Database (After Migration):**
- [ ] Contacts table accessible
- [ ] Intake sessions readable
- [ ] Cases query works
- [ ] Documents storage works
- [ ] All foreign keys intact

### **Admin Database:**
- [ ] Tenant registry works
- [ ] Billing tables accessible
- [ ] Admin authentication works

---

## 📝 **Next Steps:**

**Right Now:**
1. You get the credentials from Supabase
2. Share them with me (paste here)
3. I'll create `.env.local` with proper configuration
4. I'll test connectivity to all 3 databases

**After Migration:**
1. I'll verify data migrated correctly
2. I'll test all CRUD operations
3. I'll run integration tests
4. I'll confirm application works end-to-end

---

## ❓ **Ready to Provide Credentials?**

**Option 1:** Paste them here now (I'll configure everything)

**Option 2:** "Wait, let me do migration first, then we'll test"

**Option 3:** "I'll create .env.local myself, just tell me what to put"

Which option? 🚀

