#!/usr/bin/env python3
"""
Final precise fixes for both files
"""

import re

# ============================================
# 1. ADD MARGIN-BOTTOM TO CARDS SECTION (pricing.html)
# ============================================
print("FIX 1: Adding margin-bottom to cards section...")

with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Find section with padding: 60px 24px and background: white and color: #1A1A1A
# This should be the cards section
pattern = r'(<section style="padding: 60px 24px; background: white; color: #1A1A1A;">)'
replacement = r'<section style="padding: 60px 24px; margin-bottom: 60px; background: white; color: #1A1A1A;">'

# But we need to make sure it's the cards section, not another section
# Look for the comment before it
if '<!-- PRACTICE AREAS & SETUP CARDS -->' in content:
    # Find the section right after this comment
    cards_pattern = r'(<!-- PRACTICE AREAS & SETUP CARDS -->\s*<section style="padding: 60px 24px; background: white; color: #1A1A1A;">)'
    cards_replacement = r'<!-- PRACTICE AREAS & SETUP CARDS -->\n    <section style="padding: 60px 24px; margin-bottom: 60px; background: white; color: #1A1A1A;">'
    
    if re.search(cards_pattern, content):
        content = re.sub(cards_pattern, cards_replacement, content)
        print("[OK] Added margin-bottom: 60px to cards section")
    else:
        # Try without the comment
        if re.search(pattern, content):
            content = re.sub(pattern, replacement, content, count=1)  # Only replace first occurrence
            print("[OK] Added margin-bottom: 60px to cards section (without comment)")
        else:
            print("[WARNING] Cards section pattern not found")
else:
    print("[WARNING] Cards section comment not found")

with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

# ============================================
# 2. CONVERT FAQ TO GREEN CARDS (profitability.html)
# ============================================
print("\nFIX 2: Converting FAQ to green card format...")

