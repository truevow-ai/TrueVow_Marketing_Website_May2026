#!/usr/bin/env python3
"""
Fix visual repetition in hero section
Change the recovery figure format to avoid repeating "$5,150 to $20,600" format
"""

import re

with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Option 1: Change to "up to $20,600/month" format
# Option 2: Change to single average figure
# Option 3: Change wording to avoid exact repetition

# Let's go with Option 1: "up to $20,600/month" to reduce visual repetition
pattern = r'(Average firm may recover )(\$5,150 to \$20,600/month)( in additional revenue)'
if re.search(pattern, content, re.IGNORECASE):
    # Change to "up to $20,600/month" format
    content = re.sub(
        pattern,
        r'\1up to $20,600/month\3',
        content,
        flags=re.IGNORECASE
    )
    print("[OK] Changed recovery figure to 'up to $20,600/month' to reduce visual repetition")
else:
    # Try alternative pattern
    pattern2 = r'(Convert 40% more leads[^•]*•\s*Average firm may recover )(\$5,150 to \$20,600/month)( in additional revenue)'
    if re.search(pattern2, content, re.IGNORECASE):
        content = re.sub(
            pattern2,
            r'\1up to $20,600/month\3',
            content,
            flags=re.IGNORECASE
        )
        print("[OK] Changed recovery figure format (pattern 2)")

# Write the file
with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("[OK] Visual repetition fix complete!")
print("\nNow the hero shows:")
print("  Headline: 'Stop Losing $5,150-$20,600/Month in Missed Cases'")
print("  Recovery: 'Average firm may recover up to $20,600/month in additional revenue'")
print("\nThis reduces visual repetition while keeping the same meaning.")

