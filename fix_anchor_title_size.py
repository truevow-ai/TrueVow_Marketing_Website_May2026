#!/usr/bin/env python3
"""
Increase font size of anchor-title heading
"""

import re

# Read the file
with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Find and update .anchor-title CSS to increase font-size
# Look for .anchor-title in style block
anchor_title_pattern = r'(\.anchor-title\s*\{[^}]*font-size:\s*)(\d+)(px[^}]*\})'

if re.search(anchor_title_pattern, content, re.IGNORECASE | re.DOTALL):
    # Update existing font-size to at least 28px
    content = re.sub(
        anchor_title_pattern,
        lambda m: m.group(1) + '28px' + m.group(3) if int(m.group(2)) < 28 else m.group(0),
        content,
        flags=re.IGNORECASE | re.DOTALL
    )
else:
    # Add font-size if it doesn't exist
    content = re.sub(
        r'(\.anchor-title\s*\{[^}]*)(\})',
        r'\1font-size: 28px; \2',
        content,
        flags=re.IGNORECASE | re.DOTALL
    )

# Also add inline style to the heading itself as a backup
content = re.sub(
    r'(<div[^>]*class="anchor-title"[^>]*)(>)',
    lambda m: m.group(1) + ' style="font-size: 28px; font-weight: 700;"' + m.group(2) if 'style=' not in m.group(1) else m.group(0),
    content,
    flags=re.IGNORECASE
)

# Write the file back
with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("[OK] Anchor title font size increased to 28px!")

