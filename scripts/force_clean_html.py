#!/usr/bin/env python3
"""Force clean county-cap.html by removing all old code"""

file_path = 'marketing/county-cap.html'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Find markers
start_marker = '<!-- All old code removed - county search functionality now in js/county-cap-search.js -->'
footer_marker = '<!-- STANDARDIZED FOOTER'

start_pos = content.find(start_marker)
footer_pos = content.find(footer_marker)

if start_pos == -1:
    print(f"ERROR: Could not find start marker")
    exit(1)

if footer_pos == -1:
    print(f"ERROR: Could not find footer marker")
    exit(1)

# Remove everything between start marker and footer
new_content = content[:start_pos + len(start_marker)] + '\n\n' + content[footer_pos:]

# Write cleaned file
with open(file_path, 'w', encoding='utf-8') as f:
    f.write(new_content)

removed_chars = footer_pos - start_pos - len(start_marker)
print(f"✓ Removed {removed_chars:,} characters of old code")
print(f"✓ File cleaned: {len(new_content):,} chars (was {len(content):,} chars)")

# Verify no old code remains
if 'checkCountyData' in new_content or 'practiceAreaData' in new_content:
    print("⚠️  WARNING: Some old code may still remain")
else:
    print("✓ Verified: No old county data objects found")

