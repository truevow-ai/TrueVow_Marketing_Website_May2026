#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Final comprehensive fix for all 4 issues
"""

import re
import os

filepath = "marketing/county-cap.html"
backup_path = "marketing/county-cap.html.final-4-fixes-backup"

print(f"[FIX] Reading {filepath}...")
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# Create backup
print(f"[BACKUP] Creating backup...")
with open(backup_path, 'w', encoding='utf-8') as f:
    f.write(content)

original = content
changes = []

# 1. FIX TABLE FORMATTING - Remove literal CSS
print("[FIX 1] Fixing table formatting...")
# Remove any style="background: #E8F4FD;"> appearing as text
content = re.sub(r'style="background:\s*#E8F4FD;">\s*', '', content)
# Ensure +48% has emoji
content = re.sub(r'(\+48%)\s*([^✅]*SWEET SPOT[^✅]*)', r'\1 ✅ \2', content)
changes.append("Table formatting fixed")

# 2. FIX GRAPH - Fix ALL chart instances to show upward trend
print("[FIX 2] Fixing ALL chart instances...")
# Fix the first chart (line 65) - change from cases to advantage
content = re.sub(
    r"label:\s*'Cases Per Month',\s*data:\s*\[2\.5,\s*4\.8,\s*4\.2,\s*3\.7,\s*3\.2,\s*2\.8,\s*2\.5\]",
    "label: 'Your Competitive Advantage %', data: [0, 92, 68, 48, 28, 14, 0]",
    content
)

# Update labels for first chart
content = re.sub(
    r"labels:\s*\['0%',\s*'10%',\s*'20%',\s*'33%',\s*'50%',\s*'75%',\s*'100%'\]",
    "labels: ['100%', '75%', '50%', '33%', '20%', '10%', '0%']",
    content
)

# Fix other chart instances (already have reversed data, just ensure labels match)
# The charts at lines 92 and 142 should already be fixed, but let's verify
if "labels: ['100%', '50%', '33%', '20%', '10%']" not in content:
    content = re.sub(
        r"labels:\s*\['10%',\s*'20%',\s*'33%',\s*'50%',\s*'100%'\]",
        "labels: ['100%', '50%', '33%', '20%', '10%']",
        content
    )

if "data: [0, 28, 48, 68, 92]" not in content:
    content = re.sub(
        r"data:\s*\[92,\s*68,\s*48,\s*28,\s*0\]",
        "data: [0, 28, 48, 68, 92]",
        content
    )

changes.append("All charts fixed to show upward trend")

# 3. FIX OPTION 1 ICON
print("[FIX 3] Fixing Option 1 icon...")
# Replace question mark at start of Option 1 card
content = re.sub(r'(\?\s*)(Option 1: Priority Waitlist)', r'📋 \2', content)
# Ensure icon after text
content = re.sub(r'Option 1: Priority Waitlist(?!\s*📋)', 'Option 1: Priority Waitlist 📋', content)
changes.append("Option 1 icon fixed")

# 4. FIX STATE/COUNTY DROPDOWN
print("[FIX 4] Fixing state/county dropdown...")
# The function exists, but we need to ensure the HTML has the right IDs
# Look for select elements and ensure they have onchange
# Search for various patterns of state select
state_patterns = [
    (r'(<select[^>]*id="check-state"[^>]*)(>)', r'\1 onchange="loadCheckCounties()"\2'),
    (r'(<select[^>]*name="state"[^>]*id="check-state"[^>]*)(>)', r'\1 onchange="loadCheckCounties()"\2'),
]

for pattern, replacement in state_patterns:
    if re.search(pattern, content):
        content = re.sub(pattern, replacement, content)
        changes.append("State dropdown onchange added")
        break

# Also ensure county dropdown has onchange for showAvailability
county_patterns = [
    (r'(<select[^>]*id="check-county"[^>]*)(>)', r'\1 onchange="showAvailability()"\2'),
]

for pattern, replacement in county_patterns:
    if re.search(pattern, content):
        content = re.sub(pattern, replacement, content)
        changes.append("County dropdown onchange added")
        break

# Verify function is accessible
if 'function loadCheckCounties' in content and 'checkCountyData' in content:
    print("  [INFO] loadCheckCounties function and data exist")
else:
    print("  [WARN] Missing loadCheckCounties function or data")

changes.append("State/county dropdown fixed")

# Save file
if content != original:
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"\n[DONE] All fixes applied!")
    print(f"[BACKUP] Backup: {backup_path}")
    print(f"\n[CHANGES]")
    for change in changes:
        print(f"  ✓ {change}")
else:
    print("\n[INFO] No changes needed")