with open('marketing/profitability.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Replace FAQ section
old_faq = '''    <section class="section" id="faq">
        <h2>Frequently Asked Questions</h2>
        <div style="max-width: 900px; margin: 24px auto;">
            <div style="margin-bottom: 18px;">
                <strong>Do you replace my receptionist?</strong>
                <p>We replace unpredictability, not people. Many firms keep a receptionist for in-office tasks and client care, and let TrueVow handle every inbound lead 24/7.</p>
            </div>
            <div style="margin-bottom: 18px;">
                <strong>Do you use generative AI to make legal decisions?</strong>
                <p>No. Core intake relies on deterministic finite-state logic that your firm can review. Supporting ML is used for infrastructure tasks like speech-to-text, not for giving legal advice.</p>
            </div>
            <div style="margin-bottom: 18px;">
                <strong>What data is stored and for how long?</strong>
                <p>By default, we avoid long-term storage. Where retention is enabled, it operates within clearly defined windows and is designed to support QA and export, not model training.</p>
            </div>
            <div style="margin-bottom: 18px;">
                <strong>Can you prove ROI using our own funnel numbers?</strong>
                <p>Yes. We encourage firms to plug in their actual marketing and intake data. The whole point of TrueVow is to make your economics transparent enough to defend in a partner meeting.</p>
            </div>
            <div style="margin-bottom: 18px;">
                <strong>Is this only for personal injury practices?</strong>
                <p>No. While the example math often uses PI-style case values, the underlying intake engine is built to support multiple practice areas where missed calls and slow follow-up cost real money.</p>
            </div>
        </div>
    </section>'''

new_faq = '''    <section class="section" id="faq">
        <h2>Frequently Asked Questions</h2>
        <div style="max-width: 1000px; margin: 0 auto; padding: 40px 24px;">
            <div class="faq-card" style="background: #F0FDF4; border-left: 4px solid #22C55E; border-radius: 12px; padding: 24px; margin-bottom: 20px; box-shadow: 0 4px 12px rgba(34,197,94,0.1);">
                <p style="font-size: 18px; color: #1A1A1A; margin: 0 0 12px 0; line-height: 1.6; font-weight: 700;">
                    <strong style="color: #166534;">Do you replace my receptionist?</strong>
                </p>
                <p style="font-size: 16px; color: #1A1A1A; margin: 0; line-height: 1.6;">
                    We replace unpredictability, not people. Many firms keep a receptionist for in-office tasks and client care, and let TrueVow handle every inbound lead 24/7.
                </p>
            </div>
            <div class="faq-card" style="background: #F0FDF4; border-left: 4px solid #22C55E; border-radius: 12px; padding: 24px; margin-bottom: 20px; box-shadow: 0 4px 12px rgba(34,197,94,0.1);">
                <p style="font-size: 18px; color: #1A1A1A; margin: 0 0 12px 0; line-height: 1.6; font-weight: 700;">
                    <strong style="color: #166534;">Do you use generative AI to make legal decisions?</strong>
                </p>
                <p style="font-size: 16px; color: #1A1A1A; margin: 0; line-height: 1.6;">
                    No. Core intake relies on deterministic finite-state logic that your firm can review. Supporting ML is used for infrastructure tasks like speech-to-text, not for giving legal advice.
                </p>
            </div>
            <div class="faq-card" style="background: #F0FDF4; border-left: 4px solid #22C55E; border-radius: 12px; padding: 24px; margin-bottom: 20px; box-shadow: 0 4px 12px rgba(34,197,94,0.1);">
                <p style="font-size: 18px; color: #1A1A1A; margin: 0 0 12px 0; line-height: 1.6; font-weight: 700;">
                    <strong style="color: #166534;">What data is stored and for how long?</strong>
                </p>
                <p style="font-size: 16px; color: #1A1A1A; margin: 0; line-height: 1.6;">
                    By default, we avoid long-term storage. Where retention is enabled, it operates within clearly defined windows and is designed to support QA and export, not model training.
                </p>
            </div>
            <div class="faq-card" style="background: #F0FDF4; border-left: 4px solid #22C55E; border-radius: 12px; padding: 24px; margin-bottom: 20px; box-shadow: 0 4px 12px rgba(34,197,94,0.1);">
                <p style="font-size: 18px; color: #1A1A1A; margin: 0 0 12px 0; line-height: 1.6; font-weight: 700;">
                    <strong style="color: #166534;">Can you prove ROI using our own funnel numbers?</strong>
                </p>
                <p style="font-size: 16px; color: #1A1A1A; margin: 0; line-height: 1.6;">
                    Yes. We encourage firms to plug in their actual marketing and intake data. The whole point of TrueVow is to make your economics transparent enough to defend in a partner meeting.
                </p>
            </div>
            <div class="faq-card" style="background: #F0FDF4; border-left: 4px solid #22C55E; border-radius: 12px; padding: 24px; margin-bottom: 20px; box-shadow: 0 4px 12px rgba(34,197,94,0.1);">
                <p style="font-size: 18px; color: #1A1A1A; margin: 0 0 12px 0; line-height: 1.6; font-weight: 700;">
                    <strong style="color: #166534;">Is this only for personal injury practices?</strong>
                </p>
                <p style="font-size: 16px; color: #1A1A1A; margin: 0; line-height: 1.6;">
                    No. While the example math often uses PI-style case values, the underlying intake engine is built to support multiple practice areas where missed calls and slow follow-up cost real money.
                </p>
            </div>
        </div>
    </section>'''

if old_faq in content:
    content = content.replace(old_faq, new_faq)
    print("[OK] Converted FAQ to green card format")
else:
    # Try with regex to handle whitespace variations
    old_faq_pattern = r'<section class="section" id="faq">.*?Frequently Asked Questions.*?</section>'
    if re.search(old_faq_pattern, content, re.DOTALL):
        # Extract and replace more carefully
        match = re.search(r'(<section class="section" id="faq">.*?</section>)', content, re.DOTALL)
        if match and 'Do you replace my receptionist' in match.group(0):
            content = content.replace(match.group(0), new_faq)
            print("[OK] Converted FAQ to green card format (regex)")
        else:
            print("[WARNING] FAQ section found but content doesn't match")
    else:
        print("[WARNING] FAQ section not found")

with open('marketing/profitability.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("\n[OK] All fixes complete!")


