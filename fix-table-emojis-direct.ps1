# Fix emoji question marks in table - direct replacement approach

$filePath = "marketing\county-cap.html"
$backupPath = "marketing\county-cap.html.emoji-direct-fix-backup"

Write-Host "Reading file..."
$content = Get-Content $filePath -Encoding UTF8 -Raw

# Create backup
Write-Host "Creating backup..."
Copy-Item $filePath $backupPath

# Use HTML entities for emojis (more reliable)
$checkEmoji = "&#x2705;"  # ✅
$warningEmoji = "&#x26A0;&#xFE0F;"  # ⚠️
$crossEmoji = "&#x274C;"  # ❌

Write-Host "Replacing question marks with emoji HTML entities..."

# Replace each pattern individually
# Pattern: +92% ? -> +92% ✅
$content = $content -replace '(\+92%)\s*\?', "`$1 $checkEmoji"

# Pattern: +68% ? -> +68% ✅  
$content = $content -replace '(\+68%)\s*\?', "`$1 $checkEmoji"

# Pattern: +48% ? SWEET SPOT! -> +48% ✅ SWEET SPOT!
$content = $content -replace '(\+48%)\s*\?\s*(SWEET SPOT!)', "`$1 $checkEmoji `$2"

# Pattern: +28% ?? -> +28% ⚠️
$content = $content -replace '(\+28%)\s*\?\?', "`$1 $warningEmoji"

# Pattern: +28% ! -> +28% ⚠️
$content = $content -replace '(\+28%)\s*!', "`$1 $warningEmoji"

# Pattern: 0% ? No Advantage -> 0% ❌ No Advantage
$content = $content -replace '(0%)\s*\?\s*(No Advantage)', "`$1 $crossEmoji `$2"

Write-Host "Replacements complete"

# Save with UTF-8 encoding (no BOM)
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($filePath, $content, $utf8NoBom)

Write-Host "Done! File saved with emoji HTML entities."
Write-Host "Backup: $backupPath"

