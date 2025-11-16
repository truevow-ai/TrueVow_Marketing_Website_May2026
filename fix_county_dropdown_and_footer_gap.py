#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Fix:
1. Remove "(X seats left)" from county dropdown - show only county names
2. Seats info already shown separately in showAvailability() - that's good
3. Remove white gap between CTA section and footer
"""

import re

filepath = "marketing/county-cap.html"
backup_path = "marketing/county-cap.html.dropdown-footer-fix-backup"

print(f"[FIX] Reading {filepath}...")
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# Create backup
print(f"[BACKUP] Creating backup...")
with open(backup_path, 'w', encoding='utf-8') as f:
    f.write(content)

original = content
changes = []

# 1. Remove "(X seats left)" from county dropdown options
print("\n[FIX 1] Removing '(X seats left)' from county dropdown...")
# Find the line that creates county options with seats info
content = re.sub(
    r'option\.textContent = `\$\{county\.name\} \(\$\{county\.remaining\} seats left\)`;',
    'option.textContent = county.name;',
    content
)
changes.append("✅ Removed '(X seats left)' from county dropdown options")

# Also check for any other variations
content = re.sub(
    r'option\.textContent = `\$\{county\.name\}.*?seats left.*?`;',
    'option.textContent = county.name;',
    content,
    flags=re.DOTALL
)

# 2. Remove gap between CTA section and footer
print("\n[FIX 2] Removing gap between CTA section and footer...")

# Find the CTA section closing tag and remove any margin/padding
# The CTA section should end right before the footer
# Look for closing </section> tag before footer and remove any spacing

# Remove margin-bottom from cta-section
content = re.sub(
    r'(<section class="cta-section"[^>]*>)',
    r'\1',
    content
)

# Add style to remove bottom margin/padding from cta-section
if 'class="cta-section"' in content:
    # Find cta-section and ensure it has no bottom margin
    content = re.sub(
        r'(<section class="cta-section")',
        r'<section class="cta-section" style="margin-bottom: 0; padding-bottom: 0;"',
        content
    )
    changes.append("✅ Removed bottom margin from CTA section")

# Remove any margin-top from footer
content = re.sub(
    r'(<footer[^>]*style="[^"]*)(margin-top:\s*[^;]+;?)',
    r'\1',
    content
)

# Ensure footer has no top margin
if '<footer' in content:
    # Add margin-top: 0 to footer if it doesn't have it
    footer_pattern = r'(<footer[^>]*style=")([^"]*)"'
    def add_margin_top(match):
        style = match.group(2)
        if 'margin-top' not in style:
            if style and not style.endswith(';'):
                style += ';'
            style += ' margin-top: 0;'
        return match.group(1) + style + '"'
    
    content = re.sub(footer_pattern, add_margin_top, content)
    changes.append("✅ Removed top margin from footer")

# Also check for any white space or padding between sections
# Look for closing </section> followed by whitespace and then footer
content = re.sub(
    r'(</section>\s*)(\s+)(<!-- STANDARDIZED FOOTER|<footer)',
    r'\1\3',
    content,
    flags=re.MULTILINE
)

# Remove any margin/padding from the container div inside cta-section
content = re.sub(
    r'(<div class="container"[^>]*style="[^"]*)(margin-bottom:\s*[^;]+;?)',
    r'\1',
    content
)

# Write the fixed content
if content != original:
    print(f"\n[SAVE] Writing fixed content to {filepath}...")
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"\n{'='*60}")
    print("SUMMARY OF CHANGES:")
    for change in changes:
        print(f"  {change}")
    print(f"{'='*60}")
else:
    print("\n[INFO] No changes made")

