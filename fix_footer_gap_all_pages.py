#!/usr/bin/env python3
"""
Fix white gap between sections and footer on all pages
- Remove top padding from footer
- Remove bottom padding/margin from last section before footer
"""

import re
import os

def fix_footer_gap(filepath):
    """Fix footer gap in a single HTML file"""
    if not os.path.exists(filepath):
        print(f"  [SKIP] {filepath} not found")
        return False
    
    print(f"\n[FILE] Processing: {filepath}")
    
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    original = content
    changes = []
    
    # 1. Fix footer - remove top padding
    footer_pattern = r'(<footer[^>]*style="[^"]*padding:\s*)(\d+px\s+\d+px\s+\d+px\s+\d+px)([^"]*")'
    if re.search(footer_pattern, content):
        content = re.sub(
            footer_pattern,
            r'\1 0 20px 120px 20px !important; margin-top: 0 !important;\3',
            content
        )
        changes.append("Footer top padding removed")
    
    # Also handle footer with padding already modified
    footer_pattern2 = r'(<footer[^>]*style="[^"]*padding:\s*0\s+\d+px\s+\d+px\s+\d+px)([^"]*")'
    if re.search(footer_pattern2, content) and 'margin-top: 0' not in content:
        content = re.sub(
            footer_pattern2,
            r'\1 !important; margin-top: 0 !important;\2',
            content
        )
        changes.append("Footer margin-top added")
    
    # 2. Find last section before footer and remove bottom padding
    # Look for sections with padding that ends before footer
    # Pattern: section with style="padding: ..." that comes before footer
    section_pattern = r'(<section[^>]*style="[^"]*padding:\s*)(\d+px\s+\d+px\s+)(\d+px)(\s+\d+px)([^"]*">[^<]*</section>)(\s*<!--\s*FOOTER|<!--\s*STANDARDIZED\s*FOOTER|<footer)'
    
    def replace_section_padding(match):
        top_padding = match.group(2)
        left_right = match.group(3)
        bottom_padding = match.group(4)
        rest = match.group(5)
        footer_start = match.group(6)
        
        # Change bottom padding to 0
        new_bottom = " 0"
        new_style = f'{match.group(1)}{top_padding}{left_right}{new_bottom}{rest}'
        return new_style + footer_start
    
    if re.search(section_pattern, content, re.DOTALL):
        content = re.sub(section_pattern, replace_section_padding, content, flags=re.DOTALL)
        changes.append("Last section bottom padding removed")
    
    # 3. Also handle inline style sections with padding: 100px 24px (common pattern)
    # This is for sections like: style="padding: 100px 24px; ..."
    section_inline_pattern = r'(<section[^>]*style="[^"]*padding:\s*)(\d+px\s+\d+px)([^"]*">[^<]*</section>)(\s*<!--\s*FOOTER|<!--\s*STANDARDIZED\s*FOOTER|<footer)'
    
    def replace_inline_padding(match):
        padding = match.group(2)  # e.g., "100px 24px"
        rest = match.group(3)
        footer_start = match.group(4)
        
        # Change to: padding: 100px 24px 0 24px (remove bottom)
        parts = padding.split()
        if len(parts) == 2:
            # Two-value padding: top/bottom left/right -> change to four values with 0 bottom
            new_padding = f"{parts[0]} {parts[1]} 0 {parts[1]}"
        else:
            new_padding = padding  # Keep as is if already 4 values
        
        new_style = f'{match.group(1)}{new_padding}{rest}'
        return new_style + footer_start
    
    if re.search(section_inline_pattern, content, re.DOTALL):
        content = re.sub(section_inline_pattern, replace_inline_padding, content, flags=re.DOTALL)
        changes.append("Section inline padding adjusted")
    
    # 4. Add margin-bottom: 0 to last section before footer
    # Find section that ends right before footer comment or footer tag
    section_before_footer = r'(<section[^>]*style="[^"]*)([^"]*">[^<]*</section>)(\s*<!--\s*FOOTER|<!--\s*STANDARDIZED\s*FOOTER|<footer)'
    
    def add_margin_bottom_zero(match):
        style_attr = match.group(1)
        rest = match.group(2)
        footer_start = match.group(3)
        
        if 'margin-bottom' not in style_attr:
            # Add margin-bottom: 0 !important;
            if style_attr.endswith('"'):
                new_style = style_attr[:-1] + '; margin-bottom: 0 !important;"'
            else:
                new_style = style_attr + ' margin-bottom: 0 !important;'
        else:
            new_style = style_attr
        
        return new_style + rest + footer_start
    
    if re.search(section_before_footer, content, re.DOTALL):
        content = re.sub(section_before_footer, add_margin_bottom_zero, content, flags=re.DOTALL)
        changes.append("Margin-bottom: 0 added to last section")
    
    if content != original:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"  [✓] Changes: {', '.join(changes)}")
        return True
    else:
        print(f"  [SKIP] No changes needed")
        return False

# Fix both pages
files = [
    'marketing/pricing.html',
    'marketing/county-cap.html'
]

print("=" * 60)
print("FIXING FOOTER GAP ON ALL PAGES")
print("=" * 60)

for filepath in files:
    fix_footer_gap(filepath)

print("\n" + "=" * 60)
print("DONE")
print("=" * 60)

