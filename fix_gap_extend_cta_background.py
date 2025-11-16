#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Remove the separate blue fill div and extend the CTA section's background directly
by adding padding-bottom to the CTA section itself
"""

import re

filepath = "marketing/county-cap.html"
backup_path = "marketing/county-cap.html.extend-cta-backup"

print(f"[FIX] Reading {filepath}...")
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# Create backup
print(f"[BACKUP] Creating backup...")
with open(backup_path, 'w', encoding='utf-8') as f:
    f.write(content)

original = content
changes = []

# 1. Remove the blue fill div entirely
print("\n[FIX 1] Removing blue fill div...")
content = re.sub(
    r'<!-- BLUE FILL - Remove white gap between CTA and footer -->\s*<div style="[^"]*"></div>\s*',
    r'',
    content
)
if content != original:
    changes.append("Removed blue fill div")
    original = content

# 2. Update CTA section to extend background with padding-bottom
print("\n[FIX 2] Extending CTA section background...")
# Find the CTA section opening tag and update its padding
content = re.sub(
    r'<section class="cta-section" style="margin-bottom: 0; padding-bottom: 0;">',
    r'<section class="cta-section" style="margin-bottom: 0 !important; padding-bottom: 100px !important; padding: 80px 24px 100px 24px !important;">',
    content
)
if content != original:
    changes.append("Extended CTA section background with padding-bottom")
    original = content

# 3. Also update the CSS rule for .cta-section to ensure it extends
print("\n[FIX 3] Updating .cta-section CSS rule...")
content = re.sub(
    r'\.cta-section\s*\{\s*background:\s*linear-gradient\(135deg,\s*#0A2463\s+0%,\s*#0052CC\s+100%\);\s*color:\s*white;\s*padding:\s*80px\s+24px;\s*text-align:\s*center;\s*\}',
    r'.cta-section { background: linear-gradient(135deg, #0A2463 0%, #0052CC 100%); color: white; padding: 80px 24px 100px 24px; text-align: center; margin-bottom: 0 !important; }',
    content
)
if content != original:
    changes.append("Updated .cta-section CSS rule to extend background")
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

