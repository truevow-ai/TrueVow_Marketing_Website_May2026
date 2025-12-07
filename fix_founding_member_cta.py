#!/usr/bin/env python3
"""
Fix the Founding Member CTA button link
"""

import re

with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Find the "Apply Now (Checkbox for Founding Member Interest)" button
# Look for the text pattern
pattern = r'(<a[^>]*href=")([^"]*)("[^>]*>.*?Apply Now.*?Checkbox for Founding Member Interest[^<]*</a>)'

if re.search(pattern, content, re.IGNORECASE | re.DOTALL):
    # Replace the href to point to apply.html
    content = re.sub(
        pattern,
        lambda m: m.group(1) + 'apply.html' + m.group(3),
        content,
        flags=re.IGNORECASE | re.DOTALL
    )
    print("[OK] Fixed Founding Member CTA button link to apply.html")
else:
    # Try a different pattern - find the button by its text content
    # Look for the button that contains "Checkbox for Founding Member"
    pattern2 = r'(<a[^>]*href=")([^"]*)("[^>]*>.*?Checkbox for Founding Member[^<]*</a>)'
    if re.search(pattern2, content, re.IGNORECASE | re.DOTALL):
        content = re.sub(
            pattern2,
            lambda m: m.group(1) + 'apply.html' + m.group(3),
            content,
            flags=re.IGNORECASE | re.DOTALL
        )
        print("[OK] Fixed Founding Member CTA button link to apply.html (pattern 2)")
    else:
        # Try to find it by looking for the section and then the button
        # Find "Founding Member Upgrade Program" section
        founding_section_idx = content.find('FOUNDING MEMBER UPGRADE PROGRAM')
        if founding_section_idx >= 0:
            # Find the next <a> tag after this section
            section_end = content.find('</section>', founding_section_idx)
            if section_end >= 0:
                section_content = content[founding_section_idx:section_end]
                # Find href in this section that might be wrong
                # Look for href="/marketing/apply.html" or similar
                section_content = re.sub(
                    r'(href=")(/marketing/apply\.html|#|javascript:void\(0\))(")',
                    r'\1apply.html\3',
                    section_content,
                    flags=re.IGNORECASE
                )
                content = content[:founding_section_idx] + section_content + content[section_end:]
                print("[OK] Fixed Founding Member CTA button link in section")
        else:
            print("[WARNING] Could not find Founding Member section")

# Write the file
with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("[OK] CTA button fix complete!")

