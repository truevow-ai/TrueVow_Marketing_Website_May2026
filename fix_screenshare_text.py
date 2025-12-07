#!/usr/bin/env python3
"""
Update onboarding text to mention screenshare setup
"""

import re

with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Find and update the onboarding text
# Look for "We set up your phone forwarding, calendar sync. and practice area"
patterns = [
    (r'(30-minute onboarding call[^→]*→\s*)(We set up your phone forwarding, calendar sync[^<]*)', 
     r'\1We help you set up through screenshare: phone forwarding, calendar sync, and practice area'),
    (r'(30-minute onboarding call[^→]*→\s*)(We set up your phone forwarding, calendar sync[^<]*)',
     r'\1We help you set up through screenshare: phone forwarding, calendar sync, and practice area'),
    (r'(We set up your phone forwarding, calendar sync[^<]*)',
     r'We help you set up through screenshare: phone forwarding, calendar sync, and practice area'),
]

for pattern, replacement in patterns:
    if re.search(pattern, content, re.IGNORECASE):
        content = re.sub(
            pattern,
            replacement,
            content,
            flags=re.IGNORECASE
        )
        print(f"[OK] Updated onboarding text to mention screenshare")
        break

# Also check for similar patterns in FAQ sections
faq_patterns = [
    (r'(30-minute screenshare call[^→]*→\s*)(We help you integrate[^<]*)',
     r'\1We help you set up through screenshare: integrate'),
    (r'(30-minute call[^→]*→\s*)(We[^<]*set up[^<]*)',
     r'\1We help you set up through screenshare:'),
]

for pattern, replacement in faq_patterns:
    if re.search(pattern, content, re.IGNORECASE):
        content = re.sub(
            pattern,
            replacement,
            content,
            flags=re.IGNORECASE
        )
        print(f"[OK] Updated FAQ onboarding text")

# Write the file
with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("[OK] Screenshare text update complete!")

