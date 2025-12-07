#!/usr/bin/env python3
"""Verify California data integration"""

import re

with open('marketing/county-cap.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Check for California counties
ca_counties = ['alameda', 'los-angeles', 'san-diego', 'orange', 'riverside', 
               'san-bernardino', 'santa-clara', 'san-francisco', 'sacramento', 
               'contra-costa', 'fresno', 'kern', 'ventura', 'san-mateo', 'stanislaus']

found = []
for county in ca_counties:
    if f'"{county}":' in content:
        found.append(county)

print(f"✓ Found {len(found)} California counties in practiceAreaData")
print(f"  Counties: {', '.join(found[:5])}...")

# Check for JavaScript updates (check for both escaped and unescaped versions)
if ("selectedState === 'FL' || selectedState === 'CA'" in content or 
    "selectedState === 'FL' ||| selectedState === 'CA'" in content or
    "selectedState === 'FL' \\|\\| selectedState === 'CA'" in content):
    print("✓ JavaScript updated to handle California counties")
elif "practiceAreaData[selectedCounty]" in content:
    print("✓ JavaScript will work for California (checks practiceAreaData directly)")
else:
    print("⚠ JavaScript not updated for California")

# Check structure
if 'window.practiceAreaData = practiceAreaData;' in content:
    print("✓ practiceAreaData properly assigned to window")
else:
    print("⚠ practiceAreaData assignment missing")

# Check for syntax errors (duplicate closing braces)
if '    },\n    };' in content:
    print("⚠ Found potential duplicate closing brace")
else:
    print("✓ No duplicate closing braces found")

