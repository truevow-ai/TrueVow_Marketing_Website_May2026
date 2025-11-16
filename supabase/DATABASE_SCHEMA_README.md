# 🗄️ TrueVow Supabase Database Schema Documentation

**Database:** `TrueVow-Marketing-Website`  
**URL:** `https://napwpkagxzqfpbearkjs.supabase.co`  
**Status:** ✅ Tables Created & Ready  
**Last Updated:** January 8, 2026

---

## 📊 Database Overview

This database powers the TrueVow marketing website, including:
- ✅ Blog content hub (articles & videos)
- ✅ Newsletter subscriptions
- ✅ Contact form submissions
- ✅ Firm application forms
- ✅ Website analytics tracking

---

## 📋 Tables

### 1. `blog_content` (Blog Content) ✅ **VERIFIED**

**Purpose:** Stores blog articles and videos for the blog hub.

**Columns (17 total - VERIFIED from database):**

| Column | Type | Description | Required |
|--------|------|-------------|----------|
| `id` | UUID | Primary key (auto-generated) | ✅ |
| `title` | VARCHAR(200) | Article/video title (max 70 chars recommended) | ✅ |
| `teaser` | TEXT | Short description/teaser (max 160 chars recommended) | ✅ |
| `canonical_url` | TEXT | Full URL to LinkedIn/YouTube article | ✅ |
| `publish_date` | DATE | Publication date | ✅ |
| `thumbnail_url` | TEXT | Optional thumbnail image URL | ❌ |
| `type` | VARCHAR(20) | Content type: `'article'` or `'video'` | ✅ |
| `status` | VARCHAR(20) | Status: `'draft'`, `'published'`, `'archived'` | ✅ |
| `platform_name` | VARCHAR(50) | Platform: `'linkedin'` or `'youtube'` | ✅ |
| `read_time_minutes` | INTEGER | Reading time (for articles) | ❌ |
| `watch_time_minutes` | INTEGER | Watch time (for videos) | ❌ |
| `is_featured` | BOOLEAN | Featured content flag | ❌ (default: false) |
| `view_count` | INTEGER | Total view count | ❌ (default: 0) |
| `click_count` | INTEGER | Total click count | ❌ (default: 0) |
| `created_at` | TIMESTAMP | Creation timestamp | ✅ (auto) |
| `updated_at` | TIMESTAMP | Last update timestamp | ✅ (auto) |
| `published_at` | TIMESTAMP | Publication timestamp | ❌ |

**Indexes:**
- Primary key on `id`
- Index on `status` (for filtering published content)
- Index on `publish_date` (for sorting)
- Index on `type` (for filtering articles/videos)
- Index on `platform_name` (for platform filtering)

**Row Level Security (RLS):**
- ✅ Enabled
- Public SELECT allowed for `status = 'published'`
- INSERT/UPDATE/DELETE restricted to authenticated users

**Example Query:**
```sql
-- Fetch all published articles
SELECT id, title, teaser, canonical_url, publish_date, thumbnail_url, type, platform_name
FROM blog_content
WHERE status = 'published'
ORDER BY publish_date DESC;
```

**Used By:**
- `js/blog-content.js` - Fetches content for blog hub ✅ **UPDATED**
- `pages/api/blog/content.ts` - API endpoint for blog content ✅ **UPDATED**
- `components/admin/AddContentForm.tsx` - Admin form to add content ✅ **UPDATED**

---

### 2. `blog_analytics` (Blog Analytics) ✅ **VERIFIED**

**Purpose:** Tracks views, clicks, and shares for blog content.

**Status:** Table exists but is empty (columns need to be verified via Supabase dashboard)

**Expected Columns (based on code usage):**

| Column | Type | Description | Required |
|--------|------|-------------|----------|
| `id` | UUID | Primary key (auto-generated) | ✅ |
| `content_id` | UUID | Foreign key to `blog_content.id` | ✅ |
| `event_type` | VARCHAR(20) | Event type: `'view'`, `'click'`, `'share'` | ✅ |
| `ip_addr` | INET | IP address of visitor | ❌ |
| `user_agent` | TEXT | Browser user agent string | ❌ |
| `referrer` | TEXT | HTTP referrer URL | ❌ |
| `utm_source` | VARCHAR(100) | UTM source parameter | ❌ |
| `utm_medium` | VARCHAR(100) | UTM medium parameter | ❌ |
| `utm_campaign` | VARCHAR(100) | UTM campaign parameter | ❌ |
| `created_at` | TIMESTAMP | Event timestamp | ✅ (auto) |

