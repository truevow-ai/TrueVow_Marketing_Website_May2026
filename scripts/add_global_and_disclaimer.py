#!/usr/bin/env python3
"""
Add global assignment for practiceAreaData and disclaimer
"""

import re

with open('marketing/county-cap.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Find where practiceAreaData ends (look for }; followed by comment or function)
# Pattern: }; followed by whitespace and then a comment or function definition
pattern = r'(    \};\s*)(//|    //|    function|    window\.)'

def add_global(match):
    closing = match.group(1)
    next_line = match.group(2)
    return closing + '\n    window.practiceAreaData = practiceAreaData;\n    ' + next_line

# Replace
content = re.sub(pattern, add_global, content, count=1)

# Add disclaimer in the "Check Your County Availability" section
# Find the section and add disclaimer after the description paragraph
disclaimer_html = '''
            <div style="background: #FFF9E6; padding: 20px; border-radius: 12px; border-left: 4px solid #F59E0B; margin: 32px auto; max-width: 800px;">
                <p style="margin: 0; color: #92400E; font-size: 14px; line-height: 1.6;">
                    <strong>Data Sources & Methodology:</strong><br>
                    Total law firm counts are based on U.S. Bureau of Labor Statistics (BLS) Q1 2024 data for law offices (NAICS 54111) by county. Solo and small law firm counts (firms with &lt;21 attorneys) are calculated using The Florida Bar 2014 Economic Survey finding that 67% of Florida attorneys operate as solo practitioners or in firms with 5 or fewer attorneys. Practice area breakdowns use industry-standard distribution percentages based on analysis of Florida Bar data and Clio 2024 civil filings. Actual numbers may vary by county based on local market conditions. Data is intended for general informational purposes.
                </p>
            </div>
'''

# Find the "Check Your County Availability" section and add disclaimer
pattern2 = r'(<p style="font-size: 1\.125rem; margin-bottom: 32px[^>]*>See if seats are available[^<]*</p>)'

def add_disclaimer(match):
    return match.group(1) + disclaimer_html

content = re.sub(pattern2, add_disclaimer, content)

# Write back
with open('marketing/county-cap.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("✓ Added window.practiceAreaData global assignment")
print("✓ Added data sources disclaimer")

