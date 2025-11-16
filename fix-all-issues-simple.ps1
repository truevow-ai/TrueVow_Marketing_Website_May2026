# Simple fix script - avoids emoji corruption in script itself

$filePath = "marketing\county-cap.html"
$backupPath = "marketing\county-cap.html.all-fixes-backup"

Write-Host "Reading file..."
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
$content = [System.IO.File]::ReadAllText($filePath, $utf8NoBom)

Copy-Item $filePath $backupPath

Write-Host "Fixing issues..."

# Simple replacements - use actual characters from file
$content = $content -replace '(\+92%)\s*\?', '$1 ✅'
$content = $content -replace '(\+68%)\s*\?', '$1 ✅'
$content = $content -replace '(\+48%)\s*\?\s*(SWEET SPOT!)', '$1 ✅ $2'
$content = $content -replace '(\+28%)\s*\?\?', '$1 ⚠️'
$content = $content -replace '(0%)\s*\?\s*(No Advantage)', '$1 ❌ $2'

# Section headers
$content = $content -replace '\?\s*What We Promise', '✅ What We Promise'
$content = $content -replace '\?\s*What We Do NOT Promise', '❌ What We Do NOT Promise'
$content = $content -replace 'View All 67 Florida Counties\s*\?', 'View All 67 Florida Counties 🗺️'

# Options
$content = $content -replace 'Option 1: Priority Waitlist(?!\s*📋)', 'Option 1: Priority Waitlist 📋'
$content = $content -replace 'Option 2: Adjacent County(?!\s*🗺️)', 'Option 2: Adjacent County 🗺️'
$content = $content -replace 'Option 3: Refer Fellow Attorneys(?!\s*💰)', 'Option 3: Refer Fellow Attorneys 💰'

# Other sections
$content = $content -replace '\?\s*Who Qualifies', '✅ Who Qualifies'
$content = $content -replace '\?\s*What You Lock In', '🎁 What You Lock In'
$content = $content -replace '\?\s*"Locked for life"', '❌ "Locked for life"'
$content = $content -replace '\?\s*"Guaranteed 76-hour setup"', '❌ "Guaranteed 76-hour setup"'
$content = $content -replace '\?\s*"Only 500 spots"', '❌ "Only 500 spots"'

# FAQ toggle
if ($content -match 'faq-item' -and $content -notmatch 'function toggleFAQ') {
    $script = @'

        <script>
            function toggleFAQ(element) {
                element.classList.toggle('active');
            }
            document.addEventListener('DOMContentLoaded', function() {
                document.querySelectorAll('.faq-item').forEach(function(item) {
                    item.addEventListener('click', function() {
                        toggleFAQ(this);
                    });
                });
            });
        </script>
'@
    $bodyEnd = $content.LastIndexOf('</body>')
    if ($bodyEnd -gt 0) {
        $content = $content.Insert($bodyEnd, $script)
    }
}

[System.IO.File]::WriteAllText($filePath, $content, $utf8NoBom)
Write-Host "Done! Backup: $backupPath"


