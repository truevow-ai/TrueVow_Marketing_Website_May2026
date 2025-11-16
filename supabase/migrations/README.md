# Supabase Migration Files

This folder contains SQL migration files for database setup.

## Migration Files:

### `001_phase1_website_schema.sql`
Marketing website database schema with tables for:
- Blog content
- Newsletter subscribers
- Contact form submissions
- Firm applications
- Analytics

### `001_initial_blog_schema.sql`
Blog hub database schema with:
- Content items table
- Platforms table
- Tags table
- Analytics table

### `002_phase1_tenant_app_schema.sql`
Tenant application database schema (migrated from TruthLine)

### `003_saas_admin_schema.sql`
SaaS admin database schema for tenant management

---

**⚠️ IMPORTANT:** These SQL files need to be restored from your Supabase dashboard or backups.

To recreate:
1. Go to Supabase Dashboard → SQL Editor
2. Export existing schemas
3. Save as migration files in this folder

