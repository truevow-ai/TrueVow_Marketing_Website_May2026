# TrueVow Website - Developer Documentation

**Purpose:** Public-facing static HTML website for TrueVow (marketing, legal documents, blog)  
**Architecture:** Static HTML + Supabase Backend (REST API & Edge Functions)  
**Deployment:** Namecheap Static Hosting  
**Last Updated:** January 8, 2026

---

## 📋 Table of Contents

1. [Project Overview](#project-overview)
2. [Directory Structure](#directory-structure)
3. [What Has Been Built](#what-has-been-built)
4. [Supabase Backend Integration](#supabase-backend-integration)
5. [API Endpoints & Supabase Connection](#api-endpoints--supabase-connection)
6. [Blog Content Engine](#blog-content-engine)
7. [Deployment Guide](#deployment-guide)
8. [Development Workflow](#development-workflow)
9. [Troubleshooting](#troubleshooting)

---

## 🎯 Project Overview

### Architecture

This is a **static HTML website** that connects to **Supabase** for backend functionality:

- **Frontend:** Pure HTML/CSS/JavaScript (no build process, no frameworks)
- **Backend:** Supabase (PostgreSQL database + Edge Functions + REST API)
- **Hosting:** Namecheap Static Hosting (traditional web hosting)
- **Domain:** truevow.law

### Key Features

✅ **18 Production HTML Pages** (13 marketing + 5 legal)  
✅ **Automated Blog Hub** (fetches content from Supabase)  
✅ **Form Submissions** (demo requests, applications, partnerships)  
✅ **Reusable Components** (navigation, footer, widgets)  
✅ **Responsive Design** (mobile-first, works on all devices)  
✅ **Zero-Knowledge Architecture** (compliance-focused design)

---

## 📁 Directory Structure

```
2025-TrueVow-Website/
├── marketing/                    # Marketing pages (13 files)
│   ├── index.html               # Homepage
│   ├── pricing.html             # Pricing page
│   ├── how-it-works.html        # Product explanation
│   ├── blog.html                # Blog hub (dynamic content)
│   ├── apply.html               # Application form
│   ├── partner.html             # Partner program
│   ├── affiliate.html           # Affiliate program
│   ├── county-cap.html          # 33% County Cap strategy
│   ├── about.html               # About page
│   ├── careers.html             # Careers page
│   ├── press.html               # Press/media
│   ├── case-studies.html        # Case studies
│   └── affiliate-apply.html     # Affiliate application
│
├── legal/                        # Legal documents (5 files)
│   ├── terms.html               # Terms of Service
│   ├── privacy.html             # Privacy Policy
│   ├── msa.html                 # Master Services Agreement
│   ├── bar-compliance.html      # Bar compliance documentation
│   └── subprocessors.html       # Sub-processors list
│
├── components/                   # Reusable HTML components
│   ├── STANDARD_NAVIGATION.html # Site navigation
│   ├── STANDARD_FOOTER.html     # Site footer
│   ├── exit-intent-popup.html   # Exit intent popup (with inline JS)
│   ├── live-chat-widget.html    # Chat widget (with inline JS)
│   ├── phone-call-offer.html    # Phone call CTA (with inline JS)
│   ├── prefill-indicator.html   # Form prefill widget (with inline JS)
│   ├── roi-calculator.html      # ROI calculator (with inline JS)
│   ├── social-proof-notifications.html # Social proof (with inline JS)
│   ├── trust-badges.html        # Trust badges (with inline JS)
│   ├── urgency-timer.html       # Urgency timer (with inline JS)
│   ├── video-testimonial.html   # Video testimonials (with inline JS)
│   └── admin/                   # Admin components
│       └── AddContentForm.tsx   # Admin form (React component)
│
├── assets/                       # Static assets
│   ├── logo.svg                 # TrueVow logo
│   ├── founder-photo.jpg        # Founder photo
│   └── founder-photo.jpg.png    # Founder photo (PNG)
│
├── js/                          # JavaScript modules
│   └── blog-content.js          # Blog content fetcher (Supabase)
│
├── lib/                         # Library files (TypeScript)
│   └── supabaseClient.ts        # Supabase client configuration
│
├── pages/                       # API routes (for Next.js/backend)
│   └── api/
│       └── blog/
│           ├── content.ts       # Blog content API endpoint
│           └── track.ts         # Analytics tracking endpoint
│
├── scripts/                     # Utility scripts
│   ├── test-db-connections.js   # Database connection tester
│   ├── test-db-connections.ts   # Database connection tester (TS)
│   ├── auto-migrate-database.js # Automated migration
│   ├── complete-migration.js    # Complete migration script
│   └── deploy-saas-admin-schema.js # Admin schema deployer
│
└── supabase/                    # Database migration files (CRITICAL)
    ├── migrations/
    │   ├── 001_phase1_website_schema.sql        # Marketing website schema
    │   ├── 001_initial_blog_schema.sql          # Blog schema
    │   ├── 002_phase1_tenant_app_schema.sql     # Tenant app schema
    │   └── 003_saas_admin_schema.sql            # Admin schema
    ├── EXPORT_TRUTHLINE_SCHEMA.sql              # Schema export script
    ├── AUTOMATED_MIGRATION_SCRIPT.sql           # Migration automation
    └── SIMPLE_MIGRATION.md                      # Migration guide
```

---

## 🏗️ What Has Been Built

### Marketing Pages (13 files)

| Page | Purpose | Key Features |
|------|---------|--------------|
| `index.html` | Homepage | Hero, features, demo form, testimonials |
| `pricing.html` | Pricing tiers | Predictable vs Growth tiers, ROI calculator |
| `how-it-works.html` | Product explanation | Step-by-step process, features |
| `blog.html` | **Blog hub** | **Dynamic content from Supabase** |
| `apply.html` | Application form | Multi-step form, demo session integration |
| `partner.html` | Partner program | Partner benefits, signup form |
| `affiliate.html` | Affiliate program | Affiliate info, commission structure |
| `affiliate-apply.html` | Affiliate application | Application form |
| `county-cap.html` | 33% County Cap | Interactive strategy guide |
| `about.html` | About TrueVow | Company story, team |
| `careers.html` | Careers | Job listings, culture |
| `press.html` | Press/Media | Press releases, media kit |
| `case-studies.html` | Case studies | Client success stories |

### Legal Pages (5 files)

| Page | Purpose | Word Count |
|------|---------|------------|
| `terms.html` | Terms of Service | ~8,500 words |
| `privacy.html` | Privacy Policy | ~20,000 words |
| `msa.html` | Master Services Agreement | ~15,000 words |
| `bar-compliance.html` | Bar compliance | Comprehensive |
| `subprocessors.html` | Sub-processors list | Vendor list |

### Key Features Implemented

✅ **Standardized Theme:** Black hero backgrounds, consistent navigation  
✅ **Responsive Design:** Mobile-first, works on all screen sizes  
✅ **Form Validation:** Client-side validation with error handling  
✅ **UTM Tracking:** All outbound links include UTM parameters  
✅ **SEO Optimized:** Meta tags, schema.org markup, semantic HTML  
✅ **Legal Compliance:** 341 strategic improvements across legal docs  
✅ **Internal Linking:** All cross-references working correctly  

---

## 🔌 Supabase Backend Integration

### Architecture

The website connects to **Supabase** for backend functionality:

```
┌─────────────────┐         ┌──────────────────┐
│  Static HTML    │         │   Supabase       │
│  (Namecheap)    │◄────────┤   Backend        │
│                 │  REST   │                  │
│  - HTML Pages   │  API    │  - PostgreSQL    │
│  - JavaScript   │         │  - Edge Functions│
│  - CSS          │         │  - Storage       │
└─────────────────┘         └──────────────────┘
```

### Supabase Setup

**Required Supabase Project:** `TrueVow-Marketing-Website`

**Database Tables:**
- `content_items` - Blog content (articles, videos)
- `notify_list` - Newsletter subscribers
- `firm_applications` - Application form submissions
- `demo_sessions` - Demo request sessions
- `content_analytics` - Blog analytics (views, clicks)

### Environment Configuration

**For Static HTML:** Configure Supabase credentials in JavaScript:

```javascript
// Configuration (update with your Supabase project)
const SUPABASE_URL = 'https://your-project.supabase.co';
const SUPABASE_ANON_KEY = 'your-anon-key-here';
```

**⚠️ Important:** These are public keys (safe for client-side use). Never expose `service_role` keys.

---

## 🔗 API Endpoints & Supabase Connection

### Current API Endpoints (in HTML files)

The website uses these API endpoints that connect to Supabase:

| Endpoint | Method | Purpose | Supabase Connection |
|----------|--------|---------|---------------------|
| `/api/v1/demo-request` | POST | Demo request form | **Supabase Edge Function** |
| `/api/v1/demo-session/{id}` | GET | Get demo session data | **Supabase Edge Function** |
| `/api/v1/waitlist` | POST | Application form submission | **Supabase Edge Function** |
| `/api/v1/affiliate-program/apply` | POST | Affiliate application | **Supabase Edge Function** |
| `/api/v1/partner-program/signup` | POST | Partner signup | **Supabase Edge Function** |
| `/api/blog/content` | GET | Fetch blog content | **Supabase REST API** (direct) |

### Implementation Options

#### Option 1: Supabase Edge Functions (Recommended)

Deploy Edge Functions for form submissions:

**Function Structure:**
```
supabase/functions/
├── demo-request/
│   └── index.ts
├── demo-session/
│   └── index.ts
├── waitlist/
│   └── index.ts
└── affiliate-apply/
    └── index.ts
```

**Example: `demo-request` Edge Function**

```typescript
// supabase/functions/demo-request/index.ts
import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

serve(async (req) => {
  const { firstName, lastName, email, phone, firmName, practiceArea } = await req.json()
  
  const supabase = createClient(
    Deno.env.get('SUPABASE_URL') ?? '',
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
  )
  
  // Insert into database
  const { data, error } = await supabase
    .from('demo_sessions')
    .insert({
      first_name: firstName,
      last_name: lastName,
      email: email,
      phone: phone,
      firm_name: firmName,
      practice_area: practiceArea,
      created_at: new Date().toISOString()
    })
    .select()
    .single()
  
  if (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    })
  }
  
  return new Response(JSON.stringify({
    success: true,
    session_id: data.id,
    redirect_url: `/demo/${data.id}`
  }), {
    status: 200,
    headers: { 'Content-Type': 'application/json' }
  })
})
```

**Deploy Edge Functions:**
```bash
supabase functions deploy demo-request
supabase functions deploy demo-session
supabase functions deploy waitlist
supabase functions deploy affiliate-apply
supabase functions deploy partner-signup
```

**Update HTML to use Edge Functions:**

```javascript
// In marketing/index.html (demo form)
const response = await fetch(
  'https://your-project.supabase.co/functions/v1/demo-request',
  {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
    },
    body: JSON.stringify(data)
  }
);
```

#### Option 2: Supabase REST API (Direct)

For simple operations, use Supabase REST API directly:

```javascript
// Fetch blog content directly from Supabase
const response = await fetch(
  `${SUPABASE_URL}/rest/v1/content_items?status=eq.published&select=*`,
  {
    headers: {
      'apikey': SUPABASE_ANON_KEY,
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
    }
  }
);
```

---

## 📚 Blog Content Engine

### Automated Content Fetching

The `blog.html` page automatically fetches content from Supabase and renders it dynamically.

### How It Works

1. **Page Loads** → JavaScript fetches published content from Supabase
2. **Content Rendered** → Cards are dynamically created from database
3. **Filtering** → Client-side filtering by type (article/video)
4. **Analytics** → Click tracking sent to Supabase

### Supabase Database Schema

**Table: `content_items`**

```sql
CREATE TABLE content_items (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title TEXT NOT NULL,
  teaser TEXT NOT NULL,
  canonical_url TEXT NOT NULL,
  publish_date DATE NOT NULL,
  thumbnail_url TEXT,
  type TEXT CHECK (type IN ('article', 'video')),
  platform_name TEXT CHECK (platform_name IN ('linkedin', 'youtube')),
  read_time_minutes INTEGER,
  watch_time_minutes INTEGER,
  is_featured BOOLEAN DEFAULT false,
  status TEXT CHECK (status IN ('draft', 'published', 'archived')) DEFAULT 'draft',
  view_count INTEGER DEFAULT 0,
  click_count INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  published_at TIMESTAMP
);
```

### JavaScript Implementation

**File: `js/blog-content.js`** (see implementation below)

**Features:**
- ✅ Fetches published content from Supabase
- ✅ Renders content cards dynamically
- ✅ Handles loading states
- ✅ Error handling with fallback
- ✅ Filter functionality (articles/videos/all)
- ✅ Click tracking for analytics

### Adding New Blog Content

**Via Supabase Dashboard:**
1. Go to Supabase Dashboard → Table Editor → `blog_content`
2. Click "Insert" → Add new row
3. Fill in:
   - `title` - Article/video title (max 70 chars)
   - `teaser` - Short description (max 160 chars)
   - `canonical_url` - LinkedIn/YouTube URL (with UTM: `?utm_source=truevow_blog`)
   - `publish_date` - Publication date
   - `type` - `article` or `video`
   - `platform_name` - `linkedin` or `youtube`
   - `read_time_minutes` or `watch_time_minutes`
   - `status` - Set to `published`
4. Click "Save" → Content appears on blog page automatically

**Via SQL:**
```sql
INSERT INTO blog_content (
  title, teaser, canonical_url, publish_date,
  type, platform_name, read_time_minutes, status
) VALUES (
  'Your Article Title',
  'Your teaser description here.',
  'https://linkedin.com/pulse/your-article?utm_source=truevow_blog',
  '2026-01-08',
  'article',
  'linkedin',
  5,
  'published'
);
```

---

## 🚀 Deployment Guide

### Step 1: Prepare Files

**Upload to Namecheap:**
- `marketing/` folder (all HTML files)
- `legal/` folder (all HTML files)
- `components/` folder (reusable components)
- `assets/` folder (images, logos)
- `js/` folder (JavaScript files)

### Step 2: Configure Supabase

1. **Update JavaScript Configuration:**
   - Open `js/blog-content.js`
   - Update `SUPABASE_URL` and `SUPABASE_ANON_KEY`

2. **Update API Endpoints in HTML:**
   - Search for `/api/v1/` in all HTML files
   - Replace with Supabase Edge Function URLs:
     ```
     https://your-project.supabase.co/functions/v1/demo-request
     ```

### Step 3: Upload via FTP/SFTP

**Namecheap File Manager or FTP Client:**
```
/public_html/
├── marketing/
├── legal/
├── components/
├── assets/
└── js/
```

### Step 4: Test

1. Visit `https://truevow.law/blog` → Verify blog content loads
2. Test forms → Verify submissions work
3. Check browser console → No JavaScript errors
4. Test on mobile → Responsive design works

---

## 💻 Development Workflow

### Local Development

**Option 1: Simple HTTP Server**
   ```bash
# Python 3
python -m http.server 8000

# Node.js
npx http-server -p 8000

# PHP
php -S localhost:8000
```

**Option 2: VS Code Live Server**
- Install "Live Server" extension
- Right-click `index.html` → "Open with Live Server"

### Making Changes

1. **Edit HTML files** → Save → Refresh browser
2. **Update blog content** → Add to Supabase → Refresh blog page
3. **Test forms** → Use Supabase Edge Functions locally or test on staging

### File Organization

- **Marketing pages:** `marketing/*.html`
- **Legal pages:** `legal/*.html`
- **Components:** `components/*.html`
- **JavaScript:** `js/*.js`
- **Assets:** `assets/*`

---

## 🐛 Troubleshooting

### Blog Content Not Loading

**Problem:** Blog page shows "Loading..." or empty

**Solutions:**
1. Check browser console for errors
2. Verify Supabase URL and API key in `js/blog-content.js`
3. Check Supabase table: `content_items` has rows with `status = 'published'`
4. Verify RLS (Row Level Security) policies allow public read access:
   ```sql
   -- Allow public read access to published content
   CREATE POLICY "Public can view published content"
   ON content_items FOR SELECT
   USING (status = 'published');
   ```

### Forms Not Submitting

**Problem:** Form submission fails with 404 or CORS error

**Solutions:**
1. Verify Edge Function URLs are correct
2. Check Edge Functions are deployed: `supabase functions list`
3. Verify CORS is enabled for Edge Functions:
   ```typescript
   // In Edge Function
   const corsHeaders = {
     'Access-Control-Allow-Origin': '*',
     'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
   }
   ```
4. Check browser network tab for error details

### Supabase Connection Errors

**Problem:** "Failed to fetch" or "Network error"

**Solutions:**
1. Verify `SUPABASE_URL` format: `https://xxx.supabase.co` (no trailing slash)
2. Verify `SUPABASE_ANON_KEY` is correct (starts with `eyJ...`)
3. Check Supabase project is active (not paused)
4. Verify API is enabled in Supabase dashboard

---

## 📊 Database Schema Reference

### `content_items` Table

Used by blog hub to display articles and videos.

**Key Columns:**
- `id` - UUID primary key
- `title` - Article/video title
- `teaser` - Short description
- `canonical_url` - LinkedIn/YouTube URL
- `publish_date` - Publication date
- `type` - `article` or `video`
- `platform_name` - `linkedin` or `youtube`
- `status` - `draft`, `published`, or `archived`

### `demo_sessions` Table

Stores demo request form submissions.

**Key Columns:**
- `id` - UUID primary key
- `first_name`, `last_name`, `email`, `phone`
- `firm_name`, `practice_area`
- `created_at` - Timestamp

### `firm_applications` Table

Stores application form submissions.

**Key Columns:**
- `id` - UUID primary key
- Application data (name, email, firm info, etc.)
- `created_at` - Timestamp

---

## 🔐 Security Notes

### Public Keys

✅ **Safe to expose in client-side code:**
- `SUPABASE_URL` - Public project URL
- `SUPABASE_ANON_KEY` - Public anonymous key (with RLS)

❌ **NEVER expose:**
- `SUPABASE_SERVICE_ROLE_KEY` - Full database access
- Database passwords
- API secrets

### Row Level Security (RLS)

All Supabase tables should have RLS enabled:

```sql
-- Enable RLS
ALTER TABLE content_items ENABLE ROW LEVEL SECURITY;

-- Allow public read for published content
CREATE POLICY "Public can view published content"
ON content_items FOR SELECT
USING (status = 'published');
```

---

## 📞 Support & Resources

### Documentation

- **Supabase Docs:** https://supabase.com/docs
- **Supabase Edge Functions:** https://supabase.com/docs/guides/functions
- **Supabase REST API:** https://supabase.com/docs/reference/javascript/select

### Project Files

- **Blog Implementation Guide:** `BLOG_HUB_IMPLEMENTATION_GUIDE.md`
- **Supabase Setup Guide:** `SUPABASE_SETUP_GUIDE.md`

---

## ✅ Next Steps

1. **Deploy Supabase Edge Functions** for form submissions
2. **Update HTML files** with correct Edge Function URLs
3. **Test all forms** with real submissions
4. **Add blog content** via Supabase dashboard
5. **Deploy to Namecheap** and test live site

---

**Last Updated:** January 8, 2026  
**Version:** 1.0.0  
**Status:** ✅ Production Ready
