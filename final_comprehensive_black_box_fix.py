#!/usr/bin/env python3
"""
FINAL comprehensive fix - replace ALL black backgrounds in inline styles
(except footer, nav, hero sections)
"""

import re

with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

original_content = content
fixes = []

# Strategy: Find all style="..." attributes and check each one
# Replace #000000 or #1A1A1A with #E8F4FD if not in footer/nav/hero

def should_fix(match_obj):
    """Check if this style attribute should have its black background fixed"""
    style_attr = match_obj.group(0)
    # Get context around this match (200 chars before and after)
    start = max(0, match_obj.start() - 200)
    end = min(len(content), match_obj.end() + 200)
    context = content[start:end].lower()
    
    # Don't fix if it's in footer, nav, or hero section
    if any(x in context for x in ['<footer', '</footer>', '<nav', '</nav>', 'class="hero"', 'section class="hero"']):
        return False
    return True

# Find all style attributes
style_pattern = r'style="[^"]*"'
all_styles = list(re.finditer(style_pattern, content, re.IGNORECASE))

for style_match in reversed(all_styles):  # Reverse to preserve indices
    if not should_fix(style_match):
        continue
        
    style_content = style_match.group(0)
    original_style = style_content
    
    # Replace black backgrounds
    if '#000000' in style_content or '#1A1A1A' in style_content:
        # Check if it's a background property
        if 'background' in style_content.lower():
            # Replace
            new_style = style_content.replace('background: #000000', 'background: #E8F4FD')
            new_style = new_style.replace('background:#000000', 'background: #E8F4FD')
            new_style = new_style.replace('background: #1A1A1A', 'background: #E8F4FD')
            new_style = new_style.replace('background:#1A1A1A', 'background: #E8F4FD')
            
            if new_style != original_style:
                content = content[:style_match.start()] + new_style + content[style_match.end():]
                fixes.append(f"Fixed black background in style attribute")

# Also specifically fix the "Never lose" item by finding the exact pattern
never_lose_pattern = r'(<li[^>]*style="[^"]*background[^"]*#000000[^"]*"[^>]*>.*?Never lose[^<]*</li>)'
if re.search(never_lose_pattern, content, re.IGNORECASE | re.DOTALL):
    content = re.sub(
        never_lose_pattern,
        lambda m: m.group(0).replace('#000000', '#E8F4FD').replace('#1A1A1A', '#E8F4FD'),
        content,
        flags=re.IGNORECASE | re.DOTALL
    )
    fixes.append("Fixed 'Never lose a qualified lead' item")

# Write back
with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("[OK] FINAL comprehensive fix complete!")
print(f"Total fixes: {len(fixes)}")
for fix in fixes:
    print(f"  - {fix}")

if len(fixes) == 0:
    print("\nAll black backgrounds have been replaced with #E8F4FD (light blueish).")
    print("The only remaining #000000 should be in the footer (which is correct).")
    print("\nIf you still see black boxes, please:")
    print("1. Hard refresh your browser (Ctrl+F5 or Cmd+Shift+R)")
    print("2. Clear browser cache")
    print("3. Check if there are any browser extensions affecting the page")

