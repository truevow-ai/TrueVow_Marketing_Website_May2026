#!/usr/bin/env python3
"""Clean up duplicate CSS rules for pricing CTAs"""

import re

with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Remove duplicate .pricing-cta rules (keep only the standardized one)
# Find all .pricing-cta blocks and keep only the first standardized one
pattern1 = r'(\.pricing-cta\s*\{[^}]*\})\s*(\.pricing-cta\s*\{[^}]*\})'
# Replace with just the first one
content = re.sub(r'\.pricing-cta\s*\{[^}]*background:[^}]*\}\s*\.pricing-cta\s*\{', '.pricing-cta {', content, flags=re.DOTALL)

# Remove duplicate .pricing-cta-secondary rules
pattern2 = r'(\.pricing-cta-secondary\s*\{[^}]*\})\s*(\.pricing-cta-secondary\s*\{[^}]*\})'
content = re.sub(r'\.pricing-cta-secondary\s*\{[^}]*\}\s*\.pricing-cta-secondary\s*\{', '.pricing-cta-secondary {', content, flags=re.DOTALL)

# Also remove the old hover rule that has transform: scale
pattern3 = r'\.pricing-cta:hover\s*\{\s*background:\s*#0052CC;\s*transform:\s*scale\(1\.02\);\s*\}'
content = re.sub(pattern3, '', content)

# Remove old secondary hover that changes to blue
pattern4 = r'\.pricing-cta-secondary:hover\s*\{\s*background:\s*#0A2463;\s*color:\s*white\s*!\s*important;\s*\}'
# Keep the new one that changes to darker black
content = re.sub(pattern4, '', content)

with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("[OK] Cleaned up duplicate CSS rules")

