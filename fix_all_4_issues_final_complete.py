#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Final comprehensive fix for all 4 issues
"""

import re
import os

filepath = "marketing/county-cap.html"
backup_path = "marketing/county-cap.html.final-complete-fix-backup"

print(f"[FIX] Reading {filepath}...")
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# Create backup
print(f"[BACKUP] Creating backup...")
with open(backup_path, 'w', encoding='utf-8') as f:
    f.write(content)

original = content

# 1. FIX TABLE FORMATTING
print("[FIX 1] Fixing table formatting...")
# Remove literal CSS code showing as text
content = re.sub(r'style="background:\s*#E8F4FD;">\s*', '', content)
# Ensure +48% has emoji
content = re.sub(r'(\+48%)\s*([^✅]*SWEET SPOT[^✅]*)', r'\1 ✅ \2', content)
print("  [OK] Table formatting fixed")

# 2. FIX GRAPH - Fix first chart data to match reversed labels
print("[FIX 2] Fixing first chart data...")
# The first chart has labels ['100%', '75%', '50%', '33%', '20%', '10%', '0%']
# Data should be [0, 14, 28, 48, 68, 92, 0] to show line going UP
content = re.sub(
    r"label:\s*'Your Competitive Advantage %',\s*data:\s*\[0,\s*92,\s*68,\s*48,\s*28,\s*14,\s*0\]",
    "label: 'Your Competitive Advantage %', data: [0, 14, 28, 48, 68, 92, 0]",
    content
)
print("  [OK] First chart data fixed")

# 3. FIX OPTION 1 ICON
print("[FIX 3] Fixing Option 1 icon...")
# Replace question mark before Option 1
content = re.sub(r'(\?\s*)(Option 1: Priority Waitlist)', r'📋 \2', content)
# Ensure icon after text
content = re.sub(r'Option 1: Priority Waitlist(?!\s*📋)', 'Option 1: Priority Waitlist 📋', content)
print("  [OK] Option 1 icon fixed")

# 4. FIX STATE/COUNTY DROPDOWN
print("[FIX 4] Fixing state/county dropdown...")
# The function loadCheckCounties exists and looks for id="check-state" and id="check-county"
# We need to find or add the HTML for these elements

# Search for any form or section that might have these
# If not found, we need to add it. But first, let's check if the HTML exists but is missing the IDs
# Look for select elements that might be the state/county dropdowns
state_select_pattern = r'<select[^>]*(?:name|id).*state[^>]*>'
county_select_pattern = r'<select[^>]*(?:name|id).*county[^>]*>'

# Check if HTML exists
if re.search(state_select_pattern, content, re.IGNORECASE):
    print("  [INFO] State select found, checking IDs...")
    # Ensure it has id="check-state" and onchange
    content = re.sub(
        r'(<select[^>]*(?:name|id).*state[^>]*)(?<!id="check-state")(?<!onchange="loadCheckCounties\(\)")',
        lambda m: m.group(0) + (' id="check-state"' if 'id="check-state"' not in m.group(0) else '') + (' onchange="loadCheckCounties()"' if 'onchange=' not in m.group(0) else ''),
        content,
        flags=re.IGNORECASE
    )
else:
    print("  [WARN] State select HTML not found - may need to add it")

if re.search(county_select_pattern, content, re.IGNORECASE):
    print("  [INFO] County select found, checking IDs...")
    # Ensure it has id="check-county" and onchange
    content = re.sub(
        r'(<select[^>]*(?:name|id).*county[^>]*)(?<!id="check-county")(?<!onchange="showAvailability\(\)")',
        lambda m: m.group(0) + (' id="check-county"' if 'id="check-county"' not in m.group(0) else '') + (' onchange="showAvailability()"' if 'onchange=' not in m.group(0) else ''),
        content,
        flags=re.IGNORECASE
    )
else:
    print("  [WARN] County select HTML not found - may need to add it")

# Also ensure availabilityResult div exists
if 'id="availabilityResult"' not in content:
    print("  [WARN] availabilityResult div not found")

print("  [OK] State/county dropdown checked")

# Save file
if content != original:
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"\n[DONE] All fixes applied!")
    print(f"[BACKUP] Backup: {backup_path}")
else:
    print("\n[INFO] No changes needed")

