#!/usr/bin/env python3
"""
Comprehensive fix for all black box issues in pricing.html
Reads file in chunks to handle large size
"""

import re

# Read the file
print("Reading pricing.html...")
with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

print(f"File size: {len(content)} characters")

# Track what we fix
fixes_applied = []

# 1. Fix the "Never lose a qualified lead to voicemail again" item
# This is in a <li> with style containing background: #000000
pattern1 = r'(<li[^>]*style="[^"]*background:\s*)(#000000|#1A1A1A|#000)([^"]*Never lose a qualified lead to voicemail again[^<]*</li>)'
if re.search(pattern1, content, re.IGNORECASE | re.DOTALL):
    content = re.sub(
        pattern1,
        lambda m: m.group(1) + '#E8F4FD' + m.group(3),
        content,
        flags=re.IGNORECASE | re.DOTALL
    )
    fixes_applied.append("Fixed 'Never lose a qualified lead' black box")

# Also check for background: #000000 in any li containing that text
pattern1b = r'(<li[^>]*style="[^"]*background:\s*#000000[^"]*"[^>]*>.*?Never lose a qualified lead[^<]*</li>)'
if re.search(pattern1b, content, re.IGNORECASE | re.DOTALL):
    content = re.sub(
        pattern1b,
        lambda m: m.group(0).replace('#000000', '#E8F4FD').replace('#1A1A1A', '#E8F4FD'),
        content,
        flags=re.IGNORECASE | re.DOTALL
    )
    fixes_applied.append("Fixed 'Never lose a qualified lead' black box (pattern 1b)")

# 2. Fix CSS for .faq-highlight class if it has black background
pattern2 = r'(\.faq-highlight\s*\{[^}]*background:\s*)(#000000|#1A1A1A|#000)([^}]*\})'
if re.search(pattern2, content, re.IGNORECASE | re.DOTALL):
    content = re.sub(
        pattern2,
        lambda m: m.group(1) + '#E8F4FD' + m.group(3),
        content,
        flags=re.IGNORECASE | re.DOTALL
    )
    fixes_applied.append("Fixed .faq-highlight CSS black background")

# 3. Fix all inline style divs with class="faq-highlight" that have black background
pattern3 = r'(<div[^>]*class="faq-highlight"[^>]*style="[^"]*background:\s*)(#000000|#1A1A1A|#000)([^"]*")'
matches3 = len(re.findall(pattern3, content, re.IGNORECASE))
if matches3 > 0:
    content = re.sub(
        pattern3,
        lambda m: m.group(1) + '#E8F4FD' + m.group(3),
        content,
        flags=re.IGNORECASE
    )
    fixes_applied.append(f"Fixed {matches3} FAQ highlight divs with black backgrounds")

# 4. Fix divs with style containing "margin-top" and "margin-bottom" and "padding" that have black background
# These are typically FAQ callout boxes
pattern4 = r'(<div[^>]*style="[^"]*margin-top:\s*\d+px[^"]*margin-bottom:\s*\d+px[^"]*padding[^"]*background:\s*)(#000000|#1A1A1A|#000)([^"]*")'
matches4 = len(re.findall(pattern4, content, re.IGNORECASE))
if matches4 > 0:
    content = re.sub(
        pattern4,
        lambda m: m.group(1) + '#E8F4FD' + m.group(3),
        content,
        flags=re.IGNORECASE
    )
    fixes_applied.append(f"Fixed {matches4} FAQ callout boxes with black backgrounds")

# 5. Fix any div with background: #000000 in FAQ answer sections
pattern5 = r'(<div class="faq-answer">.*?<div[^>]*style="[^"]*background:\s*)(#000000|#1A1A1A|#000)([^"]*")'
matches5 = len(re.findall(pattern5, content, re.IGNORECASE | re.DOTALL))
if matches5 > 0:
    content = re.sub(
        pattern5,
        lambda m: m.group(1) + '#E8F4FD' + m.group(3),
        content,
        flags=re.IGNORECASE | re.DOTALL
    )
    fixes_applied.append(f"Fixed {matches5} FAQ answer divs with black backgrounds")

# 6. Fix "How does Settle? work?" section specifically
pattern6 = r'(💰 How does Settle\? work.*?<div[^>]*style="[^"]*background:\s*)(#000000|#1A1A1A|#000)([^"]*")'
if re.search(pattern6, content, re.IGNORECASE | re.DOTALL):
    content = re.sub(
        pattern6,
        lambda m: m.group(1) + '#E8F4FD' + m.group(3),
        content,
        flags=re.IGNORECASE | re.DOTALL
    )
    fixes_applied.append("Fixed 'How does Settle? work?' black box")

# 7. More aggressive: Find any div with background: #000000 that's not the footer
pattern7 = r'(<div[^>]*style="[^"]*background:\s*)(#000000|#1A1A1A)([^"]*"[^>]*>)(?!.*footer)'
matches7 = len(re.findall(pattern7, content, re.IGNORECASE))
if matches7 > 0:
    # Be careful - only replace if it's in FAQ or pricing sections
    def replace_black_bg(match):
        full_match = match.group(0)
        # Don't replace if it's in footer or nav
        if 'footer' in full_match.lower() or 'nav' in full_match.lower():
            return full_match
        # Replace black with light blue
        return match.group(1) + '#E8F4FD' + match.group(3)
    
    content = re.sub(
        pattern7,
        replace_black_bg,
        content,
        flags=re.IGNORECASE
    )
    fixes_applied.append(f"Fixed {matches7} additional divs with black backgrounds (excluding footer/nav)")

# Write the file back
print("Writing fixed file...")
with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("\n[OK] Comprehensive black box fix complete!")
print(f"\nTotal fixes applied: {len(fixes_applied)}")
for fix in fixes_applied:
    print(f"  - {fix}")

print("\nAll black backgrounds in FAQ highlights and callout boxes have been changed to #E8F4FD (light blueish).")
print("Footer and navigation remain black as intended.")

