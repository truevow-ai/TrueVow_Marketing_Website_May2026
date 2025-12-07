#!/usr/bin/env python3
"""
Fix two issues:
1. Remove disclaimer from county search section
2. Move disclaimer to FAQ section
3. Fix JavaScript error - move window.practiceAreaData assignment after practiceAreaData is defined
"""

import re

with open('marketing/county-cap.html', 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Remove disclaimer from county search section
disclaimer_pattern = r'            <div style="background: #FFF9E6[^>]*>.*?Data Sources & Methodology.*?</div>\s*'
content = re.sub(disclaimer_pattern, '', content, flags=re.DOTALL)

# 2. Remove the premature window.practiceAreaData assignment (line 502)
# It's trying to assign before practiceAreaData is defined
content = re.sub(
    r'    \};\s*window\.practiceAreaData = practiceAreaData;\s*window\.checkCountyData = checkCountyData;',
    r'    };\n    window.checkCountyData = checkCountyData;',
    content
)

# 3. Find where practiceAreaData ends and add window assignment there
# Look for the closing }; of practiceAreaData (should be after all county data)
# Pattern: }; followed by comment or function definition
pattern = r'(    \};\s*)(//|    //|    function loadAvailabilityCounties|    // Make function)'

def add_window_assignment(match):
    closing = match.group(1)
    next_line = match.group(2)
    # Only add if it's after practiceAreaData (check if it's before loadAvailabilityCounties)
    if 'loadAvailabilityCounties' in next_line or 'Make function' in next_line:
        return closing + '\n    window.practiceAreaData = practiceAreaData;\n    ' + next_line
    return match.group(0)

content = re.sub(pattern, add_window_assignment, content, count=1)

# 4. Find FAQ section and add disclaimer there
# Look for FAQ section heading
faq_pattern = r'(<h2[^>]*>.*?Frequently Asked Questions.*?</h2>)'

disclaimer_faq = '''
            <div class="faq-item" onclick="toggleFAQ(this)">
                <div class="faq-question">
                    What data sources are used for county law firm counts?
                    <span class="faq-toggle">+</span>
                </div>
                <div class="faq-answer">
                    <p><strong>Data Sources & Methodology:</strong></p>
                    <p>Total law firm counts are based on U.S. Bureau of Labor Statistics (BLS) Q1 2024 data for law offices (NAICS 54111) by county. Solo and small law firm counts (firms with &lt;21 attorneys) are calculated using The Florida Bar 2014 Economic Survey finding that 67% of Florida attorneys operate as solo practitioners or in firms with 5 or fewer attorneys.</p>
                    <p>Practice area breakdowns use industry-standard distribution percentages based on analysis of Florida Bar data and Clio 2024 civil filings. Actual numbers may vary by county based on local market conditions. Data is intended for general informational purposes.</p>
                </div>
            </div>
'''

def add_faq_disclaimer(match):
    return match.group(1) + disclaimer_faq

content = re.sub(faq_pattern, add_faq_disclaimer, content, flags=re.IGNORECASE | re.DOTALL)

# Write back
with open('marketing/county-cap.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("✓ Removed disclaimer from county search section")
print("✓ Added disclaimer to FAQ section")
print("✓ Fixed window.practiceAreaData assignment (moved after definition)")

