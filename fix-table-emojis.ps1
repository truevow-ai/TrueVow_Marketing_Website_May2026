# Fix emoji question marks in the capacity table

$filePath = "marketing\county-cap.html"
$backupPath = "marketing\county-cap.html.emoji-fix-backup"

Write-Host "Reading file..."
$content = Get-Content $filePath -Encoding UTF8 -Raw

# Create backup
Write-Host "Creating backup..."
Copy-Item $filePath $backupPath

# Fix emojis in the table
# +92% ? -> +92% ✅
$content = $content -replace '\+92%\s*\?', '+92% ✅'

# +68% ? -> +68% ✅
$content = $content -replace '\+68%\s*\?', '+68% ✅'

# +48% ? SWEET SPOT! -> +48% ✅ SWEET SPOT!
$content = $content -replace '\+48%\s*\?\s*SWEET SPOT!', '+48% ✅ SWEET SPOT!'

# +28% ?? -> +28% ⚠️
$content = $content -replace '\+28%\s*\?\?', '+28% ⚠️'

# 0% ? No Advantage -> 0% ❌ No Advantage
$content = $content = $content -replace '0%\s*\?\s*No Advantage', '0% ❌ No Advantage'

Write-Host "Fixed emoji placeholders in table"

# Save with UTF-8 encoding
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($filePath, $content, $utf8NoBom)

Write-Host "Done! Emojis fixed."
Write-Host "Backup: $backupPath"

