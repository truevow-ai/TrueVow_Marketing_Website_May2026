# Fix county-cap.html: All emojis, accordion, ensure UTF-8

$filePath = "marketing\county-cap.html"
$backupPath = "marketing\county-cap.html.complete-fix-backup"

Write-Host "Reading file..."
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
$content = [System.IO.File]::ReadAllText($filePath, $utf8NoBom)

# Create backup
Write-Host "Creating backup..."
Copy-Item $filePath $backupPath

# Define emojis using Unicode
$checkEmoji = [char]0x2705
$crossEmoji = [char]0x274C
$warningEmoji = [char]0x26A0 + [char]0xFE0F
$mapEmoji = [char]0x1F5FA + [char]0xFE0F
$clipboardEmoji = [char]0x1F4CB
$moneyEmoji = [char]0x1F4B0
$giftEmoji = [char]0x1F381

Write-Host "Fixing emojis..."

# Table emojis
$content = $content -replace '(\+92%)\s*\?', "`$1 $checkEmoji"
$content = $content -replace '(\+68%)\s*\?', "`$1 $checkEmoji"
$content = $content -replace '(\+48%)\s*\?\s*(SWEET SPOT!)', "`$1 $checkEmoji `$2"
$content = $content -replace '(\+28%)\s*\?\?', "`$1 $warningEmoji"
$content = $content -replace '(\+28%)\s*!', "`$1 $warningEmoji"
$content = $content -replace '(0%)\s*\?\s*(No Advantage)', "`$1 $crossEmoji `$2"

# Section emojis
$content = $content -replace '\?\s*What We Promise', "$checkEmoji What We Promise"
$content = $content -replace '\?\s*What We Do NOT Promise', "$crossEmoji What We Do NOT Promise"
$content = $content -replace 'View All 67 Florida Counties\s*\?', "View All 67 Florida Counties $mapEmoji"
$content = $content -replace 'Option 1: Priority Waitlist(?!\s*[📋])', "Option 1: Priority Waitlist $clipboardEmoji"
$content = $content -replace 'Option 2: Adjacent County(?!\s*[🗺️])', "Option 2: Adjacent County $mapEmoji"
$content = $content -replace 'Option 3: Refer Fellow Attorneys(?!\s*[💰])', "Option 3: Refer Fellow Attorneys $moneyEmoji"
$content = $content -replace '\?\s*Who Qualifies', "$checkEmoji Who Qualifies"
$content = $content -replace '\?\s*What You Lock In', "$giftEmoji What You Lock In"
$content = $content -replace '\?\s*"Locked for life"', "$crossEmoji `"Locked for life`""
$content = $content -replace '\?\s*"Guaranteed 76-hour setup"', "$crossEmoji `"Guaranteed 76-hour setup`""
$content = $content -replace '\?\s*"Only 500 spots"', "$crossEmoji `"Only 500 spots`""

Write-Host "Emojis fixed"

# Fix FAQ accordion
if ($content -match 'faq-item' -and $content -notmatch 'function toggleFAQ') {
    Write-Host "Adding FAQ toggle function..."
    $faqScript = "`n        <script>`n            function toggleFAQ(element) {`n                element.classList.toggle('active');`n            }`n            document.addEventListener('DOMContentLoaded', function() {`n                document.querySelectorAll('.faq-item').forEach(item => {`n                    item.addEventListener('click', function() {`n                        toggleFAQ(this);`n                    });`n                });`n            });`n        </script>`n"
    $bodyEnd = $content.LastIndexOf('</body>')
    if ($bodyEnd -gt 0) {
        $content = $content.Insert($bodyEnd, $faqScript)
        Write-Host "FAQ toggle function added"
    }
}

# Save with UTF-8 (no BOM)
[System.IO.File]::WriteAllText($filePath, $content, $utf8NoBom)

Write-Host "Done! All fixes applied."
Write-Host "Backup: $backupPath"


