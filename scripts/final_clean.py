#!/usr/bin/env python3
"""Final cleanup - remove all old code between markers"""

file_path = 'marketing/county-cap.html'

with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

# Find markers
start_idx = None
footer_idx = None

for i, line in enumerate(lines):
    if '<!-- All old code removed - county search functionality now in js/county-cap-search.js -->' in line:
        start_idx = i
    if '<!-- STANDARDIZED FOOTER' in line:
        footer_idx = i
        break

if start_idx is None or footer_idx is None:
    print(f"ERROR: start={start_idx}, footer={footer_idx}")
    exit(1)

# Keep everything before start marker + 1 line, then footer onwards
new_lines = lines[:start_idx + 1] + ['\n'] + lines[footer_idx:]

with open(file_path, 'w', encoding='utf-8') as f:
    f.writelines(new_lines)

print(f"✓ Removed {footer_idx - start_idx - 1} lines (lines {start_idx + 2} to {footer_idx})")
print(f"✓ File: {len(new_lines)} lines (was {len(lines)})")

# Verify
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()
    if 'checkCountyData' in content or 'practiceAreaData' in content:
        print("⚠️  WARNING: Old code still present")
    else:
        print("✓ Verified: No old code found")

