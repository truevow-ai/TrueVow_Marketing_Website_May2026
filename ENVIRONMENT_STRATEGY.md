# 🌍 Multi-Environment Strategy
**How to Deploy the Same Code to Dev, Staging, Beta, Production**

---

## 🎯 **The Core Principle**

**Code is environment-agnostic. Configuration is environment-specific.**

- ✅ Code references variables: `process.env.DATABASE_URL`
- ✅ Each environment has different `.env` file
- ✅ Same code, different databases
- ✅ Zero code changes between environments

---

## 📁 **Environment Files Structure**

```
your-project/
├── .env.local              ← Local development (YOUR computer)
├── .env.development        ← Development server
├── .env.staging            ← Staging server (pre-production testing)
├── .env.beta               ← Beta server (customer testing)
├── .env.production         ← Production server (live customers)
└── .env.example            ← Template (committed to git)
```

**Which files to commit to git:**
- ✅ `.env.example` (template with placeholder values)
- ❌ `.env.local` (your personal credentials)
- ❌ `.env.development` (dev server credentials)
- ❌ `.env.staging` (staging credentials)
- ❌ `.env.beta` (beta credentials)
- ❌ `.env.production` (production credentials - NEVER commit!)

---

## 🗄️ **Database Naming Per Environment**

### **Development Environment** (Your computer)
```bash
# .env.local
TENANT_APP_SUPABASE_URL=https://flhnyyreaxkmwmexchla.supabase.co
TENANT_APP_SUPABASE_ANON_KEY=eyJhbGci...

# Points to: TrueVow-Tenant-App-Development
```

### **Staging Environment** (Pre-production server)
```bash
# .env.staging
TENANT_APP_SUPABASE_URL=https://staging-project-id.supabase.co
TENANT_APP_SUPABASE_ANON_KEY=eyJhbGci...

# Points to: TrueVow-Tenant-App-Staging (new database you'd create)
```

### **Beta Environment** (Customer testing)
```bash
# .env.beta
TENANT_APP_SUPABASE_URL=https://beta-project-id.supabase.co
TENANT_APP_SUPABASE_ANON_KEY=eyJhbGci...

# Points to: TrueVow-Tenant-App-Beta (new database)
```

### **Production Environment** (Live customers)
```bash
# .env.production
TENANT_APP_SUPABASE_URL=https://smith-law-prod.supabase.co
TENANT_APP_SUPABASE_ANON_KEY=eyJhbGci...

# Points to: truevow-smith-associates-app (customer's database)
```

---

## 🚀 **Deployment Workflow**

### **Scenario: Push Code to Staging**

**Step 1: Developer writes code locally**
```bash
# Uses .env.local
npm run dev
# Connects to: TrueVow-Tenant-App-Development
```

**Step 2: Commit code to git**
```bash
git add .
git commit -m "Add contact search feature"
git push origin main
```

**Step 3: Deploy to staging server**
```bash
# On staging server (or via CI/CD like Vercel)
git pull origin main
npm install
npm run build

# Vercel/Netlify automatically uses .env.staging
# OR you set environment variables in hosting dashboard
```

**Step 4: Staging uses different database**
```
Staging server reads: .env.staging
Connects to: TrueVow-Tenant-App-Staging
SAME CODE, DIFFERENT DATABASE ✅
```

---

## 🔧 **How Hosting Platforms Handle This**

### **Vercel (Recommended)**

1. Go to Vercel dashboard → Your project
2. Settings → Environment Variables
3. Add variables for each environment:

| Variable | Development | Preview | Production |
|----------|-------------|---------|------------|
| `TENANT_APP_SUPABASE_URL` | dev-url | staging-url | prod-url |
| `TENANT_APP_SUPABASE_ANON_KEY` | dev-key | staging-key | prod-key |

**When you deploy:**
- `git push` to `dev` branch → uses Development vars
- `git push` to `staging` branch → uses Preview vars
- `git push` to `main` branch → uses Production vars

**Same code, different databases automatically!**

---

### **Netlify**

Similar approach:
1. Site settings → Build & deploy → Environment
2. Add variables per context (Deploy context = environment)

---

### **AWS / Custom Server**

Use PM2 or similar:

```bash
# On development server
pm2 start app.js --name truevow-dev --env development

# On staging server
pm2 start app.js --name truevow-staging --env staging

# On production server
pm2 start app.js --name truevow-prod --env production
```

PM2 loads the correct `.env.{environment}` file automatically.

---

## 🎯 **How Your Current Setup Works**

### **Right Now (Development):**

