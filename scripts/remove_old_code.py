#!/usr/bin/env python3
"""Remove all old code from county-cap.html"""

file_path = 'marketing/county-cap.html'

print("Reading file...")
with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

print(f"File has {len(lines)} lines")

# Find markers
start_idx = None
footer_idx = None

for i, line in enumerate(lines):
    if '<!-- All old code removed - county search functionality now in js/county-cap-search.js -->' in line:
        start_idx = i
        print(f"Found start marker at line {i+1}")
    if '<!-- STANDARDIZED FOOTER' in line:
        footer_idx = i
        print(f"Found footer at line {i+1}")
        break

if start_idx is None:
    print("ERROR: Could not find start marker")
    exit(1)

if footer_idx is None:
    print("ERROR: Could not find footer")
    exit(1)

# Remove everything between start marker and footer
new_lines = lines[:start_idx + 1] + ['\n'] + lines[footer_idx:]

print(f"Removing {footer_idx - start_idx - 1} lines (lines {start_idx + 2} to {footer_idx})")

# Write cleaned file
with open(file_path, 'w', encoding='utf-8') as f:
    f.writelines(new_lines)

print(f"✓ File cleaned: {len(new_lines)} lines (was {len(lines)})")

# Verify
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()
    if 'checkCountyData' in content or 'practiceAreaData' in content:
        print("⚠️  WARNING: Old code still present")
        matches = content.count('checkCountyData') + content.count('practiceAreaData')
        print(f"   Found {matches} matches")
    else:
        print("✓ Verified: No old code found")

