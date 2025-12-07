#!/usr/bin/env python3
"""
Fix three issues:
1. Add equal padding above and below the cards section
2. Update hero headline with case count context
3. Convert profitability.html FAQ to green card format
"""

import re

# ============================================
# 1. FIX PRICING.HTML: CARDS SECTION PADDING
# ============================================
print("=" * 60)
print("FIX 1: Adding equal padding to cards section")
print("=" * 60)

with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    pricing_content = f.read()

# Find the cards section and ensure equal padding
# The section above has padding: 60px 24px, so we'll match that
cards_section_pattern = r'(<!-- PRACTICE AREAS & SETUP CARDS -->\s*<section style="padding: )(\d+px \d+px)(; background: white; color: #1A1A1A;">)'

if re.search(cards_section_pattern, pricing_content):
    # Ensure padding is 60px 24px (matching top section)
    pricing_content = re.sub(
        cards_section_pattern,
        r'\160px 24px\3',
        pricing_content
    )
    print("[OK] Cards section padding set to 60px 24px")
    
    # Also ensure the section below has proper spacing
    # The COMPARE section should have margin-top or the cards section should have margin-bottom
    # Let's add margin-bottom to cards section to create equal spacing
    cards_section_end_pattern = r'(</div>\s*</section>)\s*(<!-- ANCHOR)'
    if re.search(cards_section_end_pattern, pricing_content):
        pricing_content = re.sub(
            cards_section_end_pattern,
            r'\1\n    </section>\n    \2',
            pricing_content
        )
        # Now update the section to add margin-bottom
        pricing_content = re.sub(
            r'(<!-- PRACTICE AREAS & SETUP CARDS -->\s*<section style="padding: 60px 24px; background: white; color: #1A1A1A;">)',
            r'\1; margin-bottom: 60px;',
            pricing_content
        )
        print("[OK] Added margin-bottom to cards section for equal spacing")
else:
    print("[WARNING] Could not find cards section pattern")

# ============================================
# 2. FIX PRICING.HTML: HERO HEADLINE UPDATE
# ============================================
print("\n" + "=" * 60)
print("FIX 2: Updating hero headline with case count context")
print("=" * 60)

# Update headline
old_headline = r'Stop Losing \$5,150-\$20,600/Month in Missed Cases\. We Answer Every Call\.'
new_headline = 'Stop Losing ~$5,150 per Missed Case. We Answer Every Call.'

pricing_content = re.sub(old_headline, new_headline, pricing_content)
print(f"[OK] Updated headline: {new_headline}")

# Update recovery statement
old_recovery = r'Average firm may recover up to \$20,600/month in additional revenue'
new_recovery = 'Average firm may recover up to ~$20,600/month in additional revenue (3-4 cases/month)'

pricing_content = re.sub(old_recovery, new_recovery, pricing_content)
print(f"[OK] Updated recovery: {new_recovery}")

# Write pricing.html
with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(pricing_content)

print("\n[OK] pricing.html updated successfully")

# ============================================
# 3. FIX PROFITABILITY.HTML: FAQ TO GREEN CARDS
# ============================================
print("\n" + "=" * 60)
print("FIX 3: Converting FAQ to green card format")
print("=" * 60)

with open('marketing/profitability.html', 'r', encoding='utf-8') as f:
    profitability_content = f.read()

# Find the FAQ section
faq_section_pattern = r'(<section class="section" id="faq">.*?<h2>Frequently Asked Questions</h2>.*?<div style="max-width: 900px; margin: 24px auto;">)(.*?)(</div>.*?</section>)'

match = re.search(faq_section_pattern, profitability_content, re.DOTALL)
if match:
    faq_start = match.group(1)
    faq_items = match.group(2)
    faq_end = match.group(3)
    
    # Convert each FAQ item to green card format
    # Pattern: <div style="margin-bottom: 18px;"><strong>Question</strong><p>Answer</p></div>
    item_pattern = r'<div style="margin-bottom: 18px;">\s*<strong>(.*?)</strong>\s*<p>(.*?)</p>\s*</div>'
    
    def convert_to_card(m):
        question = m.group(1).strip()
        answer = m.group(2).strip()
        return f'''            <div class="faq-card" style="background: #F0FDF4; border-left: 4px solid #22C55E; border-radius: 12px; padding: 24px; margin-bottom: 20px; box-shadow: 0 4px 12px rgba(34,197,94,0.1);">
                <p style="font-size: 18px; color: #1A1A1A; margin: 0 0 12px 0; line-height: 1.6; font-weight: 700;">
                    <strong style="color: #166534;">{question}</strong>
                </p>
                <p style="font-size: 16px; color: #1A1A1A; margin: 0; line-height: 1.6;">
                    {answer}
                </p>
            </div>'''
    
    new_faq_items = re.sub(item_pattern, convert_to_card, faq_items, flags=re.DOTALL)
    
    # Update the section with new format
    new_faq_section = faq_start + '\n' + new_faq_items + '\n        ' + faq_end
    
    profitability_content = profitability_content.replace(match.group(0), new_faq_section)
    print("[OK] Converted FAQ items to green card format")
    
    # Update section padding for better spacing
    profitability_content = re.sub(
        r'(<section class="section" id="faq">)',
        r'\1\n        <div style="max-width: 1000px; margin: 0 auto; padding: 40px 24px;">',
        profitability_content
    )
    
    # Close the div before </section>
    profitability_content = re.sub(
        r'(</div>.*?</section>)',
        r'        </div>\n    \1',
        profitability_content,
        count=1
    )
    
    print("[OK] Updated FAQ section padding and container")
else:
    print("[WARNING] Could not find FAQ section pattern")

# Write profitability.html
with open('marketing/profitability.html', 'w', encoding='utf-8') as f:
    f.write(profitability_content)

print("\n[OK] profitability.html updated successfully")

print("\n" + "=" * 60)
print("ALL FIXES COMPLETE!")
print("=" * 60)
print("\nSummary:")
print("1. ✅ Cards section: Equal padding (60px) above and below")
print("2. ✅ Hero headline: 'Stop Losing ~$5,150 per Missed Case'")
print("3. ✅ Recovery statement: Added case count context (3-4 cases/month)")
print("4. ✅ FAQ section: Converted to green card format")


