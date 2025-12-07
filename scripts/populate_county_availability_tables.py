#!/usr/bin/env python3
"""
Script to populate web_availability_county and web_availability_practice_area_seats tables
Extracts data from the hardcoded JavaScript object in marketing/county-cap.html
"""

import re
import json
import os

# Practice area display order (as agreed)
PRACTICE_AREA_ORDER = {
    'personal-injury': 1,
    'family-law': 2,
    'immigration': 3,
    'criminal-defense': 4,
    'employment-law': 5,
    'bankruptcy': 6,
    'real-estate': 7,
    'estate-planning': 8,
    'workers-comp': 9
}

def extract_practice_area_data(html_file):
    """Extract practiceAreaData from HTML file"""
    with open(html_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Find the practiceAreaData object
    pattern = r'const practiceAreaData = ({.*?});'
    match = re.search(pattern, content, re.DOTALL)
    
    if not match:
        raise ValueError("Could not find practiceAreaData in HTML file")
    
    # Extract the JSON-like object
    data_str = match.group(1)
    
    # Convert to actual JSON (handle JavaScript object syntax)
    # Replace single quotes with double quotes for JSON
    data_str = re.sub(r"'([^']*)':", r'"\1":', data_str)
    data_str = re.sub(r": '([^']*)'", r': "\1"', data_str)
    data_str = re.sub(r": '([^']*)',", r': "\1",', data_str)
    data_str = re.sub(r": '([^']*)'}", r': "\1"}', data_str)
    
    # Handle boolean values
    data_str = re.sub(r': true', r': true', data_str)
    data_str = re.sub(r': false', r': false', data_str)
    
    # Parse as JSON
    try:
        data = json.loads(data_str)
    except json.JSONDecodeError:
        # If JSON parsing fails, try to extract manually
        print("Warning: JSON parsing failed, using regex extraction")
        return extract_manually(content)
    
    return data

def extract_manually(content):
    """Fallback: Extract data using regex patterns"""
    data = {}
    
    # Find all county blocks
    county_pattern = r'"([^"]+)":\s*\{[^}]*"overall":\s*\{([^}]+)\}[^}]*"practiceAreas":\s*\{([^}]+)\}'
    
    # This is complex, let's use a simpler approach
    # Find the practiceAreaData section
    start = content.find('const practiceAreaData = {')
    if start == -1:
        raise ValueError("Could not find practiceAreaData")
    
    # Find the end of the object
    brace_count = 0
    in_string = False
    escape_next = False
    i = start + len('const practiceAreaData = {')
    
    while i < len(content):
        char = content[i]
        
        if escape_next:
            escape_next = False
            i += 1
            continue
        
        if char == '\\':
            escape_next = True
            i += 1
            continue
        
        if char == '"':
            in_string = not in_string
        elif not in_string:
            if char == '{':
                brace_count += 1
            elif char == '}':
                brace_count -= 1
                if brace_count == -1:
                    break
        
        i += 1
    
    # Extract the object string
    obj_str = content[start + len('const practiceAreaData = '):i+1]
    
    # Use eval (safe in this context as we control the input)
    # Actually, let's parse it more carefully
    return parse_js_object(obj_str)

def parse_js_object(obj_str):
    """Parse JavaScript object string"""
    # This is a simplified parser - for production, use a proper JS parser
    # For now, we'll use a regex-based approach
    data = {}
    
    # Extract county blocks
    county_blocks = re.findall(r'"([^"]+)":\s*\{', obj_str)
    
    for county_slug in county_blocks:
        # Extract overall data
        overall_pattern = rf'"{county_slug}":\s*\{{[^}}]*"overall":\s*\{{([^}}]+)\}}'
        overall_match = re.search(overall_pattern, obj_str, re.DOTALL)
        
        if overall_match:
            overall_str = overall_match.group(1)
            overall = {}
            for key, value in re.findall(r'"?([^"]+)"?:\s*(\d+)', overall_str):
                overall[key] = int(value)
        
        # Extract practice areas
        practice_pattern = rf'"{county_slug}":\s*\{{[^}}]*"practiceAreas":\s*\{{([^}}]+)\}}'
        practice_match = re.search(practice_pattern, obj_str, re.DOTALL)
        
        if practice_match:
            practice_str = practice_match.group(1)
            practice_areas = {}
            # Parse each practice area
            for pa_match in re.finditer(r'"([^"]+)":\s*\{{([^}}]+)\}}', practice_str):
                pa_slug = pa_match.group(1)
                pa_data_str = pa_match.group(2)
                pa_data = {}
                for key, value in re.findall(r'"?([^"]+)"?:\s*"?([^"]+)"?', pa_data_str):
                    if value.isdigit():
                        pa_data[key] = int(value)
                    else:
                        pa_data[key] = value
                practice_areas[pa_slug] = pa_data
        
        data[county_slug] = {
            'overall': overall,
            'practiceAreas': practice_areas
        }
    
    return data

def generate_sql_inserts(data):
    """Generate SQL INSERT statements"""
    sql_statements = []
    
    sql_statements.append("-- ============================================")
    sql_statements.append("-- POPULATE WEB_AVAILABILITY_COUNTY AND WEB_AVAILABILITY_PRACTICE_AREA_SEATS")
    sql_statements.append("-- Generated from marketing/county-cap.html practiceAreaData")
    sql_statements.append("-- ============================================\n")
    
    sql_statements.append("-- Clear existing data (optional - comment out if you want to keep existing)")
    sql_statements.append("-- TRUNCATE TABLE web_availability_practice_area_seats CASCADE;")
    sql_statements.append("-- TRUNCATE TABLE web_availability_county CASCADE;\n")
    
    # Determine state from county slug or name
    def get_state_code(county_slug):
        # Florida counties
        fl_counties = ['miami-dade', 'broward', 'palm-beach', 'hillsborough', 'orange', 
                      'duval', 'pinellas', 'brevard', 'volusia', 'polk', 'lee', 'sarasota',
                      'manatee', 'escambia', 'marion', 'alachua', 'leon', 'okaloosa',
                      'seminole', 'pasco', 'hernando', 'citrus', 'lake', 'st-lucie',
                      'indian-river', 'martin', 'charlotte', 'collier', 'bay', 'osceola',
                      'clay', 'santa-rosa', 'walton', 'highlands', 'putnam', 'flagler',
                      'monroe', 'gadsden', 'sumter', 'taylor', 'columbia', 'suwannee',
                      'washington', 'calhoun', 'franklin', 'gulf', 'holmes', 'jackson',
                      'jefferson', 'lafayette', 'liberty', 'madison', 'union', 'wakulla',
                      'baker', 'bradford', 'dixie', 'gilchrist', 'hamilton', 'hardee',
                      'hendry', 'levy']
        
        if county_slug in fl_counties:
            return 'FL'
        else:
            return 'CA'  # Default to CA for others
    
    # Generate INSERT statements for counties
    sql_statements.append("-- ============================================")
    sql_statements.append("-- INSERT COUNTY DATA")
    sql_statements.append("-- ============================================\n")
    
    for county_slug, county_data in data.items():
        overall = county_data.get('overall', {})
        state_code = get_state_code(county_slug)
        
        # Format county name from slug
        county_name = county_slug.replace('-', ' ').title()
        # Handle special cases
        if county_slug == 'miami-dade':
            county_name = 'Miami-Dade'
        elif county_slug == 'st-lucie':
            county_name = 'St. Lucie'
        
        sql_statements.append(f"-- {county_name} County, {state_code}")
        sql_statements.append(f"""INSERT INTO web_availability_county (
    state_code, county_slug, county_name,
    total_firms, total_seats, premium_total, standard_total,
    filled, premium_remaining, standard_remaining, is_active
) VALUES (
    '{state_code}',
    '{county_slug}',
    '{county_name}',
    {overall.get('totalFirms', overall.get('total_firms', 0))},
    {overall.get('totalSeats', overall.get('total_seats', 0))},
    {overall.get('premiumTotal', overall.get('premium_total', 0))},
    {overall.get('standardTotal', overall.get('standard_total', 0))},
    {overall.get('filled', 0)},
    {overall.get('premiumRemaining', overall.get('premium_remaining', 0))},
    {overall.get('standardRemaining', overall.get('standard_remaining', 0))},
    true
)
ON CONFLICT (state_code, county_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    total_seats = EXCLUDED.total_seats,
    premium_total = EXCLUDED.premium_total,
    standard_total = EXCLUDED.standard_total,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    updated_at = now();
""")
    
    # Generate INSERT statements for practice areas
    sql_statements.append("\n-- ============================================")
    sql_statements.append("-- INSERT PRACTICE AREA DATA")
    sql_statements.append("-- ============================================\n")
    
    for county_slug, county_data in data.items():
        practice_areas = county_data.get('practiceAreas', {})
        state_code = get_state_code(county_slug)
        
        if not practice_areas:
            continue
        
        sql_statements.append(f"-- Practice areas for {county_slug}")
        
        for pa_slug, pa_data in practice_areas.items():
            display_order = PRACTICE_AREA_ORDER.get(pa_slug, 0)
            total_firms = pa_data.get('totalFirms', pa_data.get('firms', 0))
            
            sql_statements.append(f"""INSERT INTO web_availability_practice_area_seats (
    county_availability_id, practice_area_slug, practice_area_name,
    total_firms, cap, premium, standard,
    filled, premium_remaining, standard_remaining,
    display_order, is_active
) 
SELECT 
    id,
    '{pa_slug}',
    '{pa_data.get("name", "")}',
    {total_firms},
    {pa_data.get('cap', 0)},
    {pa_data.get('premium', 0)},
    {pa_data.get('standard', 0)},
    {pa_data.get('filled', 0)},
    {pa_data.get('premiumRemaining', pa_data.get('premium_remaining', 0))},
    {pa_data.get('standardRemaining', pa_data.get('standard_remaining', 0))},
    {display_order},
    true
FROM web_availability_county
WHERE state_code = '{state_code}' AND county_slug = '{county_slug}'
ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET
    total_firms = EXCLUDED.total_firms,
    cap = EXCLUDED.cap,
    premium = EXCLUDED.premium,
    standard = EXCLUDED.standard,
    filled = EXCLUDED.filled,
    premium_remaining = EXCLUDED.premium_remaining,
    standard_remaining = EXCLUDED.standard_remaining,
    display_order = EXCLUDED.display_order,
    updated_at = now();
""")
    
    sql_statements.append("\n-- ============================================")
    sql_statements.append("-- VERIFICATION")
    sql_statements.append("-- ============================================\n")
    
    sql_statements.append("SELECT 'County records:' AS type, COUNT(*) AS count FROM web_availability_county;")
    sql_statements.append("SELECT 'Practice area records:' AS type, COUNT(*) AS count FROM web_availability_practice_area_seats;")
    sql_statements.append("\nSELECT state_code, COUNT(*) AS county_count FROM web_availability_county GROUP BY state_code;")
    
    return '\n'.join(sql_statements)

def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.dirname(script_dir)
    html_file = os.path.join(project_root, 'marketing', 'county-cap.html')
    output_file = os.path.join(project_root, 'supabase', 'POPULATE_COUNTY_AVAILABILITY_DATA.sql')
    
    print(f"Reading data from: {html_file}")
    data = extract_practice_area_data(html_file)
    
    print(f"Found {len(data)} counties")
    
    print(f"Generating SQL...")
    sql = generate_sql_inserts(data)
    
    print(f"Writing SQL to: {output_file}")
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(sql)
    
    print(f"✅ SQL file generated: {output_file}")
    print(f"   Ready to run in Supabase SQL Editor")

if __name__ == '__main__':
    main()

