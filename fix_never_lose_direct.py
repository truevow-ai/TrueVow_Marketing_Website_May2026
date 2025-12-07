#!/usr/bin/env python3
"""
Direct fix for "Never lose a qualified lead" black box
"""

import re

with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Direct replacement - find any li with #000000 background containing "Never lose"
content = content.replace(
    'background: #000000; padding: 12px; border-radius: 8px; margin-bottom: 16px; font-weight: 700; color: #0A2463;">                            <span class="feature-check">✓</span> <strong>Never lose a qualified lead to voicemail again</strong>',
    'background: #E8F4FD; padding: 12px; border-radius: 8px; margin-bottom: 16px; font-weight: 700; color: #0A2463;">                            <span class="feature-check">✓</span> <strong>Never lose a qualified lead to voicemail again</strong>'
)

# Also try without spaces
content = content.replace(
    'background:#000000;padding:12px;border-radius:8px;margin-bottom:16px;font-weight:700;color:#0A2463;">',
    'background:#E8F4FD;padding:12px;border-radius:8px;margin-bottom:16px;font-weight:700;color:#0A2463;">'
)

# Find all remaining #000000 in style attributes (except footer/nav)
def replace_black_bg(match):
    full = match.group(0)
    if 'footer' in full.lower() or 'nav' in full.lower() or 'hero' in full.lower():
        return full
    return full.replace('#000000', '#E8F4FD').replace('#1A1A1A', '#E8F4FD')

# Replace all style="...background: #000000..." except in footer/nav
content = re.sub(
    r'(style="[^"]*background:\s*)(#000000|#1A1A1A)([^"]*")(?!.*footer)(?!.*nav)',
    lambda m: m.group(1) + '#E8F4FD' + m.group(3) if 'footer' not in m.group(0).lower() and 'nav' not in m.group(0).lower() and 'hero' not in m.group(0).lower() else m.group(0),
    content,
    flags=re.IGNORECASE
)

with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("[OK] Direct fix applied for 'Never lose' and all remaining black backgrounds (except footer/nav/hero)")

