# Instructions to Populate County Availability Tables

## Quick Method (Recommended)

Since the HTML file is very large (13,000+ lines), use this simple approach:

### Option 1: Use Browser Console (Easiest)

1. Open `marketing/county-cap.html` in your browser
2. Open browser console (F12)
3. The `practiceAreaData` object is already loaded as `window.practiceAreaData`
4. Run this in console:

```javascript
// Copy this entire block and paste in browser console
const data = window.practiceAreaData;
const flCounties = new Set(['miami-dade', 'broward', 'palm-beach', /* ... all FL counties ... */]);
const practiceAreaOrder = {
    'personal-injury': 1, 'family-law': 2, 'immigration': 3,
    'criminal-defense': 4, 'employment-law': 5, 'bankruptcy': 6,
    'real-estate': 7, 'estate-planning': 8, 'workers-comp': 9
};

let sql = `-- POPULATE WEB_AVAILABILITY_COUNTY AND WEB_AVAILABILITY_PRACTICE_AREA_SEATS\n\n`;

// Generate county inserts
Object.keys(data).forEach(countySlug => {
    const overall = data[countySlug].overall;
    const stateCode = flCounties.has(countySlug) ? 'FL' : 'CA';
    let countyName = countySlug.replace(/-/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
    
    sql += `INSERT INTO web_availability_county (state_code, county_slug, county_name, total_firms, total_seats, premium_total, standard_total, filled, premium_remaining, standard_remaining, is_active) VALUES ('${stateCode}', '${countySlug}', '${countyName}', ${overall.totalFirms}, ${overall.totalSeats}, ${overall.premiumTotal}, ${overall.standardTotal}, ${overall.filled}, ${overall.premiumRemaining}, ${overall.standardRemaining}, true) ON CONFLICT (state_code, county_slug) DO UPDATE SET total_firms = EXCLUDED.total_firms, total_seats = EXCLUDED.total_seats, premium_total = EXCLUDED.premium_total, standard_total = EXCLUDED.standard_total, filled = EXCLUDED.filled, premium_remaining = EXCLUDED.premium_remaining, standard_remaining = EXCLUDED.standard_remaining, updated_at = now();\n`;
});

// Generate practice area inserts
Object.keys(data).forEach(countySlug => {
    const practiceAreas = data[countySlug].practiceAreas;
    const stateCode = flCounties.has(countySlug) ? 'FL' : 'CA';
    
    Object.keys(practiceAreas).forEach(paSlug => {
        const pa = practiceAreas[paSlug];
        const totalFirms = pa.totalFirms || pa.firms || 0;
        const displayOrder = practiceAreaOrder[paSlug] || 0;
        
        sql += `INSERT INTO web_availability_practice_area_seats (county_availability_id, practice_area_slug, practice_area_name, total_firms, cap, premium, standard, filled, premium_remaining, standard_remaining, display_order, is_active) SELECT id, '${paSlug}', '${pa.name.replace(/'/g, "''")}', ${totalFirms}, ${pa.cap}, ${pa.premium}, ${pa.standard}, ${pa.filled}, ${pa.premiumRemaining || pa.premium_remaining || 0}, ${pa.standardRemaining || pa.standard_remaining || 0}, ${displayOrder}, true FROM web_availability_county WHERE state_code = '${stateCode}' AND county_slug = '${countySlug}' ON CONFLICT (county_availability_id, practice_area_slug) DO UPDATE SET total_firms = EXCLUDED.total_firms, cap = EXCLUDED.cap, premium = EXCLUDED.premium, standard = EXCLUDED.standard, filled = EXCLUDED.filled, premium_remaining = EXCLUDED.premium_remaining, standard_remaining = EXCLUDED.standard_remaining, display_order = EXCLUDED.display_order, updated_at = now();\n`;
    });
});

console.log(sql);
// Copy the output and save to supabase/POPULATE_COUNTY_AVAILABILITY_DATA.sql
```

### Option 2: Run Script Locally

Run this in your terminal (not through me):

```bash
node scripts/generate_county_insert_sql.js
```

This will read the HTML file and generate the complete SQL file.

## Manual Method

If the above don't work, you can manually extract the data from `marketing/county-cap.html` starting at line 523 where `const practiceAreaData = {` begins.

The SQL file template is already created at `supabase/POPULATE_COUNTY_AVAILABILITY_DATA.sql` - you just need to populate it with all counties.

