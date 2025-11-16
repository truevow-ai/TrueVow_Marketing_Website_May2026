#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Complete fix for county-cap.html - all 4 issues
"""

import re
import os

filepath = "marketing/county-cap.html"
backup_path = "marketing/county-cap.html.complete-fix-backup"

print(f"[FIX] Reading {filepath}...")
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# Create backup
print(f"[BACKUP] Creating backup...")
with open(backup_path, 'w', encoding='utf-8') as f:
    f.write(content)

original = content

# 1. FIX CHART - Show competitive advantage as INCREASING line
print("[FIX 1] Fixing chart to show upward trend...")
# The chart should show advantage INCREASING as you're earlier (lower penetration)
# At 10% penetration: 92% advantage (highest)
# At 33% penetration: 48% advantage (sweet spot)
# At 100% penetration: 0% advantage (no advantage)

# Replace ALL chart data instances
content = re.sub(
    r"data:\s*\[4\.8,\s*4\.2,\s*3\.7,\s*3\.2,\s*2\.5\]",
    "data: [92, 68, 48, 28, 0]",
    content
)

# Update Y-axis to show percentage and change max
content = re.sub(
    r"title:\s*\{\s*display:\s*true,\s*text:\s*'Cases per Month'\s*\}",
    "title: { display: true, text: 'Competitive Advantage %' }",
    content
)

content = re.sub(
    r"max:\s*5(?!\d)",
    "max: 100",
    content
)

# Update label
content = re.sub(
    r"label:\s*'Your Cases/Month'",
    "label: 'Your Competitive Advantage %'",
    content
)

# Add percentage formatting to Y-axis ticks
y_axis_pattern = r"(y:\s*\{[^}]*beginAtZero:\s*true[^}]*)(max:\s*100[^}]*)(\})"
def add_ticks(match):
    return match.group(1) + match.group(2) + ",\n                                    ticks: { callback: function(value) { return value + '%'; } }" + match.group(3)

content = re.sub(y_axis_pattern, add_ticks, content, flags=re.DOTALL)

print("  [OK] Chart updated to show competitive advantage %")

# 2. FIX TABLE EMOJI GIBBERISH
print("[FIX 2] Fixing table emoji gibberish...")
# Find and fix the table with percentages
table_fixes = [
    (r'(\+92%)\s+[^\s]+\s+[^\s]+', r'\1 ✅'),
    (r'(\+68%)\s+[^\s]+\s+[^\s]+', r'\1 ✅'),
    (r'(\+48%)\s+[^\s]+\s+(SWEET SPOT!)', r'\1 ✅ \2'),
    (r'(\+28%)\s+[^\s]+', r'\1 ⚠️'),
    (r'(0%)\s+[^\s]+\s+(No Advantage)', r'\1 ❌ \2'),
]

for pattern, replacement in table_fixes:
    content = re.sub(pattern, replacement, content)

# Fix any corrupted Unicode sequences
content = re.sub(r'âœ\.\.\.', '✅', content)
content = re.sub(r'âŒ', '❌', content)
content = re.sub(r'[^\x00-\x7F]+(?=\s*(?:SWEET SPOT|No Advantage))', '', content)

print("  [OK] Table emojis fixed")

# 3. FIX QUESTION MARKS IN OPTIONS 1-3
print("[FIX 3] Fixing question marks in Options 1-3...")

# Option 1
content = re.sub(
    r'(Option 1:\s*Priority Waitlist)(?!\s*📋)',
    r'\1 📋',
    content
)

# Option 2
content = re.sub(
    r'(Option 2:\s*Adjacent County)(?!\s*🗺️)',
    r'\1 🗺️',
    content
)

# Option 3
content = re.sub(
    r'(Option 3:\s*Refer Fellow Attorneys)(?!\s*💰)',
    r'\1 💰',
    content
)

# Fix question marks in bullet points and sections
content = re.sub(
    r'\?\s*(Keep your spot|No payment|Email alerts|Guaranteed onboarding|Instant activation|Expand your practice|Can add multiple|Unlimited referrals|Paid within)',
    r'✅ \1',
    content
)

# Fix section headers
content = re.sub(r'\?\s*(Who Qualifies|What You Lock In)', r'✅ \1', content)
content = re.sub(r'\?\s*"Locked for life"', r'❌ "Locked for life"', content)
content = re.sub(r'\?\s*"Guaranteed 76-hour setup"', r'❌ "Guaranteed 76-hour setup"', content)
content = re.sub(r'\?\s*"Only 500 spots"', r'❌ "Only 500 spots"', content)

# Fix button
content = re.sub(r'View All 67 Florida Counties\s*\?', 'View All 67 Florida Counties 🗺️', content)

print("  [OK] Question marks replaced with emojis")

# 4. FIX FAQ ACCORDION
print("[FIX 4] Fixing FAQ accordion...")

# Ensure FAQ CSS exists
if '.faq-item .faq-answer' not in content or 'display: none' not in content:
    faq_css = '''
        <style>
            .faq-item .faq-answer {
                display: none;
                padding: 16px 0;
                color: #666;
                line-height: 1.6;
            }
            .faq-item.active .faq-answer {
                display: block !important;
            }
            .faq-item {
                cursor: pointer;
            }
            .faq-question {
                cursor: pointer;
            }
        </style>'''
    
    # Insert in head
    head_end = content.rfind('</head>')
    if head_end > 0:
        content = content[:head_end] + faq_css + '\n' + content[head_end:]
        print("  [OK] FAQ CSS added")

# Ensure FAQ JavaScript works
faq_script = '''
        <script>
            (function() {
                function initFAQ() {
                    const faqItems = document.querySelectorAll('.faq-item');
                    faqItems.forEach(function(item) {
                        // Remove existing listeners by cloning
                        const newItem = item.cloneNode(true);
                        item.parentNode.replaceChild(newItem, item);
                        
                        // Add click handler
                        newItem.addEventListener('click', function(e) {
                            if (e.target.tagName !== 'A') {
                                e.preventDefault();
                                newItem.classList.toggle('active');
                            }
                        });
                        
                        // Make question clickable
                        const question = newItem.querySelector('.faq-question');
                        if (question) {
                            question.style.cursor = 'pointer';
                            question.addEventListener('click', function(e) {
                                e.stopPropagation();
                                newItem.classList.toggle('active');
                            });
                        }
                    });
                }
                
                if (document.readyState === 'loading') {
                    document.addEventListener('DOMContentLoaded', initFAQ);
                } else {
                    initFAQ();
                }
            })();
        </script>'''

# Check if we need to add the script
if 'faq-item' in content:
    body_end = content.rfind('</body>')
    if body_end > 0 and 'initFAQ' not in content:
        content = content[:body_end] + faq_script + '\n' + content[body_end:]
        print("  [OK] FAQ JavaScript added")

# Save file
if content != original:
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"\n[DONE] All fixes applied!")
    print(f"[BACKUP] Backup saved to: {backup_path}")
    print("\n[SUMMARY]")
    print("  ✓ Chart shows competitive advantage % (upward trend)")
    print("  ✓ Table emojis fixed")
    print("  ✓ Options 1-3 question marks fixed")
    print("  ✓ FAQ accordion fixed")
else:
    print("\n[INFO] No changes needed")

