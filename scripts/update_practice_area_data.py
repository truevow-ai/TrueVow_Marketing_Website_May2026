#!/usr/bin/env python3
"""
Replace practiceAreaData in county-cap.html with complete 67-county data
"""

import re

# Read the generated JavaScript data
try:
    with open('scripts/florida_practice_area_data.js', 'r', encoding='utf-8') as f:
        new_data = f.read().strip()
except UnicodeDecodeError:
    with open('scripts/florida_practice_area_data.js', 'r', encoding='utf-8-sig') as f:
        new_data = f.read().strip()
    
# Remove the const declaration and semicolon - we'll add it back
if new_data.startswith('const practiceAreaData = '):
    new_data = new_data[25:]  # Remove "const practiceAreaData = "
if new_data.endswith(';'):
    new_data = new_data[:-1]  # Remove trailing semicolon

# Read the HTML file
with open('marketing/county-cap.html', 'r', encoding='utf-8') as f:
    html_content = f.read()

# Find and replace the practiceAreaData section
# Pattern: from "const practiceAreaData = {" to "};" (including the comment before it)
pattern = r'    // Practice area data for Miami-Dade County\s+const practiceAreaData = \{.*?\};'

replacement = f'    // Practice area data for all 67 Florida counties\n    const practiceAreaData = {new_data};'

# Replace
new_html = re.sub(pattern, replacement, html_content, flags=re.DOTALL)

# Write back
with open('marketing/county-cap.html', 'w', encoding='utf-8') as f:
    f.write(new_html)

print("✓ Updated practiceAreaData with all 67 counties")
print(f"  Replaced section with {len(new_data)} characters of data")

