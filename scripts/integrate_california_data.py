#!/usr/bin/env python3
"""
Integrate California county data into marketing/county-cap.html
Insert California data before the closing brace of practiceAreaData object
"""

import re

# Read the California data
with open('scripts/california_practice_area_data.js', 'r', encoding='utf-8') as f:
    california_data = f.read()

# Read the HTML file
with open('marketing/county-cap.html', 'r', encoding='utf-8') as f:
    html_content = f.read()

# Find where practiceAreaData ends (before window.practiceAreaData assignment)
# Look for the pattern: }; followed by window.practiceAreaData
pattern = r'(    \}\s*\n\s*\nwindow\.practiceAreaData = practiceAreaData;)'

# Insert California data before the closing brace
# The California data needs to be inserted before the final closing brace of practiceAreaData
# We need to find the last county entry and add California data after it

# Find the end of the last Florida county entry
# Look for the pattern where we have the last practice area closing, then the practiceAreas closing, then the county closing
# We'll insert California data right before the final closing brace of practiceAreaData

# More specific: find the closing of practiceAreaData object (}; before window.practiceAreaData)
match = re.search(r'(\s+)\}\s*\n\s*\nwindow\.practiceAreaData = practiceAreaData;', html_content)

if match:
    indent = match.group(1)
    # Insert California data before the closing brace
    # Add a comma after the last Florida county entry
    # First, let's find the last entry in practiceAreaData and add a comma if needed
    
    # Find the pattern: last county entry ends with }, then we have };
    # We need to insert California data between the last }, and the final };
    
    # Better approach: find the closing }; of practiceAreaData and insert before it
    replacement = f'{indent}}},\n\n{california_data.rstrip()}\n{indent}}};\n\nwindow.practiceAreaData = practiceAreaData;'
    
    html_content = re.sub(
        r'(\s+)\}\s*\n\s*\nwindow\.practiceAreaData = practiceAreaData;',
        replacement,
        html_content,
        count=1
    )
    
    print("✓ California data integrated into practiceAreaData object")
else:
    print("⚠ Could not find insertion point. Trying alternative method...")
    # Alternative: find just before window.practiceAreaData
    pattern2 = r'(window\.practiceAreaData = practiceAreaData;)'
    replacement2 = f'{california_data.rstrip()}\n    }};\n\n    \\1'
    
    html_content = re.sub(pattern2, replacement2, html_content, count=1)
    print("✓ California data integrated (alternative method)")

# Also need to update the JavaScript to handle California counties
# Find the check for Florida and add California
florida_check = r"if \(selectedState === 'FL' && typeof practiceAreaData !== 'undefined' && !practiceAreaData\[selectedCounty\]\)"
california_check = r"if \(\(selectedState === 'FL' \|\| selectedState === 'CA'\) && typeof practiceAreaData !== 'undefined' && !practiceAreaData\[selectedCounty\]\)"

html_content = re.sub(florida_check, california_check, html_content)

# Also update the showAvailability function check
florida_check2 = r"if \(typeof practiceAreaData !== 'undefined' && practiceAreaData\[selectedCounty\]\)"
# This one should work for both FL and CA, so no change needed

# Update the state check in the fallback section
fallback_check = r"const selectedState = fallbackStateSelect \? fallbackStateSelect\.value : '';\s*if \(selectedState === 'FL'"
fallback_replacement = r"const selectedState = fallbackStateSelect ? fallbackStateSelect.value : '';\n        if ((selectedState === 'FL' || selectedState === 'CA')"

html_content = re.sub(fallback_check, fallback_replacement, html_content)

# Write back
with open('marketing/county-cap.html', 'w', encoding='utf-8') as f:
    f.write(html_content)

print("✓ Updated JavaScript to handle California counties")
print("✓ Integration complete!")

