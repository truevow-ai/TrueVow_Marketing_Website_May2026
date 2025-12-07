#!/usr/bin/env python3
"""
Fix hero revenue figure to align with headline loss figure
Headline: $5,150-$20,600/Month in Missed Cases
Current recovery: $5,150 to $15,450/month
Should be: $5,150 to $20,600/month to match
"""

import re

with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Find and update the recovery figure to match the loss figure
# Change "$5,150 to $15,450/month" to "$5,150 to $20,600/month"
pattern1 = r'(Average firm may recover )(\$5,150 to \$15,450/month)( in additional revenue)'
if re.search(pattern1, content, re.IGNORECASE):
    content = re.sub(
        pattern1,
        r'\1$5,150 to $20,600/month\3',
        content,
        flags=re.IGNORECASE
    )
    print("[OK] Updated recovery figure to $5,150 to $20,600/month to match headline")

# Also check for any other instances that might need updating
pattern2 = r'(\$5,150 to \$15,450/month)'
if re.search(pattern2, content, re.IGNORECASE):
    # Only replace if it's in a recovery context, not if it's already correct elsewhere
    # Check context - if it's about recovery, update it
    matches = list(re.finditer(pattern2, content, re.IGNORECASE))
    for match in reversed(matches):
        context = content[max(0, match.start()-50):match.end()+50]
        if 'recover' in context.lower() or 'additional revenue' in context.lower():
            content = content[:match.start()] + '$5,150 to $20,600/month' + content[match.end():]
            print("[OK] Updated additional recovery figure instance")

# Write the file
with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("[OK] Hero revenue alignment fix complete!")
print("\nNow the recovery figure ($5,150 to $20,600/month) matches the loss figure in the headline.")

