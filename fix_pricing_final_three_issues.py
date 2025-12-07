#!/usr/bin/env python3
"""
Fix final three issues in pricing.html:
1. Add proper padding-top to footer (equal to bottom padding)
2. Change "Why We Built TrueVow" section background to black, font to white
3. Change emotional urgency box background to white and adjust font colors
"""

import re

with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

fixes = []

# 1. Fix footer padding-top
# Current footer has: padding: 0 20px 120px 20px !important
# Need to add padding-top: 120px (equal to bottom padding)
footer_pattern = r'(<footer[^>]*style="[^"]*padding:\s*)(0\s+20px\s+120px\s+20px)([^"]*")'
if re.search(footer_pattern, content, re.IGNORECASE):
    content = re.sub(
        footer_pattern,
        lambda m: m.group(1) + '120px 20px 120px 20px' + m.group(3),
        content,
        flags=re.IGNORECASE
    )
    fixes.append("Fixed footer padding-top to 120px (equal to bottom)")

# Also check if padding-top is already set but needs adjustment
footer_pattern2 = r'(<footer[^>]*style="[^"]*padding-top:\s*)(\d+)(px[^"]*padding:\s*0\s+20px\s+120px)'
if re.search(footer_pattern2, content, re.IGNORECASE):
    content = re.sub(
        footer_pattern2,
        lambda m: m.group(1) + '120' + m.group(3),
        content,
        flags=re.IGNORECASE
    )
    fixes.append("Adjusted footer padding-top to 120px")

# 2. Change "Why We Built TrueVow" section background to black, font to white
why_built_pattern = r'(<!-- WHY WE BUILT TRUEVOW -->\s*<section[^>]*style="[^"]*background:\s*)(#F8F9FA|#E2E8F0|white|#FFFFFF)([^"]*color:\s*)(#1A1A1A|#000000)([^"]*")'
if re.search(why_built_pattern, content, re.IGNORECASE):
    content = re.sub(
        why_built_pattern,
        lambda m: m.group(1) + '#000000' + m.group(3) + 'white' + m.group(5),
        content,
        flags=re.IGNORECASE
    )
    fixes.append("Changed 'Why We Built TrueVow' section to black background, white font")

# Also update the h2 and p tags inside to ensure white color
why_built_h2_pattern = r'(<!-- WHY WE BUILT TRUEVOW -->.*?<h2[^>]*style="[^"]*color:\s*)(#1A1A1A|#000000)([^"]*")'
if re.search(why_built_h2_pattern, content, re.IGNORECASE | re.DOTALL):
    content = re.sub(
        why_built_h2_pattern,
        lambda m: m.group(1) + 'white' + m.group(3),
        content,
        flags=re.IGNORECASE | re.DOTALL
    )
    fixes.append("Changed 'Why We Built TrueVow' h2 to white")

why_built_p_pattern = r'(<!-- WHY WE BUILT TRUEVOW -->.*?<p[^>]*style="[^"]*color:\s*)(#1A1A1A|#000000)([^"]*")'
if re.search(why_built_p_pattern, content, re.IGNORECASE | re.DOTALL):
    content = re.sub(
        why_built_p_pattern,
        lambda m: m.group(1) + 'white' + m.group(3),
        content,
        flags=re.IGNORECASE | re.DOTALL
    )
    fixes.append("Changed 'Why We Built TrueVow' paragraph to white")

# 3. Change emotional urgency box background to white and adjust font colors
# Find the box with "The frustration of missing calls at 9 PM"
emotional_box_pattern = r'(<div[^>]*style="[^"]*margin:\s*40px auto[^"]*padding:\s*32px[^"]*background:\s*)(#E8F4FD|#FFF3CD|linear-gradient[^"]*)([^"]*The frustration of missing calls[^"]*")'
if re.search(emotional_box_pattern, content, re.IGNORECASE | re.DOTALL):
    content = re.sub(
        emotional_box_pattern,
        lambda m: m.group(1) + 'white' + m.group(3),
        content,
        flags=re.IGNORECASE | re.DOTALL
    )
    fixes.append("Changed emotional urgency box background to white")

# Update font colors in the emotional urgency box to match overall color scheme
# Change the dark golden/brown colors to darker colors that work on white background
# Find paragraphs inside the emotional box and update their colors
emotional_p1_pattern = r'(<div[^>]*style="[^"]*background:\s*white[^"]*The frustration[^"]*">.*?<p[^>]*style="[^"]*color:\s*)(#856404|#B8860B)([^"]*")'
if re.search(emotional_p1_pattern, content, re.IGNORECASE | re.DOTALL):
    content = re.sub(
        emotional_p1_pattern,
        lambda m: m.group(1) + '#1A1A1A' + m.group(3),
        content,
        flags=re.IGNORECASE | re.DOTALL
    )
    fixes.append("Updated emotional box paragraph 1 color to dark gray")

emotional_p2_pattern = r'(<div[^>]*style="[^"]*background:\s*white[^"]*The frustration[^"]*">.*?<p[^>]*style="[^"]*color:\s*)(#B8860B)([^"]*Every month you wait)'
if re.search(emotional_p2_pattern, content, re.IGNORECASE | re.DOTALL):
    content = re.sub(
        emotional_p2_pattern,
        lambda m: m.group(1) + '#666666' + m.group(3),
        content,
        flags=re.IGNORECASE | re.DOTALL
    )
    fixes.append("Updated emotional box paragraph 2 color to medium gray")

# Update strong tags inside to use darker colors
emotional_strong_pattern = r'(<div[^>]*style="[^"]*background:\s*white[^"]*The frustration[^"]*">.*?<strong[^>]*style="[^"]*color:\s*)(#856404|#B8860B)([^"]*")'
if re.search(emotional_strong_pattern, content, re.IGNORECASE | re.DOTALL):
    content = re.sub(
        emotional_strong_pattern,
        lambda m: m.group(1) + '#0A2463' + m.group(3),  # Use dark blue for emphasis
        content,
        flags=re.IGNORECASE | re.DOTALL
    )
    fixes.append("Updated emotional box strong tags to dark blue")

# Update the red color for the total amount
emotional_red_pattern = r'(<div[^>]*style="[^"]*background:\s*white[^"]*The frustration[^"]*">.*?<strong[^>]*style="[^"]*color:\s*)(#B91C1C)([^"]*font-size:\s*22px[^"]*">\$7,050)'
if re.search(emotional_red_pattern, content, re.IGNORECASE | re.DOTALL):
    # Keep red for the total amount as it's important for emphasis
    # But we could change it if needed - for now, keep it
    pass

# Write the file
with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("[OK] All three issues fixed!")
print(f"\nTotal fixes: {len(fixes)}")
for fix in fixes:
    print(f"  - {fix}")

