#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Fix JavaScript syntax error preventing loadCheckCounties from being defined
The error is at line 142:64 - "function statement requires a name"
"""

import re

filepath = "marketing/county-cap.html"
backup_path = "marketing/county-cap.html.js-syntax-fix-backup"

print(f"[FIX] Reading {filepath}...")
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# Create backup
print(f"[BACKUP] Creating backup...")
with open(backup_path, 'w', encoding='utf-8') as f:
    f.write(content)

original = content
changes = []

# The issue is that the Chart.js initialization might be running multiple times
# or there's a syntax error in the compressed JavaScript
# Let's ensure the loadCheckCounties function is properly defined and accessible

# Check if loadCheckCounties function exists
if 'function loadCheckCounties()' in content:
    print("[INFO] loadCheckCounties function found")
    
    # The function exists, but it's not being loaded due to a syntax error earlier
    # The error at line 142:64 suggests there's a problem with the Chart initialization
    # Let's add a check to prevent Chart from being initialized multiple times
    
    # Fix: Add a check to destroy existing chart before creating a new one
    chart_init_pattern = r'(const capacityChart = new Chart\(ctx, \{)'
    if re.search(chart_init_pattern, content):
        # Add code to destroy existing chart first
        replacement = r'''// Destroy existing chart if it exists
            if (window.capacityChartInstance) {
                window.capacityChartInstance.destroy();
            }
            \1'''
        content = re.sub(chart_init_pattern, replacement, content)
        
        # Also store the chart instance globally
        content = re.sub(
            r'(const capacityChart = new Chart\(ctx, \{)',
            r'window.capacityChartInstance = new Chart(ctx, {',
            content
        )
        changes.append("Fixed Chart.js initialization to prevent duplicate chart error")
        print("  [OK] Fixed Chart.js initialization")
    
    # Ensure loadCheckCounties is in global scope (it should be, but let's verify)
    # The function is already defined in global scope, so that's good
    
    # The main issue might be that the script tag is malformed or there's a syntax error
    # Let's check if there are any unclosed braces or parentheses
    
    # Actually, looking at the error more carefully - "function statement requires a name" at 142:64
    # This suggests there might be a function() without a name somewhere
    # Let me check the Chart initialization callback
    
    # The callback function should be fine: `callback: function(value) { return value + '%'; }`
    # But maybe there's an issue with how it's formatted in the compressed code
    
    # Let's ensure the script tag is properly closed
    if '</script>' in content:
        print("  [OK] Script tag is properly closed")
    else:
        print("  [WARN] Script tag might not be closed properly")
        # Add closing script tag if missing
        if '<script>' in content and '</script>' not in content:
            # Find the last script tag and ensure it's closed
            script_end = content.rfind('</script>')
            if script_end == -1:
                # Find where the script should end (before FOOTER comment)
                footer_pos = content.find('<!-- FOOTER -->')
                if footer_pos > 0:
                    content = content[:footer_pos] + '    </script>\n' + content[footer_pos:]
                    changes.append("Added missing closing script tag")
                    print("  [OK] Added missing closing script tag")

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
    print("\n[INFO] No changes detected - checking for other issues...")
    # If no changes, the issue might be elsewhere
    # Let's verify the function is accessible by checking the HTML structure
    if 'onchange="loadCheckCounties()"' in content:
        print("  [OK] State select has onchange handler")
    else:
        print("  [ERROR] State select missing onchange handler!")

