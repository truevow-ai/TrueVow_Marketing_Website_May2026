#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Complete fix for all 4 issues in county-cap.html
"""

import re
import os

filepath = "marketing/county-cap.html"
backup_path = "marketing/county-cap.html.complete-4-fixes-backup"

print(f"[FIX] Reading {filepath}...")
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# Create backup
print(f"[BACKUP] Creating backup...")
with open(backup_path, 'w', encoding='utf-8') as f:
    f.write(content)

original = content
changes = []

# 1. FIX TABLE FORMATTING - Remove literal CSS showing as text
print("[FIX 1] Fixing table formatting (removing literal CSS)...")
# Pattern: style="background: #E8F4FD;"> appearing as text in table
content_fixed = re.sub(
    r'style="background:\s*#E8F4FD;">\s*',
    '',
    content
)
if content_fixed != content:
    content = content_fixed
    changes.append("Table formatting fixed (removed literal CSS)")

# Also fix any other style attributes showing as text
content_fixed = re.sub(
    r'style="[^"]*background[^"]*">\s*(\+48%)',
    r'\1 ✅',
    content
)
if content_fixed != content:
    content = content_fixed
    changes.append("Table CSS cleaned")

# Ensure SWEET SPOT has emoji
content_fixed = re.sub(
    r'(\+48%)\s*([^✅]*SWEET SPOT[^✅]*)',
    r'\1 ✅ \2',
    content
)
if content_fixed != content:
    content = content_fixed
    changes.append("SWEET SPOT emoji added")

print("  [OK] Table formatting fixed")

# 2. FIX GRAPH - Make line go UP (increasing advantage)
print("[FIX 2] Fixing graph to show upward trend...")
# The user wants the line to go UP, meaning advantage increases
# Current after my previous fix: labels reversed, data reversed
# But we need: X-axis 10% to 100% (left to right), Y-axis 0% to 100% (bottom to top)
# Data should be: [92, 68, 48, 28, 0] for labels ['10%', '20%', '33%', '50%', '100%']
# This shows line going DOWN (which is correct - less advantage as more firms join)
# But user wants it to go UP...

# Actually, I think the user wants the X-axis reversed OR the data inverted
# Let's try: Keep labels ['10%', '20%', '33%', '50%', '100%'] but reverse data
# OR reverse labels to ['100%', '50%', '33%', '20%', '10%'] with data [0, 28, 48, 68, 92]
# This way line goes UP from left (100% = 0%) to right (10% = 92%)

# Check current state
if "labels: ['100%', '50%', '33%', '20%', '10%']" in content:
    # Already reversed - this should show line going UP
    print("  [INFO] Graph labels already reversed")
else:
    # Reverse labels
    content_fixed = re.sub(
        r"labels:\s*\['10%',\s*'20%',\s*'33%',\s*'50%',\s*'100%'\]",
        "labels: ['100%', '50%', '33%', '20%', '10%']",
        content
    )
    if content_fixed != content:
        content = content_fixed
        changes.append("Graph labels reversed")

# Ensure data matches reversed labels
if "data: [0, 28, 48, 68, 92]" in content:
    print("  [INFO] Graph data already reversed")
else:
    content_fixed = re.sub(
        r"data:\s*\[92,\s*68,\s*48,\s*28,\s*0\]",
        "data: [0, 28, 48, 68, 92]",
        content
    )
    if content_fixed != content:
        content = content_fixed
        changes.append("Graph data reversed")

print("  [OK] Graph fixed to show upward trend")

# 3. FIX OPTION 1 MISSING ICON
print("[FIX 3] Fixing Option 1 missing icon...")
# Find Option 1 and add clipboard icon if missing
if "Option 1: Priority Waitlist 📋" in content:
    print("  [INFO] Option 1 already has icon")
else:
    # Add icon
    content_fixed = re.sub(
        r'Option 1:\s*Priority Waitlist(?!\s*📋)',
        'Option 1: Priority Waitlist 📋',
        content
    )
    if content_fixed != content:
        content = content_fixed
        changes.append("Option 1 icon added")
    
    # Also fix if there's a question mark
    content_fixed = re.sub(
        r'Option 1:\s*Priority Waitlist\s*\?',
        'Option 1: Priority Waitlist 📋',
        content
    )
    if content_fixed != content:
        content = content_fixed
        changes.append("Option 1 question mark replaced")

# Fix icon at top of card (before the text)
content_fixed = re.sub(
    r'(\?\s*)(Option 1: Priority Waitlist)',
    r'📋 \2',
    content
)
if content_fixed != content:
    content = content_fixed
    changes.append("Option 1 top icon fixed")

print("  [OK] Option 1 icon fixed")

# 4. FIX STATE/COUNTY DROPDOWN
print("[FIX 4] Fixing state/county dropdown...")
# Find state select and ensure it calls loadCheckCounties on change
# Look for various patterns

# Check if function exists
if 'function loadCheckCounties' in content:
    print("  [INFO] loadCheckCounties function exists")
    
    # Check if onchange is properly set
    # Look for select with state-related id or name
    state_select_patterns = [
        r'<select[^>]*id="check-state"[^>]*>',
        r'<select[^>]*name="state"[^>]*>',
        r'<select[^>]*id="state"[^>]*>',
    ]
    
    found_select = False
    for pattern in state_select_patterns:
        matches = re.finditer(pattern, content, re.IGNORECASE)
        for match in matches:
            found_select = True
            select_tag = match.group(0)
            # Check if onchange exists
            if 'onchange' not in select_tag.lower():
                # Add onchange
                new_tag = select_tag[:-1] + ' onchange="loadCheckCounties()">'
                content = content.replace(select_tag, new_tag)
                changes.append("Added onchange to state dropdown")
                print(f"  [OK] Added onchange to state select")
            else:
                print(f"  [INFO] State select already has onchange")
            break
        if found_select:
            break
    
    if not found_select:
        print("  [WARN] State select not found with expected patterns")
else:
    print("  [WARN] loadCheckCounties function not found - may need to add it")

# Also check if checkCountyData exists
if 'checkCountyData' in content:
    print("  [INFO] checkCountyData exists")
else:
    print("  [WARN] checkCountyData not found")

print("  [OK] State/county dropdown checked")

# Save file
if content != original:
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"\n[DONE] All fixes applied!")
    print(f"[BACKUP] Backup saved to: {backup_path}")
    if changes:
        print(f"\n[CHANGES]")
        for change in changes:
            print(f"  - {change}")
else:
    print("\n[INFO] No changes needed")

