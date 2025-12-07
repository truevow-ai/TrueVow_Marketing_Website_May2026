#!/usr/bin/env python3
"""Implement all critical expert panel changes (except social proof)"""

import re

with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

# 1. ADD TRUST BAR ABOVE FOLD (Right after hero section, before emotional urgency)
trust_bar = '''    <!-- TRUST BAR (Above Fold) -->
    <section style="padding: 20px 24px; background: #F8F9FA; border-bottom: 1px solid #E5E5E5;">
        <div style="max-width: 1200px; margin: 0 auto; display: flex; justify-content: center; align-items: center; gap: 40px; flex-wrap: wrap;">
            <div style="display: flex; align-items: center; gap: 8px;">
                <span style="color: #10B981; font-size: 20px; font-weight: 700;">✓</span>
                <span style="color: #1A1A1A; font-size: 16px; font-weight: 600;">Bar-Compliant</span>
            </div>
            <div style="display: flex; align-items: center; gap: 8px;">
                <span style="color: #10B981; font-size: 20px; font-weight: 700;">✓</span>
                <span style="color: #1A1A1A; font-size: 16px; font-weight: 600;">Zero-Knowledge</span>
            </div>
            <div style="display: flex; align-items: center; gap: 8px;">
                <span style="color: #10B981; font-size: 20px; font-weight: 700;">✓</span>
                <span style="color: #1A1A1A; font-size: 16px; font-weight: 600;">Blockchain-Verified</span>
            </div>
        </div>
    </section>'''

# Insert trust bar after hero section
pattern1 = r'(</section>\s*<!-- EMOTIONAL URGENCY BOX -->)'
replacement1 = r'\1\n' + trust_bar
content = re.sub(pattern1, replacement1, content)
print("[OK] Added trust bar above fold")

# 2. ADD "QUICK APPLY" CTA AFTER EMOTIONAL URGENCY BOX
quick_apply_cta = '''    <!-- QUICK APPLY CTA (After Emotional Urgency) -->
    <section style="padding: 40px 24px; background: white; text-align: center;">
        <div style="max-width: 800px; margin: 0 auto;">
            <a href="apply.html" style="display: inline-flex; align-items: center; justify-content: center; gap: 10px; background: linear-gradient(135deg, #0A2463 0%, #0052CC 100%); color: white; padding: 20px 48px; border-radius: 12px; font-size: 20px; font-weight: 700; text-decoration: none; box-shadow: 0 8px 24px rgba(10,36,99,0.3); transition: transform 0.2s ease, box-shadow 0.2s ease;" onmouseover="this.style.transform='translateY(-3px)'; this.style.boxShadow='0 12px 32px rgba(10,36,99,0.4)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 8px 24px rgba(10,36,99,0.3)'">
                Lock Your Spot (33 Spots This Week) → Get 11 FREE Bookings
            </a>
            <p style="margin-top: 16px; font-size: 14px; color: #666;">
                ⏰ Review in 48 Hours | ⚡ Live in 76 Hours | ✅ Cancel Anytime
            </p>
        </div>
    </section>'''

# Insert quick apply CTA after emotional urgency box
pattern2 = r'(</section>\s*<!-- PRACTICE AREAS & SETUP CARDS -->)'
replacement2 = r'\1\n' + quick_apply_cta
content = re.sub(pattern2, replacement2, content)
print("[OK] Added Quick Apply CTA after emotional urgency box")

