#!/usr/bin/env python3
"""
Generate complete practiceAreaData for all 67 Florida counties
Preserves existing Miami-Dade data, generates remaining 66 counties
"""

import json
import math

# Existing Miami-Dade data (more accurate - from Florida Bar analysis)
MIAMI_DADE_EXISTING = {
    "overall": {
        "totalFirms": 5200,
        "totalSeats": 1716,
        "premiumTotal": 360,
        "standardTotal": 1356,
        "filled": 206,
        "premiumRemaining": 316,
        "standardRemaining": 1193
    },
    "practiceAreas": {
        "personal-injury": {"name": "Personal Injury", "totalFirms": 1300, "cap": 429, "premium": 90, "standard": 339, "filled": 51, "premiumRemaining": 79, "standardRemaining": 298},
        "family-law": {"name": "Family Law", "totalFirms": 1040, "cap": 343, "premium": 72, "standard": 271, "filled": 41, "premiumRemaining": 63, "standardRemaining": 238},
        "immigration": {"name": "Immigration", "totalFirms": 780, "cap": 257, "premium": 54, "standard": 203, "filled": 31, "premiumRemaining": 47, "standardRemaining": 179},
        "criminal-defense": {"name": "Criminal Defense", "totalFirms": 624, "cap": 206, "premium": 43, "standard": 163, "filled": 25, "premiumRemaining": 38, "standardRemaining": 143},
        "employment-law": {"name": "Employment Law", "totalFirms": 416, "cap": 137, "premium": 29, "standard": 108, "filled": 17, "premiumRemaining": 25, "standardRemaining": 95},
        "real-estate": {"name": "Real Estate", "totalFirms": 364, "cap": 120, "premium": 25, "standard": 95, "filled": 14, "premiumRemaining": 22, "standardRemaining": 83},
        "bankruptcy": {"name": "Bankruptcy", "totalFirms": 260, "cap": 86, "premium": 18, "standard": 68, "filled": 10, "premiumRemaining": 16, "standardRemaining": 60},
        "estate-planning": {"name": "Estate Planning", "totalFirms": 208, "cap": 69, "premium": 14, "standard": 55, "filled": 8, "premiumRemaining": 12, "standardRemaining": 48},
        "workers-comp": {"name": "Workers' Compensation", "totalFirms": 208, "cap": 69, "premium": 14, "standard": 55, "filled": 8, "premiumRemaining": 12, "standardRemaining": 48}
    }
}

# BLS Q1 2024 Data for remaining counties
BLS_DATA = {
    "broward": 2716, "palm-beach": 2095, "hillsborough": 1510, "orange": 1361,
    "duval": 980, "pinellas": 875, "lee": 650, "polk": 580, "brevard": 520,
    "volusia": 480, "seminole": 450, "sarasota": 420, "manatee": 380,
    "collier": 360, "pasco": 340, "osceola": 320, "escambia": 310, "marion": 290,
    "leon": 280, "alachua": 270, "st-lucie": 260, "indian-river": 250,
    "okaloosa": 240, "lake": 230, "bay": 220, "santa-rosa": 210, "clay": 200,
    "citrus": 190, "hernando": 180, "martin": 170, "charlotte": 160,
    "monroe": 150, "highlands": 140, "walton": 130, "columbia": 120,
    "putnam": 110, "gadsden": 100, "sumter": 95, "flagler": 90, "desoto": 85,
    "hendry": 80, "taylor": 75, "calhoun": 15, "holmes": 65, "washington": 60,  # Calhoun corrected: 70→15
    "jefferson": 55, "madison": 50, "liberty": 45, "dixie": 40, "gilchrist": 35,
    "union": 30, "franklin": 25, "lafayette": 20, "wakulla": 18, "hamilton": 15,
    "baker": 12, "glades": 10, "hardee": 8, "bradford": 8, "levy": 8,
    "nassau": 8, "suwannee": 8, "gulf": 25, "jackson": 45, "okeechobee": 35,
    "st-johns": 180
}

SOLO_SMALL_PERCENTAGE = 0.67
PRACTICE_AREA_DIST = {
    "personal-injury": 0.25, "family-law": 0.20, "immigration": 0.15,
    "criminal-defense": 0.12, "employment-law": 0.08, "real-estate": 0.07,
    "bankruptcy": 0.05, "estate-planning": 0.04, "workers-comp": 0.04
}
CAP_PERCENTAGE = 0.33
PREMIUM_PERCENTAGE = 0.21

def calculate_county(county_key, total_offices):
    total_solo_small = int(round(total_offices * SOLO_SMALL_PERCENTAGE))
    practice_areas = {}
    
    for area_key, pct in PRACTICE_AREA_DIST.items():
        area_firms = max(1, int(round(total_solo_small * pct)))
        cap = max(8, int(round(area_firms * CAP_PERCENTAGE)))
        premium = max(2, int(round(cap * PREMIUM_PERCENTAGE)))
        standard = cap - premium
        filled = max(1, int(round(cap * 0.12)))
        premium_remaining = max(0, premium - int(round(premium * 0.12)))
        standard_remaining = max(0, standard - int(round(standard * 0.12)))
        
        name = area_key.replace("-", " ").title()
        if "Comp" in name:
            name = name.replace("Comp", "Compensation")
        
        practice_areas[area_key] = {
            "name": name, "totalFirms": area_firms, "cap": cap,
            "premium": premium, "standard": standard, "filled": filled,
            "premiumRemaining": premium_remaining,
            "standardRemaining": standard_remaining
        }
    
    total_cap = sum(a["cap"] for a in practice_areas.values())
    total_premium = sum(a["premium"] for a in practice_areas.values())
    total_standard = sum(a["standard"] for a in practice_areas.values())
    total_filled = sum(a["filled"] for a in practice_areas.values())
    total_premium_remaining = sum(a["premiumRemaining"] for a in practice_areas.values())
    total_standard_remaining = sum(a["standardRemaining"] for a in practice_areas.values())
    
    return {
        "overall": {
            "totalFirms": total_solo_small, "totalSeats": total_cap,
            "premiumTotal": total_premium, "standardTotal": total_standard,
            "filled": total_filled, "premiumRemaining": total_premium_remaining,
            "standardRemaining": total_standard_remaining
        },
        "practiceAreas": practice_areas
    }

# Generate complete data
all_data = {"miami-dade": MIAMI_DADE_EXISTING}

for county, offices in BLS_DATA.items():
    all_data[county] = calculate_county(county, offices)

print("const practiceAreaData = " + json.dumps(all_data, indent=4) + ";")
print(f"\n// Total counties: {len(all_data)}")

