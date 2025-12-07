#!/usr/bin/env python3
"""
Final verification and fix for all black boxes
"""

import re

with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

fixes = []

# Find "Never lose" and check its background
never_lose_idx = content.find('Never lose')
if never_lose_idx >= 0:
    # Get the surrounding context
    start = max(0, never_lose_idx - 200)
    end = min(len(content), never_lose_idx + 200)
    context = content[start:end]
    
    # Check if it has #000000 background
    if '#000000' in context or 'background: #000000' in context or 'background:#000000' in context:
        # Find the <li> tag containing this
        li_start = content.rfind('<li', 0, never_lose_idx)
        if li_start >= 0:
            li_end = content.find('</li>', never_lose_idx)
            if li_end >= 0:
                li_tag = content[li_start:li_end+5]
                # Replace #000000 with #E8F4FD
                new_li = li_tag.replace('background: #000000', 'background: #E8F4FD')
                new_li = new_li.replace('background:#000000', 'background: #E8F4FD')
                if new_li != li_tag:
                    content = content[:li_start] + new_li + content[li_end+5:]
                    fixes.append("Fixed 'Never lose' black box")

# Find all remaining style="...background: #000000..." that are NOT in footer/nav/hero
# Use a more careful approach
def fix_black_bg_in_style(match):
    full_match = match.group(0)
    # Skip if it's footer, nav, or hero section
    if any(x in full_match.lower() for x in ['footer', '<nav', 'class="hero"', 'section class="hero"']):
        return full_match
    # Replace black with light blue
    return full_match.replace('background: #000000', 'background: #E8F4FD').replace('background:#000000', 'background: #E8F4FD')

# Find all style attributes with background: #000000
pattern = r'style="[^"]*background:\s*#000000[^"]*"'
matches = list(re.finditer(pattern, content, re.IGNORECASE))
non_footer_matches = [m for m in matches if 'footer' not in content[max(0,m.start()-100):m.end()].lower() and 'nav' not in content[max(0,m.start()-100):m.end()].lower() and 'hero' not in content[max(0,m.start()-100):m.end()].lower()]

if non_footer_matches:
    # Replace from end to start to preserve indices
    for match in reversed(non_footer_matches):
        old = match.group(0)
        new = old.replace('background: #000000', 'background: #E8F4FD').replace('background:#000000', 'background: #E8F4FD')
        if new != old:
            content = content[:match.start()] + new + content[match.end():]
            fixes.append(f"Fixed black background in style attribute")

# Write back
with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("[OK] Final verification and fixes complete!")
if fixes:
    for fix in fixes:
        print(f"  - {fix}")
else:
    print("  - All black boxes already fixed!")