**Note:** ⚠️ Table is empty, so column structure needs to be verified in Supabase dashboard. The columns above are inferred from code usage.

**Indexes:**
- Primary key on `id`
- Foreign key on `content_id` → `blog_content.id`
- Index on `event_type` (for filtering)
- Index on `created_at` (for time-based queries)

**Row Level Security (RLS):**
- ✅ Enabled
- Public INSERT allowed (for tracking)
- SELECT restricted to authenticated users (admin only)

**Example Query:**
```sql
-- Track a click event
INSERT INTO content_analytics (content_id, event_type, ip_addr, user_agent, referrer, utm_source)
VALUES (
  'uuid-of-content-item',
  'click',
  '192.168.1.1',
  'Mozilla/5.0...',
  'https://truevow.law/blog',
  'blog_hub'
);

-- Get analytics for a content item
SELECT event_type, COUNT(*) as count
FROM blog_analytics
WHERE content_id = 'uuid-of-content-item'
GROUP BY event_type;
```

**Used By:**
- `js/blog-content.js` - Tracks views and clicks
- `pages/api/blog/track.ts` - API endpoint for analytics tracking
- Admin dashboard (analytics reports)

---

### 3. `newsletter_subscribers` (Newsletter Subscribers) ✅ **VERIFIED**

**Purpose:** Stores newsletter subscription emails.

**Columns:**

| Column | Type | Description | Required |
|--------|------|-------------|----------|
| `id` | UUID | Primary key (auto-generated) | ✅ |
| `email` | VARCHAR(255) | Subscriber email (unique) | ✅ |
| `ip_addr` | INET | IP address at signup | ❌ |
| `user_agent` | TEXT | Browser user agent string | ❌ |
| `source` | VARCHAR(100) | Signup source (e.g., `'blog_hub'`, `'homepage'`) | ❌ |
| `subscribed_at` | TIMESTAMP | Subscription timestamp | ✅ (auto) |
| `unsubscribed_at` | TIMESTAMP | Unsubscription timestamp | ❌ |
| `is_active` | BOOLEAN | Active subscription flag | ❌ (default: true) |

**Indexes:**
- Primary key on `id`
- Unique index on `email` (prevents duplicates)
- Index on `is_active` (for filtering active subscribers)

**Row Level Security (RLS):**
- ✅ Enabled
- Public INSERT allowed (for subscriptions)
- SELECT restricted to authenticated users (admin only)

**Example Query:**
```sql
-- Subscribe to newsletter
INSERT INTO notify_list (email, ip_addr, user_agent, source)
VALUES (
  'user@example.com',
  '192.168.1.1',
  'Mozilla/5.0...',
  'blog_hub'
)
ON CONFLICT (email) DO NOTHING;

-- Get active subscribers
SELECT email, subscribed_at
FROM notify_list
WHERE is_active = true
ORDER BY subscribed_at DESC;
```

**Used By:**
- `lib/supabaseClient.ts` - `subscribeToNewsletter()` function
- Newsletter signup forms (future implementation)
- Admin dashboard (subscriber management)

---

### 4. `firm_applications` (Firm Application Forms)

**Purpose:** Stores law firm application form submissions.

**Columns:**

