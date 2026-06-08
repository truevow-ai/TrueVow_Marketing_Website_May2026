# Getting Started

<cite>
**Referenced Files in This Document**
- [README.md](file://README.md)
- [package.json](file://package.json)
- [.env.local](file://.env.local)
- [scripts/setup_env_local.ps1](file://scripts/setup_env_local.ps1)
- [PRODUCTION_DEPLOY/DEPLOYMENT_GUIDE.txt](file://PRODUCTION_DEPLOY/DEPLOYMENT_GUIDE.txt)
- [PRODUCTION_DEPLOY/TEST_REPORT.md](file://PRODUCTION_DEPLOY/TEST_REPORT.md)
- [js/blog-content.js](file://js/blog-content.js)
- [js/load-components.js](file://js/load-components.js)
- [marketing/index.html](file://marketing/index.html)
- [marketing/blog.html](file://marketing/blog.html)
- [components/STANDARD_NAVIGATION.html](file://components/STANDARD_NAVIGATION.html)
- [admin/README.md](file://admin/README.md)
</cite>

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Local Development Setup](#local-development-setup)
4. [Environment Configuration](#environment-configuration)
5. [Initial Testing](#initial-testing)
6. [Quick Deployment](#quick-deployment)
7. [Troubleshooting](#troubleshooting)
8. [Best Practices](#best-practices)
9. [Next Steps](#next-steps)

## Introduction
This guide helps you set up and run the TrueVow Website project locally, configure environment variables, test core functionality, and deploy to Namecheap static hosting. The project is a static HTML website that integrates with Supabase for dynamic content and form submissions.

## Prerequisites
Before starting, ensure you have:
- Basic web development knowledge (HTML, CSS, JavaScript)
- Node.js installed (required for optional database scripts and tooling)
- npm (Node.js package manager)
- A modern web browser for testing

These requirements are confirmed by the project configuration and scripts.

**Section sources**
- [package.json](file://package.json#L30-L32)

## Local Development Setup
Choose one of the following methods to serve the site locally:

### Option 1: Python HTTP Server
- Start a local server in the project root:
  - Python 3: `python -m http.server 8000`
  - Access the site at `http://localhost:8000`

### Option 2: Node.js http-server
- Install globally: `npm install -g http-server`
- Start server: `npx http-server -p 8000`
- Access the site at `http://localhost:8000`

### Option 3: VS Code Live Server Extension
- Install the "Live Server" extension
- Right-click any HTML file (e.g., `marketing/index.html`) and choose "Open with Live Server"

Notes:
- The site uses embedded components and JavaScript that rely on relative paths. Serving from the project root ensures assets and components load correctly.
- The production package demonstrates a clean deployment structure suitable for Namecheap static hosting.

**Section sources**
- [README.md](file://README.md#L466-L491)
- [PRODUCTION_DEPLOY/DEPLOYMENT_GUIDE.txt](file://PRODUCTION_DEPLOY/DEPLOYMENT_GUIDE.txt#L60-L91)

## Environment Configuration
The project supports environment variables for local development and database operations. Follow these steps:

### 1. Create or Update .env.local
- Use the provided PowerShell script to generate a `.env.local` file with required variables:
  - Run: `.\scripts\setup_env_local.ps1`
  - This creates `.env.local` with Supabase credentials and database settings
- Alternatively, manually create `.env.local` in the project root with the following structure:
  - `MARKETING_DATABASE_URL`: Supabase database connection string
  - `MARKETING_SUPABASE_URL`: Supabase project URL
  - `MARKETING_SUPABASE_ANON_KEY`: Supabase public anonymous key
  - `MARKETING_SUPABASE_SERVICE_ROLE_SECRET`: Supabase service role secret (for migrations)

### 2. Supabase Credentials in JavaScript
- The blog content loader (`js/blog-content.js`) includes Supabase configuration constants:
  - `SUPABASE_URL`: Supabase project URL
  - `SUPABASE_ANON_KEY`: Supabase public anonymous key
- Update these values to match your Supabase project settings.

### 3. Admin Interface Credentials
- The admin blog manager (`admin/blog-manager.html`) also requires Supabase credentials:
  - Update `SUPABASE_URL` and `SUPABASE_ANON_KEY` in the JavaScript section of the admin file.

Security reminder:
- The anonymous key is safe for client-side use.
- Never expose the service role key in client-side code.

**Section sources**
- [.env.local](file://.env.local#L1-L38)
- [scripts/setup_env_local.ps1](file://scripts/setup_env_local.ps1#L1-L34)
- [js/blog-content.js](file://js/blog-content.js#L11-L12)
- [admin/README.md](file://admin/README.md#L50-L55)

## Initial Testing
Perform these checks to verify the site works correctly:

### 1. Blog Content Loading
- Open `marketing/blog.html` in your browser
- Verify:
  - Filter buttons (All Content, Articles, Videos) are present
  - Content grid renders without errors
  - Console shows no JavaScript errors
- Expected behavior:
  - Empty content grid is normal until Supabase has published content

### 2. Form Functionality
- On `marketing/index.html`, locate the demo form:
  - Fields: First Name, Last Name, Phone Number, Email Address, Practice Area, Law Firm Name, Consent
  - Submit button: "Schedule My Live Demo"
- Validate:
  - Form renders correctly
  - Client-side phone validation triggers for invalid numbers
  - No console errors during form interaction

### 3. Responsive Design
- Resize your browser window to simulate mobile:
  - Navigation collapses appropriately
  - Forms and cards remain usable
  - No horizontal scrolling on small screens

### 4. Component Loading
- Confirm that navigation and footer load via the component loader:
  - The loader fetches `components/STANDARD_NAVIGATION.html` and injects it into the page
  - Verify the navigation appears consistently across pages

### 5. Production Package Validation
- The production deployment package includes:
  - 46 files, 2.26 MB total
  - All marketing, legal, components, assets, and JavaScript files
- Use the test report as a reference for expected behavior and pass rates

**Section sources**
- [marketing/blog.html](file://marketing/blog.html#L1-L200)
- [marketing/index.html](file://marketing/index.html#L1-L200)
- [js/blog-content.js](file://js/blog-content.js#L319-L350)
- [js/load-components.js](file://js/load-components.js#L36-L55)
- [components/STANDARD_NAVIGATION.html](file://components/STANDARD_NAVIGATION.html#L1-L25)
- [PRODUCTION_DEPLOY/TEST_REPORT.md](file://PRODUCTION_DEPLOY/TEST_REPORT.md#L1-L505)

## Quick Deployment
Deploy the site to Namecheap static hosting using the production package:

### Step 1: Prepare Files
- Use the production deployment package located at `PRODUCTION_DEPLOY/`
- Upload the following to your Namecheap domain root (`/public_html/`):
  - `marketing/` (all HTML pages)
  - `legal/` (all HTML pages)
  - `components/` (reusable components)
  - `assets/` (images, logos)
  - `js/` (JavaScript files)
  - `widgets/` (chatbot widget)
  - `apply.html` (root application form)

### Step 2: Set Homepage
- Option A (Recommended): Move the homepage to the root
  - Copy `marketing/index.html` to `/public_html/index.html`
- Option B: Set up a redirect
  - Create `.htaccess` in `/public_html/` with: `Redirect 301 / /marketing/index.html`

### Step 3: Verify Deployment
- Visit your domain (e.g., `https://truevow.law`)
- Test key pages:
  - Homepage loads
  - Pricing page: `truevow.law/marketing/pricing.html`
  - Privacy policy: `truevow.law/legal/privacy.html`
  - Demo form submission works
  - Navigation and footer links function

### Step 4: Enable SSL Certificate
- In Namecheap cPanel, enable AutoSSL for your domain
- Wait 5–10 minutes for certificate activation
- Verify HTTPS works: `https://truevow.law`

### Post-Deployment Tasks
- Add blog content:
  - Log into Supabase dashboard
  - Add content to the `web_blog_content` table
  - Set `status = 'published'` for live posts
- Test demo form:
  - Submit a test demo request
  - Check the `web_demo_requests` table
  - Verify data is captured correctly

**Section sources**
- [PRODUCTION_DEPLOY/DEPLOYMENT_GUIDE.txt](file://PRODUCTION_DEPLOY/DEPLOYMENT_GUIDE.txt#L60-L147)

## Troubleshooting
Common issues and solutions:

### Blog Content Not Loading
- Symptoms:
  - Blog page shows "Loading..." or empty
- Solutions:
  - Check browser console for errors
  - Verify Supabase URL and API key in `js/blog-content.js`
  - Confirm the `web_blog_content` table has rows with `status = 'published'`
  - Ensure Row Level Security (RLS) policies allow public read access

### Forms Not Submitting
- Symptoms:
  - 404 or CORS errors on form submission
- Solutions:
  - Verify Supabase URL and anonymous key are correct
  - Check that the `web_demo_requests` table exists
  - Confirm RLS policies allow INSERT for the demo form table

### Supabase Connection Errors
- Symptoms:
  - "Failed to fetch" or "Network error"
- Solutions:
  - Verify `SUPABASE_URL` format: `https://xxx.supabase.co` (no trailing slash)
  - Verify `SUPABASE_ANON_KEY` starts with `eyJ...`
  - Ensure the Supabase project is active and API is enabled

### Production Deployment Issues
- Symptoms:
  - Pages not loading after upload
  - Forms not working on live site
- Solutions:
  - Check file paths are correct (case-sensitive on Linux servers)
  - Verify `.html` extensions are included in URLs
  - Confirm file permissions (files: 644, folders: 755)
  - Ensure assets are uploaded correctly and paths are relative

**Section sources**
- [README.md](file://README.md#L502-L547)
- [PRODUCTION_DEPLOY/DEPLOYMENT_GUIDE.txt](file://PRODUCTION_DEPLOY/DEPLOYMENT_GUIDE.txt#L182-L196)

## Best Practices
- Keep Supabase credentials secure:
  - Use the anonymous key for client-side operations
  - Never expose the service role key
- Maintain consistent component usage:
  - Navigation and footer are loaded via `js/load-components.js`
  - Ensure placeholders exist in your HTML for component injection
- Test across devices:
  - Validate mobile responsiveness and touch interactions
- Monitor performance:
  - The production package is optimized (2.26 MB, 46 files)
  - Keep assets compressed and avoid unnecessary scripts

## Next Steps
- Deploy to Namecheap and verify all pages load
- Add blog content to Supabase and confirm it appears on the blog hub
- Test form submissions and verify data in Supabase
- Enable SSL and monitor site performance
- Consider adding analytics and setting up automated backups