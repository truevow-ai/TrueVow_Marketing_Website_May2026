#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Fix the footer CSS rule that has padding: 60px 24px (60px top padding)
This is causing the white gap between CTA section and footer
"""

import re

filepath = "marketing/county-cap.html"
backup_path = "marketing/county-cap.html.footer-css-fix-backup"

print(f"[FIX] Reading {filepath}...")
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# Create backup
print(f"[BACKUP] Creating backup...")
with open(backup_path, 'w', encoding='utf-8') as f:
    f.write(content)

original = content
changes = []

# Fix the footer CSS rule - change padding: 60px 24px to padding: 0 24px 60px 24px
print("\n[FIX 1] Updating footer CSS rule...")
# The CSS is minified, so we need to match the exact pattern
content = re.sub(
    r'footer\s*\{\s*background:\s*#1a1a1a;\s*color:\s*#999;\s*padding:\s*60px\s+24px;\s*text-align:\s*center;\s*\}',
    r'footer { background: #1a1a1a; color: #999; padding: 0 24px 60px 24px; text-align: center; margin-top: 0 !important; }',
    content
)
if content != original:
    changes.append("Updated footer CSS rule to remove top padding")
    original = content
else:
    # Try a more flexible pattern in case spacing is different
    content = re.sub(
        r'footer\s*\{[^}]*padding:\s*60px\s+24px[^}]*\}',
        lambda m: m.group(0).replace('padding: 60px 24px', 'padding: 0 24px 60px 24px').replace('}', ' margin-top: 0 !important; }'),
        content
    )
    if content != original:
        changes.append("Updated footer CSS rule to remove top padding (flexible match)")

# Write changes
if changes:
    print(f"\n[WRITE] Writing changes to {filepath}...")
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"\n[SUCCESS] Applied {len(changes)} fixes:")
    for change in changes:
        print(f"  ✓ {change}")
else:
    print("\n[INFO] No changes needed - footer CSS rule not found or already fixed")

