#!/usr/bin/env python3
"""
Fix final adjustments in pricing.html:
1. Increase size of "COMPARE: What You're Probably Paying Now" heading
2. Make card headings bold: "Human Receptionist", "Answering Service (Mid-Tier Live Receptionist)", "Marketing Ad Spend Lost"
3. Add padding to footer from top
"""

import re

# Read the file
with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Increase size of "COMPARE: What You're Probably Paying Now" heading
# Find the anchor-title class or the heading itself
content = re.sub(
    r'(<div[^>]*class="anchor-title"[^>]*>)\s*COMPARE: What You\'re Probably Paying Now\s*(</div>)',
    lambda m: m.group(1) + 'COMPARE: What You\'re Probably Paying Now' + m.group(2),
    content,
    flags=re.IGNORECASE
)

# Update the CSS for .anchor-title to increase font size
content = re.sub(
    r'(\.anchor-title\s*\{[^}]*font-size:\s*)(\d+)(px[^}]*\})',
    lambda m: m.group(1) + str(max(int(m.group(2)), 24)) + 'px' + m.group(3) if int(m.group(2)) < 24 else m.group(0),
    content,
    flags=re.IGNORECASE | re.DOTALL
)

# If anchor-title doesn't have font-size, add it
if '.anchor-title' in content and 'font-size' not in content.split('.anchor-title')[1].split('}')[0]:
    content = re.sub(
        r'(\.anchor-title\s*\{[^}]*)(\})',
        r'\1font-size: 28px; \2',
        content,
        flags=re.IGNORECASE | re.DOTALL
    )

# 2. Make card headings bold
# Find the anchor-label divs and make them bold
card_headings = [
    'Human Receptionist',
    'Answering Service \\(Mid-Tier Live Receptionist\\)',
    'Marketing Ad Spend Lost'
]

for heading in card_headings:
    # Make the text bold by wrapping in <strong> or adding font-weight
    content = re.sub(
        r'(<div[^>]*class="anchor-label"[^>]*>)\s*' + heading + r'\s*(</div>)',
        lambda m: m.group(1) + '<strong>' + heading.replace('\\', '') + '</strong>' + m.group(2),
        content,
        flags=re.IGNORECASE
    )
    
    # Also ensure the CSS for .anchor-label has font-weight: bold
    content = re.sub(
        r'(\.anchor-label\s*\{[^}]*)(\})',
        lambda m: m.group(1) + ' font-weight: 700;' + m.group(2) if 'font-weight' not in m.group(1) else m.group(0),
        content,
        flags=re.IGNORECASE | re.DOTALL
    )

# 3. Add padding to footer from top
# Find footer and add padding-top
content = re.sub(
    r'(<footer[^>]*style="[^"]*)(background:\s*#000000[^"]*")',
    lambda m: m.group(1) + 'padding-top: 60px; ' + m.group(2) if 'padding-top' not in m.group(1) else m.group(0),
    content,
    flags=re.IGNORECASE
)

# If footer doesn't have inline style, add it
if '<footer' in content and 'style=' not in content.split('<footer')[1].split('>')[0]:
    content = re.sub(
        r'(<footer)([^>]*>)',
        r'\1 style="background: #000000; padding-top: 60px;"\2',
        content,
        flags=re.IGNORECASE
    )

# Write the file back
with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("[OK] All final adjustments applied successfully!")
print("\nFixed:")
print("1. Increased size of 'COMPARE: What You're Probably Paying Now' heading")
print("2. Made card headings bold: 'Human Receptionist', 'Answering Service (Mid-Tier Live Receptionist)', 'Marketing Ad Spend Lost'")
print("3. Added padding-top: 60px to footer")

