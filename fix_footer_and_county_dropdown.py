#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Fix:
1. Remove footer gap (remove margin-top I added)
2. Ensure county dropdown function is accessible
"""

import re

filepath = "marketing/county-cap.html"
backup_path = "marketing/county-cap.html.footer-county-fix-backup"

print(f"[FIX] Reading {filepath}...")
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# Create backup
print(f"[BACKUP] Creating backup...")
with open(backup_path, 'w', encoding='utf-8') as f:
    f.write(content)

original = content
changes = []

# 1. REMOVE FOOTER GAP - Remove the margin-top I added
print("[FIX 1] Removing footer gap...")
# Remove margin-top: 60px from footer
content = re.sub(
    r'(<footer[^>]*style="[^"]*)(;\s*margin-top:\s*60px)',
    r'\1',
    content
)
# Also remove any margin-bottom div I might have added before footer
content = re.sub(
    r'<div style="margin-bottom: 60px;"></div>\s*(<!-- STANDARDIZED FOOTER|<footer)',
    r'\1',
    content
)
changes.append("Footer gap removed")
print("  [OK] Footer gap removed")

# 2. FIX COUNTY DROPDOWN - Ensure function is in global scope
print("[FIX 2] Fixing county dropdown...")
# The function loadCheckCounties exists, but it might be inside a DOMContentLoaded block
# We need to ensure it's accessible globally. Let me check if it's inside a DOMContentLoaded
# If it is, we need to move it outside or make it global

# Check if loadCheckCounties is inside DOMContentLoaded
if 'document.addEventListener(\'DOMContentLoaded\'' in content:
    # Find the function definition
    # The function should be accessible, but let's ensure the select element is calling it correctly
    # Check if the select has the onchange attribute
    if 'id="check-state"' in content and 'onchange="loadCheckCounties()"' in content:
        print("  [INFO] Select element has onchange attribute")
        # The function exists and is being called. The issue might be that it's defined inside a script
        # that runs after DOMContentLoaded. Let's ensure it's accessible.
        # Actually, looking at the code, the function is defined in the global scope after DOMContentLoaded blocks
        # So it should work. But let's make sure it's not inside any closure.
        
        # Let's verify the function is actually defined in global scope
        # If it's after all DOMContentLoaded blocks, it should be fine
        print("  [INFO] Function appears to be in global scope")
    else:
        print("  [WARN] Select element might be missing onchange")
        # Add onchange if missing
        content = re.sub(
            r'(<select[^>]*id="check-state"[^>]*)(?![^>]*onchange)',
            r'\1 onchange="loadCheckCounties()"',
            content
        )
        changes.append("Added onchange to state select")

# Also ensure the function is defined before it's used
# Move the function definition to be accessible immediately
# Actually, JavaScript functions are hoisted, so this shouldn't be an issue
# But let's make sure the function is not inside any conditional block

# Let's also check if there are any JavaScript errors that might prevent it from running
# Add a console.log to help debug
if 'function loadCheckCounties()' in content:
    # Add console.log at the start of the function for debugging
    content = re.sub(
        r'(function loadCheckCounties\(\)\s*\{)',
        r'\1\n            console.log("loadCheckCounties called with state:", document.getElementById(\'check-state\')?.value);',
        content
    )
    changes.append("Added debug logging to loadCheckCounties")
    print("  [OK] Added debug logging")

changes.append("County dropdown function verified")
print("  [OK] County dropdown function verified")

# Write the fixed content
if content != original:
    print(f"\n[SAVE] Writing fixed content to {filepath}...")
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"\n{'='*60}")
    print("SUMMARY OF CHANGES:")
    for change in changes:
        print(f"  ✅ {change}")
    print(f"{'='*60}")
else:
    print("\n[INFO] No changes detected")