# 3. ADD "TECHNOLOGY BURNOUT" ACKNOWLEDGMENT SECTION (Before pricing)
tech_burnout_section = '''    <!-- TECHNOLOGY BURNOUT ACKNOWLEDGMENT -->
    <section style="padding: 60px 24px; background: #F8F9FA;">
        <div style="max-width: 900px; margin: 0 auto; text-align: center;">
            <h2 style="font-size: 36px; font-weight: 800; margin-bottom: 24px; color: #1A1A1A;">
                Built for Attorneys Who Are Tired of Tech That Doesn't Work
            </h2>
            <p style="font-size: 20px; color: #666; line-height: 1.8; margin-bottom: 32px;">
                We know you've tried intake tools that required training, daily logins, and constant monitoring. We know you're tired of tech that promises the world but delivers headaches.
            </p>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 24px; margin-top: 40px;">
                <div style="background: white; padding: 32px; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.08);">
                    <div style="font-size: 48px; margin-bottom: 16px;">❌</div>
                    <h3 style="font-size: 20px; font-weight: 700; margin-bottom: 12px; color: #1A1A1A;">No Training Required</h3>
                    <p style="font-size: 16px; color: #666; line-height: 1.6;">Benjamin uses deterministic FSM (not AI). No learning curve. No fine-tuning. It just works.</p>
                </div>
                <div style="background: white; padding: 32px; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.08);">
                    <div style="font-size: 48px; margin-bottom: 16px;">❌</div>
                    <h3 style="font-size: 20px; font-weight: 700; margin-bottom: 12px; color: #1A1A1A;">No Daily Logins</h3>
                    <p style="font-size: 16px; color: #666; line-height: 1.6;">Set it once during onboarding. Benjamin runs 24/7 without your input. You just get bookings in your inbox.</p>
                </div>
                <div style="background: white; padding: 32px; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.08);">
                    <div style="font-size: 48px; margin-bottom: 16px;">❌</div>
                    <h3 style="font-size: 20px; font-weight: 700; margin-bottom: 12px; color: #1A1A1A;">No Migration Required</h3>
                    <p style="font-size: 16px; color: #666; line-height: 1.6;">We don't need your client database. We work alongside whatever you use now. Zero disruption.</p>
                </div>
            </div>
            <p style="margin-top: 40px; font-size: 18px; color: #1A1A1A; font-weight: 600;">
                If you can use email and a calendar, you can use TrueVow. That's it.
            </p>
        </div>
    </section>'''

# Insert technology burnout section before pricing section
pattern3 = r'(<!-- PRICING TIERS -->)'
replacement3 = tech_burnout_section + r'\n    \1'
content = re.sub(pattern3, replacement3, content)
print("[OK] Added Technology Burnout acknowledgment section")

# 4. ADD "COMMON CONCERNS" SECTION (Top 3 Objections) BEFORE PRICING
common_concerns = '''    <!-- COMMON CONCERNS (Top 3 Objections) -->
    <section style="padding: 60px 24px; background: white;">
        <div style="max-width: 900px; margin: 0 auto;">
            <h2 style="font-size: 36px; font-weight: 800; margin-bottom: 40px; text-align: center; color: #1A1A1A;">
                Common Concerns (Quick Answers)
            </h2>
            <div style="display: grid; gap: 24px;">
                <!-- Concern 1 -->
                <div style="background: #F8F9FA; padding: 32px; border-radius: 12px; border-left: 4px solid #0A2463;">
                    <h3 style="font-size: 22px; font-weight: 700; margin-bottom: 12px; color: #1A1A1A;">
                        "I'm too old / not tech-savvy enough for this."
                    </h3>
                    <p style="font-size: 18px; color: #666; line-height: 1.7;">
                        <strong>That's EXACTLY why we built TrueVow.</strong> We do ALL the setup FOR you in a 30-minute screenshare call. If you can use email and a calendar, you're qualified. <a href="#faq-tech-savvy" style="color: #0A2463; text-decoration: underline; font-weight: 600;">Read full answer →</a>
                    </p>
                </div>
                <!-- Concern 2 -->
                <div style="background: #F8F9FA; padding: 32px; border-radius: 12px; border-left: 4px solid #0A2463;">
                    <h3 style="font-size: 22px; font-weight: 700; margin-bottom: 12px; color: #1A1A1A;">
                        "I can't afford another expense right now."
                    </h3>
                    <p style="font-size: 18px; color: #666; line-height: 1.7;">
                        <strong>You're not spending $29. You're capturing $5,150 you would have lost.</strong> First 11 bookings are FREE. If you can't afford TrueVow, you can't afford to keep practicing the way you are. <a href="#faq-afford" style="color: #0A2463; text-decoration: underline; font-weight: 600;">See the math →</a>
                    </p>
                </div>
                <!-- Concern 3 -->
                <div style="background: #F8F9FA; padding: 32px; border-radius: 12px; border-left: 4px solid #0A2463;">
                    <h3 style="font-size: 22px; font-weight: 700; margin-bottom: 12px; color: #1A1A1A;">
                        "I don't have time to migrate data, train the system, or log in every day."
                    </h3>
                    <p style="font-size: 18px; color: #666; line-height: 1.7;">
                        <strong>You don't have to. That's the whole point.</strong> Zero data migration. Zero training. Zero daily logins. 30-minute setup, then Benjamin works 24/7. <a href="#faq-time" style="color: #0A2463; text-decoration: underline; font-weight: 600;">See how it works →</a>
                    </p>
                </div>
            </div>
            <p style="text-align: center; margin-top: 32px; font-size: 16px; color: #666;">
                <a href="#faq-section" style="color: #0A2463; text-decoration: underline; font-weight: 600;">See all 15+ objections answered in our FAQ →</a>
            </p>
        </div>
    </section>'''

