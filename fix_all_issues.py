#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Fix all issues on landing pages:
1. Embed navigation and footer
2. Fix all question mark emojis
3. Fix FAQ accordion
4. Ensure UTF-8 encoding
"""

import os
import re
from pathlib import Path

# Landing pages to fix
LANDING_PAGES = [
    "marketing/index.html",
    "marketing/how-it-works.html",
    "marketing/pricing.html",
    "marketing/profitability.html",
    "marketing/affiliate-apply.html",
    "marketing/affiliate.html",
    "marketing/partner.html",
    "marketing/press.html",
    "marketing/about.html",
    "marketing/careers.html",
    "marketing/case-studies.html",
    "marketing/apply.html",
    "marketing/demo-oakwood.html",
    "marketing/county-cap.html",
]

# Navigation HTML
NAVIGATION_HTML = '''<!-- STANDARDIZED NAVIGATION - Embedded for direct file opening -->
<nav style="position: sticky; top: 0; z-index: 1000; background: white; border-bottom: 1px solid #E5E5E5; padding: 20px 0; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
    <div style="max-width: 1200px; margin: 0 auto; padding: 0 24px; display: flex; justify-content: space-between; align-items: center;">
        <a href="index.html" style="display: flex; align-items: center; text-decoration: none; gap: 12px;">
            <img src="../assets/logo.svg" alt="TrueVow" style="height: 40px; width: auto;">
        </a>
        <div style="display: flex; gap: 32px; align-items: center;">
            <a href="index.html" style="color: #555555; text-decoration: none; font-size: 16px; font-weight: 500;">Home</a>
            <a href="how-it-works.html" style="color: #555555; text-decoration: none; font-size: 16px; font-weight: 500;">How It Works</a>
            <a href="pricing.html" style="color: #555555; text-decoration: none; font-size: 16px; font-weight: 500;">Pricing</a>
            <a href="county-cap.html" style="color: #555555; text-decoration: none; font-size: 16px; font-weight: 500;">33% Cap</a>
            <a href="profitability.html" style="color: #555555; text-decoration: none; font-size: 16px; font-weight: 500;">ROI</a>
        </div>
        <a href="apply.html" style="background: #0A2463; color: white !important; padding: 12px 24px; border-radius: 8px; font-size: 16px; font-weight: 600; text-decoration: none;">Apply Now →</a>
    </div>
</nav>'''

# Footer HTML
FOOTER_HTML = '''<!-- STANDARDIZED FOOTER - Embedded for direct file opening -->
<footer style="background: #1a1a1a; color: #999; padding: 60px 24px; text-align: center;">
    <div style="max-width: 1200px; margin: 0 auto;">
        <div style="margin-bottom: 32px;">
            <a href="index.html" style="display: inline-flex; align-items: center; gap: 8px; text-decoration: none; color: #999;">
                <span style="font-size: 24px; font-weight: 700; color: #0A2463;">True</span><span style="font-size: 24px; font-weight: 700; color: white;">Vow</span>
            </a>
        </div>
        <p style="font-size: 16pt; font-style: italic; color: #999; margin-bottom: 32px;">Leveling the playing field for solo and small law firms.</p>
        <div style="border-top: 1px solid #333; padding-top: 32px;">
            <p style="color: #666; font-size: 14px;">© 2025 TrueVow. All rights reserved.</p>
            <div style="display: flex; justify-content: center; gap: 24px; flex-wrap: wrap;">
                <a href="../legal/terms.html" style="color: #999; text-decoration: none; font-size: 14px;">Terms</a>
                <a href="../legal/privacy.html" style="color: #999; text-decoration: none; font-size: 14px;">Privacy</a>
                <a href="../legal/msa.html" style="color: #999; text-decoration: none; font-size: 14px;">MSA</a>
            </div>
        </div>
    </div>
</footer>'''

# FAQ Toggle Script
FAQ_SCRIPT = '''
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
        </script>'''

def fix_file(filepath):
    """Fix a single HTML file"""
    if not os.path.exists(filepath):
        print(f"  [SKIP] Skipping {filepath} (not found)")
        return False
    
    print(f"\n[FILE] Processing: {filepath}")
    
    # Read with UTF-8
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    original = content
    changes = []
    
    # 1. Embed navigation
    nav_pattern = r'<div[^>]*id="truevow-navigation"[^>]*></div>'
    if re.search(nav_pattern, content):
        content = re.sub(nav_pattern, NAVIGATION_HTML, content)
        changes.append("Navigation embedded")
    elif 'STANDARDIZED NAVIGATION' not in content:
        # Insert after <body>
        body_match = re.search(r'<body[^>]*>', content, re.IGNORECASE)
        if body_match:
            pos = body_match.end()
            content = content[:pos] + '\n' + NAVIGATION_HTML + '\n' + content[pos:]
            changes.append("Navigation inserted")
    
    # 2. Embed footer
    footer_pattern = r'<div[^>]*id="truevow-footer"[^>]*></div>'
    if re.search(footer_pattern, content):
        content = re.sub(footer_pattern, FOOTER_HTML, content)
        changes.append("Footer embedded")
    elif 'STANDARDIZED FOOTER' not in content:
        # Insert before </body>
        body_end = content.rfind('</body>')
        if body_end > 0:
            content = content[:body_end] + '\n' + FOOTER_HTML + '\n' + content[body_end:]
            changes.append("Footer inserted")
    
    # 3. Fix emojis (only for county-cap.html)
    if 'county-cap.html' in filepath:
        emoji_fixes = [
            (r'(\+92%)\s*\?', r'\1 ✅'),
            (r'(\+68%)\s*\?', r'\1 ✅'),
            (r'(\+48%)\s*\?\s*(SWEET SPOT!)', r'\1 ✅ \2'),
            (r'(\+28%)\s*\?\?', r'\1 ⚠️'),
            (r'(0%)\s*\?\s*(No Advantage)', r'\1 ❌ \2'),
            (r'\?\s*What We Promise', '✅ What We Promise'),
            (r'\?\s*What We Do NOT Promise', '❌ What We Do NOT Promise'),
            (r'View All 67 Florida Counties\s*\?', 'View All 67 Florida Counties 🗺️'),
            (r'Option 1: Priority Waitlist(?!\s*📋)', 'Option 1: Priority Waitlist 📋'),
            (r'Option 2: Adjacent County(?!\s*🗺️)', 'Option 2: Adjacent County 🗺️'),
            (r'Option 3: Refer Fellow Attorneys(?!\s*💰)', 'Option 3: Refer Fellow Attorneys 💰'),
            (r'\?\s*Who Qualifies', '✅ Who Qualifies'),
            (r'\?\s*What You Lock In', '🎁 What You Lock In'),
            (r'\?\s*"Locked for life"', '❌ "Locked for life"'),
            (r'\?\s*"Guaranteed 76-hour setup"', '❌ "Guaranteed 76-hour setup"'),
            (r'\?\s*"Only 500 spots"', '❌ "Only 500 spots"'),
        ]
        for pattern, replacement in emoji_fixes:
            if re.search(pattern, content):
                content = re.sub(pattern, replacement, content)
                changes.append("Emojis fixed")
    
    # 4. Fix FAQ accordion
    if 'faq-item' in content and 'function toggleFAQ' not in content:
        body_end = content.rfind('</body>')
        if body_end > 0:
            content = content[:body_end] + FAQ_SCRIPT + content[body_end:]
            changes.append("FAQ toggle added")
    
    # 5. Ensure UTF-8 meta tag
    if 'charset' not in content or 'UTF-8' not in content.upper():
        head_match = re.search(r'<head[^>]*>', content, re.IGNORECASE)
        if head_match:
            pos = head_match.end()
            meta_tag = '\n    <meta charset="UTF-8">\n'
            content = content[:pos] + meta_tag + content[pos:]
            changes.append("UTF-8 meta tag added")
    
    # Save with UTF-8
    if content != original:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"  [OK] Fixed: {', '.join(set(changes))}")
        return True
    else:
        print(f"  [OK] No changes needed")
        return False

def main():
    print("[FIX] Fixing all landing pages...")
    print("=" * 60)
    
    fixed_count = 0
    for page in LANDING_PAGES:
        if fix_file(page):
            fixed_count += 1
    
    print("\n" + "=" * 60)
    print(f"[DONE] Fixed {fixed_count} files.")
    print("\n[INFO] All files saved with UTF-8 encoding.")
    print("[INFO] Navigation and footer embedded in all pages.")
    print("[INFO] Emojis fixed in county-cap.html.")
    print("[INFO] FAQ accordion fixed.")

if __name__ == '__main__':
    main()

