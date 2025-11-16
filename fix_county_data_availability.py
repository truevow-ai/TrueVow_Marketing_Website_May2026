#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Move county data to essential script block so it's available when loadCheckCounties runs
"""

import re

filepath = "marketing/county-cap.html"
backup_path = "marketing/county-cap.html.county-data-fix-backup"

print(f"[FIX] Reading {filepath}...")
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# Create backup
print(f"[BACKUP] Creating backup...")
with open(backup_path, 'w', encoding='utf-8') as f:
    f.write(content)

original = content
changes = []

# Find where window.checkCountyData is defined in the main script
# We need to extract it and move it to the essential script block

# First, find the essential script block ending
essential_script_end = r'(// Make it available globally.*?</script>)'
essential_match = re.search(essential_script_end, content, re.DOTALL)

if essential_match:
    # Find where window.checkCountyData is defined
    county_data_pattern = r'(// County Availability Checker - Top Counties by State\s+window\.checkCountyData\s*=\s*\{[^}]+\})'
    county_data_match = re.search(county_data_pattern, content, re.DOTALL)
    
    if not county_data_match:
        # Try a more flexible pattern - the data might span many lines
        county_data_pattern = r'(// County Availability Checker - Top Counties by State\s+window\.checkCountyData\s*=\s*\{.*?\n\s*\};)'
        county_data_match = re.search(county_data_pattern, content, re.DOTALL | re.MULTILINE)
    
    if county_data_match:
        county_data_code = county_data_match.group(1)
        
        # Insert county data right before the "Make it available globally" comment
        insert_point = essential_match.start(1)
        new_code = county_data_code + "\n    \n    " + essential_match.group(1)
        content = content[:insert_point] + new_code + content[essential_match.end(1):]
        changes.append("Moved county data to essential script block")
        print("  [OK] Moved county data to essential script block")
        
        # Now remove the duplicate from the main script
        content = re.sub(county_data_pattern, '', content, flags=re.DOTALL)
        changes.append("Removed duplicate county data from main script")
        print("  [OK] Removed duplicate from main script")
    else:
        print("  [WARNING] Could not find county data definition")
else:
    print("  [WARNING] Could not find essential script block")

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
    print("\n[INFO] No changes needed")