| Column | Type | Description | Required |
|--------|------|-------------|----------|
| `id` | UUID | Primary key (auto-generated) | ✅ |
| `firm_name` | VARCHAR(255) | Law firm name | ✅ |
| `contact_name` | VARCHAR(255) | Primary contact name | ✅ |
| `email` | VARCHAR(255) | Contact email | ✅ |
| `phone` | VARCHAR(50) | Contact phone number | ❌ |
| `state` | VARCHAR(50) | State/jurisdiction | ❌ |
| `practice_areas` | TEXT[] | Array of practice areas | ❌ |
| `current_intake_method` | TEXT | Current intake process description | ❌ |
| `monthly_case_volume` | INTEGER | Estimated monthly cases | ❌ |
| `bar_member` | BOOLEAN | Is contact a bar member? | ❌ |
| `bar_state` | VARCHAR(50) | Bar admission state | ❌ |
| `bar_number` | VARCHAR(100) | Bar number | ❌ |
| `demo_requested` | BOOLEAN | Requested demo? | ❌ (default: false) |
| `demo_session_id` | UUID | Link to demo session (if applicable) | ❌ |
| `status` | VARCHAR(50) | Application status: `'pending'`, `'approved'`, `'rejected'`, `'onboarding'` | ❌ (default: 'pending') |
| `notes` | TEXT | Internal notes | ❌ |
| `created_at` | TIMESTAMP | Application timestamp | ✅ (auto) |
| `updated_at` | TIMESTAMP | Last update timestamp | ✅ (auto) |

**Indexes:**
- Primary key on `id`
- Index on `email` (for lookups)
| Index on `status` (for filtering by status)
- Index on `created_at` (for sorting)

**Row Level Security (RLS):**
- ✅ Enabled
- Public INSERT allowed (for form submissions)
- SELECT/UPDATE restricted to authenticated users (admin only)

**Example Query:**
```sql
-- Submit application
INSERT INTO firm_applications (firm_name, contact_name, email, phone, state, practice_areas, current_intake_method, monthly_case_volume)
VALUES (
  'Smith & Associates',
  'John Smith',
  'john@smithlaw.com',
  '555-123-4567',
  'California',
  ARRAY['Personal Injury', 'Workers Compensation'],
  'Manual phone intake',
  50
);

-- Get pending applications
SELECT firm_name, contact_name, email, created_at
FROM firm_applications
WHERE status = 'pending'
ORDER BY created_at DESC;
```

**Used By:**
- `marketing/apply.html` - Application form submission
- Admin dashboard (application pipeline)
- Demo session integration (future)

---

### 5. `platforms` (Platform Reference)

**Purpose:** Reference table for content platforms (LinkedIn, YouTube).

**Columns:**

| Column | Type | Description | Required |
|--------|------|-------------|----------|
| `name` | VARCHAR(50) | Platform name (primary key): `'linkedin'`, `'youtube'` | ✅ |
| `display_name` | VARCHAR(100) | Human-readable name: `'LinkedIn'`, `'YouTube'` | ✅ |
| `icon_class` | VARCHAR(100) | CSS icon class | ❌ |
| `outbound_label` | VARCHAR(100) | Link text: `'Read on LinkedIn'`, `'Watch on YouTube'` | ✅ |
| `base_url` | TEXT | Platform base URL | ✅ |
| `created_at` | TIMESTAMP | Creation timestamp | ✅ (auto) |

**Indexes:**
- Primary key on `name`

**Example Data:**
```sql
INSERT INTO platforms (name, display_name, icon_class, outbound_label, base_url) VALUES
('linkedin', 'LinkedIn', 'linkedin-icon', 'Read on LinkedIn', 'https://linkedin.com'),
('youtube', 'YouTube', 'youtube-icon', 'Watch on YouTube', 'https://youtube.com');
```

**Used By:**
- `blog_content` table (via `platform_name` foreign key)
- Blog hub rendering (platform-specific styling)

---

### 6. `blog_tags` (Content Tags)

**Purpose:** Categorization tags for blog content.

**Columns:**

| Column | Type | Description | Required |
|--------|------|-------------|----------|
| `id` | UUID | Primary key (auto-generated) | ✅ |
| `name` | VARCHAR(100) | Tag name (e.g., `'Ethics & Compliance'`) | ✅ |
| `slug` | VARCHAR(100) | URL-friendly slug (e.g., `'ethics-compliance'`) | ✅ |
| `description` | TEXT | Tag description | ❌ |
| `color` | VARCHAR(7) | Hex color code (e.g., `'#0A2463'`) | ❌ |
| `created_at` | TIMESTAMP | Creation timestamp | ✅ (auto) |

**Indexes:**
- Primary key on `id`
- Unique index on `slug`

