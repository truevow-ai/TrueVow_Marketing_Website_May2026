# Fix UTF-8 Encoding for county-cap.html
# Following the pattern from WEBSITE_THEME_STANDARDIZATION_COMPLETE.md

$filePath = "marketing\county-cap.html"
$backupPath = "marketing\county-cap.html.encoding-backup"

Write-Host "Reading file with UTF-8 encoding..."
$content = Get-Content $filePath -Encoding UTF8 -Raw

# Create backup
Write-Host "Creating backup..."
Copy-Item $filePath $backupPath

# Count occurrences of ??
$questionMarkCount = ([regex]::Matches($content, '\?\?')).Count
Write-Host "Found $questionMarkCount instances of '??' question marks"

if ($questionMarkCount -gt 0) {
    Write-Host "Fixing corrupted emojis..."
    
    # Define emojis using Unicode escape sequences to avoid corruption
    $chartEmoji = [char]0x1F4CA  # 📊
    $checkEmoji = [char]0x2705    # ✅
    $warningEmoji = [char]0x26A0 + [char]0xFE0F  # ⚠️
    $moneyEmoji = [char]0x1F4B0   # 💰
    $targetEmoji = [char]0x1F3AF  # 🎯
    $phoneEmoji = [char]0x1F4DE   # 📞
    $calendarEmoji = [char]0x1F4C5 # 📅
    $mapEmoji = [char]0x1F5FA + [char]0xFE0F  # 🗺️
    
    # Replace "??" with appropriate emojis based on context
    # Pattern 1: "??" after section-icon or icon classes -> chart emoji
    $content = $content -replace '(section-icon[^>]*>)\?\?', "`$1$chartEmoji"
    $content = $content -replace '(class="[^"]*icon[^"]*"[^>]*>)\?\?', "`$1$chartEmoji"
    
    # Pattern 2: "??" in list items -> checkmark
    $content = $content -replace '(<\s*li[^>]*>)\s*\?\?\s*', "`$1$checkEmoji "
    
    # Pattern 3: "??" near "warning" or "important" -> warning emoji
    $content = $content -replace '(warning|important|note)[^>]*>\s*\?\?', "`$1>$warningEmoji"
    
    # Pattern 4: "??" near "chart" or "data" or "analytics" -> chart emoji
    $content = $content -replace '(chart|data|analytics|capacity|seats)[^>]*>\s*\?\?', "`$1>$chartEmoji"
    
    # Pattern 5: "??" near "money" or "price" or "cost" -> money emoji
    $content = $content -replace '(money|price|cost|fee|revenue)[^>]*>\s*\?\?', "`$1>$moneyEmoji"
    
    # Pattern 6: "??" near "target" or "goal" -> target emoji
    $content = $content -replace '(target|goal|focus)[^>]*>\s*\?\?', "`$1>$targetEmoji"
    
    # Pattern 7: "??" near "phone" or "call" -> phone emoji
    $content = $content -replace '(phone|call|contact)[^>]*>\s*\?\?', "`$1>$phoneEmoji"
    
    # Pattern 8: "??" near "calendar" or "schedule" -> calendar emoji
    $content = $content -replace '(calendar|schedule|book)[^>]*>\s*\?\?', "`$1>$calendarEmoji"
    
    # Pattern 9: "??" near "map" or "location" -> map emoji
    $content = $content -replace '(map|location|county)[^>]*>\s*\?\?', "`$1>$mapEmoji"
    
    # Pattern 10: Any remaining standalone "??" -> chart emoji (most common for county page)
    $content = $content -replace '\?\?', $chartEmoji
    
    Write-Host "Applied fixes. Saving with UTF-8 encoding..."
} else {
    Write-Host "No '??' found. Re-saving file with proper UTF-8 encoding..."
}

# Save with UTF-8 encoding (no BOM)
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($filePath, $content, $utf8NoBom)

Write-Host "Done! File saved with UTF-8 encoding."
Write-Host "Backup saved to: $backupPath"
Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Open the file in a browser to verify emojis display correctly"
Write-Host "2. If some emojis are still wrong, check the context and update manually"
