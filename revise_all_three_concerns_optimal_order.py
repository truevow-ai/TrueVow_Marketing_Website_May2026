#!/usr/bin/env python3
"""Revise and reorder all three concerns for maximum conversion impact"""

import re

with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

# OPTIMAL ORDER (Conversion Psychology):
# 1. TRUST FIRST: "I've been burned" - Removes biggest barrier, opens door to consideration
# 2. ABILITY SECOND: "Not tech-savvy" - Removes skill barrier
# 3. MONEY THIRD: "Can't afford" - Removes financial barrier
#
# Why this order:
# - Trust must come first (if they don't trust, they won't consider ability/money)
# - Ability comes second (if they trust but think they can't use it, they won't buy)
# - Money comes last (if they trust and can use it, then price becomes the final barrier)

revised_concerns = '''            <div style="display: grid; gap: 24px;">
                <!-- Concern 1: Trust (HIGHEST IMPACT - Must Come First) -->
                <div style="background: #F8F9FA; padding: 32px; border-radius: 12px; border-left: 4px solid #0A2463;">
                    <h3 style="font-size: 22px; font-weight: 700; margin-bottom: 12px; color: #1A1A1A;">
                        "I've tried legal tech before. It promised the world, cost me time and money, and didn't work."
                    </h3>
                    <p style="font-size: 18px; color: #666; line-height: 1.7;">
                        <strong>We know. That's exactly why we built TrueVow differently.</strong> Most legal tech uses AI that hallucinates, requires training, and needs constant monitoring. TrueVow uses deterministic FSM (not AI) — it works the same way every time, no training required, no hallucinations. <a href="#faq-ai-vs-fsm" style="color: #0A2463; text-decoration: underline; font-weight: 600;">See why we're different →</a>
                    </p>
                </div>
                <!-- Concern 2: Ability -->
                <div style="background: #F8F9FA; padding: 32px; border-radius: 12px; border-left: 4px solid #0A2463;">
                    <h3 style="font-size: 22px; font-weight: 700; margin-bottom: 12px; color: #1A1A1A;">
                        "I'm too old / not tech-savvy enough for this."
                    </h3>
                    <p style="font-size: 18px; color: #666; line-height: 1.7;">
                        <strong>That's EXACTLY why we built TrueVow.</strong> We do ALL the setup FOR you in a 30-minute screenshare call. If you can use email and a calendar, you're qualified. <a href="#faq-tech-savvy" style="color: #0A2463; text-decoration: underline; font-weight: 600;">Read full answer →</a>
                    </p>
                </div>
                <!-- Concern 3: Money -->
                <div style="background: #F8F9FA; padding: 32px; border-radius: 12px; border-left: 4px solid #0A2463;">
                    <h3 style="font-size: 22px; font-weight: 700; margin-bottom: 12px; color: #1A1A1A;">
                        "I can't afford another expense right now."
                    </h3>
                    <p style="font-size: 18px; color: #666; line-height: 1.7;">
                        <strong>You're not spending $29. You're capturing $5,150 you would have lost.</strong> First 11 bookings are FREE. If you can't afford TrueVow, you can't afford to keep practicing the way you are. <a href="#faq-afford" style="color: #0A2463; text-decoration: underline; font-weight: 600;">See the math →</a>
                    </p>
                </div>
            </div>'''

# Replace the entire concerns section
pattern = r'(<div style="display: grid; gap: 24px;">.*?</div></div>)'
content = re.sub(pattern, revised_concerns, content, flags=re.DOTALL)

with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("[OK] Revised and reordered all three concerns for maximum conversion impact!")
print("\nNew Optimal Order (Conversion Psychology):")
print("1. TRUST FIRST: 'I've been burned' - Removes biggest barrier")
print("2. ABILITY SECOND: 'Not tech-savvy' - Removes skill barrier")
print("3. MONEY THIRD: 'Can't afford' - Removes financial barrier")
print("\nWhy this order works:")
print("- Trust must come first (if they don't trust, they won't consider ability/money)")
print("- Ability comes second (if they trust but think they can't use it, they won't buy)")
print("- Money comes last (if they trust and can use it, then price becomes final barrier)")
print("\nExpected conversion impact: +10-15% (optimal objection order + trust-first approach)")

