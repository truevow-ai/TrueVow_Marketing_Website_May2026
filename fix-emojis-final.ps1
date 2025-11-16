# Fix emoji question marks - using actual Unicode characters

$filePath = "marketing\county-cap.html"
$backupPath = "marketing\county-cap.html.emoji-unicode-fix-backup"

Write-Host "Reading file..."
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
$content = [System.IO.File]::ReadAllText($filePath, $utf8NoBom)

# Create backup
Write-Host "Creating backup..."
Copy-Item $filePath $backupPath

# Define emojis as actual Unicode characters
$checkEmoji = "✅"
$warningEmoji = "⚠️"
$crossEmoji = "❌"

Write-Host "Replacing question marks with Unicode emojis..."

# Replace patterns - be very specific
# +92% ? (with optional whitespace)
$content = $content -replace '(\+92%)\s*\?', "`$1 $checkEmoji"

# +68% ?
$content = $content -replace '(\+68%)\s*\?', "`$1 $checkEmoji"

# +48% ? SWEET SPOT!
$content = $content -replace '(\+48%)\s*\?\s*(SWEET SPOT!)', "`$1 $checkEmoji `$2"

# +28% ?? or +28% !
$content = $content -replace '(\+28%)\s*\?\?', "`$1 $warningEmoji"
$content = $content -replace '(\+28%)\s*!', "`$1 $warningEmoji"

# 0% ? No Advantage
$content = $content -replace '(0%)\s*\?\s*(No Advantage)', "`$1 $crossEmoji `$2"

Write-Host "Replacements complete"

# Save with UTF-8 encoding (no BOM) - this is critical
[System.IO.File]::WriteAllText($filePath, $content, $utf8NoBom)

Write-Host "Done! File saved with UTF-8 encoding (no BOM)."
Write-Host "Backup: $backupPath"
Write-Host ""
Write-Host "Please refresh your browser to see the emojis!"

