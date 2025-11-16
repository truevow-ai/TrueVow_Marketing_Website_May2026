#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Complete fix for white gap between CTA section and footer:
1. Ensure CTA section has no bottom margin/padding
2. Ensure blue fill div covers full width and height
3. Ensure footer has no top margin/padding
4. Add CSS to remove any body/html margins
"""

import re

filepath = "marketing/county-cap.html"
backup_path = "marketing/county-cap.html.white-gap-complete-backup"

print(f"[FIX] Reading {filepath}...")
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# Create backup
print(f"[BACKUP] Creating backup...")
with open(backup_path, 'w', encoding='utf-8') as f:
    f.write(content)

original = content
changes = []

# 1. Update the blue fill div to ensure it covers the gap properly
print("\n[FIX 1] Updating blue fill div...")
content = re.sub(
    r'<!-- BLUE FILL - Remove white gap between CTA and footer -->\s*<div style="background: linear-gradient\(135deg, #0A2463 0%, #0052CC 100%\); min-height: 80px; margin: 0 !important; padding: 0 !important; width: 100vw; display: block; box-sizing: border-box; position: relative; left: 50%; transform: translateX\(-50%\);"></div>',
    r'<!-- BLUE FILL - Remove white gap between CTA and footer -->\n<div style="background: linear-gradient(135deg, #0A2463 0%, #0052CC 100%); min-height: 100px; margin: 0 !important; padding: 0 !important; width: 100vw; display: block; box-sizing: border-box; position: relative; left: 50%; transform: translateX(-50%); overflow: visible;"></div>',
    content
)
if content != original:
    changes.append("Updated blue fill div to cover gap")
    original = content

# 2. Add CSS to ensure no body/html margins
print("\n[FIX 2] Adding CSS to remove body/html margins...")
# Find the style tag with the existing CSS overrides
css_override_pattern = r'(section\.cta-section\s*\{[^}]*margin-bottom:\s*0\s*!important;[^}]*\})'
if re.search(css_override_pattern, content):
    # Add additional CSS after the existing override
    content = re.sub(
        r'(section\.cta-section\s*\{[^}]*margin-bottom:\s*0\s*!important;[^}]*\})',
        r'\1\n            body, html {\n                margin: 0 !important;\n                padding: 0 !important;\n            }\n            section {\n                margin-bottom: 0 !important;\n            }',
        content
    )
    if content != original:
        changes.append("Added CSS to remove body/html margins")
        original = content

# 3. Ensure footer has no top margin
print("\n[FIX 3] Ensuring footer has no top margin...")
content = re.sub(
    r'<footer style="background: #1A1A1A; color: white; padding: 0 20px 120px 20px !important; text-align: center; margin-top: 0 !important;">',
    r'<footer style="background: #1A1A1A; color: white; padding: 0 20px 120px 20px !important; text-align: center; margin-top: 0 !important; margin-bottom: 0 !important;">',
    content
)
if content != original:
    changes.append("Ensured footer has no top/bottom margin")
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

