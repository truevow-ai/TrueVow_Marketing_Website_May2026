# Add Founder Photo to About Page

## ✅ HTML Already Updated

The about.html page is ready and waiting for your photo!

## 📸 Photo Requirements

**File specs:**
- **Filename:** `founder-photo.jpg`
- **Location:** `C:\Users\yasha\OneDrive\Documents\TRUTHLINE\Cursor\2025-TrueVow-Website\assets\founder-photo.jpg`
- **Recommended size:** 400x400px minimum (will display as 200x200px)
- **Format:** JPG or PNG
- **Style:** Professional headshot with clean background

**The photo you showed me (blue cap, dark shirt) would work perfectly!**

---

## 🚀 How to Add Your Photo

### Option 1: Copy Existing Photo
If you have the photo saved somewhere:
```powershell
Copy-Item "path\to\your\photo.jpg" "C:\Users\yasha\OneDrive\Documents\TRUTHLINE\Cursor\2025-TrueVow-Website\assets\founder-photo.jpg"
```

### Option 2: Use the Blue Cap Photo
The photo you shared earlier (in the blue cap with dark shirt) is perfect for this! Just:
1. Save that photo to your computer
2. Rename it to `founder-photo.jpg`
3. Place it in: `2025-TrueVow-Website\assets\`

---

## 🎨 How It Will Look

**Layout on about.html:**
```
┌─────────────────────────────────────────────────┐
│  [Circular Photo]    Afghan S. Yasha Ullah Khan │
│   200x200px          Founder & Chief Vow Keeper │
│   Blue border        TrueVow Global Technologies│
│                      Former: Microsoft, Oracle... │
└─────────────────────────────────────────────────┘
```

**Design features:**
- ✅ Circular photo with blue border (matches brand #0A2463)
- ✅ Professional grey card background
- ✅ Blue accent stripe on left
- ✅ Name in large blue text
- ✅ Title and credentials below

---

## 🔍 Verify It Works

After adding the photo:

1. **Start the server** (if not running):
   ```powershell
   cd C:\Users\yasha\OneDrive\Documents\TRUTHLINE\Cursor\2025-TrueVow-Website
   python -m http.server 8000
   ```

2. **Open in browser:**
   ```
   http://localhost:8000/marketing/about.html
   ```

3. **You should see:**
   - Your photo in a circle with blue border
   - Your name and title next to it
   - Professional card layout

---

## ❓ If Photo Doesn't Show

**Check:**
1. File is named exactly: `founder-photo.jpg` (lowercase, no spaces)
2. File is in: `assets/` folder at the root of 2025-TrueVow-Website
3. File is a valid JPG or PNG image
4. Hard refresh browser: `Ctrl + F5`

**Alternative filenames that will work:**
- `founder-photo.jpg` ✅
- `founder-photo.png` (change HTML to .png) ✅
- `founder-photo.jpeg` (change HTML to .jpeg) ✅

---

## 📊 Current Status

- ✅ HTML structure created
- ✅ Styling applied (professional card layout)
- ✅ Image path set: `../assets/founder-photo.jpg`
- ⏳ **Waiting for:** Your photo to be placed in assets folder

**Once you add the photo, refresh the page and it will appear!**

