# Getting Started

<cite>
**Referenced Files in This Document**
- [README.md](file://README.md)
- [package.json](file://package.json)
- [.env.local](file://.env.local)
- [marketing/index.html](file://marketing/index.html)
- [PRODUCTION_DEPLOY/README_FIRST.txt](file://PRODUCTION_DEPLOY/README_FIRST.txt)
- [PRODUCTION_DEPLOY/DEPLOYMENT_GUIDE.txt](file://PRODUCTION_DEPLOY/DEPLOYMENT_GUIDE.txt)
- [PRODUCTION_DEPLOY/marketing/index.html](file://PRODUCTION_DEPLOY/marketing/index.html)
- [PRODUCTION_DEPLOY/js/load-components.js](file://PRODUCTION_DEPLOY/js/load-components.js)
- [components/STANDARD_NAVIGATION.html](file://components/STANDARD_NAVIGATION.html)
- [js/blog-content.js](file://js/blog-content.js)
- [LAUNCH_READY_SUMMARY.md](file://LAUNCH_READY_SUMMARY.md)
</cite>

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Local Development Setup](#local-development-setup)
4. [Environment Configuration](#environment-configuration)
5. [Development Workflow](#development-workflow)
6. [Running Static HTML Locally](#running-static-html-locally)
7. [Testing Functionality](#testing-functionality)
8. [Initial Deployment Preparation](#initial-deployment-preparation)
9. [Troubleshooting](#troubleshooting)
10. [Conclusion](#conclusion)

## Introduction
This guide helps you set up and develop the TrueVow Website locally, test functionality, and prepare for deployment. The project is a static HTML website that integrates with Supabase for dynamic content and form submissions. It includes marketing pages, legal pages, reusable components, and JavaScript modules for blog content and component loading.

## Prerequisites
Before starting, ensure you have:
- A modern code editor (e.g., VS Code)
- Git installed and configured
- Node.js (version 18+ recommended) for optional local server and scripts
- A browser for testing (Chrome, Firefox, Safari, Edge)

These requirements are confirmed by the project’s package configuration and documentation.

**Section sources**
- [package.json](file://package.json#L30-L32)
- [README.md](file://README.md#L1-L20)

## Local Development Setup
Follow these steps to prepare your local environment:

1. **Clone the repository** using Git.
2. **Install dependencies** (Node.js scripts and libraries):
   - Run: `npm install`
3. **Verify Node.js version**:
   - Confirm Node.js 18+ is installed as required by the project.

These steps align with the project’s package configuration and development workflow.

**Section sources**
- [package.json](file://package.json#L5-L22)
- [package.json](file://package.json#L30-L32)

## Environment Configuration
The project uses Supabase for backend functionality. For local development and testing, configure the Supabase credentials in the relevant files.

- **Supabase configuration in HTML files**:
  - The homepage demonstrates Supabase configuration embedded in the HTML for demo form submissions.
  - Update the Supabase URL and anonymous key to match your Supabase project.

- **Environment variables for local scripts**:
  - The `.env.local` file contains Supabase connection details and other secrets for local integrations.
  - Keep this file private and do not commit it to version control.

- **Production deployment configuration**:
  - The production deployment package includes pre-configured Supabase credentials embedded in HTML files.
  - Verify the Supabase URL and anonymous key match your project before deploying.

Important notes:
- The Supabase anonymous key is safe for client-side use and is used to connect to Supabase REST APIs.
- Service role keys must never be exposed publicly.

**Section sources**
- [marketing/index.html](file://marketing/index.html#L84-L86)
- [.env.local](file://.env.local#L15-L28)
- [PRODUCTION_DEPLOY/README_FIRST.txt](file://PRODUCTION_DEPLOY/README_FIRST.txt#L95-L106)
- [README.md](file://README.md#L194-L205)

## Development Workflow
The project uses a straightforward static HTML workflow with reusable components and JavaScript modules:

- **File organization**:
  - Marketing pages: `marketing/*.html`
  - Legal pages: `legal/*.html`
  - Reusable components: `components/*.html`
  - JavaScript modules: `js/*.js`
  - Assets: `assets/*`

- **Component loading**:
  - The component loader script fetches navigation and footer components and injects them into pages.
  - Placeholders for components are defined in pages and replaced at runtime.

- **Blog content engine**:
  - The blog content module fetches published content from Supabase and renders cards dynamically.
  - It supports filtering by type and featured status, and tracks analytics.

- **Making changes**:
  - Edit HTML files directly; save and refresh the browser to see updates.
  - Update blog content via the Supabase dashboard; refresh the blog page to reflect changes.

**Section sources**
- [README.md](file://README.md#L46-L120)
- [PRODUCTION_DEPLOY/js/load-components.js](file://PRODUCTION_DEPLOY/js/load-components.js#L1-L58)
- [js/blog-content.js](file://js/blog-content.js#L1-L120)

## Running Static HTML Locally
There are two common approaches to serve static HTML locally:

- **Option 1: Simple HTTP Server**
  - Use Python, Node.js, or PHP to start a local server:
    - Python: `python -m http.server 8000`
    - Node.js: `npx http-server -p 8000`
    - PHP: `php -S localhost:8000`
  - Access the site at `http://localhost:8000`.

- **Option 2: VS Code Live Server Extension**
  - Install the “Live Server” extension.
  - Right-click on an HTML file (e.g., `marketing/index.html`) and select “Open with Live Server.”
  - The browser opens automatically and reloads on file changes.

Choose the option that fits your workflow. Both enable testing of navigation, forms, and components.

**Section sources**
- [README.md](file://README.md#L466-L490)

## Testing Functionality
To validate functionality locally:

- **Blog content**:
  - Ensure the blog page loads content from Supabase.
  - Verify filtering by type and featured status.
  - Check analytics tracking does not break the page.

- **Forms**:
  - Test the demo form submission on the homepage.
  - Verify phone number normalization and validation.
  - Confirm the form posts to the Supabase table configured in the HTML.

- **Navigation and components**:
  - Confirm the standardized navigation and footer appear consistently across pages.
  - Validate internal links and responsive design on mobile.

- **Console and network tabs**:
  - Use the browser developer tools to check for JavaScript errors and network failures.

**Section sources**
- [js/blog-content.js](file://js/blog-content.js#L26-L102)
- [marketing/index.html](file://marketing/index.html#L152-L200)
- [components/STANDARD_NAVIGATION.html](file://components/STANDARD_NAVIGATION.html#L1-L25)

## Initial Deployment Preparation
Prepare for production deployment by following these steps:

- **Review production deployment package**:
  - The `PRODUCTION_DEPLOY` folder contains only the files needed for live deployment.
  - It includes marketing pages, legal pages, components, JavaScript, assets, and the root application form.

- **Upload to Namecheap**:
  - Upload the folders from the production package to `/public_html/` on your Namecheap hosting.
  - Ensure the folder structure matches the deployment guide.

- **Set homepage**:
  - Option A: Move `marketing/index.html` to `/public_html/index.html`.
  - Option B: Create a redirect in `.htaccess` to route the root to the marketing homepage.

- **Enable SSL certificate**:
  - In cPanel, enable AutoSSL for the domain to ensure HTTPS.

- **Post-deployment verification**:
  - Test key pages (e.g., homepage, pricing, privacy).
  - Submit a test demo form and confirm it appears in the Supabase table.
  - Add blog content to the Supabase table and verify it displays on the blog page.

- **Supabase configuration**:
  - Confirm the Supabase URL and anonymous key are correctly configured in the production HTML files.

**Section sources**
- [PRODUCTION_DEPLOY/README_FIRST.txt](file://PRODUCTION_DEPLOY/README_FIRST.txt#L1-L146)
- [PRODUCTION_DEPLOY/DEPLOYMENT_GUIDE.txt](file://PRODUCTION_DEPLOY/DEPLOYMENT_GUIDE.txt#L60-L110)
- [PRODUCTION_DEPLOY/DEPLOYMENT_GUIDE.txt](file://PRODUCTION_DEPLOY/DEPLOYMENT_GUIDE.txt#L110-L125)
- [PRODUCTION_DEPLOY/DEPLOYMENT_GUIDE.txt](file://PRODUCTION_DEPLOY/DEPLOYMENT_GUIDE.txt#L125-L147)
- [LAUNCH_READY_SUMMARY.md](file://LAUNCH_READY_SUMMARY.md#L43-L76)

## Troubleshooting
Common issues and resolutions:

- **Blog content not loading**:
  - Check the browser console for errors.
  - Verify Supabase URL and anonymous key in the blog content module.
  - Ensure the Supabase table has published content and RLS policies allow public read access.

- **Forms not submitting**:
  - Verify the Supabase endpoint URL in the HTML form matches your project.
  - Check for CORS errors and ensure the endpoint is reachable.
  - Validate phone number formatting and required fields.

- **Supabase connection errors**:
  - Confirm the Supabase URL format and anonymous key are correct.
  - Ensure the Supabase project is active and the API is enabled.

- **Component placeholders not rendering**:
  - Confirm the component loader script runs after the DOM is ready.
  - Verify the placeholder IDs exist in the HTML.

- **File paths and permissions on Namecheap**:
  - Ensure file paths are correct and case-sensitive.
  - Verify file permissions are set appropriately.

**Section sources**
- [README.md](file://README.md#L502-L547)
- [PRODUCTION_DEPLOY/DEPLOYMENT_GUIDE.txt](file://PRODUCTION_DEPLOY/DEPLOYMENT_GUIDE.txt#L179-L196)

## Conclusion
You now have everything needed to set up the TrueVow Website locally, test functionality, and prepare for deployment. Use the local development workflow to iterate quickly, then follow the production deployment steps to launch on Namecheap. Keep the Supabase configuration secure and leverage the reusable components and JavaScript modules to streamline updates.