# 🗄️ Supabase Database Setup Guide
## TrueVow Blog & Media Hub - Complete Implementation

**Status:** ✅ READY TO DEPLOY  
**Estimated Setup Time:** 30 minutes  
**Complexity:** Intermediate

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [Step 1: Create Supabase Project](#step-1-create-supabase-project)
4. [Step 2: Run Database Migration](#step-2-run-database-migration)
5. [Step 3: Configure Environment Variables](#step-3-configure-environment-variables)
6. [Step 4: Test Database Connection](#step-4-test-database-connection)
7. [Step 5: Deploy Admin Dashboard](#step-5-deploy-admin-dashboard)
8. [Step 6: Set Up GitHub Actions](#step-6-set-up-github-actions)
9. [Maintenance Workflow](#maintenance-workflow)
10. [Troubleshooting](#troubleshooting)
11. [API Reference](#api-reference)

---

## 🎯 Overview

This guide walks you through setting up the **Supabase-powered database** for TrueVow's Blog & Media Hub. Once complete, you'll have:

✅ **Production-ready database** with 8 tables, 3 triggers, 16 RLS policies  
✅ **REST API endpoints** for fetching/adding content  
✅ **Admin dashboard** for managing blog content  
✅ **Automated rebuilds** via GitHub Actions  
✅ **Analytics tracking** for views, clicks, shares  
✅ **Newsletter subscription** system

---

## 📦 Prerequisites

Before starting, ensure you have:

- [x] Supabase account (free tier is fine)  
- [x] Node.js 18+ installed  
- [x] Git/GitHub access  
- [x] Basic SQL knowledge (optional but helpful)  
- [x] Next.js project initialized (if using Next.js)

---

## Step 1: Create Supabase Project

### 1.1 Sign Up for Supabase

1. Go to [supabase.com](https://supabase.com)
2. Click "Start your project"
3. Sign in with GitHub (recommended)

### 1.2 Create New Project

1. Click "New Project"
2. **Organization:** Select your organization
3. **Name:** `truevow-blog-hub`
4. **Database Password:** Generate strong password (save this!)
5. **Region:** Choose closest to your users (e.g., `us-east-1`)
6. **Pricing Plan:** Free tier (upgrade later if needed)
7. Click "Create new project"

⏱️ **Wait 2-3 minutes** for project provisioning.

---

## Step 2: Run Database Migration

### 2.1 Access SQL Editor

1. In your Supabase dashboard, click **"SQL Editor"** in left sidebar
2. Click **"New query"** button

### 2.2 Run Migration Script

1. Open the file: `supabase/migrations/001_initial_blog_schema.sql`
2. Copy **entire contents** of the file
3. Paste into Supabase SQL Editor
4. Click **"Run"** (bottom right)

✅ **Expected Output:**
```
NOTICE: =====================================================
NOTICE: TrueVow Blog & Media Hub Schema Migration Complete!
NOTICE: =====================================================
NOTICE: Tables created: 8
NOTICE: Views created: 2
NOTICE: Triggers created: 3
NOTICE: RLS policies: 16
NOTICE: Sample content: 3 items
NOTICE: =====================================================
Success. No rows returned
```

### 2.3 Verify Tables Created

1. Click **"Table Editor"** in left sidebar
2. You should see these tables:
   - `content_items`
   - `platforms`
   - `tags`
   - `content_tags`
   - `editorial_queue`
   - `notify_list`
   - `content_analytics`

3. Click on `content_items` → you should see 3 sample rows

---

## Step 3: Configure Environment Variables

### 3.1 Get Supabase API Keys

1. Click **"Settings"** (gear icon) in left sidebar
2. Click **"API"** tab
3. Copy these values:

**Project URL:**
```
https://your-project-id.supabase.co
```

**anon/public Key:**
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

**service_role Key:** (keep this secret!)
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### 3.2 Create Environment File

Create `.env.local` in your project root:

```bash
# Supabase Configuration
NEXT_PUBLIC_SUPABASE_URL=https://your-project-id.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

# Service Role Key (server-side only - never expose to client!)
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

# Analytics (Optional)
NEXT_PUBLIC_GA_MEASUREMENT_ID=G-XXXXXXXXXX
```

⚠️ **Important:** `.env.local` is gitignored - never commit it!

### 3.3 Install Supabase Client

```bash
npm install @supabase/supabase-js
# or
yarn add @supabase/supabase-js
```

---

## Step 4: Test Database Connection

### 4.1 Test API Route

Start your dev server:

```bash
npm run dev
```

Open browser to:
```
http://localhost:3000/api/blog/content
```

✅ **Expected Response:**
```json
{
  "success": true,
  "count": 3,
  "data": [
    {
      "id": "uuid-here",
      "title": "Is Pay-Per-Intake Ethical? A 50-State Fee-Sharing Round-up",
      "teaser": "Why paying a vendor for a service is ethically sound...",
      "type": "article",
      "platform_name": "linkedin",
      "tags": [
        {"name": "Ethics & Compliance", "slug": "ethics-compliance"}
      ]
    },
    ...
  ]
}
```

### 4.2 Test with Query Parameters

Try filtering:

- Articles only: `/api/blog/content?type=article`
- Videos only: `/api/blog/content?type=video`
- Featured only: `/api/blog/content?featured=true`
- Limit results: `/api/blog/content?limit=2`

---

## Step 5: Deploy Admin Dashboard

### 5.1 Create Admin Page

Create `pages/admin/blog.tsx`:

```tsx
import AddContentForm from '@/components/admin/AddContentForm'

export default function AdminBlogPage() {
  return (
    <div className="min-h-screen bg-gray-50 py-12">
      <AddContentForm 
        onSuccess={() => {
          alert('Content added! Rebuilding blog...')
          // Trigger rebuild via GitHub Action
        }}
      />
    </div>
  )
}
```

### 5.2 Protect Admin Route

Add authentication middleware (example with Supabase Auth):

```tsx
// pages/admin/blog.tsx
import { useEffect } from 'react'
import { useRouter } from 'next/router'
import { supabase } from '@/lib/supabaseClient'

export default function AdminBlogPage() {
  const router = useRouter()
  
  useEffect(() => {
    const checkAuth = async () => {
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) {
        router.push('/admin/login')
      }
    }
    checkAuth()
  }, [router])
  
  return <AddContentForm />
}
```

### 5.3 Set Up Supabase Auth (Optional)

1. In Supabase dashboard, click **"Authentication"**
2. Click **"Providers"** tab
3. Enable **"Email"** provider
4. Add your admin email:
   - Click **"Users"** tab
   - Click **"Add user"**
   - Enter email + password
   - Click **"Create user"**

---

## Step 6: Set Up GitHub Actions

### 6.1 Add Secrets to GitHub

1. Go to your GitHub repo
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Add these secrets:

| Secret Name | Value |
|-------------|-------|
| `NEXT_PUBLIC_SUPABASE_URL` | Your project URL |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Your anon key |
| `VERCEL_TOKEN` | Your Vercel token (if using Vercel) |

### 6.2 Enable Workflow

1. The workflow file is at `.github/workflows/rebuild-blog.yml`
2. Push to main branch to trigger first build
3. Verify workflow runs:
   - Click **Actions** tab in GitHub
   - Should see "Rebuild Blog on Content Update" workflow

### 6.3 Configure Supabase Webhook (Optional)

For instant rebuilds when content is published:

1. In Supabase dashboard, click **"Database"** → **"Webhooks"**
2. Click **"Create a new hook"**
3. Settings:
   - **Name:** `content-published-webhook`
   - **Table:** `content_items`
   - **Events:** `INSERT`, `UPDATE`
   - **Type:** `HTTP Request`
   - **URL:** `https://api.github.com/repos/your-username/your-repo/dispatches`
   - **Headers:**
     ```json
     {
       "Authorization": "token YOUR_GITHUB_TOKEN",
       "Accept": "application/vnd.github.v3+json"
     }
     ```
   - **Payload:**
     ```json
     {
       "event_type": "content-published"
     }
     ```

---

## 📝 Maintenance Workflow

### Adding New Content (5 minutes)

**Option A: Admin Dashboard (Recommended)**

1. Go to `https://yourdomain.com/admin/blog`
2. Fill in form:
   - Title (max 70 chars)
   - Teaser (max 160 chars)
   - LinkedIn/YouTube URL
   - Publish date
   - Read/Watch time
3. Check "Publish immediately" (or save as draft)
4. Click "Publish Content"
5. ✅ GitHub Action automatically rebuilds site in ~2 mins

**Option B: SQL Query (Advanced)**

```sql
INSERT INTO content_items (
  title, 
  teaser, 
  canonical_url, 
  publish_date, 
  type, 
  platform_name, 
  read_time_minutes,
  status
) VALUES (
  'Your Article Title Here',
  'Your teaser here (max 160 chars).',
  'https://linkedin.com/pulse/your-article?utm_source=truevow_blog',
  '2025-11-20',
  'article',
  'linkedin',
  4,
  'published'
);
```

### Viewing Analytics

```sql
-- Top performing content
SELECT 
  title,
  type,
  view_count,
  click_count,
  ROUND((click_count::NUMERIC / NULLIF(view_count, 0)::NUMERIC) * 100, 2) AS ctr_percentage
FROM content_items
WHERE status = 'published'
ORDER BY view_count DESC
LIMIT 10;

-- Recent analytics events
SELECT 
  ci.title,
  ca.event_type,
  ca.utm_source,
  ca.created_at
FROM content_analytics ca
JOIN content_items ci ON ca.content_id = ci.id
ORDER BY ca.created_at DESC
LIMIT 50;
```

### Managing Tags

```sql
-- Add new tag
INSERT INTO tags (name, slug, description, color)
VALUES ('State Bar Compliance', 'state-bar-compliance', 'State-specific ethics guidance', '#10B981');

-- Tag existing content
INSERT INTO content_tags (content_id, tag_id)
SELECT 
  ci.id,
  t.id
FROM content_items ci
CROSS JOIN tags t
WHERE ci.title LIKE '%Ethics%'
AND t.slug = 'ethics-compliance';
```

---

## 🔧 Troubleshooting

### Issue: "Missing Supabase environment variables"

**Solution:**
1. Check `.env.local` exists in project root
2. Verify variable names match exactly:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
3. Restart dev server after adding env vars

### Issue: API returns empty array

**Solution:**
1. Check content status is `published`:
   ```sql
   SELECT title, status FROM content_items;
   ```
2. If status is `draft`, update:
   ```sql
   UPDATE content_items SET status = 'published';
   ```

### Issue: RLS policy blocking access

**Solution:**
1. Check RLS is enabled:
   ```sql
   SELECT tablename, rowsecurity 
   FROM pg_tables 
   WHERE schemaname = 'public';
   ```
2. Test without RLS (temporarily):
   ```sql
   ALTER TABLE content_items DISABLE ROW LEVEL SECURITY;
   ```
3. Re-enable after testing:
   ```sql
   ALTER TABLE content_items ENABLE ROW LEVEL SECURITY;
   ```

### Issue: GitHub Action not triggering

**Solution:**
1. Check workflow file exists: `.github/workflows/rebuild-blog.yml`
2. Verify secrets are added to GitHub repo
3. Check Actions tab for error logs
4. Manual trigger: **Actions** → **Rebuild Blog** → **Run workflow**

---

## 📚 API Reference

### GET /api/blog/content

Fetch published blog content.

**Query Parameters:**
- `type` (optional): `article` | `video`
- `featured` (optional): `true` | `false`
- `limit` (optional): integer

**Response:**
```json
{
  "success": true,
  "count": 3,
  "data": [...]
}
```

### POST /api/blog/track

Track content analytics (views, clicks, shares).

**Request Body:**
```json
{
  "contentId": "uuid-here",
  "eventType": "click",
  "referrer": "https://linkedin.com",
  "utmSource": "linkedin",
  "utmMedium": "social"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Analytics tracked successfully"
}
```

---

## 🚀 Next Steps

Now that Supabase is set up:

1. ✅ **Test the admin form** - Add your first real content
2. ✅ **Replace sample data** - Update the 3 sample posts with real URLs
3. ✅ **Set up authentication** - Protect `/admin/*` routes
4. ✅ **Configure webhooks** - Enable instant rebuilds
5. ✅ **Monitor analytics** - Track which content performs best

---

## 📞 Support

**Documentation:**
- Supabase Docs: https://supabase.com/docs
- Next.js Docs: https://nextjs.org/docs

**Need Help?**
- Review `BLOG_HUB_IMPLEMENTATION_GUIDE.md` for content strategy
- Check Supabase logs: Dashboard → **Logs** → **API**
- Verify RLS policies: Dashboard → **Authentication** → **Policies**

---

**Status:** 🟢 Database Ready  
**Last Updated:** November 6, 2025  
**Version:** 1.0.0

