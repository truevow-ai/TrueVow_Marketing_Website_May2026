#!/usr/bin/env python3
"""
Fix remaining black box issues:
1. "Never lose a qualified lead" item in pricing card
2. Any remaining FAQ highlights with black backgrounds
"""

import re

# Read the file
with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

fixes = []

# 1. Fix "Never lose a qualified lead" - find the exact pattern
# Look for li with background: #000000 containing that text
pattern1 = r'(<li[^>]*style="[^"]*background:\s*#000000[^"]*"[^>]*>.*?Never lose a qualified lead to voicemail again[^<]*</li>)'
if re.search(pattern1, content, re.IGNORECASE | re.DOTALL):
    content = re.sub(
        pattern1,
        lambda m: m.group(0).replace('background: #000000', 'background: #E8F4FD').replace('background:#000000', 'background: #E8F4FD'),
        content,
        flags=re.IGNORECASE | re.DOTALL
    )
    fixes.append("Fixed 'Never lose a qualified lead' black box")

# 2. Find all divs with class="faq-highlight" that don't have inline style with background
# Check if they're using the CSS class which might have black background
# We already fixed the CSS, but check for any inline overrides

# 3. Find all divs with style containing background: #000000 that are in FAQ sections
pattern3 = r'(<div[^>]*style="[^"]*background:\s*#000000[^"]*"[^>]*>.*?</div>)'
matches3 = re.findall(pattern3, content, re.IGNORECASE | re.DOTALL)
faq_matches = [m for m in matches3 if 'faq' in m.lower() or 'settle' in m.lower() or 'median settlement' in m.lower() or 'no phi' in m.lower()]
if faq_matches:
    for match in faq_matches:
        if 'footer' not in match.lower() and 'nav' not in match.lower():
            content = content.replace(match, match.replace('background: #000000', 'background: #E8F4FD').replace('background:#000000', 'background: #E8F4FD'))
    fixes.append(f"Fixed {len(faq_matches)} FAQ divs with black backgrounds")

# 4. More specific: Find divs with margin-top, margin-bottom, padding that have #000000
pattern4 = r'(<div[^>]*style="[^"]*margin-top:\s*\d+px[^"]*margin-bottom:\s*\d+px[^"]*padding[^"]*background:\s*#000000[^"]*")'
matches4 = len(re.findall(pattern4, content, re.IGNORECASE))
if matches4 > 0:
    content = re.sub(
        pattern4,
        lambda m: m.group(0).replace('background: #000000', 'background: #E8F4FD'),
        content,
        flags=re.IGNORECASE
    )
    fixes.append(f"Fixed {matches4} callout boxes with black backgrounds")

# 5. Check for "How does Settle? work?" section specifically
pattern5 = r'(💰 How does Settle\? work.*?<div[^>]*style="[^"]*background:\s*#000000[^"]*")'
if re.search(pattern5, content, re.IGNORECASE | re.DOTALL):
    content = re.sub(
        pattern5,
        lambda m: m.group(0).replace('background: #000000', 'background: #E8F4FD'),
        content,
        flags=re.IGNORECASE | re.DOTALL
    )
    fixes.append("Fixed 'How does Settle? work?' black box")

# Write the file
with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("[OK] Remaining black box fixes applied!")
if fixes:
    for fix in fixes:
        print(f"  - {fix}")
else:
    print("  - No additional fixes needed (all black boxes already fixed)")

