# Embed navigation directly in county-cap.html so it works when opened directly

$filePath = "marketing\county-cap.html"
$backupPath = "marketing\county-cap.html.nav-embed-backup"

Write-Host "Reading file..."
$content = Get-Content $filePath -Encoding UTF8 -Raw

# Create backup
Write-Host "Creating backup..."
Copy-Item $filePath $backupPath

# Navigation HTML with relative paths (works when opened directly)
$navigationHTML = @"
<!-- STANDARDIZED NAVIGATION - Embedded for direct file opening -->
<nav style="position: sticky; top: 0; z-index: 1000; background: white; border-bottom: 1px solid #E5E5E5; padding: 20px 0; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
    <div style="max-width: 1200px; margin: 0 auto; padding: 0 24px; display: flex; justify-content: space-between; align-items: center;">
        <!-- LEFT: Logo -->
        <a href="index.html" style="display: flex; align-items: center; text-decoration: none; gap: 12px;">
            <img src="../assets/logo.svg" alt="TrueVow" style="height: 40px; width: auto;">
        </a>
        
        <!-- CENTER: Navigation Links -->
        <div style="display: flex; gap: 32px; align-items: center;">
            <a href="index.html" style="color: #555555; text-decoration: none; font-size: 16px; font-weight: 500; transition: color 0.3s;" onmouseover="this.style.color='#0A2463'" onmouseout="this.style.color='#555555'">Home</a>
            <a href="how-it-works.html" style="color: #555555; text-decoration: none; font-size: 16px; font-weight: 500; transition: color 0.3s;" onmouseover="this.style.color='#0A2463'" onmouseout="this.style.color='#555555'">How It Works</a>
            <a href="pricing.html" style="color: #555555; text-decoration: none; font-size: 16px; font-weight: 500; transition: color 0.3s;" onmouseover="this.style.color='#0A2463'" onmouseout="this.style.color='#555555'">Pricing</a>
            <a href="county-cap.html" style="color: #555555; text-decoration: none; font-size: 16px; font-weight: 500; transition: color 0.3s;" onmouseover="this.style.color='#0A2463'" onmouseout="this.style.color='#555555'">33% Cap</a>
            <a href="profitability.html" style="color: #555555; text-decoration: none; font-size: 16px; font-weight: 500; transition: color 0.3s;" onmouseover="this.style.color='#0A2463'" onmouseout="this.style.color='#555555'">ROI</a>
        </div>
        
        <!-- RIGHT: CTA Button -->
        <a href="apply.html" style="background: #0A2463; color: white !important; padding: 12px 24px; border-radius: 8px; font-size: 16px; font-weight: 600; text-decoration: none; transition: background 0.3s; display: inline-flex; align-items: center; gap: 8px;" onmouseover="this.style.background='#0052CC'" onmouseout="this.style.background='#0A2463'">
            Apply Now &rarr;
        </a>
    </div>
</nav>
"@

# Find and replace navigation placeholder
if ($content -match '<div id="truevow-navigation"></div>') {
    Write-Host "Found navigation placeholder - replacing with embedded navigation..."
    $content = $content -replace '<div id="truevow-navigation"></div>', $navigationHTML
} elseif ($content -match 'id="truevow-navigation"') {
    Write-Host "Found navigation placeholder (alternative format) - replacing..."
    $content = $content -replace '<div[^>]*id="truevow-navigation"[^>]*></div>', $navigationHTML
} else {
    Write-Host "Navigation placeholder not found - checking if navigation already exists..."
    if ($content -notmatch '<!-- STANDARDIZED NAVIGATION') {
        # Try to find <body> tag and insert after it
        $bodyMatch = [regex]::Match($content, '<body[^>]*>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        if ($bodyMatch.Success) {
            $insertionPoint = $bodyMatch.Index + $bodyMatch.Length
            $content = $content.Insert($insertionPoint, "`n$navigationHTML`n")
            Write-Host "Inserted navigation after body tag"
        } else {
            Write-Host "Could not find body tag - navigation may already be embedded"
        }
    } else {
        Write-Host "Navigation already embedded"
    }
}

# Save with UTF-8 encoding
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($filePath, $content, $utf8NoBom)

Write-Host "Done! Navigation embedded directly in HTML."
Write-Host "Backup: $backupPath"

