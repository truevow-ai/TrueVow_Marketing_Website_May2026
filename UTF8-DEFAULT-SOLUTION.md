# ✅ UTF-8 Encoding Default Solution

## Problem
Files keep getting corrupted with question marks instead of emojis because they're not saved with UTF-8 encoding.

## Solution: PowerShell Profile Configuration

Add this to your PowerShell profile to make UTF-8 the default encoding:

### Step 1: Find Your PowerShell Profile
```powershell
$PROFILE
```

### Step 2: Create/Edit Profile
```powershell
notepad $PROFILE
```

### Step 3: Add This Code
```powershell
# Set UTF-8 as default encoding for file operations
$PSDefaultParameterValues['*:Encoding'] = 'utf8'
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
```

### Step 4: Reload Profile
```powershell
. $PROFILE
```

---

## Alternative: Use This Script for All File Operations

I've created scripts that **always** use UTF-8 (no BOM) encoding:

- `fix-all-landing-pages.ps1` - Fixes all landing pages
- `fix-county-cap-all-issues.ps1` - Fixes county-cap.html

These scripts use:
```powershell
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::ReadAllText($file, $utf8NoBom)
[System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
```

---

## VS Code Settings (If Using VS Code)

Add to `.vscode/settings.json`:
```json
{
    "files.encoding": "utf8",
    "files.autoGuessEncoding": false,
    "files.eol": "\n"
}
```

---

## Git Configuration (If Using Git)

```bash
git config --global core.quotepath false
git config --global i18n.commitEncoding utf-8
git config --global i18n.logOutputEncoding utf-8
```

---

**Result:** All files will be saved with UTF-8 encoding by default, preventing emoji corruption.


