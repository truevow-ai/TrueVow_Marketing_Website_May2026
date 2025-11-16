# Fix county-cap.html: All emojis, accordion, ensure UTF-8

$filePath = "marketing\county-cap.html"
$backupPath = "marketing\county-cap.html.complete-fix-backup"

Write-Host "Reading file..."
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
$content = [System.IO.File]::ReadAllText($filePath, $utf8NoBom)

# Create backup
Write-Host "Creating backup..."
Copy-Item $filePath $backupPath

# Fix ALL question marks with proper emojis
Write-Host "Fixing emojis..."

# Table emojis
$content = $content -replace '(\+92%)\s*\?', '$1 ✅'
$content = $content -replace '(\+68%)\s*\?', '$1 ✅'
$content = $content -replace '(\+48%)\s*\?\s*(SWEET SPOT!)', '$1 ✅ $2'
$content = $content -replace '(\+28%)\s*\?\?', '$1 ⚠️'
$content = $content -replace '(\+28%)\s*!', '$1 ⚠️'
$content = $content -replace '(0%)\s*\?\s*(No Advantage)', '$1 ❌ $2'

# Section emojis
$content = $content -replace '\? What We Promise', '✅ What We Promise'
$content = $content -replace '\? What We Do NOT Promise', '❌ What We Do NOT Promise'
$content = $content -replace 'View All 67 Florida Counties \?', 'View All 67 Florida Counties 🗺️'
$content = $content -replace 'Option 1: Priority Waitlist', 'Option 1: Priority Waitlist 📋'
$content = $content -replace 'Option 2: Adjacent County', 'Option 2: Adjacent County 🗺️'
$content = $content -replace 'Option 3: Refer Fellow Attorneys', 'Option 3: Refer Fellow Attorneys 💰'
$content = $content -replace '\? Who Qualifies', '✅ Who Qualifies'
$content = $content -replace '\? What You Lock In', '🎁 What You Lock In'
$content = $content -replace '\? "Locked for life"', '❌ "Locked for life"'
$content = $content -replace '\? "Guaranteed 76-hour setup"', '❌ "Guaranteed 76-hour setup"'
$content = $content -replace '\? "Only 500 spots"', '❌ "Only 500 spots"'

Write-Host "Emojis fixed"

# Fix FAQ accordion - ensure toggleFAQ exists and works
if ($content -match 'faq-item' -and $content -notmatch 'function toggleFAQ') {
    Write-Host "Adding FAQ toggle function..."
    $faqScript = @"
        <script>
            function toggleFAQ(element) {
                element.classList.toggle('active');
            }
            document.addEventListener('DOMContentLoaded', function() {
                document.querySelectorAll('.faq-item').forEach(item => {
                    item.addEventListener('click', function() {
                        toggleFAQ(this);
                    });
                });
            });
        </script>
"@
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


