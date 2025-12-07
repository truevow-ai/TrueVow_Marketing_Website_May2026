#!/usr/bin/env python3
"""
Replace practiceAreaData in county-cap.html with complete 67-county data
Generates data directly to avoid encoding issues
"""

import json
import re

# Import the generation logic
import sys
sys.path.append('scripts')
from generate_all_florida_counties_js import all_data

# Generate the JavaScript object string
new_data = json.dumps(all_data, indent=4)

# Read the HTML file
with open('marketing/county-cap.html', 'r', encoding='utf-8') as f:
    html_content = f.read()

# Find and replace the practiceAreaData section
pattern = r'    // Practice area data for Miami-Dade County\s+const practiceAreaData = \{.*?\};'

replacement = f'    // Practice area data for all 67 Florida counties\n    const practiceAreaData = {new_data};'

# Replace
new_html = re.sub(pattern, replacement, html_content, flags=re.DOTALL)

# Write back
with open('marketing/county-cap.html', 'w', encoding='utf-8') as f:
    f.write(new_html)

print("✓ Updated practiceAreaData with all 67 counties")
print(f"  Total counties in data: {len(all_data)}")

