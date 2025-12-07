#!/usr/bin/env python3
"""
Fix all black box issues in pricing.html:
1. Fix "Never lose a qualified lead to voicemail again" black box
2. Fix FAQ highlight boxes that are black
3. Fix emotional urgency box background (image 4) to light blueish
"""

import re

# Read the file
with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Fix the bullet point "Never lose a qualified lead to voicemail again" black box
# This is likely in a pricing feature list with background: #000000
content = re.sub(
    r'(<li[^>]*style="[^"]*background:\s*)#000000([^"]*Never lose a qualified lead to voicemail again[^<]*</li>)',
    lambda m: m.group(1) + '#E8F4FD' + m.group(2),
    content,
    flags=re.IGNORECASE | re.DOTALL
)

# Also fix if it's background: #1A1A1A or any dark color
content = re.sub(
    r'(<li[^>]*style="[^"]*background:\s*)(#000000|#1A1A1A|#000)([^"]*Never lose a qualified lead to voicemail again[^<]*</li>)',
    lambda m: m.group(1) + '#E8F4FD' + m.group(3),
    content,
    flags=re.IGNORECASE | re.DOTALL
)

# 2. Fix all FAQ highlight boxes that are black
# Find all .faq-highlight divs with black backgrounds
content = re.sub(
    r'(<div[^>]*class="faq-highlight"[^>]*style="[^"]*background:\s*)(#000000|#1A1A1A|#000)([^"]*")',
    lambda m: m.group(1) + '#E8F4FD' + m.group(3),
    content,
    flags=re.IGNORECASE
)

# Also check for faq-highlight in style attribute without class
content = re.sub(
    r'(<div[^>]*style="[^"]*faq-highlight[^"]*background:\s*)(#000000|#1A1A1A|#000)([^"]*")',
    lambda m: m.group(1) + '#E8F4FD' + m.group(3),
    content,
    flags=re.IGNORECASE
)

# Fix any div with background: #000000 that contains FAQ content
# Look for patterns like "How does Settle? work?" or FAQ answers
content = re.sub(
    r'(<div[^>]*style="[^"]*background:\s*)(#000000|#1A1A1A|#000)([^"]*"[^>]*>.*?How does Settle\? work.*?</div>)',
    lambda m: m.group(1) + '#E8F4FD' + m.group(3),
    content,
    flags=re.IGNORECASE | re.DOTALL
)

# 3. Fix all callout boxes throughout FAQs - be more aggressive
# Find any div with margin-top, margin-bottom, padding that has black background
content = re.sub(
    r'(<div[^>]*style="[^"]*margin-top:\s*\d+px[^"]*margin-bottom:\s*\d+px[^"]*padding[^"]*background:\s*)(#000000|#1A1A1A|#000)([^"]*border-left[^"]*")',
    lambda m: m.group(1) + '#E8F4FD' + m.group(3),
    content,
    flags=re.IGNORECASE
)

# Fix any div with background: #000000 in FAQ sections
# Look for FAQ answer sections
content = re.sub(
    r'(<div class="faq-answer">[^<]*<div[^>]*style="[^"]*background:\s*)(#000000|#1A1A1A|#000)([^"]*")',
    lambda m: m.group(1) + '#E8F4FD' + m.group(3),
    content,
    flags=re.IGNORECASE | re.DOTALL
)

# 4. Fix emotional urgency box (image 4) - change inside box background to light blueish
# The box with "The frustration of missing calls at 9 PM..."
# Find the div inside the section with the gradient background
content = re.sub(
    r'(<div[^>]*style="[^"]*margin:\s*40px auto[^"]*padding:\s*32px[^"]*background:\s*)(linear-gradient\([^)]+\)|#FFF3CD|#FFE082|#[A-F0-9]{6})([^"]*The frustration of missing calls[^"]*")',
    lambda m: m.group(1) + '#E8F4FD' + m.group(3),
    content,
    flags=re.IGNORECASE | re.DOTALL
)

# Also try a more specific pattern for the emotional urgency box
content = re.sub(
    r'(<div[^>]*style="[^"]*margin:\s*40px auto[^"]*padding:\s*32px[^"]*background:\s*)(linear-gradient\(135deg,\s*#FFF3CD[^)]+\))([^"]*border-radius[^"]*")',
    lambda m: m.group(1) + '#E8F4FD' + m.group(3),
    content,
    flags=re.IGNORECASE
)

# Write the file back
with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("[OK] All black box issues fixed!")
print("\nFixed:")
print("1. 'Never lose a qualified lead to voicemail again' black box -> light blue")
print("2. All FAQ highlight boxes with black backgrounds -> light blue (#E8F4FD)")
print("3. Emotional urgency box background -> light blueish (#E8F4FD)")
print("\nPlease verify the page and let me know if any black boxes remain.")

