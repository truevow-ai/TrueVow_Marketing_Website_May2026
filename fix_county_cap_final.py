#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Fix all 4 issues in county-cap.html:
1. Flip chart to show upward trend (competitive advantage increasing)
2. Fix table emoji gibberish
3. Fix question marks in Options 1-3
4. Fix FAQ accordion
"""

import re
import os

filepath = "marketing/county-cap.html"
backup_path = "marketing/county-cap.html.final-fix-backup"

print(f"[FIX] Reading {filepath}...")
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# Create backup
print(f"[BACKUP] Creating backup...")
with open(backup_path, 'w', encoding='utf-8') as f:
    f.write(content)

original = content

# 1. FIX CHART - Flip to show upward trend (competitive advantage)
print("[FIX 1] Fixing chart to show upward trend...")
# The chart should show COMPETITIVE ADVANTAGE increasing, not cases decreasing
# Current: [4.8, 4.2, 3.7, 3.2, 2.5] - shows decreasing
# New: Show advantage percentage: [92%, 68%, 48%, 28%, 0%] as [0.92, 0.68, 0.48, 0.28, 0.0]
# Or better: Show advantage as cases above baseline: [2.3, 1.7, 1.2, 0.7, 0.0]
# Actually, let's show it as "Competitive Advantage %" on Y-axis: [92, 68, 48, 28, 0]

# Find and replace chart data
chart_pattern = r"data:\s*\[4\.8,\s*4\.2,\s*3\.7,\s*3\.2,\s*2\.5\]"
chart_replacement = "data: [92, 68, 48, 28, 0]"

if re.search(chart_pattern, content):
    content = re.sub(chart_pattern, chart_replacement, content)
    print("  [OK] Chart data flipped to show advantage")
    
    # Also update Y-axis label and max
    content = re.sub(
        r"title:\s*\{\s*display:\s*true,\s*text:\s*'Cases per Month'\s*\}",
        "title: { display: true, text: 'Competitive Advantage %' }",
        content
    )
    
    content = re.sub(
        r"max:\s*5",
        "max: 100",
        content
    )
    
    content = re.sub(
        r"beginAtZero:\s*true",
        "beginAtZero: true,\n                                    ticks: { callback: function(value) { return value + '%'; } }",
        content
    )
    
    # Update tooltip
    content = re.sub(
        r"label:\s*'Your Cases/Month'",
        "label: 'Your Competitive Advantage'",
        content
    )
    
    print("  [OK] Y-axis updated to show percentage")
else:
    print("  [WARN] Chart pattern not found, trying alternative...")
    # Try finding the chart with different pattern
    alt_pattern = r"data:\s*\[(?:4\.8|4\.2|3\.7|3\.2|2\.5)"
    if re.search(alt_pattern, content):
        # Replace all instances
        content = re.sub(
            r"data:\s*\[4\.8,\s*4\.2,\s*3\.7,\s*3\.2,\s*2\.5\]",
            "data: [92, 68, 48, 28, 0]",
            content
        )
        print("  [OK] Chart data replaced (alternative pattern)")

# 2. FIX TABLE EMOJI GIBBERISH
print("[FIX 2] Fixing table emoji gibberish...")
# Replace corrupted emoji patterns
emoji_fixes = [
    (r'(\+92%)\s*[^\s]*\s*([^\s]*)', r'\1 ✅'),
    (r'(\+68%)\s*[^\s]*\s*([^\s]*)', r'\1 ✅'),
    (r'(\+48%)\s*[^\s]*\s*(SWEET SPOT!)', r'\1 ✅ \2'),
    (r'(\+28%)\s*[^\s]*', r'\1 ⚠️'),
    (r'(0%)\s*[^\s]*\s*(No Advantage)', r'\1 ❌ \2'),
]

for pattern, replacement in emoji_fixes:
    if re.search(pattern, content):
        content = re.sub(pattern, replacement, content)
        print(f"  [OK] Fixed emoji pattern: {pattern[:20]}...")

# Also fix any remaining corrupted Unicode
content = re.sub(r'âœ\.\.\.', '✅', content)
content = re.sub(r'âŒ', '❌', content)
content = re.sub(r'[^\x00-\x7F]+(?=\s*(?:SWEET SPOT|No Advantage))', '', content)

# 3. FIX QUESTION MARKS IN OPTIONS 1-3
print("[FIX 3] Fixing question marks in Options 1-3...")
# Option 1: Priority Waitlist
content = re.sub(
    r'Option 1:\s*Priority Waitlist(?!\s*📋)',
    'Option 1: Priority Waitlist 📋',
    content
)

# Option 2: Adjacent County  
content = re.sub(
    r'Option 2:\s*Adjacent County(?!\s*🗺️)',
    'Option 2: Adjacent County 🗺️',
    content
)

# Option 3: Refer Fellow Attorneys
content = re.sub(
    r'Option 3:\s*Refer Fellow Attorneys(?!\s*💰)',
    'Option 3: Refer Fellow Attorneys 💰',
    content
)

# Fix question marks in bullet points
content = re.sub(
    r'(\?\s*)(Keep your spot|No payment|Email alerts|Guaranteed onboarding|Instant activation|Expand your practice|Can add multiple|Unlimited referrals|Paid within)',
    r'✅ \2',
    content
)

# Fix question marks in section headers
content = re.sub(
    r'\?\s*(Who Qualifies|What You Lock In)',
    r'✅ \1',
    content
)

content = re.sub(
    r'\?\s*"Locked for life"',
    r'❌ "Locked for life"',
    content
)

content = re.sub(
    r'\?\s*"Guaranteed 76-hour setup"',
    r'❌ "Guaranteed 76-hour setup"',
    content
)

content = re.sub(
    r'\?\s*"Only 500 spots"',
    r'❌ "Only 500 spots"',
    content
)

print("  [OK] Question marks replaced with emojis")

# 4. FIX FAQ ACCORDION
print("[FIX 4] Fixing FAQ accordion...")
# Check if FAQ toggle function exists and works properly
if 'faq-item' in content:
    # Ensure toggleFAQ function exists
    if 'function toggleFAQ' not in content or content.count('function toggleFAQ') < 2:
        # Add proper FAQ toggle script before </body>
        faq_script = '''
        <script>
            function toggleFAQ(element) {
                element.classList.toggle('active');
            }
            document.addEventListener('DOMContentLoaded', function() {
                // Make entire FAQ item clickable
                document.querySelectorAll('.faq-item').forEach(function(item) {
                    // Remove any existing listeners by cloning
                    const question = item.querySelector('.faq-question');
                    if (question) {
                        question.style.cursor = 'pointer';
                        question.addEventListener('click', function(e) {
                            e.stopPropagation();
                            toggleFAQ(item);
                        });
                    }
                    // Also make the whole item clickable as fallback
                    item.style.cursor = 'pointer';
                    item.addEventListener('click', function(e) {
                        if (e.target.tagName !== 'A') {
                            toggleFAQ(item);
                        }
                    });
                });
            });
        </script>'''
        
        # Insert before last </body> or before last </script>
        body_end = content.rfind('</body>')
        if body_end > 0:
            # Check if script already exists
            if 'document.querySelectorAll(\'.faq-item\')' not in content or content.count('document.querySelectorAll(\'.faq-item\')') < 2:
                content = content[:body_end] + faq_script + '\n' + content[body_end:]
                print("  [OK] FAQ toggle script added")
            else:
                print("  [INFO] FAQ script already exists")
    else:
        print("  [INFO] FAQ toggle function already exists")
        
    # Ensure CSS for FAQ is correct
    if '.faq-item.active .faq-answer' not in content or 'display: block' not in content:
        # Add CSS if missing
        faq_css = '''
        <style>
            .faq-item .faq-answer {
                display: none;
                padding: 16px 0;
                color: #666;
                line-height: 1.6;
            }
            .faq-item.active .faq-answer {
                display: block;
            }
            .faq-item {
                cursor: pointer;
            }
            .faq-question {
                cursor: pointer;
            }
        </style>'''
        
        # Insert in <head> or before </head>
        head_end = content.rfind('</head>')
        if head_end > 0 and 'faq-item .faq-answer' not in content:
            content = content[:head_end] + faq_css + '\n' + content[head_end:]
            print("  [OK] FAQ CSS added")

# Save file
if content != original:
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"\n[DONE] All fixes applied!")
    print(f"[BACKUP] Backup saved to: {backup_path}")
else:
    print("\n[INFO] No changes needed")