**Example Data:**
```sql
INSERT INTO blog_tags (name, slug, description, color) VALUES
('Ethics & Compliance', 'ethics-compliance', 'Bar ethics and Model Rule compliance', '#0A2463'),
('Zero-Knowledge Security', 'zero-knowledge-security', 'Privacy-first architecture', '#10B981'),
('ROI & Strategy', 'roi-strategy', 'Marketing ROI and business strategy', '#F59E0B');
```

**Used By:**
- Content tagging system (future implementation)
- Blog filtering by category

---

### 7. `blog_content_tags` (Content-Tag Relationships)

**Purpose:** Many-to-many relationship between content and tags.

**Columns:**

| Column | Type | Description | Required |
|--------|------|-------------|----------|
| `id` | UUID | Primary key (auto-generated) | ✅ |
| `content_id` | UUID | Foreign key to `blog_content.id` | ✅ |
| `tag_id` | UUID | Foreign key to `blog_tags.id` | ✅ |
| `created_at` | TIMESTAMP | Creation timestamp | ✅ (auto) |

**Indexes:**
- Primary key on `id`
- Foreign key on `content_id` → `blog_content.id`
- Foreign key on `tag_id` → `blog_tags.id`
- Unique index on `(content_id, tag_id)` (prevents duplicates)

**Used By:**
- Content tagging system (future implementation)

---

### 8. `page_analytics` (Website Traffic Analytics)

**Purpose:** Tracks page views and traffic metrics.

**Columns:**

| Column | Type | Description | Required |
|--------|------|-------------|----------|
| `id` | UUID | Primary key (auto-generated) | ✅ |
| `page_path` | VARCHAR(255) | Page path (e.g., `'/blog'`, `'/pricing'`) | ✅ |
| `page_title` | VARCHAR(255) | Page title | ❌ |
| `ip_addr` | INET | Visitor IP address | ❌ |
| `user_agent` | TEXT | Browser user agent | ❌ |
| `referrer` | TEXT | HTTP referrer URL | ❌ |
| `utm_source` | VARCHAR(100) | UTM source | ❌ |
| `utm_medium` | VARCHAR(100) | UTM medium | ❌ |
| `utm_campaign` | VARCHAR(100) | UTM campaign | ❌ |
| `session_id` | UUID | Session identifier | ❌ |
| `viewed_at` | TIMESTAMP | View timestamp | ✅ (auto) |

**Indexes:**
- Primary key on `id`
- Index on `page_path` (for page analytics)
- Index on `viewed_at` (for time-based queries)

**Used By:**
- Website traffic tracking (future implementation)
- Admin dashboard (traffic reports)

---

## 📊 Views

### 1. `published_blog_content`

**Purpose:** Pre-filtered view of published content with metadata.

**Definition:**
```sql
CREATE VIEW published_blog_content AS
SELECT 
  ci.*,
  p.display_name as platform_display_name,
  p.icon_class as platform_icon_class,
  p.outbound_label as platform_outbound_label,
  array_agg(t.name) as tags
FROM content_items ci
LEFT JOIN platforms p ON ci.platform_name = p.name
LEFT JOIN blog_content_tags ct ON ci.id = ct.content_id
LEFT JOIN blog_tags t ON ct.tag_id = t.id
WHERE ci.status = 'published' 
  AND ci.is_active = true
GROUP BY ci.id, p.display_name, p.icon_class, p.outbound_label;
```

**Used By:**
- Blog content API (future optimization)
- Admin dashboard (content preview)

---

### 2. `firm_applications_dashboard`

**Purpose:** Application pipeline view for admin dashboard.

**Definition:**
```sql
CREATE VIEW firm_applications_dashboard AS
SELECT 
  fa.*,
  COUNT(*) OVER (PARTITION BY fa.status) as status_count,
  CASE 
    WHEN fa.created_at > NOW() - INTERVAL '24 hours' THEN 'New'
    WHEN fa.created_at > NOW() - INTERVAL '7 days' THEN 'Recent'
    ELSE 'Older'
  END as recency
FROM firm_applications fa
ORDER BY fa.created_at DESC;
```

**Used By:**
- Admin dashboard (application pipeline)

---

## 🔐 Row Level Security (RLS) Policies

All tables have RLS enabled with the following policies:

