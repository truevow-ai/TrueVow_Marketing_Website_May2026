#!/usr/bin/env python3
"""Fix cards section margin-bottom"""

with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    lines = f.readlines()

# Find the line with the cards section
for i, line in enumerate(lines):
    if 'PRACTICE AREAS & SETUP CARDS' in line:
        # Next line should be the section tag
        if i + 1 < len(lines):
            next_line = lines[i + 1]
            if 'padding: 60px 24px; background: white; color: #1A1A1A;' in next_line:
                # Add margin-bottom
                lines[i + 1] = next_line.replace(
                    'padding: 60px 24px; background: white; color: #1A1A1A;',
                    'padding: 60px 24px; margin-bottom: 60px; background: white; color: #1A1A1A;'
                )
                print(f"OK: Added margin-bottom at line {i+2}")
                break

with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.writelines(lines)

print("Done!")


