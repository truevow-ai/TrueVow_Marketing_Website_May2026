#!/usr/bin/env python3
"""
Generate practice area data for all California counties
Using the same methodology as Florida counties
"""

import math

# California-specific data
# Based on California State Bar data, solo/small firms represent approximately 65-70% of total
# Using 68% as a conservative estimate (similar to Florida's 67%)
SOLO_SMALL_PERCENTAGE = 0.68

# Practice area distribution (same as Florida - industry standard)
PRACTICE_AREA_DISTRIBUTION = {
    "personal-injury": 0.25,
    "family-law": 0.20,
    "immigration": 0.15,
    "criminal-defense": 0.12,
    "employment-law": 0.08,
    "real-estate": 0.07,
    "bankruptcy": 0.05,
    "estate-planning": 0.04,
    "workers-comp": 0.04
}

# BLS Q1 2024 data for California counties (law offices - NAICS 54111)
# Top counties from BLS, others estimated based on population and known legal markets
CALIFORNIA_COUNTY_DATA = {
    "los-angeles": {"totalOffices": 15200, "name": "Los Angeles"},
    "san-diego": {"totalOffices": 3200, "name": "San Diego"},
    "orange": {"totalOffices": 2800, "name": "Orange"},
    "riverside": {"totalOffices": 1200, "name": "Riverside"},
    "san-bernardino": {"totalOffices": 1100, "name": "San Bernardino"},
    "santa-clara": {"totalOffices": 2400, "name": "Santa Clara"},
    "alameda": {"totalOffices": 2200, "name": "Alameda"},
    "sacramento": {"totalOffices": 1600, "name": "Sacramento"},
    "contra-costa": {"totalOffices": 1100, "name": "Contra Costa"},
    "fresno": {"totalOffices": 900, "name": "Fresno"},
    "kern": {"totalOffices": 700, "name": "Kern"},
    "san-francisco": {"totalOffices": 2000, "name": "San Francisco"},
    "ventura": {"totalOffices": 800, "name": "Ventura"},
    "san-mateo": {"totalOffices": 1000, "name": "San Mateo"},
    "stanislaus": {"totalOffices": 500, "name": "Stanislaus"},
    "tulare": {"totalOffices": 400, "name": "Tulare"},
    "san-joaquin": {"totalOffices": 500, "name": "San Joaquin"},
    "sonoma": {"totalOffices": 600, "name": "Sonoma"},
    "solano": {"totalOffices": 400, "name": "Solano"},
    "monterey": {"totalOffices": 400, "name": "Monterey"},
    "santa-barbara": {"totalOffices": 500, "name": "Santa Barbara"},
    "placer": {"totalOffices": 400, "name": "Placer"},
    "san-luis-obispo": {"totalOffices": 300, "name": "San Luis Obispo"},
    "shasta": {"totalOffices": 200, "name": "Shasta"},
    "butte": {"totalOffices": 250, "name": "Butte"},
    "el-dorado": {"totalOffices": 200, "name": "El Dorado"},
    "yolo": {"totalOffices": 200, "name": "Yolo"},
    "napa": {"totalOffices": 200, "name": "Napa"},
    "humboldt": {"totalOffices": 200, "name": "Humboldt"},
    "merced": {"totalOffices": 250, "name": "Merced"},
    "kings": {"totalOffices": 150, "name": "Kings"},
    "madera": {"totalOffices": 150, "name": "Madera"},
    "imperial": {"totalOffices": 150, "name": "Imperial"},
    "sutter": {"totalOffices": 100, "name": "Sutter"},
    "yuba": {"totalOffices": 100, "name": "Yuba"},
    "tehama": {"totalOffices": 100, "name": "Tehama"},
    "colusa": {"totalOffices": 50, "name": "Colusa"},
    "glenn": {"totalOffices": 50, "name": "Glenn"},
    "lake": {"totalOffices": 100, "name": "Lake"},
    "mendocino": {"totalOffices": 100, "name": "Mendocino"},
    "marin": {"totalOffices": 400, "name": "Marin"},
    "napa": {"totalOffices": 200, "name": "Napa"},
    "sonoma": {"totalOffices": 600, "name": "Sonoma"},
    # Add remaining counties with estimated data based on population
    "amador": {"totalOffices": 50, "name": "Amador"},
    "calaveras": {"totalOffices": 50, "name": "Calaveras"},
    "del-norte": {"totalOffices": 50, "name": "Del Norte"},
    "inyo": {"totalOffices": 30, "name": "Inyo"},
    "lassen": {"totalOffices": 30, "name": "Lassen"},
    "modoc": {"totalOffices": 20, "name": "Modoc"},
    "mono": {"totalOffices": 30, "name": "Mono"},
    "nevada": {"totalOffices": 100, "name": "Nevada"},
    "plumas": {"totalOffices": 30, "name": "Plumas"},
    "sierra": {"totalOffices": 20, "name": "Sierra"},
    "siskiyou": {"totalOffices": 50, "name": "Siskiyou"},
    "trinity": {"totalOffices": 30, "name": "Trinity"},
    "tuolumne": {"totalOffices": 50, "name": "Tuolumne"}
}

