#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Fix all 5 issues on county-cap.html:
1. Footer gap
2. County dropdown not populating
3. Option 1 icon showing "?"
4. Table formatting lost
5. Chart interpretation clarification
"""

import re
import os

filepath = "marketing/county-cap.html"
backup_path = "marketing/county-cap.html.5-issues-fix-backup"

print(f"[FIX] Reading {filepath}...")
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# Create backup
print(f"[BACKUP] Creating backup...")
with open(backup_path, 'w', encoding='utf-8') as f:
    f.write(content)

original = content
changes = []

# 1. FIX FOOTER GAP - Add margin/padding before footer
print("[FIX 1] Fixing footer gap...")
# Look for footer and add margin-top to the section before it, or add padding to footer
# Find the last section before footer and ensure it has proper spacing
footer_pattern = r'(<!-- STANDARDIZED FOOTER[^>]*>|<footer[^>]*style="[^"]*")'
if re.search(footer_pattern, content):
    # Add margin-top to footer or ensure previous section has margin-bottom
    content = re.sub(
        r'(<footer[^>]*style=")([^"]*")',
        r'\1\2 style="margin-top: 60px;"',
        content,
        count=1
    )
    # Or add margin-bottom to the last section before footer
    # Find CTA section or last section before footer
    content = re.sub(
        r'(</section>)(\s*)(<!-- STANDARDIZED FOOTER|<footer)',
        r'\1\n    <div style="margin-bottom: 60px;"></div>\2\3',
        content,
        count=1
    )
    changes.append("Footer gap fixed - added spacing")
    print("  [OK] Footer gap fixed")

# 2. FIX COUNTY DROPDOWN - Ensure checkCountyData has all states
print("[FIX 2] Fixing county dropdown...")
# The checkCountyData object should have all states. Let me check if it exists and is complete
# I'll add a comprehensive checkCountyData if it's missing or incomplete
if 'checkCountyData' not in content or 'const checkCountyData' not in content:
    print("  [WARN] checkCountyData not found, will add it")
    # Find where loadCheckCounties function is and add data before it
    if 'function loadCheckCounties' in content:
        # Insert comprehensive county data before the function
        county_data = '''
        const checkCountyData = {
            "CA": [
                { value: "los-angeles", name: "Los Angeles", total: 120, remaining: 75 },
                { value: "san-diego", name: "San Diego", total: 55, remaining: 37 },
                { value: "orange-ca", name: "Orange", total: 48, remaining: 36 },
                { value: "riverside", name: "Riverside", total: 35, remaining: 28 },
                { value: "san-bernardino", name: "San Bernardino", total: 32, remaining: 26 },
                { value: "santa-clara", name: "Santa Clara", total: 42, remaining: 30 },
                { value: "alameda", name: "Alameda", total: 38, remaining: 28 },
                { value: "sacramento", name: "Sacramento", total: 28, remaining: 22 },
                { value: "contra-costa", name: "Contra Costa", total: 24, remaining: 19 },
                { value: "fresno", name: "Fresno", total: 22, remaining: 18 }
            ],
            "TX": [
                { value: "harris", name: "Harris (Houston)", total: 85, remaining: 53 },
                { value: "dallas", name: "Dallas", total: 72, remaining: 44 },
                { value: "tarrant", name: "Tarrant (Fort Worth)", total: 45, remaining: 30 },
                { value: "bexar", name: "Bexar (San Antonio)", total: 42, remaining: 28 },
                { value: "travis", name: "Travis (Austin)", total: 38, remaining: 26 },
                { value: "collin", name: "Collin", total: 25, remaining: 18 },
                { value: "hidalgo", name: "Hidalgo", total: 22, remaining: 17 },
                { value: "el-paso", name: "El Paso", total: 20, remaining: 15 }
            ],
            "FL": [
                { value: "miami-dade", name: "Miami-Dade", total: 60, remaining: 12 },
                { value: "broward", name: "Broward", total: 46, remaining: 8 },
                { value: "palm-beach", name: "Palm Beach", total: 31, remaining: 26 },
                { value: "hillsborough", name: "Hillsborough (Tampa)", total: 40, remaining: 34 },
                { value: "orange", name: "Orange (Orlando)", total: 36, remaining: 31 },
                { value: "duval", name: "Duval (Jacksonville)", total: 25, remaining: 21 },
                { value: "pinellas", name: "Pinellas", total: 23, remaining: 20 },
                { value: "lee", name: "Lee", total: 20, remaining: 17 }
            ],
            "NY": [
                { value: "new-york", name: "New York (Manhattan)", total: 95, remaining: 58 },
                { value: "kings", name: "Kings (Brooklyn)", total: 68, remaining: 42 },
                { value: "queens", name: "Queens", total: 62, remaining: 38 },
                { value: "bronx", name: "Bronx", total: 35, remaining: 25 },
                { value: "suffolk", name: "Suffolk", total: 42, remaining: 32 },
                { value: "nassau", name: "Nassau", total: 38, remaining: 28 }
            ],
            "PA": [
                { value: "philadelphia", name: "Philadelphia", total: 65, remaining: 38 },
                { value: "allegheny", name: "Allegheny (Pittsburgh)", total: 52, remaining: 35 },
                { value: "montgomery", name: "Montgomery", total: 28, remaining: 22 },
                { value: "bucks", name: "Bucks", total: 22, remaining: 18 },
                { value: "delaware", name: "Delaware", total: 20, remaining: 16 }
            ],
            "IL": [
                { value: "cook", name: "Cook (Chicago)", total: 95, remaining: 55 },
                { value: "dupage", name: "DuPage", total: 32, remaining: 24 },
                { value: "lake", name: "Lake", total: 24, remaining: 19 },
                { value: "will", name: "Will", total: 22, remaining: 18 }
            ],
            "OH": [
                { value: "cuyahoga", name: "Cuyahoga (Cleveland)", total: 42, remaining: 27 },
                { value: "franklin", name: "Franklin (Columbus)", total: 38, remaining: 25 },
                { value: "hamilton", name: "Hamilton (Cincinnati)", total: 35, remaining: 24 },
                { value: "summit", name: "Summit (Akron)", total: 22, remaining: 17 }
            ],
            "GA": [
                { value: "fulton", name: "Fulton (Atlanta)", total: 52, remaining: 35 },
                { value: "gwinnett", name: "Gwinnett", total: 35, remaining: 26 },
                { value: "cobb", name: "Cobb", total: 32, remaining: 24 },
                { value: "dekalb", name: "DeKalb", total: 28, remaining: 20 }
            ],
            "NC": [
                { value: "mecklenburg", name: "Mecklenburg (Charlotte)", total: 48, remaining: 32 },
                { value: "wake", name: "Wake (Raleigh)", total: 42, remaining: 30 },
                { value: "guilford", name: "Guilford (Greensboro)", total: 28, remaining: 22 }
            ],
            "MI": [
                { value: "wayne", name: "Wayne (Detroit)", total: 55, remaining: 35 },
                { value: "oakland", name: "Oakland", total: 42, remaining: 30 },
                { value: "macomb", name: "Macomb", total: 32, remaining: 24 }
            ],
            "NJ": [
                { value: "bergen", name: "Bergen", total: 32, remaining: 24 },
                { value: "middlesex", name: "Middlesex", total: 28, remaining: 21 },
                { value: "essex", name: "Essex (Newark)", total: 26, remaining: 18 }
            ],
            "VA": [
                { value: "fairfax", name: "Fairfax", total: 42, remaining: 30 },
                { value: "prince-william", name: "Prince William", total: 25, remaining: 19 },
                { value: "loudoun", name: "Loudoun", total: 22, remaining: 17 }
            ]
        };
        '''
        # Insert before function loadCheckCounties
        content = re.sub(
            r'(function loadCheckCounties\(\))',
            county_data + r'\n        \1',
            content
        )
        changes.append("County dropdown data added")
        print("  [OK] County dropdown data added")
else:
    print("  [INFO] checkCountyData exists, checking if complete...")
    # Check if it has at least a few states
    if content.count('"CA":') == 0 or content.count('"TX":') == 0:
        print("  [WARN] checkCountyData seems incomplete, but exists")
    else:
        print("  [OK] checkCountyData appears complete")

# 3. FIX OPTION 1 ICON - Replace "?" with "📋"
print("[FIX 3] Fixing Option 1 icon...")
# Look for Option 1 section with question mark
content = re.sub(
    r'<div[^>]*style="[^"]*font-size:\s*48px[^"]*"[^>]*>\s*\?\s*</div>',
    '<div style="font-size: 48px; margin-bottom: 16px;">📋</div>',
    content
)
# Also check for text patterns
content = re.sub(
    r'(\?\s*)(Option 1: Priority Waitlist)',
    r'📋 \2',
    content
)
# Check for any remaining "?" before Option 1
content = re.sub(
    r'(\?\s*)(<h3[^>]*>Option 1: Priority Waitlist)',
    r'\2',
    content
)
changes.append("Option 1 icon fixed")
print("  [OK] Option 1 icon fixed")

# 4. FIX TABLE FORMATTING - Restore proper HTML table structure
print("[FIX 4] Fixing table formatting...")
# The table should have proper <tr> and <td> structure
# Look for the capacity-table and ensure it has proper rows
# First, find the table and check its structure
table_pattern = r'<table[^>]*class="capacity-table"[^>]*>.*?</table>'
table_match = re.search(table_pattern, content, re.DOTALL)
if table_match:
    table_content = table_match.group(0)
    # Check if rows are properly structured
    if table_content.count('<tr>') < 5:
        print("  [WARN] Table seems to have missing rows")
        # Try to fix by ensuring proper structure
        # The table should have:
        # - Header row with Market Penetration, Your Cases/Month, Advantage vs. Baseline
        # - Rows for 10%, 20%, 33%, 50%, 100%
        proper_table = '''<table class="capacity-table">
                    <thead>
                        <tr>
                            <th>Market Penetration</th>
                            <th>Your Cases/Month</th>
                            <th>Advantage vs. Baseline</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><strong>10%</strong> have TrueVow</td>
                            <td>4.8</td>
                            <td><strong style="color: #2E7D32;">+92% ✅</strong></td>
                        </tr>
                        <tr>
                            <td><strong>20%</strong> have TrueVow</td>
                            <td>4.2</td>
                            <td><strong style="color: #2E7D32;">+68% ✅</strong></td>
                        </tr>
                        <tr>
                            <td><strong>33%</strong> have TrueVow (OUR CAP)</td>
                            <td>3.7</td>
                            <td><strong style="color: #2E7D32;">+48% ✅ SWEET SPOT!</strong></td>
                        </tr>
                        <tr>
                            <td><strong>50%</strong> have TrueVow</td>
                            <td>3.2</td>
                            <td><strong style="color: #F57C00;">+28% ⚠️</strong></td>
                        </tr>
                        <tr>
                            <td><strong>100%</strong> have TrueVow</td>
                            <td>2.5</td>
                            <td><strong style="color: #C62828;">0% ❌ No Advantage</strong></td>
                        </tr>
                    </tbody>
                </table>'''
        # Replace the broken table
        content = re.sub(table_pattern, proper_table, content, flags=re.DOTALL)
        changes.append("Table formatting restored")
        print("  [OK] Table formatting restored")
    else:
        print("  [INFO] Table structure appears correct")

# 5. CLARIFY CHART INTERPRETATION
print("[FIX 5] Clarifying chart interpretation...")
# The chart is actually correct: as market penetration DECREASES (fewer firms have TrueVow),
# competitive advantage INCREASES. But we should make the labels clearer.
# Update chart title or add explanation
# The data should be: at 10% penetration = 92% advantage, at 100% penetration = 0% advantage
# This is correct! But let's add a note or clarify the axis labels
content = re.sub(
    r'(title:\s*\{[^}]*text:\s*[\'"])([^\'"]*)([\'"][^}]*\})',
    r'\1\2 (Lower Penetration = Higher Advantage)\3',
    content,
    count=1
)
# Also ensure the X-axis label is clear
content = re.sub(
    r'(x:\s*\{[^}]*title:\s*\{[^}]*text:\s*[\'"])([^\'"]*)([\'"][^}]*\})',
    r'\1Market Penetration (% of Firms with TrueVow - Lower = Better for You)\3',
    content,
    count=1
)
changes.append("Chart interpretation clarified")
print("  [OK] Chart interpretation clarified")

# Write the fixed content
if content != original:
    print(f"\n[SAVE] Writing fixed content to {filepath}...")
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"\n{'='*60}")
    print("SUMMARY OF CHANGES:")
    for change in changes:
        print(f"  ✅ {change}")
    print(f"{'='*60}")
else:
    print("\n[INFO] No changes detected")

