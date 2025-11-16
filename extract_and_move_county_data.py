#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Extract county data from main script and add it to essential script block
"""

import re

filepath = "marketing/county-cap.html"
backup_path = "marketing/county-cap.html.extract-county-backup"

print(f"[FIX] Reading {filepath}...")
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# Create backup
print(f"[BACKUP] Creating backup...")
with open(backup_path, 'w', encoding='utf-8') as f:
    f.write(content)

# Find where the county data starts in the main script
# Look for the pattern: window.checkCountyData = {
# The data is likely all on one compressed line

# First, find the essential script block where we need to insert
essential_pattern = r'(// County data must be defined BEFORE the function uses it.*?if \(!window\.checkCountyData\) \{[^}]+\})'
essential_match = re.search(essential_pattern, content, re.DOTALL)

if essential_match:
    # Now find the county data in the main script
    # Look for the comment and assignment
    main_script_pattern = r'(// County Availability Checker[^}]*?window\.checkCountyData\s*=\s*\{[^}]+\})'
    county_data_match = re.search(main_script_pattern, content, re.DOTALL)
    
    if not county_data_match:
        # Try a more flexible pattern - the object might be very long
        # Look for the start of the assignment and find the closing brace
        start_pattern = r'// County Availability Checker[^w]*?window\.checkCountyData\s*=\s*\{'
        start_match = re.search(start_pattern, content)
        
        if start_match:
            start_pos = start_match.end()
            # Find the matching closing brace
            brace_count = 1
            pos = start_pos
            while pos < len(content) and brace_count > 0:
                if content[pos] == '{':
                    brace_count += 1
                elif content[pos] == '}':
                    brace_count -= 1
                pos += 1
            
            if brace_count == 0:
                # Found the end
                county_data_code = content[start_match.start():pos]
                print(f"  [OK] Found county data (length: {len(county_data_code)} chars)")
                
                # Insert it into the essential script block
                insert_pos = essential_match.end()
                # Insert right after the initialization
                new_content = content[:insert_pos] + "\n    \n    " + county_data_code + ";" + content[insert_pos:]
                
                # Remove the original from main script
                new_content = new_content.replace(county_data_code, '', 1)
                
                content = new_content
                print("  [OK] Moved county data to essential script block")
            else:
                print("  [ERROR] Could not find end of county data object")
        else:
            print("  [ERROR] Could not find start of county data")
    else:
        print("  [OK] Found county data with simple pattern")
        county_data_code = county_data_match.group(1)
        # Insert into essential script
        insert_pos = essential_match.end()
        new_content = content[:insert_pos] + "\n    \n    " + county_data_code + ";" + content[insert_pos:]
        # Remove original
        new_content = new_content.replace(county_data_code, '', 1)
        content = new_content
        print("  [OK] Moved county data")
else:
    print("  [ERROR] Could not find essential script block")

# Write the fixed content
if content != original:
    print(f"\n[SAVE] Writing fixed content to {filepath}...")
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    print("  [OK] File saved")
else:
    print("\n[INFO] No changes made")

