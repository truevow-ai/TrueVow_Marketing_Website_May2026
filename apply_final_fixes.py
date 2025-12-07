#!/usr/bin/env python3
"""Apply final fixes"""

# Fix 1: Add margin-bottom to cards section
with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Find the cards section (after PRACTICE AREAS comment)
old = '<section style="padding: 60px 24px; background: white; color: #1A1A1A;">'
new = '<section style="padding: 60px 24px; margin-bottom: 60px; background: white; color: #1A1A1A;">'

# Only replace if it's after the PRACTICE AREAS comment
if '<!-- PRACTICE AREAS & SETUP CARDS -->' in content:
    # Find position of comment
    comment_pos = content.find('<!-- PRACTICE AREAS & SETUP CARDS -->')
    # Find next section tag after comment
    section_pos = content.find(old, comment_pos)
    if section_pos != -1:
        content = content[:section_pos] + new + content[section_pos + len(old):]
        print("OK: Added margin-bottom to cards section")
    else:
        print("WARNING: Cards section not found after comment")
else:
    print("WARNING: PRACTICE AREAS comment not found")

with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

# Fix 2: Convert FAQ items to green cards
with open('marketing/profitability.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Replace each FAQ item
faq_items = [
    ('Do you replace my receptionist?', 'We replace unpredictability, not people. Many firms keep a receptionist for in-office tasks and client care, and let TrueVow handle every inbound lead 24/7.'),
    ('Do you use generative AI to make legal decisions?', 'No. Core intake relies on deterministic finite-state logic that your firm can review. Supporting ML is used for infrastructure tasks like speech-to-text, not for giving legal advice.'),
    ('What data is stored and for how long?', 'By default, we avoid long-term storage. Where retention is enabled, it operates within clearly defined windows and is designed to support QA and export, not model training.'),
    ('Can you prove ROI using our own funnel numbers?', 'Yes. We encourage firms to plug in their actual marketing and intake data. The whole point of TrueVow is to make your economics transparent enough to defend in a partner meeting.'),
    ('Is this only for personal injury practices?', 'No. While the example math often uses PI-style case values, the underlying intake engine is built to support multiple practice areas where missed calls and slow follow-up cost real money.')
]

# Build new FAQ HTML
new_faq_html = '''    <section class="section" id="faq">
        <h2>Frequently Asked Questions</h2>
        <div style="max-width: 1000px; margin: 0 auto; padding: 40px 24px;">'''

for question, answer in faq_items:
    new_faq_html += f'''
            <div class="faq-card" style="background: #F0FDF4; border-left: 4px solid #22C55E; border-radius: 12px; padding: 24px; margin-bottom: 20px; box-shadow: 0 4px 12px rgba(34,197,94,0.1);">
                <p style="font-size: 18px; color: #1A1A1A; margin: 0 0 12px 0; line-height: 1.6; font-weight: 700;">
                    <strong style="color: #166534;">{question}</strong>
                </p>
                <p style="font-size: 16px; color: #1A1A1A; margin: 0; line-height: 1.6;">
                    {answer}
                </p>
            </div>'''

new_faq_html += '''
        </div>
    </section>'''

# Find and replace FAQ section
import re
faq_pattern = r'<section class="section" id="faq">.*?</section>'
if re.search(faq_pattern, content, re.DOTALL):
    content = re.sub(faq_pattern, new_faq_html, content, flags=re.DOTALL)
    print("OK: Converted FAQ to green card format")
else:
    print("WARNING: FAQ section not found")

with open('marketing/profitability.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("\nAll fixes complete!")


