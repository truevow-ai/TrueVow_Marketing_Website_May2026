#!/usr/bin/env python3
"""
Clean county-cap.html by removing all old county data and corrupted code
"""

file_path = 'marketing/county-cap.html'

# Read the file
with open(file_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

# Find the comment that marks where old code should be removed
start_idx = None
footer_idx = None

for i, line in enumerate(lines):
    if '<!-- All old code removed - county search functionality now in js/county-cap-search.js -->' in line:
        start_idx = i
    if '<!-- STANDARDIZED FOOTER' in line:
        footer_idx = i
        break

if start_idx is None or footer_idx is None:
    print(f"ERROR: Could not find boundaries. Start: {start_idx}, Footer: {footer_idx}")
    exit(1)

# Keep everything before the comment, add a blank line, then everything from footer onwards
new_lines = lines[:start_idx + 1] + ['\n'] + lines[footer_idx:]

# Write the cleaned file
with open(file_path, 'w', encoding='utf-8') as f:
    f.writelines(new_lines)

print(f"✓ Cleaned {file_path}")
print(f"  Removed {footer_idx - start_idx - 1} lines of old code (lines {start_idx + 2} to {footer_idx})")
print(f"  File now has {len(new_lines)} lines (was {len(lines)})")
