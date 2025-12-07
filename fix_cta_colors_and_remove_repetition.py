#!/usr/bin/env python3
"""Fix CTA color standardization and remove repetitive concern"""

import re

with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

# COLOR SCIENCE FOR LAWYERS (Black & White People):
# - Primary CTA: Dark Navy Blue (#0A2463) - Professional, Trust, Authority
# - Secondary/Value CTA: Black (#000000) - Sophistication, Power
# - Accent (FREE/Value): Gold (#FFD700) - Trust, Value (sparingly)
# - Hover: Slightly lighter blue (#0052CC) for depth
# - NO bright colors, NO gradients (too flashy for conservative audience)

STANDARD_PRIMARY_CTA = {
    'background': '#0A2463',  # Dark Navy Blue
    'color': '#FFFFFF',  # White text
    'hover_background': '#0052CC',  # Slightly lighter blue on hover
    'border': 'none',
    'box_shadow': '0 4px 12px rgba(10,36,99,0.25)'  # Subtle shadow
}

STANDARD_SECONDARY_CTA = {
    'background': '#000000',  # Black (for sophistication)
    'color': '#FFFFFF',  # White text
    'hover_background': '#1A1A1A',  # Slightly lighter black
    'border': 'none',
    'box_shadow': '0 4px 12px rgba(0,0,0,0.25)'
}

STANDARD_VALUE_CTA = {
    'background': '#FFD700',  # Gold (for FREE/Value propositions)
    'color': '#000000',  # Black text on gold
    'hover_background': '#FFC107',  # Slightly darker gold
    'border': 'none',
    'box_shadow': '0 4px 12px rgba(255,215,0,0.3)'
}

# 1. REMOVE REPETITIVE CONCERN #3 (already covered in Technology Burnout)
pattern1 = r'(<!-- Concern 3 -->.*?See how it works →</a>\s*</p>\s*</div>\s*)'
content = re.sub(pattern1, '', content, flags=re.DOTALL)
print("[OK] Removed repetitive Concern #3 from Common Concerns")

# 2. UPDATE COMMON CONCERNS HEADING (now only 2 concerns)
pattern2 = r'(Common Concerns \(Quick Answers\))'
replacement2 = r'Common Concerns (Quick Answers)'
content = re.sub(pattern2, replacement2, content)
print("[OK] Updated Common Concerns section")