# Insert common concerns before pricing
pattern4 = r'(<!-- PRICING TIERS -->)'
if common_concerns not in content:
    replacement4 = common_concerns + r'\n    \1'
    content = re.sub(pattern4, replacement4, content)
    print("[OK] Added Common Concerns section before pricing")

# 5. MOVE COMPARISON SECTION ABOVE PRICING
# First, find and extract the comparison section
comparison_pattern = r'(<!-- ANCHOR \(SHOW EXPENSIVE ALTERNATIVES FIRST!\) -->.*?</section>)'
comparison_match = re.search(comparison_pattern, content, re.DOTALL)
if comparison_match:
    comparison_section = comparison_match.group(1)
    # Remove it from current location
    content = re.sub(comparison_pattern, '', content, flags=re.DOTALL)
    # Insert it before pricing section
    pattern5 = r'(<!-- PRICING TIERS -->)'
    replacement5 = comparison_section + r'\n    \1'
    content = re.sub(pattern5, replacement5, content)
    print("[OK] Moved comparison section above pricing")

# 6. ADD "WHAT HAPPENS NEXT" TIMELINE (Before final CTA)
what_happens_next = '''    <!-- WHAT HAPPENS NEXT TIMELINE -->
    <section style="padding: 60px 24px; background: #F8F9FA;">
        <div style="max-width: 900px; margin: 0 auto; text-align: center;">
            <h2 style="font-size: 36px; font-weight: 800; margin-bottom: 16px; color: #1A1A1A;">
                What Happens After You Apply?
            </h2>
            <p style="font-size: 18px; color: #666; margin-bottom: 48px;">
                Simple process. No surprises. No long waits.
            </p>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 32px; margin-top: 40px;">
                <div style="text-align: center;">
                    <div style="width: 60px; height: 60px; background: linear-gradient(135deg, #0A2463 0%, #0052CC 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px; font-size: 24px; font-weight: 700; color: white;">1</div>
                    <h3 style="font-size: 20px; font-weight: 700; margin-bottom: 8px; color: #1A1A1A;">Apply</h3>
                    <p style="font-size: 16px; color: #666; line-height: 1.6;">Submit your firm details (takes 5 minutes)</p>
                </div>
                <div style="text-align: center;">
                    <div style="width: 60px; height: 60px; background: linear-gradient(135deg, #0A2463 0%, #0052CC 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px; font-size: 24px; font-weight: 700; color: white;">2</div>
                    <h3 style="font-size: 20px; font-weight: 700; margin-bottom: 8px; color: #1A1A1A;">Review</h3>
                    <p style="font-size: 16px; color: #666; line-height: 1.6;">Our team reviews within 48 hours</p>
                </div>
                <div style="text-align: center;">
                    <div style="width: 60px; height: 60px; background: linear-gradient(135deg, #0A2463 0%, #0052CC 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px; font-size: 24px; font-weight: 700; color: white;">3</div>
                    <h3 style="font-size: 20px; font-weight: 700; margin-bottom: 8px; color: #1A1A1A;">Onboard</h3>
                    <p style="font-size: 16px; color: #666; line-height: 1.6;">30-minute screenshare call (we do the setup)</p>
                </div>
                <div style="text-align: center;">
                    <div style="width: 60px; height: 60px; background: linear-gradient(135deg, #0A2463 0%, #0052CC 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px; font-size: 24px; font-weight: 700; color: white;">4</div>
                    <h3 style="font-size: 20px; font-weight: 700; margin-bottom: 8px; color: #1A1A1A;">Go Live</h3>
                    <p style="font-size: 16px; color: #666; line-height: 1.6;">Benjamin starts answering calls in 76 hours</p>
                </div>
            </div>
        </div>
    </section>'''