**File:** `.env.local`
```bash
TENANT_APP_SUPABASE_URL=https://flhnyyreaxkmwmexchla.supabase.co
TENANT_APP_SUPABASE_ANON_KEY=eyJhbGci...
```

**Code:** `lib/supabaseClient.ts`
```typescript
const url = process.env.TENANT_APP_SUPABASE_URL!
const key = process.env.TENANT_APP_SUPABASE_ANON_KEY!
export const tenantAppSupabase = createClient(url, key)
```

**Application:**
```typescript
// app/contacts/create.ts
import { tenantAppSupabase } from '@/lib/supabaseClient'

async function createContact(data) {
  const { data, error } = await tenantAppSupabase
    .from('contacts')
    .insert(data)
  // Works in dev, staging, beta, production - same code!
}
```

---

### **When You Deploy to Production:**

**File:** `.env.production` (on production server)
```bash
TENANT_APP_SUPABASE_URL=https://smith-law-firm-prod.supabase.co
TENANT_APP_SUPABASE_ANON_KEY=production-key-here
```

**Code:** UNCHANGED ✅  
**Same `lib/supabaseClient.ts`** - just reads different env var  
**Same `app/contacts/create.ts`** - connects to production DB automatically

---

## 🔑 **Key Takeaway**

### ❌ **BAD Approach (Hard-coded):**
```typescript
// DON'T DO THIS!
const supabase = createClient(
  'https://flhnyyreaxkmwmexchla.supabase.co',  // Hard-coded!
  'eyJhbGci...'  // Hard-coded!
)
```
**Problem:** Must change code for each environment 😱

---

### ✅ **GOOD Approach (Environment Variables):**
```typescript
// DO THIS!
const supabase = createClient(
  process.env.TENANT_APP_SUPABASE_URL!,
  process.env.TENANT_APP_SUPABASE_ANON_KEY!
)
```
**Benefit:** Same code works everywhere ✅

---

## 📋 **Workflow for Different Environments**

### **Local Development → Staging → Production**

| Step | Environment | Database | Code Changes |
|------|-------------|----------|--------------|
| 1 | Local (your PC) | TrueVow-Tenant-App-Development | Write features |
| 2 | Staging (test server) | TrueVow-Tenant-App-Staging | **Zero changes** |
| 3 | Beta (customer test) | TrueVow-Tenant-App-Beta | **Zero changes** |
| 4 | Production (live) | truevow-smith-law-app | **Zero changes** |

**How it works:**
- Same git repository
- Same codebase
- Different `.env` file per server
- Hosting platform (Vercel/Netlify) injects correct env vars

---

## 🎯 **Your Current Status**

### **✅ Already Set Up Correctly:**

Your code in `lib/supabaseClient.ts` uses environment variables:
```typescript
const tenantAppUrl = process.env.TENANT_APP_SUPABASE_URL!
const tenantAppKey = process.env.TENANT_APP_SUPABASE_ANON_KEY!
```

**This means:**
- ✅ Your code is already environment-agnostic
- ✅ No changes needed when moving to staging/production
- ✅ Just swap the `.env.local` file (or use hosting platform's env vars)

---

## 🔄 **Example: Deploying to Production**

### **When You Onboard "Smith & Associates":**

**Step 1: Create production database**
- Name: `truevow-smith-associates-app`
- Clone schema from `TrueVow-Tenant-App-Development`

**Step 2: Get production credentials**
- Project URL: `https://smith-abc123.supabase.co`
- API key: `eyJhbGci...` (different from dev)

**Step 3: Set in production server**
```bash
# On Vercel/Netlify production environment:
TENANT_APP_SUPABASE_URL=https://smith-abc123.supabase.co
TENANT_APP_SUPABASE_ANON_KEY=production-key-here
```

**Step 4: Deploy code**
```bash
git push origin main
```

**Step 5: Application automatically connects to production DB**
- ✅ Same code
- ✅ Different database
- ✅ Zero code changes

---

## ✅ **Bottom Line**

**You asked:** "Would you have to change the code every time?"

**Answer:** ❌ **NO - Never change code for different environments**

**Instead:**
- ✅ Change `.env.local` on your computer (development)
- ✅ Change env vars in Vercel dashboard (staging, production)
- ✅ Code reads `process.env.*` and adapts automatically

**Your current setup is ALREADY correct!** 🎉

---

## 🚀 **Ready for Next Step?**

Should I create the **SaaS Admin schema** now? It's the final piece of your 3-database architecture, and will enable:
- Tenant management (which firms are active)
- Module permissions (which firm has Intake, Draft, Settle, Connect)
- Billing tracking (usage, payments)
- Admin authentication (TrueVow staff access)

Say "yes" and I'll build it! 🚀

