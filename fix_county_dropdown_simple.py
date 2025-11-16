#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Fix county dropdown by using the same simple pattern as apply.html
"""

import re

filepath = "marketing/county-cap.html"
backup_path = "marketing/county-cap.html.simple-fix-backup"

print(f"[FIX] Reading {filepath}...")
with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# Create backup
print(f"[BACKUP] Creating backup...")
with open(backup_path, 'w', encoding='utf-8') as f:
    f.write(content)

original = content

# Find the essential script block and replace it with a simple working version
# that matches the pattern from apply.html

essential_script_pattern = r'(<!-- ESSENTIAL FUNCTIONS - Load First -->\s*<script>.*?</script>)'
essential_match = re.search(essential_script_pattern, content, re.DOTALL)

if essential_match:
    # Replace with simple working version
    new_essential_script = '''<!-- ESSENTIAL FUNCTIONS - Load First -->
    <script>
    // County data - defined first, simple const like apply.html
    const checkCountyData = {
        "CA": [
            { value: "los-angeles", name: "Los Angeles", total: 120, remaining: 75 },
            { value: "san-diego", name: "San Diego", total: 55, remaining: 37 },
            { value: "orange-ca", name: "Orange", total: 48, remaining: 36 },
            { value: "riverside", name: "Riverside", total: 35, remaining: 28 },
            { value: "san-bernardino", name: "San Bernardino", total: 32, remaining: 26 },
            { value: "santa-clara", name: "Santa Clara", total: 42, remaining: 30 },
            { value: "alameda", name: "Alameda", total: 38, remaining: 28 },
            { value: "sacramento", name: "Sacramento", total: 28, remaining: 22 },
            { value: "contra-costa", name: "Contra Costa", total: 24, remaining: 19 },
            { value: "fresno", name: "Fresno", total: 22, remaining: 18 },
            { value: "kern", name: "Kern", total: 20, remaining: 16 },
            { value: "san-francisco", name: "San Francisco", total: 35, remaining: 25 },
            { value: "ventura", name: "Ventura", total: 18, remaining: 15 },
            { value: "san-mateo", name: "San Mateo", total: 22, remaining: 17 },
            { value: "stanislaus", name: "Stanislaus", total: 14, remaining: 12 }
        ],
        "TX": [
            { value: "harris", name: "Harris (Houston)", total: 85, remaining: 53 },
            { value: "dallas", name: "Dallas", total: 72, remaining: 44 },
            { value: "tarrant", name: "Tarrant (Fort Worth)", total: 45, remaining: 30 },
            { value: "bexar", name: "Bexar (San Antonio)", total: 42, remaining: 28 },
            { value: "travis", name: "Travis (Austin)", total: 38, remaining: 26 },
            { value: "collin", name: "Collin", total: 25, remaining: 18 },
            { value: "hidalgo", name: "Hidalgo", total: 22, remaining: 17 },
            { value: "el-paso", name: "El Paso", total: 20, remaining: 15 },
            { value: "denton", name: "Denton", total: 18, remaining: 14 },
            { value: "fort-bend", name: "Fort Bend", total: 16, remaining: 13 },
            { value: "montgomery", name: "Montgomery", total: 15, remaining: 12 },
            { value: "williamson", name: "Williamson", total: 14, remaining: 11 },
            { value: "cameron", name: "Cameron", total: 13, remaining: 10 },
            { value: "nueces", name: "Nueces (Corpus Christi)", total: 12, remaining: 9 },
            { value: "brazoria", name: "Brazoria", total: 11, remaining: 9 }
        ],
        "FL": [
            { value: "miami-dade", name: "Miami-Dade", total: 60, remaining: 12 },
            { value: "broward", name: "Broward", total: 46, remaining: 8 },
            { value: "palm-beach", name: "Palm Beach", total: 31, remaining: 26 },
            { value: "hillsborough", name: "Hillsborough (Tampa)", total: 40, remaining: 34 },
            { value: "orange", name: "Orange (Orlando)", total: 36, remaining: 31 },
            { value: "duval", name: "Duval (Jacksonville)", total: 25, remaining: 21 },
            { value: "pinellas", name: "Pinellas", total: 23, remaining: 20 },
            { value: "lee", name: "Lee", total: 20, remaining: 17 },
            { value: "polk", name: "Polk", total: 18, remaining: 16 },
            { value: "brevard", name: "Brevard", total: 16, remaining: 14 },
            { value: "volusia", name: "Volusia", total: 15, remaining: 13 },
            { value: "seminole", name: "Seminole", total: 14, remaining: 12 },
            { value: "sarasota", name: "Sarasota", total: 14, remaining: 12 },
            { value: "manatee", name: "Manatee", total: 12, remaining: 11 },
            { value: "collier", name: "Collier", total: 12, remaining: 10 }
        ],
        "NY": [
            { value: "new-york", name: "New York (Manhattan)", total: 95, remaining: 58 },
            { value: "kings", name: "Kings (Brooklyn)", total: 68, remaining: 42 },
            { value: "queens", name: "Queens", total: 62, remaining: 38 },
            { value: "bronx", name: "Bronx", total: 35, remaining: 25 },
            { value: "richmond", name: "Richmond (Staten Island)", total: 18, remaining: 15 },
            { value: "suffolk", name: "Suffolk", total: 42, remaining: 32 },
            { value: "nassau", name: "Nassau", total: 38, remaining: 28 },
            { value: "westchester", name: "Westchester", total: 32, remaining: 24 },
            { value: "erie", name: "Erie (Buffalo)", total: 28, remaining: 22 },
            { value: "monroe", name: "Monroe (Rochester)", total: 25, remaining: 20 },
            { value: "onondaga", name: "Onondaga (Syracuse)", total: 20, remaining: 16 },
            { value: "albany", name: "Albany", total: 18, remaining: 15 },
            { value: "rockland", name: "Rockland", total: 16, remaining: 13 },
            { value: "oneida", name: "Oneida", total: 14, remaining: 12 },
            { value: "dutchess", name: "Dutchess", total: 12, remaining: 10 }
        ],
        "PA": [
            { value: "philadelphia", name: "Philadelphia", total: 65, remaining: 38 },
            { value: "allegheny", name: "Allegheny (Pittsburgh)", total: 52, remaining: 35 },
            { value: "montgomery", name: "Montgomery", total: 28, remaining: 22 },
            { value: "bucks", name: "Bucks", total: 22, remaining: 18 },
            { value: "delaware", name: "Delaware", total: 20, remaining: 16 },
            { value: "lancaster", name: "Lancaster", total: 18, remaining: 15 },
            { value: "chester", name: "Chester", total: 16, remaining: 13 },
            { value: "york", name: "York", total: 15, remaining: 12 },
            { value: "lehigh", name: "Lehigh", total: 14, remaining: 11 },
            { value: "berks", name: "Berks", total: 13, remaining: 11 },
            { value: "westmoreland", name: "Westmoreland", total: 12, remaining: 10 },
            { value: "dauphin", name: "Dauphin (Harrisburg)", total: 11, remaining: 9 },
            { value: "luzerne", name: "Luzerne", total: 10, remaining: 8 },
            { value: "northampton", name: "Northampton", total: 10, remaining: 8 },
            { value: "cumberland", name: "Cumberland", total: 9, remaining: 8 }
        ],
        "IL": [
            { value: "cook", name: "Cook (Chicago)", total: 95, remaining: 55 },
            { value: "dupage", name: "DuPage", total: 32, remaining: 24 },
            { value: "lake", name: "Lake", total: 24, remaining: 19 },
            { value: "will", name: "Will", total: 22, remaining: 18 },
            { value: "kane", name: "Kane", total: 18, remaining: 15 },
            { value: "mchenry", name: "McHenry", total: 14, remaining: 12 },
            { value: "winnebago", name: "Winnebago (Rockford)", total: 13, remaining: 11 },
            { value: "st-clair", name: "St. Clair", total: 12, remaining: 10 },
            { value: "madison", name: "Madison", total: 11, remaining: 9 },
            { value: "champaign", name: "Champaign", total: 10, remaining: 8 },
            { value: "sangamon", name: "Sangamon (Springfield)", total: 9, remaining: 8 },
            { value: "peoria", name: "Peoria", total: 9, remaining: 7 },
            { value: "rock-island", name: "Rock Island", total: 8, remaining: 7 },
            { value: "kankakee", name: "Kankakee", total: 8, remaining: 7 },
            { value: "mclean", name: "McLean", total: 8, remaining: 7 }
        ],
        "OH": [
            { value: "cuyahoga", name: "Cuyahoga (Cleveland)", total: 42, remaining: 27 },
            { value: "franklin", name: "Franklin (Columbus)", total: 38, remaining: 25 },
            { value: "hamilton", name: "Hamilton (Cincinnati)", total: 35, remaining: 24 },
            { value: "summit", name: "Summit (Akron)", total: 22, remaining: 17 },
            { value: "montgomery", name: "Montgomery (Dayton)", total: 20, remaining: 16 },
            { value: "lucas", name: "Lucas (Toledo)", total: 18, remaining: 14 },
            { value: "butler", name: "Butler", total: 14, remaining: 11 },
            { value: "stark", name: "Stark (Canton)", total: 13, remaining: 10 },
            { value: "lorain", name: "Lorain", total: 12, remaining: 10 },
            { value: "warren", name: "Warren", total: 11, remaining: 9 },
            { value: "mahoning", name: "Mahoning (Youngstown)", total: 10, remaining: 8 },
            { value: "lake-oh", name: "Lake", total: 10, remaining: 8 },
            { value: "clermont", name: "Clermont", total: 9, remaining: 8 },
            { value: "trumbull", name: "Trumbull", total: 9, remaining: 7 },
            { value: "delaware", name: "Delaware", total: 8, remaining: 7 }
        ],
        "GA": [
            { value: "fulton", name: "Fulton (Atlanta)", total: 52, remaining: 35 },
            { value: "gwinnett", name: "Gwinnett", total: 35, remaining: 26 },
            { value: "cobb", name: "Cobb", total: 32, remaining: 24 },
            { value: "dekalb", name: "DeKalb", total: 28, remaining: 20 },
            { value: "clayton", name: "Clayton", total: 18, remaining: 14 },
            { value: "cherokee", name: "Cherokee", total: 16, remaining: 13 },
            { value: "forsyth", name: "Forsyth", total: 15, remaining: 12 },
            { value: "henry", name: "Henry", total: 14, remaining: 11 },
            { value: "richmond", name: "Richmond (Augusta)", total: 13, remaining: 10 },
            { value: "hall", name: "Hall", total: 12, remaining: 10 },
            { value: "muscogee", name: "Muscogee (Columbus)", total: 11, remaining: 9 },
            { value: "bibb", name: "Bibb (Macon)", total: 10, remaining: 8 },
            { value: "chatham", name: "Chatham (Savannah)", total: 10, remaining: 8 },
            { value: "clarke", name: "Clarke (Athens)", total: 9, remaining: 7 },
            { value: "coweta", name: "Coweta", total: 8, remaining: 7 }
        ],
        "NC": [
            { value: "mecklenburg", name: "Mecklenburg (Charlotte)", total: 48, remaining: 32 },
            { value: "wake", name: "Wake (Raleigh)", total: 42, remaining: 30 },
            { value: "guilford", name: "Guilford (Greensboro)", total: 28, remaining: 22 },
            { value: "forsyth", name: "Forsyth (Winston-Salem)", total: 22, remaining: 17 },
            { value: "cumberland", name: "Cumberland (Fayetteville)", total: 18, remaining: 14 },
            { value: "durham", name: "Durham", total: 16, remaining: 13 },
            { value: "union", name: "Union", total: 14, remaining: 11 },
            { value: "buncombe", name: "Buncombe (Asheville)", total: 13, remaining: 10 },
            { value: "gaston", name: "Gaston", total: 12, remaining: 10 },
            { value: "cabarrus", name: "Cabarrus", total: 11, remaining: 9 },
            { value: "new-hanover", name: "New Hanover (Wilmington)", total: 11, remaining: 9 },
            { value: "iredell", name: "Iredell", total: 10, remaining: 8 },
            { value: "johnston", name: "Johnston", total: 9, remaining: 8 },
            { value: "onslow", name: "Onslow", total: 9, remaining: 7 },
            { value: "rowan", name: "Rowan", total: 8, remaining: 7 }
        ],
        "MI": [
            { value: "wayne", name: "Wayne (Detroit)", total: 55, remaining: 35 },
            { value: "oakland", name: "Oakland", total: 42, remaining: 30 },
            { value: "macomb", name: "Macomb", total: 32, remaining: 24 },
            { value: "kent", name: "Kent (Grand Rapids)", total: 28, remaining: 22 },
            { value: "genesee", name: "Genesee (Flint)", total: 18, remaining: 14 },
            { value: "washtenaw", name: "Washtenaw (Ann Arbor)", total: 16, remaining: 13 },
            { value: "ingham", name: "Ingham (Lansing)", total: 14, remaining: 11 },
            { value: "ottawa", name: "Ottawa", total: 12, remaining: 10 },
            { value: "kalamazoo", name: "Kalamazoo", total: 11, remaining: 9 },
            { value: "livingston", name: "Livingston", total: 10, remaining: 8 },
            { value: "st-clair", name: "St. Clair", total: 9, remaining: 8 },
            { value: "monroe", name: "Monroe", total: 9, remaining: 7 },
            { value: "jackson", name: "Jackson", total: 8, remaining: 7 },
            { value: "muskegon", name: "Muskegon", total: 8, remaining: 6 },
            { value: "saginaw", name: "Saginaw", total: 8, remaining: 6 }
        ],
        "NJ": [
            { value: "bergen", name: "Bergen", total: 32, remaining: 24 },
            { value: "middlesex", name: "Middlesex", total: 28, remaining: 21 },
            { value: "essex", name: "Essex (Newark)", total: 26, remaining: 18 },
            { value: "hudson", name: "Hudson (Jersey City)", total: 24, remaining: 17 },
            { value: "monmouth", name: "Monmouth", total: 22, remaining: 17 },
            { value: "ocean", name: "Ocean", total: 20, remaining: 16 },
            { value: "union", name: "Union", total: 18, remaining: 14 },
            { value: "camden", name: "Camden", total: 16, remaining: 12 },
            { value: "passaic", name: "Passaic", total: 15, remaining: 12 },
            { value: "morris", name: "Morris", total: 14, remaining: 11 },
            { value: "burlington", name: "Burlington", total: 13, remaining: 10 },
            { value: "somerset", name: "Somerset", total: 12, remaining: 10 },
            { value: "gloucester", name: "Gloucester", total: 11, remaining: 9 },
            { value: "atlantic", name: "Atlantic", total: 10, remaining: 8 },
            { value: "mercer", name: "Mercer (Trenton)", total: 10, remaining: 7 }
        ],
        "VA": [
            { value: "fairfax", name: "Fairfax", total: 42, remaining: 30 },
            { value: "prince-william", name: "Prince William", total: 25, remaining: 19 },
            { value: "loudoun", name: "Loudoun", total: 22, remaining: 17 },
            { value: "virginia-beach", name: "Virginia Beach (Independent City)", total: 20, remaining: 15 },
            { value: "chesterfield", name: "Chesterfield", total: 18, remaining: 14 },
            { value: "henrico", name: "Henrico", total: 16, remaining: 13 },
            { value: "chesapeake", name: "Chesapeake (Independent City)", total: 14, remaining: 11 },
            { value: "arlington", name: "Arlington", total: 14, remaining: 10 },
            { value: "norfolk", name: "Norfolk (Independent City)", total: 13, remaining: 9 },
            { value: "richmond-city", name: "Richmond (Independent City)", total: 12, remaining: 8 },
            { value: "stafford", name: "Stafford", total: 11, remaining: 9 },
            { value: "spotsylvania", name: "Spotsylvania", total: 10, remaining: 8 },
            { value: "newport-news", name: "Newport News (Independent City)", total: 10, remaining: 7 },
            { value: "hampton", name: "Hampton (Independent City)", total: 9, remaining: 7 },
            { value: "alexandria", name: "Alexandria (Independent City)", total: 9, remaining: 6 }
        ]
    };
    
    // Simple function matching apply.html pattern
    function loadCheckCounties() {
        const state = document.getElementById('check-state').value;
        const countySelect = document.getElementById('check-county');
        const resultDiv = document.getElementById('availabilityResult');
        
        // Hide previous result
        if (resultDiv) {
            resultDiv.style.display = 'none';
        }
        
        if (!state) {
            countySelect.disabled = true;
            countySelect.innerHTML = '<option value="">First select a state</option>';
            return;
        }
        
        // Enable county dropdown
        countySelect.disabled = false;
        
        // Get counties for selected state
        const counties = checkCountyData[state] || [];
        
        if (counties.length === 0) {
            // State doesn't have county data yet
            countySelect.innerHTML = '<option value="">Select your county</option>';
            if (resultDiv) {
                resultDiv.style.display = 'block';
                resultDiv.innerHTML = `
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
            }
        } else {
            // Populate with actual counties
            countySelect.innerHTML = '<option value="">Select your county</option>';
            counties.forEach(county => {
                const option = document.createElement('option');
                option.value = county.value;
                option.textContent = `${county.name} (${county.remaining} seats left)`;
                option.dataset.name = county.name;
                option.dataset.total = county.total;
                option.dataset.remaining = county.remaining;
                countySelect.appendChild(option);
            });
            
            // Add "Other County" option
            const otherOption = document.createElement('option');
            otherOption.value = 'other-county';
            otherOption.textContent = 'My county isn\\'t listed';
            countySelect.appendChild(otherOption);
        }
    }
    </script>'''
    
    content = content[:essential_match.start()] + new_essential_script + content[essential_match.end():]
    print("  [OK] Replaced essential script block with simple working version")
    
    # Also remove the duplicate function definition from main script
    # Find and remove the duplicate loadCheckCounties function
    duplicate_pattern = r'(// Define loadCheckCounties in global scope FIRST.*?function loadCheckCounties\(\) \{.*?\n\s*\}\s*// Chart initialization)'
    duplicate_match = re.search(duplicate_pattern, content, re.DOTALL)
    
    if duplicate_match:
        # Keep the Chart initialization, just remove the duplicate function
        content = re.sub(
            r'// Define loadCheckCounties in global scope FIRST.*?function loadCheckCounties\(\) \{.*?\n\s*\}\s*',
            '',
            content,
            flags=re.DOTALL,
            count=1
        )
        print("  [OK] Removed duplicate function from main script")
    
    # Also remove the duplicate window.checkCountyData from main script if it exists
    # But keep the showAvailability function
    window_data_pattern = r'(// County Availability Checker - Top Counties by State\s+window\.checkCountyData\s*=\s*\{.*?\n\s*\};)'
    window_data_match = re.search(window_data_pattern, content, re.DOTALL)
    
    if window_data_match:
        content = content[:window_data_match.start()] + content[window_data_match.end():]
        print("  [OK] Removed duplicate window.checkCountyData from main script")

# Write the fixed content
if content != original:
    print(f"\n[SAVE] Writing fixed content to {filepath}...")
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"\n{'='*60}")
    print("SUMMARY OF CHANGES:")
    print("  ✅ Replaced complex essential script with simple working version")
    print("  ✅ Defined county data as simple const (like apply.html)")
    print("  ✅ Simplified loadCheckCounties function to match apply.html pattern")
    print("  ✅ Removed duplicate function and data definitions")
    print(f"{'='*60}")
else:
    print("\n[INFO] No changes made")

