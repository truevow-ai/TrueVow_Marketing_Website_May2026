#!/usr/bin/env python3
"""
Fix emotional urgency box colors - change background to white and update font colors
"""

import re

with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Find the emotional urgency box section
# It contains "The frustration of missing calls at 9 PM"
frustration_idx = content.find('The frustration of missing calls at 9 PM')
if frustration_idx >= 0:
    # Find the div containing this text
    # Look backwards for the opening div tag
    div_start = content.rfind('<div', max(0, frustration_idx - 500), frustration_idx)
    if div_start >= 0:
        # Find the closing div tag
        div_end = content.find('</div>', frustration_idx) + 6
        if div_end > div_start:
            box_content = content[div_start:div_end]
            
            # Replace background
            new_box = box_content
            # Change background to white
            new_box = re.sub(
                r'(background:\s*)(#E8F4FD|#FFF3CD|linear-gradient[^;"]+)',
                r'\1white',
                new_box,
                flags=re.IGNORECASE
            )
            
            # Update font colors to work on white background
            # Change #856404 (dark golden brown) to #1A1A1A (dark gray)
            new_box = re.sub(
                r'(color:\s*)(#856404)',
                r'\1#1A1A1A',
                new_box,
                flags=re.IGNORECASE
            )
            
            # Change #B8860B (lighter golden brown) to #666666 (medium gray)
            new_box = re.sub(
                r'(color:\s*)(#B8860B)',
                r'\1#666666',
                new_box,
                flags=re.IGNORECASE
            )
            
            # Keep #B91C1C (red) for the total amount as it's important for emphasis
            
            # Update strong tags with #856404 to use dark blue for better contrast
            new_box = re.sub(
                r'(<strong[^>]*style="[^"]*color:\s*)(#856404)([^"]*">\$1,900|\$5,150)',
                r'\1#0A2463\3',
                new_box,
                flags=re.IGNORECASE
            )
            
            if new_box != box_content:
                content = content[:div_start] + new_box + content[div_end:]
                print("[OK] Fixed emotional urgency box - background to white, font colors updated")
            else:
                print("[INFO] Emotional urgency box already has correct colors")
        else:
            print("[WARNING] Could not find closing div tag")
    else:
        print("[WARNING] Could not find opening div tag")
else:
    print("[WARNING] Could not find 'The frustration of missing calls' text")

# Write the file
with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("[OK] Emotional urgency box fix complete!")

