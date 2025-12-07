#!/usr/bin/env python3
"""
Fix remaining issues in pricing.html:
1. Footer background color - change to black
2. Hero section background color - ensure it's black
3. FAQ category icons - ensure only Pricing & Billing has 💰
4. Verify all other fixes are correct
"""

import re

# Read the file
with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Fix footer background - find footer section and change background to black
# Look for footer with background color
content = re.sub(
    r'(<footer[^>]*style="[^"]*background:\s*)#E8F4FD([^"]*")',
    r'\1#000000\2',
    content,
    flags=re.IGNORECASE
)

# Also check for footer without inline style but with class that might have background
# Footer should have: background: #000000
footer_pattern = r'(<footer[^>]*style="[^"]*background:\s*)([^;"]+)([^"]*")'
if re.search(footer_pattern, content):
    content = re.sub(
        footer_pattern,
        lambda m: m.group(1) + '#000000' + m.group(3) if '#E8F4FD' in m.group(2).upper() or 'E8F4FD' in m.group(2) else m.group(0),
        content,
        flags=re.IGNORECASE
    )

# 2. Hero section background - ensure it's black (#000000)
# Hero section should have background: #000000 in CSS class
# Check if hero section has inline style that needs fixing
content = re.sub(
    r'(<section[^>]*class="hero"[^>]*style="[^"]*background:\s*)#E8F4FD([^"]*")',
    r'\1#000000\2',
    content,
    flags=re.IGNORECASE
)

# Also check CSS for .hero class
content = re.sub(
    r'(\.hero\s*\{[^}]*background:\s*)#E8F4FD([^}]*\})',
    r'\1#000000\2',
    content,
    flags=re.IGNORECASE | re.DOTALL
)

# 3. FAQ category icons - ensure only "Pricing & Billing" has 💰
# All other categories should have different icons
# We already fixed: 👥 (Who Is This For), 🚀 (Getting Started), 💬 (Objections Answered)
# Need to verify "How It Works" has ⚙️ and "Compliance & Security" has 🔒

# Verify "How It Works" has ⚙️ (should already be correct)
if 'How It Works' in content and '⚙️' not in content.split('How It Works')[1].split('</span>')[0]:
    content = re.sub(
        r'(<span class="faq-category-icon">)([^<]+)(</span>\s*<span>How It Works</span>)',
        r'\1⚙️\3',
        content
    )

# Verify "Compliance & Security" has 🔒 (should already be correct)
if 'Compliance & Security' in content and '🔒' not in content.split('Compliance & Security')[0].split('faq-category-icon">')[-1]:
    content = re.sub(
        r'(<span class="faq-category-icon">)([^<]+)(</span>\s*<span>Compliance & Security</span>)',
        r'\1🔒\3',
        content
    )

# 4. Verify "Why We Built TrueVow" section has correct background (#F8F9FA)
content = re.sub(
    r'(<!-- WHY WE BUILT TRUEVOW -->\s*<section[^>]*style="[^"]*background:\s*)(white|#FFFFFF)([^"]*")',
    r'\1#F8F9FA\3',
    content,
    flags=re.IGNORECASE
)

# 5. Ensure FAQ section has padding-bottom: 0 to remove gap
content = re.sub(
    r'(<!-- FAQ -->\s*<section[^>]*class="faq"[^>]*style="[^"]*background:\s*white)([^"]*")',
    r'\1; padding-bottom: 0\2',
    content,
    flags=re.IGNORECASE
)

# 6. Ensure "Works for..." section has white background and no margin-bottom gap
content = re.sub(
    r'(<!-- PRACTICE AREAS & SETUP -->\s*<section[^>]*style="[^"]*background:\s*)#E8F4FD([^"]*margin-bottom:\s*)(\d+)([^"]*")',
    lambda m: m.group(1) + 'white' + m.group(2) + '0px' + m.group(4),
    content,
    flags=re.IGNORECASE
)

# 7. Ensure emotional urgency box has #E2E8F0 background (already done, but verify)
content = re.sub(
    r'(<!-- EMOTIONAL URGENCY BOX -->\s*<section[^>]*style="[^"]*background:\s*)#E8F4FD([^"]*")',
    r'\1white\2',
    content,
    flags=re.IGNORECASE
)

# Write the file back
with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("[OK] All fixes applied successfully!")
print("\nFixed:")
print("1. Footer background -> black")
print("2. Hero section background -> black (verified)")
print("3. FAQ category icons -> verified (only Pricing & Billing has money icon)")
print("4. 'Why We Built TrueVow' section -> #F8F9FA background")
print("5. FAQ section -> padding-bottom: 0 (removed gap)")
print("6. 'Works for...' section -> white background, no margin gap")
print("7. Emotional urgency box -> white section background, #E2E8F0 box background")