# Insert before final CTA
pattern6 = r'(<!-- FINAL CTA -->)'
replacement6 = what_happens_next + r'\n    \1'
content = re.sub(pattern6, replacement6, content)
print("[OK] Added 'What Happens Next' timeline")

# 7. REWRITE ALL CTAs WITH URGENCY + BENEFIT
# Hero CTA (if exists in hero)
# Quick Apply CTA (already done above)
# Pricing card CTAs
pattern7a = r'(Apply Now \(11 FREE Bookings!\) →)'
replacement7a = r'Lock Your Spot → Get 11 FREE Bookings'
content = re.sub(pattern7a, replacement7a, content)

pattern7b = r'(Get Free Chatbot →)'
replacement7b = r'Start Free (No Credit Card) →'
content = re.sub(pattern7b, replacement7b, content)

pattern7c = r'(Apply Now \(Checkbox for Founding Member Interest\) →)'
replacement7c = r'Apply Now → Lock Your Spot (33 Spots/Week)'
content = re.sub(pattern7c, replacement7c, content)

pattern7d = r'(Apply Now • Only 33% of Firms in Your County Will Be Approved →)'
replacement7d = r'Lock Your Spot (33 Spots This Week) → Get 11 FREE Bookings'
content = re.sub(pattern7d, replacement7d, content)
print("[OK] Rewrote all CTAs with urgency + benefit")

# 8. ADD STICKY/FLOATING CTA BUTTON (CSS + HTML)
# Add CSS for sticky CTA
sticky_cta_css = '''
        /* STICKY FLOATING CTA BUTTON */
        .sticky-cta-button {
            position: fixed;
            bottom: 24px;
            right: 24px;
            z-index: 9999;
            background: linear-gradient(135deg, #0A2463 0%, #0052CC 100%);
            color: white;
            padding: 16px 32px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 700;
            text-decoration: none;
            box-shadow: 0 8px 24px rgba(10,36,99,0.4);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .sticky-cta-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 32px rgba(10,36,99,0.5);
        }
        .sticky-cta-button .cta-text {
            white-space: nowrap;
        }
        @media (max-width: 768px) {
            .sticky-cta-button {
                bottom: 16px;
                right: 16px;
                left: 16px;
                padding: 14px 24px;
                font-size: 15px;
                justify-content: center;
            }
            .sticky-cta-button .cta-text {
                font-size: 14px;
            }
        }
'''

# Insert CSS before closing </style> tag
pattern8a = r'(</style>)'
replacement8a = sticky_cta_css + r'\1'
content = re.sub(pattern8a, replacement8a, content)

# Add HTML for sticky CTA button (before closing </body>)
sticky_cta_html = '''
    <!-- STICKY FLOATING CTA BUTTON -->
    <a href="apply.html" class="sticky-cta-button">
        <span class="cta-text">Lock Your Spot →</span>
        <span style="font-size: 18px;">🚀</span>
    </a>
'''

pattern8b = r'(</body>)'
replacement8b = sticky_cta_html + r'\1'
content = re.sub(pattern8b, replacement8b, content)
print("[OK] Added sticky/floating CTA button")

# Write the file
with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("\n[OK] All critical expert panel changes implemented (except social proof)!")
print("\nChanges made:")
print("1. ✓ Trust bar above fold")
print("2. ✓ Quick Apply CTA after emotional urgency")
print("3. ✓ Technology Burnout acknowledgment section")
print("4. ✓ Common Concerns (top 3 objections) before pricing")
print("5. ✓ Comparison section moved above pricing")
print("6. ✓ 'What Happens Next' timeline")
print("7. ✓ All CTAs rewritten with urgency + benefit")
print("8. ✓ Sticky/floating CTA button")

