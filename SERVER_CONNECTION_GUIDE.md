# 🌐 Server Connection Guide

**Status:** ✅ Python server is running (Process ID: 12912)

---

## 🔗 **How to Connect**

### **Option 1: Direct Browser Access (Recommended)**

1. **Open your web browser** (Chrome, Firefox, Edge, etc.)
2. **Type in the address bar:**
   ```
   http://localhost:8000/marketing/county-cap.html
   ```
3. **Press Enter**

### **Option 2: If localhost doesn't work, try:**
```
http://127.0.0.1:8000/marketing/county-cap.html
```

---

## 🧪 **Test the County Cap Page**

**URL:** http://localhost:8000/marketing/county-cap.html

**What to check:**
- ✅ All section icons display correctly (not as "??")
- ✅ Emojis render properly
- ✅ No encoding errors in browser console (F12)

---

## ⚠️ **Troubleshooting Connection Issues**

### **Problem 1: "Unable to connect" or "Connection refused"**

**Solution A: Check if server is actually running**
```powershell
# Check if Python is running
Get-Process python
```

**Solution B: Restart the server**
```powershell
# Stop any existing server
Stop-Process -Name python -Force

# Start new server
python -m http.server 8000
```

**Solution C: Try a different port**
```powershell
# Use port 8080 instead
python -m http.server 8080
```
Then access: http://localhost:8080/marketing/county-cap.html

---

### **Problem 2: "This site can't be reached"**

**Possible causes:**
1. **Firewall blocking:** Windows Firewall may be blocking Python
2. **Antivirus blocking:** Some antivirus software blocks local servers
3. **Port already in use:** Another application is using port 8000

**Solutions:**
1. **Check Windows Firewall:**
   - Windows Security → Firewall & network protection
   - Allow Python through firewall if prompted

2. **Try different port:**
   ```powershell
   python -m http.server 8080
   ```

3. **Check what's using port 8000:**
   ```powershell
   netstat -ano | findstr :8000
   ```

---

### **Problem 3: Python not found**

**If you get "python is not recognized":**

**Option A: Use Python 3 explicitly**
```powershell
python3 -m http.server 8000
```

**Option B: Use Node.js (if installed)**
```powershell
npx http-server -p 8000
```

**Option C: Use PHP (if installed)**
```powershell
php -S localhost:8000
```

---

## 🔄 **Alternative Server Methods**

### **Method 1: Node.js http-server**
```powershell
# Install globally (one time)
npm install -g http-server

# Run server
http-server -p 8000
```

### **Method 2: VS Code Live Server Extension**
1. Install "Live Server" extension in VS Code
2. Right-click `county-cap.html`
3. Select "Open with Live Server"

### **Method 3: Python with specific directory**
```powershell
cd marketing
python -m http.server 8000
```
Then access: http://localhost:8000/county-cap.html

---

## ✅ **Quick Test**

Try opening this URL in your browser:
```
http://localhost:8000/marketing/index.html
```

If the homepage loads, the server is working. Then try:
```
http://localhost:8000/marketing/county-cap.html
```

---

## 📞 **Still Having Issues?**

1. **Check browser console** (F12) for specific error messages
2. **Try a different browser** (Chrome, Firefox, Edge)
3. **Check if you're behind a proxy** that might block localhost
4. **Verify Python is installed:**
   ```powershell
   python --version
   ```

---

**Current Server Status:** ✅ Python process running (PID: 12912)  
**Expected URL:** http://localhost:8000/marketing/county-cap.html

