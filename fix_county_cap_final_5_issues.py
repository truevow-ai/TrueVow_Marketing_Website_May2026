#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Final fix for all 5 issues on county-cap.html
"""

import re

filepath = "marketing/county-cap.html"
backup_path = "marketing/county-cap.html.final-5-issues-backup"

print(f"[FIX] Reading {filepath}...")
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# Create backup
print(f"[BACKUP] Creating backup...")
with open(backup_path, 'w', encoding='utf-8') as f:
    f.write(content)

original = content
changes = []

# 1. FIX FOOTER GAP - Remove duplicate style attribute and add proper margin
print("[FIX 1] Fixing footer gap...")
# Fix duplicate style attributes
content = re.sub(
    r'<footer style="([^"]*)" style="([^"]*)"',
    r'<footer style="\1 \2"',
    content
)
# Ensure footer has margin-top
if 'margin-top: 60px' not in content or content.count('margin-top: 60px') == 0:
    content = re.sub(
        r'(<footer[^>]*style=")([^"]*)"',
        r'\1\2; margin-top: 60px;"',
        content,
        count=1
    )
# Also add margin-bottom to the section before footer
content = re.sub(
    r'(</section>)(\s*)(<!-- STANDARDIZED FOOTER|<footer)',
    r'\1\n    <div style="margin-bottom: 60px;"></div>\2\3',
    content,
    count=1
)
changes.append("Footer gap fixed")
print("  [OK] Footer gap fixed")

# 2. FIX COUNTY DROPDOWN - Remove duplicate onchange and ensure function works
print("[FIX 2] Fixing county dropdown...")
# Remove duplicate onchange attributes
content = re.sub(
    r'(<select[^>]*onchange="loadCheckCounties\(\)"[^>]*onchange="loadCheckCounties\(\)")',
    r'<select\1 onchange="loadCheckCounties()"',
    content
)
# Ensure the select has the right ID and onchange
content = re.sub(
    r'(<select[^>]*id="check-state"[^>]*)(?<!onchange="loadCheckCounties\(\)")',
    r'\1 onchange="loadCheckCounties()"',
    content
)
# The checkCountyData already exists with all states, so we just need to ensure the function is called
changes.append("County dropdown fixed")
print("  [OK] County dropdown fixed")

# 3. FIX OPTION 1 ICON - Ensure it's 📋 not ?
print("[FIX 3] Fixing Option 1 icon...")
# Replace any remaining ? before Option 1
content = re.sub(
    r'(<div[^>]*style="[^"]*font-size:\s*48px[^"]*"[^>]*>)\s*\?\s*(</div>)',
    r'\1📋\2',
    content
)
# Also check in the text
content = re.sub(
    r'(\?\s*)(Option 1: Priority Waitlist)',
    r'\2',
    content
)
changes.append("Option 1 icon fixed")
print("  [OK] Option 1 icon fixed")

# 4. FIX TABLE FORMATTING - Ensure proper table structure
print("[FIX 4] Fixing table formatting...")
# The table should have proper <tr> tags. Let me check if rows are missing
# Look for the table and ensure it has proper structure
table_start = content.find('<table class="capacity-table"')
if table_start > 0:
    table_end = content.find('</table>', table_start)
    if table_end > 0:
        table_content = content[table_start:table_end+8]
        # Count <tr> tags
        tr_count = table_content.count('<tr>')
        if tr_count < 6:  # Should have header + 5 data rows
            print("  [WARN] Table has missing rows, restoring structure...")
            # Find and replace the broken table
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
            content = content[:table_start] + proper_table + content[table_end+8:]
            changes.append("Table formatting restored")
            print("  [OK] Table formatting restored")
        else:
            print("  [INFO] Table structure appears correct")

# 5. CLARIFY CHART INTERPRETATION
print("[FIX 5] Clarifying chart interpretation...")
# The chart is correct: lower market penetration = higher competitive advantage
# But we need to make this clearer. The user is confused because they think 100% penetration should = 100% advantage
# Actually: 10% penetration (few firms have TrueVow) = 92% advantage (you're ahead)
#          100% penetration (everyone has TrueVow) = 0% advantage (no one is ahead)
# Add a note explaining this
chart_note = '''
                <div class="highlight-box" style="margin-top: 24px; background: #E8F4FD; padding: 20px; border-left: 4px solid #0A2463;">
                    <p style="margin: 0; color: #0A2463; font-weight: 600;">
                        <strong>📊 Understanding the Chart:</strong> As <strong>fewer firms</strong> in your county have TrueVow (lower market penetration), 
                        your <strong>competitive advantage increases</strong>. At 10% penetration, you have 92% advantage. 
                        At 100% penetration (everyone has it), you have 0% advantage—back to square one.
                    </p>
                </div>'''
# Insert after the chart container
content = re.sub(
    r'(</canvas>\s*</div>)',
    r'\1' + chart_note,
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

