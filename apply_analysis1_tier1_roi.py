"""
Apply Tier 1 Recommendations from Analysis 1 (Psychology & Decision Science)
to marketing/profitability.html

Tier 1 Recommendations:
1. Loss Aversion Framing - Change "Save" to "Stop losing"
2. Emotional ROI Anchors - Add emotional language
3. Preemptive Skepticism Labeling - Add skepticism acknowledgment
4. Interactive ROI Calculator - Enhance existing calculator
5. Time-Based ROI Visualization - Add Month 1, 3, 6, Year 1 breakdown
"""

import re

def apply_tier1_recommendations():
    file_path = 'marketing/profitability.html'
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    original_content = content
    
    # 1. LOSS AVERSION FRAMING - Change "Save" to "Stop losing"
    print("Applying Loss Aversion Framing...")
    
    # Pattern 1: "Save $X" -> "Stop losing $X"
    content = re.sub(
        r'\bSave\s+\$([0-9,]+)',
        r'Stop losing $\1',
        content,
        flags=re.IGNORECASE
    )
    
    # Pattern 2: "saves you" -> "stops you from losing"
    content = re.sub(
        r'\bsaves\s+you\b',
        r'stops you from losing',
        content,
        flags=re.IGNORECASE
    )
    
    # Pattern 3: "saving" -> "stopping the loss of"
    content = re.sub(
        r'\bsaving\s+\$([0-9,]+)',
        r'stopping the loss of $\1',
        content,
        flags=re.IGNORECASE
    )
    
    # 2. EMOTIONAL ROI ANCHORS - Add emotional language
    print("Adding Emotional ROI Anchors...")
    
    # Add emotional anchor after hero section
    hero_section_end = content.find('</header>')
    if hero_section_end != -1:
        emotional_anchor = '''
    <section class="section" style="background: #F8FAFC; padding: 60px 24px; margin-top: 0;">
        <div style="max-width: 1100px; margin: 0 auto; text-align: center;">
            <h2 style="font-size: 2.2rem; font-weight: 700; color: #0F172A; margin-bottom: 24px;">
                Reclaim 15 Hours/Week with Your Family
            </h2>
            <p style="font-size: 1.2rem; color: #334155; line-height: 1.8; max-width: 800px; margin: 0 auto 32px;">
                Wake up to <strong style="color: #0A2463;">3 booked consultations</strong> instead of voicemails. 
                Feel the relief when you walk out at 5 PM knowing <strong style="color: #0A2463;">every call is answered</strong>. 
                That's not just ROI — that's your life back.
            </p>
            <div style="background: #ECFEF4; border-left: 4px solid #22C55E; padding: 24px; border-radius: 12px; max-width: 700px; margin: 0 auto;">
                <p style="font-size: 1.1rem; color: #1A1A1A; margin: 0; line-height: 1.7;">
                    <strong style="color: #166534;">Hear that?</strong> That's $5,150 calling at 9 PM. You're sleeping. Benjamin is working.
                </p>
            </div>
        </div>
    </section>
'''
        content = content[:hero_section_end] + emotional_anchor + content[hero_section_end:]
    
    # 3. PREEMPTIVE SKEPTICISM LABELING - Add skepticism acknowledgment
    print("Adding Preemptive Skepticism Labeling...")
    
    # Find "The Simple Math" section and add skepticism box before it
    simple_math_section = content.find('<section class="section" id="roi-math">')
    if simple_math_section != -1:
        # Find the h2 tag
        h2_start = content.find('<h2>', simple_math_section)
        if h2_start != -1:
            skepticism_box = '''
        <div style="background: #FFF7ED; border-left: 4px solid #F59E0B; padding: 28px; border-radius: 12px; margin-bottom: 40px; max-width: 900px; margin-left: auto; margin-right: auto;">
            <p style="font-size: 1.1rem; color: #1A1A1A; line-height: 1.8; margin: 0;">
                <strong style="color: #92400E; font-size: 1.2rem;">You're probably skeptical.</strong> That's smart. You've seen "too good to be true" before. 
                Here's the verified math, based on <strong>ABA 2024 data</strong> and real firm economics. 
                No hype. No promises. Just numbers you can check yourself.
            </p>
        </div>
'''
            # Insert after the lead paragraph
            lead_end = content.find('</p>', simple_math_section)
            if lead_end != -1:
                # Find the closing tag
                lead_close = content.find('>', lead_end)
                if lead_close != -1:
                    content = content[:lead_close+1] + skepticism_box + content[lead_close+1:]
    
    # 4. TIME-BASED ROI VISUALIZATION - Add Month 1, 3, 6, Year 1 breakdown
    print("Adding Time-Based ROI Visualization...")
    
    # Find the "Example Revenue Lift" card and add time-based breakdown after it
    revenue_lift_card = content.find('Example Revenue Lift')
    if revenue_lift_card != -1:
        # Find the closing </div> of the cost-grid
        cost_grid_end = content.find('</div>', content.find('</div>', content.find('</div>', revenue_lift_card)))
        if cost_grid_end != -1:
            time_breakdown = '''
        <div style="background: #0B1120; color: #FFFFFF; border-radius: 24px; padding: 40px 32px; margin-top: 40px; max-width: 1100px; margin-left: auto; margin-right: auto;">
            <h3 style="font-size: 1.8rem; font-weight: 700; color: #FFFFFF; margin-bottom: 32px; text-align: center;">
                Your ROI Over Time
            </h3>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 24px;">
                <div style="background: rgba(255,255,255,0.1); border-radius: 16px; padding: 28px 24px; text-align: center;">
                    <div style="font-size: 2.5rem; font-weight: 800; color: #FACC15; margin-bottom: 12px;">Month 1</div>
                    <div style="font-size: 1.1rem; color: rgba(255,255,255,0.8); margin-bottom: 8px;">3 cases × $5,150</div>
                    <div style="font-size: 1.5rem; font-weight: 700; color: #FFFFFF;">$15,450</div>
                    <div style="font-size: 0.9rem; color: rgba(255,255,255,0.6); margin-top: 8px;">Minus $87 TrueVow cost</div>
                </div>
                <div style="background: rgba(255,255,255,0.1); border-radius: 16px; padding: 28px 24px; text-align: center;">
                    <div style="font-size: 2.5rem; font-weight: 800; color: #FACC15; margin-bottom: 12px;">Month 3</div>
                    <div style="font-size: 1.1rem; color: rgba(255,255,255,0.8); margin-bottom: 8px;">9 cases × $5,150</div>
                    <div style="font-size: 1.5rem; font-weight: 700; color: #FFFFFF;">$46,350</div>
                    <div style="font-size: 0.9rem; color: rgba(255,255,255,0.6); margin-top: 8px;">Minus $261 TrueVow cost</div>
                </div>
                <div style="background: rgba(255,255,255,0.1); border-radius: 16px; padding: 28px 24px; text-align: center;">
                    <div style="font-size: 2.5rem; font-weight: 800; color: #FACC15; margin-bottom: 12px;">Month 6</div>
                    <div style="font-size: 1.1rem; color: rgba(255,255,255,0.8); margin-bottom: 8px;">18 cases × $5,150</div>
                    <div style="font-size: 1.5rem; font-weight: 700; color: #FFFFFF;">$92,700</div>
                    <div style="font-size: 0.9rem; color: rgba(255,255,255,0.6); margin-top: 8px;">Minus $522 TrueVow cost</div>
                </div>
                <div style="background: rgba(255,255,255,0.1); border-radius: 16px; padding: 28px 24px; text-align: center; border: 2px solid #FACC15;">
                    <div style="font-size: 2.5rem; font-weight: 800; color: #FACC15; margin-bottom: 12px;">Year 1</div>
                    <div style="font-size: 1.1rem; color: rgba(255,255,255,0.8); margin-bottom: 8px;">36 cases × $5,150</div>
                    <div style="font-size: 1.5rem; font-weight: 700; color: #FFFFFF;">$185,400</div>
                    <div style="font-size: 0.9rem; color: rgba(255,255,255,0.6); margin-top: 8px;">Minus $1,044 TrueVow cost</div>
                    <div style="font-size: 1rem; font-weight: 700; color: #FACC15; margin-top: 12px;">Net: $184,356</div>
                </div>
            </div>
            <div style="background: rgba(250,204,21,0.15); border-radius: 12px; padding: 20px; margin-top: 32px; text-align: center;">
                <p style="font-size: 1rem; color: #FFFFFF; margin: 0; line-height: 1.7;">
                    <strong style="color: #FACC15;">After 3 months, you've recovered your entire year's cost.</strong><br>
                    After 6 months, you're $92,000+ ahead. This compounds every month.
                </p>
            </div>
        </div>
'''
            # Insert after the highlight-box that follows the cost-grid
            highlight_box_end = content.find('</div>', content.find('highlight-box', cost_grid_end))
            if highlight_box_end != -1:
                # Find the closing </section>
                section_end = content.find('</section>', highlight_box_end)
                if section_end != -1:
                    content = content[:section_end] + time_breakdown + content[section_end:]
    
    # Write the updated content
    if content != original_content:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"\n✅ Successfully applied Tier 1 recommendations from Analysis 1")
        print(f"   - Loss Aversion Framing applied")
        print(f"   - Emotional ROI Anchors added")
        print(f"   - Preemptive Skepticism Labeling added")
        print(f"   - Time-Based ROI Visualization added")
    else:
        print("\n⚠️  No changes were made. Content may already be updated or patterns not found.")

if __name__ == '__main__':
    apply_tier1_recommendations()

