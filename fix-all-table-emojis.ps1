# Fix ALL emoji question marks in the capacity table

$filePath = "marketing\county-cap.html"
$backupPath = "marketing\county-cap.html.emoji-final-fix-backup"

Write-Host "Reading file..."
$content = Get-Content $filePath -Encoding UTF8 -Raw

# Create backup
Write-Host "Creating backup..."
Copy-Item $filePath $backupPath

# Define emoji replacements using Unicode escape sequences
$checkEmoji = [char]0x2705  # ✅
$warningEmoji = [char]0x26A0 + [char]0xFE0F  # ⚠️
$crossEmoji = [char]0x274C  # ❌

Write-Host "Replacing question marks with emojis..."

# Replace patterns in the table
# +92% ? -> +92% ✅
$content = $content -replace '(\+92%)\s*\?', "`$1 $checkEmoji"

# +68% ? -> +68% ✅
$content = $content -replace '(\+68%)\s*\?', "`$1 $checkEmoji"

# +48% ? SWEET SPOT! -> +48% ✅ SWEET SPOT!
$content = $content -replace '(\+48%)\s*\?\s*(SWEET SPOT!)', "`$1 $checkEmoji `$2"

# +28% ?? -> +28% ⚠️
$content = $content -replace '(\+28%)\s*\?\?', "`$1 $warningEmoji"

# +28% ! -> +28% ⚠️ (if it's just an exclamation)
$content = $content -replace '(\+28%)\s*!', "`$1 $warningEmoji"

# 0% ? No Advantage -> 0% ❌ No Advantage
$content = $content -replace '(0%)\s*\?\s*(No Advantage)', "`$1 $crossEmoji `$2"

Write-Host "Emoji replacements complete"

# Save with UTF-8 encoding (no BOM)
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($filePath, $content, $utf8NoBom)

Write-Host "Done! All emojis fixed."
Write-Host "Backup: $backupPath"

