#!/usr/bin/env python3
"""
Convert "Works for" and "We handle setup" sections into card-style format
with parallax effect, styled like the green callout box example
"""

import re

with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Find the "Works for" section
works_for_pattern = r'(<!-- PRACTICE AREAS & SETUP -->\s*<section[^>]*>.*?<div[^>]*max-width: 900px[^>]*>.*?<p[^>]*>.*?<strong>Works for:</strong>)([^<]*)(</p>.*?<p[^>]*>.*?<strong>We handle setup FOR you</strong>)([^<]*)(</p>.*?</div>.*?</section>)'

if re.search(works_for_pattern, content, re.IGNORECASE | re.DOTALL):
    # Replace with card-style format
    new_section = '''    <!-- PRACTICE AREAS & SETUP CARDS -->
    <section style="padding: 60px 24px; background: white; color: #1A1A1A;">
        <div style="max-width: 1000px; margin: 0 auto; display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 24px;">
            <!-- Card 1: Works For -->
            <div class="practice-card" style="background: #F0FDF4; border-left: 4px solid #22C55E; border-radius: 12px; padding: 32px; box-shadow: 0 4px 12px rgba(34,197,94,0.1); transition: transform 0.3s ease, box-shadow 0.3s ease;">
                <p style="font-size: 18px; color: #1A1A1A; margin: 0; line-height: 1.6; font-weight: 600;">
                    <strong style="color: #166534;">Works for:</strong> PI, Family Law, Immigration, Criminal, Employment, Bankruptcy, Real Estate, Estate Planning, Workers' Comp
                </p>
            </div>
            
            <!-- Card 2: Setup Process -->
            <div class="practice-card" style="background: #F0FDF4; border-left: 4px solid #22C55E; border-radius: 12px; padding: 32px; box-shadow: 0 4px 12px rgba(34,197,94,0.1); transition: transform 0.3s ease, box-shadow 0.3s ease;">
                <p style="font-size: 18px; color: #1A1A1A; margin: 0; line-height: 1.6;">
                    <strong style="color: #166534;">We handle setup FOR you</strong> (30-minute call, no tech work required) • Live in 76 hours • 11 free bookings to test • Cancel anytime if it doesn't work
                </p>
            </div>
        </div>
    </section>'''
    
    content = re.sub(
        works_for_pattern,
        new_section,
        content,
        flags=re.IGNORECASE | re.DOTALL
    )
    print("[OK] Converted sections to card-style format")
else:
    # Try a simpler pattern - find the section by its comment
    simple_pattern = r'(<!-- PRACTICE AREAS & SETUP -->.*?</section>)'
    if re.search(simple_pattern, content, re.IGNORECASE | re.DOTALL):
        match = re.search(simple_pattern, content, re.IGNORECASE | re.DOTALL)
        old_section = match.group(0)
        
        new_section = '''    <!-- PRACTICE AREAS & SETUP CARDS -->
    <section style="padding: 60px 24px; background: white; color: #1A1A1A;">
        <div style="max-width: 1000px; margin: 0 auto; display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 24px;">
            <!-- Card 1: Works For -->
            <div class="practice-card" style="background: #F0FDF4; border-left: 4px solid #22C55E; border-radius: 12px; padding: 32px; box-shadow: 0 4px 12px rgba(34,197,94,0.1); transition: transform 0.3s ease, box-shadow 0.3s ease;">
                <p style="font-size: 18px; color: #1A1A1A; margin: 0; line-height: 1.6; font-weight: 600;">
                    <strong style="color: #166534;">Works for:</strong> PI, Family Law, Immigration, Criminal, Employment, Bankruptcy, Real Estate, Estate Planning, Workers' Comp
                </p>
            </div>
            
            <!-- Card 2: Setup Process -->
            <div class="practice-card" style="background: #F0FDF4; border-left: 4px solid #22C55E; border-radius: 12px; padding: 32px; box-shadow: 0 4px 12px rgba(34,197,94,0.1); transition: transform 0.3s ease, box-shadow 0.3s ease;">
                <p style="font-size: 18px; color: #1A1A1A; margin: 0; line-height: 1.6;">
                    <strong style="color: #166534;">We handle setup FOR you</strong> (30-minute call, no tech work required) • Live in 76 hours • 11 free bookings to test • Cancel anytime if it doesn't work
                </p>
            </div>
        </div>
    </section>'''
        
        content = content.replace(old_section, new_section)
        print("[OK] Converted sections to card-style format (simple pattern)")

# Add parallax effect CSS and JavaScript
# First, check if there's a style block to add CSS to
if '<style>' in content and '</style>' in content:
    parallax_css = '''
        /* Parallax effect for practice cards */
        .practice-card {
            will-change: transform;
        }
        
        @media (prefers-reduced-motion: no-preference) {
            .practice-card {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }
        }
    '''
    
    # Add before </style>
    content = content.replace('</style>', parallax_css + '\n    </style>', 1)
    print("[OK] Added parallax CSS")

# Add parallax JavaScript
parallax_js = '''
    <script>
        // Parallax effect for practice cards
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.practice-card');
            
            // Intersection Observer for scroll-triggered animations
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };
            
            const observer = new IntersectionObserver(function(entries) {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, observerOptions);
            
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                card.style.transition = 'opacity 0.6s ease ' + (index * 0.2) + 's, transform 0.6s ease ' + (index * 0.2) + 's';
                observer.observe(card);
            });
            
            // Hover effect for parallax-like lift
            cards.forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-8px)';
                    this.style.boxShadow = '0 8px 24px rgba(34,197,94,0.2)';
                });
                
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                    this.style.boxShadow = '0 4px 12px rgba(34,197,94,0.1)';
                });
            });
        });
    </script>
'''
    
# Add before </body> or before </script> if there are existing scripts
if '</body>' in content:
    content = content.replace('</body>', parallax_js + '\n</body>', 1)
elif '</script>' in content:
    # Add after the last script
    last_script = content.rfind('</script>')
    content = content[:last_script + 9] + '\n' + parallax_js + content[last_script + 9:]
else:
    content += parallax_js

print("[OK] Added parallax JavaScript")

# Write the file
with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("\n[OK] Card conversion with parallax effect complete!")
print("\nChanges made:")
print("1. Converted 'Works for' and 'We handle setup' into two side-by-side cards")
print("2. Styled cards with light green background (#F0FDF4) and green left border (#22C55E)")
print("3. Added parallax effect: cards fade in and slide up on scroll")
print("4. Added hover effect: cards lift slightly on hover")