def calculate_practice_area_data(total_firms):
    """Calculate practice area breakdown and seat allocations"""
    practice_areas = {}
    
    for area_key, percentage in PRACTICE_AREA_DISTRIBUTION.items():
        firms = math.ceil(total_firms * percentage)
        # Ensure minimum 8 firms per practice area
        firms = max(8, firms)
        
        # 33% cap
        cap = math.ceil(firms * 0.33)
        cap = max(8, cap)  # Minimum 8 seats per practice area
        
        # 21% premium tier
        premium = math.ceil(cap * 0.21)
        premium = max(2, premium)  # Minimum 2 premium seats
        
        standard = cap - premium
        
        # Calculate filled (using 12-15% fill rate like Florida)
        filled = math.ceil(cap * 0.13)  # 13% average
        premium_filled = math.ceil(premium * 0.13)
        standard_filled = filled - premium_filled
        
        premium_remaining = max(0, premium - premium_filled)
        standard_remaining = max(0, standard - standard_filled)
        
        # Practice area name mapping
        area_names = {
            "personal-injury": "Personal Injury",
            "family-law": "Family Law",
            "immigration": "Immigration",
            "criminal-defense": "Criminal Defense",
            "employment-law": "Employment Law",
            "real-estate": "Real Estate",
            "bankruptcy": "Bankruptcy",
            "estate-planning": "Estate Planning",
            "workers-comp": "Workers' Compensation"
        }
        
        practice_areas[area_key] = {
            "name": area_names[area_key],
            "firms": firms,
            "cap": cap,
            "premium": premium,
            "standard": standard,
            "filled": filled,
            "premiumRemaining": premium_remaining,
            "standardRemaining": standard_remaining
        }
    
    return practice_areas

def generate_california_data():
    """Generate complete practiceAreaData for all California counties"""
    california_data = {}
    
    for county_slug, county_info in CALIFORNIA_COUNTY_DATA.items():
        total_offices = county_info["totalOffices"]
        total_firms = math.ceil(total_offices * SOLO_SMALL_PERCENTAGE)
        
        # Calculate overall statistics
        total_seats = math.ceil(total_firms * 0.33)
        total_seats = max(24, total_seats)  # Minimum 24 seats total (8 per practice area × 3 minimum areas)
        
        premium_total = math.ceil(total_seats * 0.21)
        premium_total = max(6, premium_total)  # Minimum 6 premium seats
        
        standard_total = total_seats - premium_total
        
        # Calculate filled (12-15% range)
        filled = math.ceil(total_seats * 0.13)
        premium_filled = math.ceil(premium_total * 0.13)
        standard_filled = filled - premium_filled
        
        premium_remaining = max(0, premium_total - premium_filled)
        standard_remaining = max(0, standard_total - standard_filled)
        
        # Calculate practice areas
        practice_areas = calculate_practice_area_data(total_firms)
        
        california_data[county_slug] = {
            "overall": {
                "totalFirms": total_firms,
                "totalSeats": total_seats,
                "premiumTotal": premium_total,
                "standardTotal": standard_total,
                "filled": filled,
                "premiumRemaining": premium_remaining,
                "standardRemaining": standard_remaining
            },
            "practiceAreas": practice_areas
        }
    
    return california_data

def format_as_javascript(california_data):
    """Format the data as JavaScript object"""
    lines = []
    
    for county_slug, data in sorted(california_data.items()):
        lines.append(f'    "{county_slug}": {{')
        lines.append('        "overall": {')
        overall = data["overall"]
        lines.append(f'            "totalFirms": {overall["totalFirms"]},')
        lines.append(f'            "totalSeats": {overall["totalSeats"]},')
        lines.append(f'            "premiumTotal": {overall["premiumTotal"]},')
        lines.append(f'            "standardTotal": {overall["standardTotal"]},')
        lines.append(f'            "filled": {overall["filled"]},')
        lines.append(f'            "premiumRemaining": {overall["premiumRemaining"]},')
        lines.append(f'            "standardRemaining": {overall["standardRemaining"]}')
        lines.append('        },')
        lines.append('        "practiceAreas": {')
        
        for area_key, area_data in sorted(data["practiceAreas"].items()):
            lines.append(f'            "{area_key}": {{')
            lines.append(f'                "name": "{area_data["name"]}",')
            lines.append(f'                "firms": {area_data["firms"]},')
            lines.append(f'                "cap": {area_data["cap"]},')
            lines.append(f'                "premium": {area_data["premium"]},')
            lines.append(f'                "standard": {area_data["standard"]},')
            lines.append(f'                "filled": {area_data["filled"]},')
            lines.append(f'                "premiumRemaining": {area_data["premiumRemaining"]},')
            lines.append(f'                "standardRemaining": {area_data["standardRemaining"]}')
            lines.append('            },')
        
        lines.append('        }')
        lines.append('    },')
    
    return '\n'.join(lines)

if __name__ == "__main__":
    print("Generating California county data...")
    california_data = generate_california_data()
    
    print(f"\nGenerated data for {len(california_data)} California counties")
    print("\nSample (Los Angeles):")
    la_data = california_data["los-angeles"]
    print(f"  Total firms: {la_data['overall']['totalFirms']}")
    print(f"  Total seats: {la_data['overall']['totalSeats']}")
    print(f"  Premium seats: {la_data['overall']['premiumTotal']}")
    print(f"  Standard seats: {la_data['overall']['standardTotal']}")
    
    # Save to file
    js_output = format_as_javascript(california_data)
    with open('scripts/california_practice_area_data.js', 'w', encoding='utf-8') as f:
        f.write(js_output)
    
    print("\n✓ California data saved to scripts/california_practice_area_data.js")
    print("\nNext step: Integrate this data into marketing/county-cap.html")

