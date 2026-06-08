#!/usr/bin/env python3
"""Aggressively remove all old code from county-cap.html"""

file_path = 'marketing/county-cap.html'

print("=" * 60)
print("Aggressive Clean Script")
print("=" * 60)

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

print(f"Original file size: {len(content):,} characters")
print(f"Original file lines: {len(content.splitlines()):,}")

# Find start marker
start_marker = '<!-- All old code removed - county search functionality now in js/county-cap-search.js -->'
start_pos = content.find(start_marker)

if start_pos == -1:
    print("ERROR: Start marker not found!")
    exit(1)

print(f"Start marker found at position: {start_pos}")

# Find footer
footer_marker = '<!-- STANDARDIZED FOOTER - Apply to all pages -->'
footer_pos = content.find(footer_marker)

if footer_pos == -1:
    print("ERROR: Footer marker not found!")
    exit(1)

print(f"Footer marker found at position: {footer_pos}")

# Calculate what to remove
marker_end = start_pos + len(start_marker)
chars_to_remove = footer_pos - marker_end

print(f"\nRemoving {chars_to_remove:,} characters")
print(f"  From position {marker_end} to {footer_pos}")

# Create new content
new_content = content[:marker_end] + '\n\n' + content[footer_pos:]

print(f"\nNew file size: {len(new_content):,} characters")
print(f"New file lines: {len(new_content.splitlines()):,}")
print(f"Removed: {len(content) - len(new_content):,} characters")

# Write cleaned file
with open(file_path, 'w', encoding='utf-8') as f:
    f.write(new_content)

print("\n✓ File cleaned successfully")

# Verify
if 'checkCountyData' in new_content or 'practiceAreaData' in new_content:
    count = new_content.count('checkCountyData') + new_content.count('practiceAreaData')
    print(f"⚠️  WARNING: Still found {count} instances of old code")
else:
    print("✓ Verified: No old county data objects found")

print("=" * 60)