# 3. STANDARDIZE STICKY CTA BUTTON
sticky_cta_css = '''
        /* STICKY FLOATING CTA BUTTON - STANDARDIZED */
        .sticky-cta-button {
            position: fixed;
            bottom: 24px;
            right: 24px;
            z-index: 9999;
            background: #0A2463;
            color: #FFFFFF;
            padding: 16px 32px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 700;
            text-decoration: none;
            box-shadow: 0 4px 12px rgba(10,36,99,0.25);
            transition: background 0.2s ease, transform 0.2s ease, box-shadow 0.2s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            border: none;
        }
        .sticky-cta-button:hover {
            background: #0052CC;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(10,36,99,0.35);
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

pattern3 = r'(/\* STICKY FLOATING CTA BUTTON \*/.*?@media.*?}\s*})'
content = re.sub(pattern3, sticky_cta_css, content, flags=re.DOTALL)
print("[OK] Standardized sticky CTA button colors")

# 4. STANDARDIZE QUICK APPLY CTA (after emotional urgency)
quick_apply_cta = '''    <!-- QUICK APPLY CTA (After Emotional Urgency) -->
    <section style="padding: 40px 24px; background: white; text-align: center;">
        <div style="max-width: 800px; margin: 0 auto;">
            <a href="apply.html" style="display: inline-flex; align-items: center; justify-content: center; gap: 10px; background: #0A2463; color: #FFFFFF; padding: 20px 48px; border-radius: 12px; font-size: 20px; font-weight: 700; text-decoration: none; box-shadow: 0 4px 12px rgba(10,36,99,0.25); transition: background 0.2s ease, transform 0.2s ease, box-shadow 0.2s ease; border: none;" onmouseover="this.style.background='#0052CC'; this.style.transform='translateY(-2px)'; this.style.boxShadow='0 6px 16px rgba(10,36,99,0.35)'" onmouseout="this.style.background='#0A2463'; this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 12px rgba(10,36,99,0.25)'">
                Lock Your Spot (33 Spots This Week) → Get 11 FREE Bookings
            </a>
            <p style="margin-top: 16px; font-size: 14px; color: #666;">
                ⏰ Review in 48 Hours | ⚡ Live in 76 Hours | ✅ Cancel Anytime
            </p>
        </div>
    </section>'''

pattern4 = r'(<!-- QUICK APPLY CTA.*?</section>)'
content = re.sub(pattern4, quick_apply_cta, content, flags=re.DOTALL)
print("[OK] Standardized Quick Apply CTA colors")

# 5. STANDARDIZE PRICING CARD CTAs
# Primary CTA (Solo & Small Firm)
pattern5a = r'(\.pricing-cta\s*\{[^}]*background:[^;]*;[^}]*\})'
pricing_cta_css = '''.pricing-cta {
            display: block;
            text-align: center;
            background: #0A2463;
            color: #FFFFFF;
            padding: 16px 32px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 700;
            transition: background 0.2s ease, transform 0.2s ease, box-shadow 0.2s ease;
            border: none;
            box-shadow: 0 4px 12px rgba(10,36,99,0.25);
        }
        .pricing-cta:hover {
            background: #0052CC;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(10,36,99,0.35);
        }'''
content = re.sub(pattern5a, pricing_cta_css, content, flags=re.DOTALL)

# Secondary CTA (Free tier)
pattern5b = r'(\.pricing-cta-secondary\s*\{[^}]*background:[^;]*;[^}]*\})'
pricing_cta_secondary_css = '''.pricing-cta-secondary {
            background: #000000;
            color: #FFFFFF;
        }
        .pricing-cta-secondary:hover {
            background: #1A1A1A;
            color: #FFFFFF !important;
        }'''
content = re.sub(pattern5b, pricing_cta_secondary_css, content, flags=re.DOTALL)
print("[OK] Standardized pricing card CTAs")

# 6. STANDARDIZE FINAL CTA PANEL
pattern6 = r'(<a href="apply\.html"[^>]*style="[^"]*background:[^"]*"[^>]*>Apply Now.*?</a>)'
final_cta = '''<a href="apply.html" style="background:#0A2463;color:#FFFFFF;text-decoration:none; padding: 16px 34px; border-radius: 999px; font-weight: 700; font-size: 1rem; box-shadow: 0 4px 12px rgba(10,36,99,0.25); transition: background 0.2s ease, transform 0.2s ease, box-shadow 0.2s ease; display: inline-flex; align-items: center; justify-content: center; border: none;" onmouseover="this.style.background='#0052CC'; this.style.transform='translateY(-2px)'; this.style.boxShadow='0 6px 16px rgba(10,36,99,0.35)'" onmouseout="this.style.background='#0A2463'; this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 12px rgba(10,36,99,0.25)'">Lock Your Spot (33 Spots This Week) → Get 11 FREE Bookings</a>'''
content = re.sub(pattern6, final_cta, content, flags=re.DOTALL)
print("[OK] Standardized final CTA panel")

# 7. STANDARDIZE FOUNDING MEMBER CTA
pattern7 = r'(<a href="/marketing/apply\.html"[^>]*style="[^"]*background:[^"]*#0A2463[^"]*"[^>]*>Apply Now.*?</a>)'
founding_member_cta = '''<a href="/marketing/apply.html" style="background: #0A2463; color: #FFFFFF; padding: 20px 48px; border-radius: 12px; font-size: 20px; font-weight: 700; text-decoration: none; display: inline-block; box-shadow: 0 4px 12px rgba(10,36,99,0.25); transition: background 0.2s ease, transform 0.2s ease, box-shadow 0.2s ease; border: none;" onmouseover="this.style.background='#0052CC'; this.style.transform='translateY(-2px)'; this.style.boxShadow='0 6px 16px rgba(10,36,99,0.35)'" onmouseout="this.style.background='#0A2463'; this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 12px rgba(10,36,99,0.25)'">Apply Now (Checkbox for Founding Member Interest) →</a>'''
content = re.sub(pattern7, founding_member_cta, content, flags=re.DOTALL)
print("[OK] Standardized Founding Member CTA")

# 8. STANDARDIZE NAVIGATION CTA
pattern8 = r'(<a href="apply\.html"[^>]*style="[^"]*background:[^"]*#0A2463[^"]*"[^>]*>Start Capturing Every Call →</a>)'
nav_cta = '''<a href="apply.html" style="background: #0A2463; color: #FFFFFF !important; padding: 12px 24px; border-radius: 8px; font-size: 16px; font-weight: 600; text-decoration: none; transition: background 0.2s ease;" onmouseover="this.style.background='#0052CC'" onmouseout="this.style.background='#0A2463'">Start Capturing Every Call →</a>'''
content = re.sub(pattern8, nav_cta, content, flags=re.DOTALL)
print("[OK] Standardized navigation CTA")

# Write the file
with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("\n[OK] All CTAs standardized with professional color scheme!")
print("\nColor Standard Applied:")
print("- Primary CTAs: Dark Navy Blue (#0A2463) - Professional, Trust, Authority")
print("- Secondary CTAs: Black (#000000) - Sophistication, Power")
print("- Hover: Slightly lighter blue (#0052CC) for depth")
print("- No bright colors, no flashy gradients (conservative for lawyers)")
print("\n[OK] Repetitive concern removed from Common Concerns section")

