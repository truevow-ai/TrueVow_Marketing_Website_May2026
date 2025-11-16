# 🔐 Admin Interface - Blog Content Manager

**Purpose:** Clean, simple interface for manually managing blog hub content  
**Location:** `admin/blog-manager.html`  
**Status:** ✅ Ready to Use

---

## 🎯 Overview

This is a **manual content directory system**. It does NOT:
- ❌ Auto-post to LinkedIn or YouTube
- ❌ Auto-generate content
- ❌ Auto-upload videos

**It DOES:**
- ✅ Provide a clean form to add blog entries
- ✅ Store catalog data in Supabase
- ✅ Display entries on the blog hub automatically

---

## 📋 Workflow

### **Current System (Manual Directory):**

1. **You publish on platform** → Write article on LinkedIn OR upload video to YouTube
2. **Copy the URL** → Get the full URL from your published content
3. **Fill the form** → Enter title, teaser, URL, date, type
4. **Submit** → Content appears on blog hub immediately

### **Future System (Auto-Generation):**

When you're ready for auto-posting, we'll add:
- Prompt management
- LLM drafting
- Moderation queue
- LinkedIn API integration
- YouTube upload API
- Approval workflows

**But for now, this is intentionally owner-first: you control when content goes live.**

---

## 🔧 Setup

### **Step 1: Configure Supabase Credentials**

Open `admin/blog-manager.html` and update the JavaScript section:

```javascript
const SUPABASE_URL = 'https://your-project.supabase.co'; // Replace with your actual URL
const SUPABASE_ANON_KEY = 'your-anon-key-here'; // Replace with your actual key
```

**Where to find these:**
1. Go to Supabase Dashboard → Your Project
2. Settings → API
3. Copy "Project URL" → `SUPABASE_URL`
4. Copy "anon public" key → `SUPABASE_ANON_KEY`

### **Step 2: Open the Form**

Simply open `admin/blog-manager.html` in your browser. No build process needed!

**Options:**
- Double-click the file to open in browser
- Or serve via local server: `python -m http.server 8000` → `http://localhost:8000/admin/blog-manager.html`

---

## 📝 Form Fields

### **Required Fields:**

| Field | Description | Max Length |
|-------|-------------|------------|
| **Title** | Article/video title | 70 characters |
| **Teaser** | Short description | 160 characters |
| **Canonical URL** | Full URL to LinkedIn/YouTube post | - |
| **Type** | Article or Video | - |
| **Platform** | LinkedIn or YouTube | - |
| **Read/Watch Time** | Minutes (required based on type) | - |
| **Publish Date** | Date published on platform | - |
| **Status** | Draft, Published, or Archived | - |

### **Optional Fields:**

| Field | Description |
|-------|-------------|
| **Thumbnail URL** | Image URL (if not provided, gradient with emoji is used) |
| **Featured** | Checkbox to feature content |

---

## ✅ Features

- ✅ **Character counters** - Real-time count for title (70) and teaser (160)
- ✅ **Auto UTM parameters** - Automatically adds `?utm_source=truevow_blog` to URLs
- ✅ **Type/Platform sync** - Selecting "Article" auto-selects "LinkedIn" (and vice versa)
- ✅ **Validation** - Required fields and URL format validation
- ✅ **Error handling** - Clear error messages if Supabase connection fails
- ✅ **Success feedback** - Confirmation message when content is added
- ✅ **Form reset** - Clear form button to start over

---

## 🚀 Usage Example

### **Adding a LinkedIn Article:**

1. **Publish on LinkedIn:**
   - Write and publish your article on LinkedIn
   - Copy the full URL: `https://linkedin.com/pulse/your-article-slug`

2. **Fill the Form:**
   - **Title:** "Is Pay-Per-Intake Ethical? A 50-State Fee-Sharing Round-up"
   - **Teaser:** "Why paying a vendor for a service is ethically sound under Model Rule 5.4..."
   - **Canonical URL:** `https://linkedin.com/pulse/your-article-slug`
   - **Type:** Article (LinkedIn)
   - **Platform:** LinkedIn
   - **Read Time:** 5 minutes
   - **Publish Date:** (select date)
   - **Status:** Published

3. **Submit:**
   - Click "Add Content"
   - ✅ Success message appears
   - Content is immediately visible on `marketing/blog.html`

---

## 🔒 Security

- ✅ Uses Supabase **anon key** (safe for client-side use)
- ✅ RLS policies protect database (public can only insert)
- ✅ No sensitive data exposed
- ✅ Form validation prevents invalid submissions

**Note:** This form should be protected with authentication in production. For now, it's a simple HTML file you can password-protect via `.htaccess` or host on a private URL.

---

## 🎨 Customization

### **Styling:**
The form uses inline CSS. To customize:
- Colors: Update hex codes in `<style>` section
- Layout: Modify grid and spacing in CSS
- Branding: Add TrueVow logo/colors

### **Validation:**
Add custom validation in the form submission handler:
```javascript
// Example: Custom URL validation
if (!canonicalUrl.includes('linkedin.com') && !canonicalUrl.includes('youtube.com')) {
    showMessage('URL must be from LinkedIn or YouTube', 'error');
    return;
}
```

---

## 📊 Database Integration

**Table:** `blog_content` ✅ **VERIFIED**  
**Method:** Supabase REST API (POST request)

**What happens when you submit:**
1. Form data is validated
2. UTM parameter is added to URL
3. Data is sent to Supabase via REST API
4. Row is inserted into `blog_content` table
5. If status = "published", it immediately appears on blog hub

---

## 🔮 Future Enhancements

When ready for auto-generation, we'll add:
- [ ] Content editing interface (edit existing entries)
- [ ] Bulk import (CSV upload)
- [ ] Draft preview (see how card will look)
- [ ] Analytics dashboard (views, clicks)
- [ ] Approval workflow (moderation queue)
- [ ] LinkedIn API integration
- [ ] YouTube API integration
- [ ] LLM drafting interface

---

## 🐛 Troubleshooting

### **"Failed to add content" error:**
- Check Supabase URL and key are correct
- Verify table `blog_content` exists
- Check RLS policies allow INSERT

### **Content not appearing on blog hub:**
- Verify `status = 'published'` in Supabase
- Check `blog.html` has correct Supabase credentials
- Clear browser cache and reload

### **Character counter not working:**
- Check JavaScript console for errors
- Verify form fields have correct IDs

---

**Last Updated:** January 8, 2026  
**Version:** 1.0.0 (Manual Directory System)

