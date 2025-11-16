# Fix ALL landing pages: Embed navigation/footer, fix emojis, fix accordion, ensure UTF-8

$landingPages = @(
    "marketing\index.html",
    "marketing\how-it-works.html",
    "marketing\pricing.html",
    "marketing\profitability.html",
    "marketing\affiliate-apply.html",
    "marketing\affiliate.html",
    "marketing\partner.html",
    "marketing\press.html",
    "marketing\about.html",
    "marketing\careers.html",
    "marketing\case-studies.html",
    "marketing\apply.html",
    "marketing\demo-oakwood.html"
)

# Navigation HTML with relative paths
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

# Footer HTML
$footerHTML = @"
<!-- STANDARDIZED FOOTER - Embedded for direct file opening -->
<footer style="background: #1a1a1a; color: #999; padding: 60px 24px; text-align: center;">
    <div style="max-width: 1200px; margin: 0 auto;">
        <div style="margin-bottom: 32px;">
            <a href="index.html" style="display: inline-flex; align-items: center; gap: 8px; text-decoration: none; color: #999;">
                <span style="font-size: 24px; font-weight: 700; color: #0A2463;">True</span><span style="font-size: 24px; font-weight: 700; color: white;">Vow</span>
            </a>
        </div>
        <p style="font-size: 16pt; font-style: italic; color: #999; margin-bottom: 32px; line-height: 1.6;">
            Leveling the playing field for solo and small law firms.
        </p>
        <div style="border-top: 1px solid #333; padding-top: 32px; margin-top: 32px;">
            <p style="color: #666; font-size: 14px; margin-bottom: 16px;">&copy; 2025 TrueVow. All rights reserved.</p>
            <div style="display: flex; justify-content: center; gap: 24px; flex-wrap: wrap;">
                <a href="../legal/terms.html" style="color: #999; text-decoration: none; font-size: 14px;">Terms</a>
                <a href="../legal/privacy.html" style="color: #999; text-decoration: none; font-size: 14px;">Privacy</a>
                <a href="../legal/msa.html" style="color: #999; text-decoration: none; font-size: 14px;">MSA</a>
                <a href="about.html" style="color: #999; text-decoration: none; font-size: 14px;">About</a>
            </div>
        </div>
    </div>
</footer>
"@

# Emoji replacements
$emojiReplacements = @{
    '\? What We Promise' = '✅ What We Promise'
    '\? What We Do NOT Promise' = '❌ What We Do NOT Promise'
    'View All 67 Florida Counties \?' = 'View All 67 Florida Counties 🗺️'
    'Option 1: Priority Waitlist' = 'Option 1: Priority Waitlist 📋'
    'Option 2: Adjacent County' = 'Option 2: Adjacent County 🗺️'
    'Option 3: Refer Fellow Attorneys' = 'Option 3: Refer Fellow Attorneys 💰'
    '\? Who Qualifies' = '✅ Who Qualifies'
    '\? What You Lock In' = '🎁 What You Lock In'
    '\? "Locked for life"' = '❌ "Locked for life"'
    '\? "Guaranteed 76-hour setup"' = '❌ "Guaranteed 76-hour setup"'
    '\? "Only 500 spots"' = '❌ "Only 500 spots"'
}

# FAQ toggle function
$faqToggleScript = @"
        <script>
            // FAQ Toggle Function
            function toggleFAQ(element) {
                element.classList.toggle('active');
            }
            
            // Initialize on page load
            document.addEventListener('DOMContentLoaded', function() {
                // Ensure FAQ items are clickable
                document.querySelectorAll('.faq-item').forEach(item => {
                    if (!item.onclick) {
                        item.addEventListener('click', function() {
                            toggleFAQ(this);
                        });
                    }
                });
            });
        </script>
"@

$utf8NoBom = New-Object System.Text.UTF8Encoding $false

foreach ($file in $landingPages) {
    if (-not (Test-Path $file)) {
        Write-Host "Skipping $file (not found)"
        continue
    }
    
    Write-Host "`nProcessing: $file"
    
    # Read file with UTF-8
    $content = [System.IO.File]::ReadAllText($file, $utf8NoBom)
    $originalContent = $content
    
    # 1. Embed navigation
    if ($content -match '<div[^>]*id="truevow-navigation"[^>]*></div>') {
        $content = $content -replace '<div[^>]*id="truevow-navigation"[^>]*></div>', $navigationHTML
        Write-Host "  ✓ Navigation embedded"
    } elseif ($content -notmatch '<!-- STANDARDIZED NAVIGATION') {
        # Insert after <body>
        $bodyMatch = [regex]::Match($content, '<body[^>]*>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        if ($bodyMatch.Success) {
            $insertionPoint = $bodyMatch.Index + $bodyMatch.Length
            $content = $content.Insert($insertionPoint, "`n$navigationHTML`n")
            Write-Host "  ✓ Navigation inserted"
        }
    }
    
    # 2. Embed footer
    if ($content -match '<div[^>]*id="truevow-footer"[^>]*></div>') {
        $content = $content -replace '<div[^>]*id="truevow-footer"[^>]*></div>', $footerHTML
        Write-Host "  ✓ Footer embedded"
    } elseif ($content -notmatch '<!-- STANDARDIZED FOOTER') {
        # Insert before </body>
        $bodyEnd = $content.LastIndexOf('</body>')
        if ($bodyEnd -gt 0) {
            $content = $content.Insert($bodyEnd, "`n$footerHTML`n")
            Write-Host "  ✓ Footer inserted"
        }
    }
    
    # 3. Fix emojis
    foreach ($pattern in $emojiReplacements.Keys) {
        if ($content -match $pattern) {
            $content = $content -replace $pattern, $emojiReplacements[$pattern]
            Write-Host "  ✓ Fixed emoji: $pattern"
        }
    }
    
    # 4. Fix FAQ accordion - ensure toggleFAQ function exists
    if ($content -match 'faq-item' -and $content -notmatch 'function toggleFAQ') {
        $bodyEnd = $content.LastIndexOf('</body>')
        if ($bodyEnd -gt 0) {
            $content = $content.Insert($bodyEnd, $faqToggleScript)
            Write-Host "  ✓ FAQ toggle function added"
        }
    }
    
    # 5. Ensure UTF-8 meta tag
    if ($content -notmatch '<meta[^>]*charset[^>]*UTF-8') {
        $headMatch = [regex]::Match($content, '<head[^>]*>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        if ($headMatch.Success) {
            $insertionPoint = $headMatch.Index + $headMatch.Length
            $metaTag = "`n    <meta charset=`"UTF-8`">`n"
            $content = $content.Insert($insertionPoint, $metaTag)
            Write-Host "  ✓ UTF-8 meta tag added"
        }
    }
    
    # Save with UTF-8 (no BOM) - CRITICAL
    if ($content -ne $originalContent) {
        [System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
        Write-Host "  ✓ File saved with UTF-8 encoding"
    } else {
        Write-Host "  - No changes needed"
    }
}

Write-Host "`n✅ All landing pages processed!"


