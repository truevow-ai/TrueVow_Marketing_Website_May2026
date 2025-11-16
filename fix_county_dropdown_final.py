#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Final fix for county dropdown - ensure function loads and works
"""

import re

filepath = "marketing/county-cap.html"
backup_path = "marketing/county-cap.html.county-final-fix-backup"

print(f"[FIX] Reading {filepath}...")
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# Create backup
print(f"[BACKUP] Creating backup...")
with open(backup_path, 'w', encoding='utf-8') as f:
    f.write(content)

original = content
changes = []

# The issue: The script might have syntax errors preventing it from loading
# Solution: Move the critical function to a separate script block BEFORE the main script
# This ensures it loads even if the main script has errors

# Find where the CTA section ends (before the JavaScript section)
cta_end_pattern = r'(</section>\s*<!-- JAVASCRIPT -->)'
if re.search(cta_end_pattern, content):
    # Insert a separate script block with just the essential functions BEFORE the main script
    essential_script = '''
    <!-- ESSENTIAL FUNCTIONS - Load First -->
    <script>
    // Ensure these functions are available immediately
    window.loadCheckCounties = function() {
        try {
            console.log("loadCheckCounties called");
            const stateEl = document.getElementById('check-state');
            const countyEl = document.getElementById('check-county');
            const resultEl = document.getElementById('availabilityResult');
            
            if (!stateEl || !countyEl || !resultEl) {
                console.error("Required elements not found");
                return;
            }
            
            const state = stateEl.value;
            console.log("State selected:", state);
            
            // Hide previous result
            resultEl.style.display = 'none';
            
            if (!state) {
                countyEl.disabled = true;
                countyEl.innerHTML = '<option value="">First select a state</option>';
                return;
            }
            
            // Enable county dropdown
            countyEl.disabled = false;
            
            // Get county data
            const counties = (window.checkCountyData && window.checkCountyData[state]) ? window.checkCountyData[state] : [];
            console.log("Counties found:", counties.length);
            
            if (counties.length === 0) {
                countyEl.innerHTML = '<option value="">Select your county</option>';
                resultEl.style.display = 'block';
                resultEl.innerHTML = `
                    <div style="background: #E8F4FD; padding: 32px; border-radius: 12px; text-align: center; border-left: 4px solid #0A2463;">
                        <h3 style="font-size: 24px; font-weight: 800; color: #0A2463; margin-bottom: 16px;">
                            ✅ We Cover This State!
                        </h3>
                        <p style="color: #666; margin-bottom: 24px;">
                            TrueVow works in all counties in your state. We'll calculate availability when you apply.
                        </p>
                        <a href="apply.html?state=${state}" style="display: inline-block; background: #0A2463; color: white; padding: 16px 32px; border-radius: 8px; font-weight: 700; text-decoration: none; transition: all 0.3s;">
                            Apply Now →
                        </a>
                    </div>
                `;
                return;
            }
            
            // Populate counties
            countyEl.innerHTML = '<option value="">Select your county</option>';
            counties.forEach(county => {
                const option = document.createElement('option');
                option.value = county.value;
                option.textContent = `${county.name} (${county.remaining} seats left)`;
                option.dataset.name = county.name;
                option.dataset.total = county.total;
                option.dataset.remaining = county.remaining;
                countyEl.appendChild(option);
            });
            
            // Add "Other County" option
            const otherOption = document.createElement('option');
            otherOption.value = 'other-county';
            otherOption.textContent = 'My county isn\\'t listed';
            countyEl.appendChild(otherOption);
            
            console.log("County dropdown populated successfully");
        } catch (error) {
            console.error("Error in loadCheckCounties:", error);
        }
    };
    
    // Make it available globally
    if (typeof loadCheckCounties === 'undefined') {
        window.loadCheckCounties = window.loadCheckCounties;
    }
    </script>
    '''
    
    content = re.sub(cta_end_pattern, essential_script + r'\1', content)
    changes.append("Added essential function script block before main script")
    print("  [OK] Added essential function script block")

# Also ensure the onchange handler uses window.loadCheckCounties
if 'onchange="loadCheckCounties()"' in content:
    # Check if we need to update it
    if 'onchange="window.loadCheckCounties()"' not in content:
        # The current handler should work, but let's make sure
        print("  [OK] onchange handler found")

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
    print("\n[INFO] No changes needed - checking structure...")