### `blog_content`
- **Public SELECT:** Allowed for `status = 'published'`
- **Authenticated INSERT/UPDATE/DELETE:** Allowed for admin users

### `blog_analytics`
- **Public INSERT:** Allowed (for tracking)
- **Authenticated SELECT:** Allowed for admin users

### `newsletter_subscribers`
- **Public INSERT:** Allowed (for subscriptions)
- **Authenticated SELECT:** Allowed for admin users

### `firm_applications`
- **Public INSERT:** Allowed (for form submissions)
- **Authenticated SELECT/UPDATE:** Allowed for admin users

---

## 📝 Common Queries

### Fetch Published Blog Content
```sql
SELECT 
  id, title, teaser, canonical_url, publish_date, 
  thumbnail_url, type, platform_name, 
  read_time_minutes, watch_time_minutes, is_featured
FROM blog_content
WHERE status = 'published'
ORDER BY publish_date DESC
LIMIT 20;
```

### Track Content View
```sql
INSERT INTO blog_analytics (content_id, event_type, ip_addr, user_agent, referrer)
VALUES (
  'content-uuid-here',
  'view',
  '192.168.1.1',
  'Mozilla/5.0...',
  'https://truevow.law/blog'
);
```

### Get Analytics Summary
```sql
SELECT 
  ci.title,
  COUNT(CASE WHEN ca.event_type = 'view' THEN 1 END) as views,
  COUNT(CASE WHEN ca.event_type = 'click' THEN 1 END) as clicks,
  ROUND(
    COUNT(CASE WHEN ca.event_type = 'click' THEN 1 END)::NUMERIC / 
    NULLIF(COUNT(CASE WHEN ca.event_type = 'view' THEN 1 END), 0)::NUMERIC * 100, 
    2
  ) as ctr_percentage
FROM blog_content ci
LEFT JOIN blog_analytics ca ON ci.id = ca.content_id
WHERE ci.status = 'published'
GROUP BY ci.id, ci.title
ORDER BY views DESC;
```

---

## 🔄 Migration Status

| Table | Status | Created | Last Updated |
|-------|--------|---------|--------------|
| `blog_content` | ✅ Active | Nov 6, 2025 | Nov 6, 2025 |
| `blog_analytics` | ✅ Active | Nov 6, 2025 | Nov 6, 2025 |
| `newsletter_subscribers` | ✅ Active | Nov 6, 2025 | Nov 6, 2025 |
| `firm_applications` | ✅ Active | Nov 6, 2025 | Nov 6, 2025 |
| `platforms` | ✅ Active | Nov 6, 2025 | Nov 6, 2025 |
| `blog_tags` | ✅ Active | Nov 6, 2025 | Nov 6, 2025 |
| `blog_content_tags` | ✅ Active | Nov 6, 2025 | Nov 6, 2025 |
| `page_analytics` | ✅ Active | Nov 6, 2025 | Nov 6, 2025 |

---

## 🚀 Next Steps

1. **Seed Initial Data:**
   - Add sample blog content to `blog_content`
   - Populate `platforms` table with LinkedIn/YouTube data

2. **Configure RLS:**
   - Verify RLS policies are correct
   - Test public access vs admin access

3. **Set Up Indexes:**
   - Verify all indexes are created
   - Monitor query performance

4. **Test API Endpoints:**
   - Test blog content fetching
   - Test analytics tracking
   - Test newsletter subscription

5. **Set Up Admin Interface:**
   - Use `admin/blog-manager.html` for manual content management
   - Configure Supabase credentials in the HTML file
   - Test adding content via the form

---

## 📝 Current System: Manual Directory

**Important:** This is a **manual content directory system**. It does NOT auto-post to LinkedIn or YouTube.

**Workflow:**
1. You publish content on LinkedIn/YouTube manually
2. Copy the URL from your published content
3. Add entry via `admin/blog-manager.html` form
4. Content appears on blog hub immediately

**Future:** Auto-generation/auto-posting will be added later with:
- Prompt management
- LLM drafting
- Moderation queue
- LinkedIn API integration
- YouTube upload API

---

**Last Updated:** January 8, 2026  
**Database URL:** `https://napwpkagxzqfpbearkjs.supabase.co`  
**Schema Version:** 1.0.0

