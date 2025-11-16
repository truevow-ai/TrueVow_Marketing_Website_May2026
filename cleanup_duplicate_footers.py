#!/usr/bin/env python3
"""
Remove duplicate footers from HTML files, keeping only the last one.
"""

import os
import re

def remove_duplicate_footers(filepath):
    """Remove duplicate footers, keeping only the last one"""
    if not os.path.exists(filepath):
        return False
    
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    original_content = content
    
    # Find all footer sections
    footer_pattern = r'(<!--\s*STANDARDIZED\s+FOOTER[^-]*-->.*?</footer>)'
    matches = list(re.finditer(footer_pattern, content, re.DOTALL | re.IGNORECASE))
    
    if len(matches) <= 1:
        return False  # No duplicates
    
    print(f"  Found {len(matches)} footer sections in {filepath}")
    
    # Keep only the last footer
    last_match = matches[-1]
    
    # Remove all footers except the last one
    for match in matches[:-1]:
        content = content[:match.start()] + content[match.end():]
        # Adjust the last match position if needed
        if match.end() < last_match.start():
            last_match = re.search(footer_pattern, content, re.DOTALL | re.IGNORECASE)
    
    # Also remove any standalone footer comments
    content = re.sub(r'<!--\s*STANDARDIZED\s+FOOTER[^-]*-->\s*(?=<!--)', '', content, flags=re.IGNORECASE)
    
    if content != original_content:
        with open(filepath, 'w', encoding='utf-8', newline='') as f:
            f.write(content)
        print(f"    ✓ Removed {len(matches) - 1} duplicate footer(s)")
        return True
    
    return False

# Check county-cap.html specifically
if __name__ == "__main__":
    filepath = "marketing/county-cap.html"
    if remove_duplicate_footers(filepath):
        print(f"\n✓ Cleaned up {filepath}")
    else:
        print(f"\n✓ No duplicates found in {filepath}")

