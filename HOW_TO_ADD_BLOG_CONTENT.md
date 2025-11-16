# 📝 How to Add Blog Content

**Step-by-Step Guide for Non-Technical Users**

---

## 🎯 **Quick Access**

### **Admin Blog Manager:**
**http://localhost:8000/admin/blog-manager.html**

---

## 📋 **Step-by-Step Instructions**

### **STEP 1: Open the Admin Form**

1. In your browser, go to: **http://localhost:8000/admin/blog-manager.html**
2. You should see a form with fields to fill out

---

### **STEP 2: Fill Out the Form**

For each blog post, fill in these fields:

#### **Required Fields:**

1. **Title** (max 70 characters)
   - Example: "Is Pay-Per-Intake Ethical? A 50-State Fee-Sharing Round-up"
   - Keep it under 70 characters

2. **Teaser** (max 160 characters)
   - Example: "Why paying a vendor for a service is ethically sound, but paying a share of legal fees is a Model Rule 5.4 violation."
   - This is the short description that shows on the card

3. **Canonical URL**
   - This is the full LinkedIn or YouTube URL
   - Example: `https://www.linkedin.com/posts/your-post-link`
   - Or: `https://www.youtube.com/watch?v=video-id`

4. **Publish Date**
   - Click the date picker
   - Select the date the content was published (or today's date)

5. **Content Type**
   - Select "Article" for LinkedIn posts
   - Select "Video" for YouTube videos

6. **Platform**
   - Select "LinkedIn" for articles
   - Select "YouTube" for videos

7. **Status**
   - Select "Published" to make it visible on the blog
   - Select "Draft" if you want to save it for later

#### **Optional Fields:**

8. **Read Time (Minutes)** - Only for articles
   - Example: "5" (for a 5-minute read)

9. **Watch Time (Minutes)** - Only for videos
   - Example: "10" (for a 10-minute video)

10. **Featured**
    - Check this box if you want to highlight this content
    - Unchecked by default

11. **Thumbnail URL** (optional)
    - If you have a custom image, paste the URL here
    - Leave blank to use the default gradient/emoji

---

### **STEP 3: Submit the Form**

1. **Click "Add Blog Content" button** at the bottom
2. Wait for the success message (green notification)
3. The form will reset, ready for the next entry

---

### **STEP 4: Verify It Worked**

1. Go back to: **http://localhost:8000/marketing/blog.html**
2. **Refresh the page** (F5 or Ctrl+R)
3. You should see your new content card appear!

---

## 📝 **Example: Adding a LinkedIn Article**

```
Title: "Zero-Knowledge Architecture: Privacy First for Legal Tech"
Teaser: "How TrueVow ensures client data never leaves your servers, meeting the strictest bar compliance requirements."
Canonical URL: https://www.linkedin.com/posts/your-actual-post-url
Publish Date: 2025-11-07
Content Type: Article
Platform: LinkedIn
Read Time: 7
Status: Published
Featured: (unchecked)
```

---

## 📝 **Example: Adding a YouTube Video**

```
Title: "Legal Tech Automation: What You Need to Know"
Teaser: "A comprehensive guide to automating your law firm intake process while maintaining ethical compliance."
Canonical URL: https://www.youtube.com/watch?v=your-video-id
Publish Date: 2025-11-07
Content Type: Video
Platform: YouTube
Watch Time: 15
Status: Published
Featured: (unchecked)
```

---

## 🧪 **Testing Tips**

### **To Add Multiple Items:**

1. Fill out form → Submit
2. Wait for success message
3. Fill out form again → Submit
4. Repeat for as many items as you want

### **To See All Your Content:**

1. After adding each item, refresh: http://localhost:8000/marketing/blog.html
2. All published content should appear in a grid

---

## 🆘 **Troubleshooting**

### **"Failed to add content" Error:**

**Check:**
1. ✅ Make sure all required fields are filled
2. ✅ Check that the URL is a valid LinkedIn or YouTube link
3. ✅ Verify the date is selected
4. ✅ Check browser console (F12) for error messages

### **Content Not Appearing on Blog:**

**Check:**
1. ✅ Make sure "Status" is set to "Published" (not "Draft")
2. ✅ Refresh the blog page (F5)
3. ✅ Check browser console (F12 → Console) for errors
4. ✅ Verify the content appears in Supabase dashboard

### **Form Not Submitting:**

**Check:**
1. ✅ Open browser console (F12 → Console)
2. ✅ Look for red error messages
3. ✅ Check if Supabase credentials are configured correctly

---

## 🎯 **Quick Checklist**

- [ ] Opened admin form: http://localhost:8000/admin/blog-manager.html
- [ ] Filled out all required fields
- [ ] Selected "Published" status
- [ ] Clicked "Add Blog Content"
- [ ] Saw success message
- [ ] Refreshed blog page
- [ ] Verified content appears

---

## 📌 **URLs Reference**

- **Admin Form:** http://localhost:8000/admin/blog-manager.html
- **Blog Page:** http://localhost:8000/marketing/blog.html

---

**Need help?** Let me know if you see any errors or if the form isn't working! 🚀

