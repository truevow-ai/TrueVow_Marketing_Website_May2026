#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Fix the white gap between CTA section and footer by:
1. Overriding CTA section padding to remove bottom padding
2. Making blue fill div cover any remaining gap
"""

import re

filepath = "marketing/county-cap.html"
backup_path = "marketing/county-cap.html.footer-gap-final-backup"

print(f"[FIX] Reading {filepath}...")
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# Create backup
print(f"[BACKUP] Creating backup...")
with open(backup_path, 'w', encoding='utf-8') as f:
    f.write(content)

original = content
changes = []

# 1. Update CTA section to override padding completely
print("\n[FIX 1] Updating CTA section padding...")
content = re.sub(
    r'<section class="cta-section" style="margin-bottom: 0; padding-bottom: 0;">',
    r'<section class="cta-section" style="margin-bottom: 0 !important; padding-bottom: 0 !important; padding: 80px 24px 0 24px !important;">',
    content
)
if content != original:
    changes.append("Updated CTA section padding to remove bottom padding")
    original = content

# 2. Ensure blue fill div is tall enough
print("\n[FIX 2] Ensuring blue fill div covers gap...")
content = re.sub(
    r'<!-- BLUE FILL - Remove white gap between CTA and footer -->\s*<div style="background: linear-gradient\(135deg, #0A2463 0%, #0052CC 100%\); min-height: 80px; margin: 0 !important; padding: 0 !important; width: 100%; display: block; box-sizing: border-box;"></div>',
    r'<!-- BLUE FILL - Remove white gap between CTA and footer -->\n<div style="background: linear-gradient(135deg, #0A2463 0%, #0052CC 100%); min-height: 100px; margin: 0 !important; padding: 0 !important; width: 100%; display: block; box-sizing: border-box; position: relative;"></div>',
    content
)
if content != original:
    changes.append("Updated blue fill div to cover gap")
    original = content

# Write changes
if changes:
    print(f"\n[WRITE] Writing changes to {filepath}...")
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"\n[SUCCESS] Applied {len(changes)} fixes:")
    for change in changes:
        print(f"  ✓ {change}")
else:
    print("\n[INFO] No changes needed")

