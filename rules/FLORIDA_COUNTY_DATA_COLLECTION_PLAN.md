# Florida County Law Firm Data Collection & Implementation Plan

## Overview
Extend the Miami-Dade practice area dropdown functionality to all 67 Florida counties by collecting, validating, and implementing county-specific law firm data.

## Phase 1: Data Collection & Research

### Data Sources to Research:
1. **Florida Bar Association**
   - State Bar roster by county
   - Active attorney licenses by county
   - Practice area registrations

2. **Census Bureau Business Data**
   - Legal services establishments by county (NAICS 5411)
   - Employment statistics by county

3. **Clio Legal Trends Report 2024**
   - Civil filings by practice area
   - Firm size distribution by county

4. **State Court Administrative Data**
   - Case filings by practice area and county
   - Attorney representation data

5. **Martindale-Hubbell / Avvo / Legal Directories**
   - Attorney listings by county and practice area
   - Firm size indicators

### Data Points Needed Per County:
- **Total solo & small law firms** (<21 attorneys, active license)
- **Breakdown by 9 practice areas:**
  1. Personal Injury
  2. Family Law
  3. Immigration
  4. Criminal Defense
  5. Employment Law
  6. Real Estate
  7. Bankruptcy
  8. Estate Planning
  9. Workers' Compensation

### Calculation Formula:
- **33% Cap per practice area**: `Math.ceil(totalFirms * 0.33)`
- **21% Premium Tier pre-hold**: `Math.ceil(cap * 0.21)`
- **Standard seats**: `cap - premium`
- **Minimum seats**: 8 (even for small counties)

## Phase 2: Data Validation

### Validation Steps:
1. **Cross-reference multiple sources** (at least 2-3 independent sources)
2. **Check for outliers** (counties with unusually high/low counts)
3. **Verify practice area distribution** (should sum to total firms)
4. **Sanity checks:**
   - Larger counties (Miami-Dade, Broward, Orange) should have higher counts
   - Rural counties should have lower counts
   - Practice area distribution should reflect population demographics

### Validation Criteria:
- ✅ Data from at least 2 independent sources
- ✅ Practice area breakdowns sum to total firms (±5% tolerance)
- ✅ County rankings align with population rankings
- ✅ No negative numbers or impossible values

## Phase 3: Data Structure Implementation

### JavaScript Data Structure:
```javascript
const practiceAreaData = {
    "miami-dade": { /* existing data */ },
    "broward": {
        "overall": {
            "totalFirms": XXXX,
            "totalSeats": XXXX,
            "premiumTotal": XXXX,
            "standardTotal": XXXX,
            "filled": XXXX,
            "premiumRemaining": XXXX,
            "standardRemaining": XXXX
        },
        "practiceAreas": {
            "personal-injury": { /* ... */ },
            // ... all 9 practice areas
        }
    },
    // ... all 67 Florida counties
};
```

### County Name Mapping:
- Use lowercase with hyphens: `miami-dade`, `palm-beach`, `orange`, etc.
- Match exactly with `checkCountyData` county values

## Phase 4: Code Implementation

### Updates Needed:
1. **Expand `practiceAreaData` object** with all 67 counties
2. **Update `showAvailability()` function** to detect all Florida counties (not just Miami-Dade)
3. **Ensure `showPracticeAreaAvailability()` works for all counties**
4. **Test dropdown functionality** for multiple counties

### Implementation Checklist:
- [ ] Add data for all 67 Florida counties
- [ ] Update county detection logic in `showAvailability()`
- [ ] Test practice area dropdown for 5+ different counties
- [ ] Verify calculations (33% cap, 21% premium) are correct
- [ ] Ensure UI displays correctly for all counties

## Phase 5: Testing & Quality Assurance

### Test Cases:
1. Select different Florida counties → verify overall stats display
2. Select practice area → verify practice-area-specific stats
3. Check calculations match expected values
4. Verify UI layout works for counties with varying data sizes
5. Test edge cases (very small counties, very large counties)

## Data Collection Priority

### High Priority (Largest Counties - Start Here):
1. Miami-Dade ✅ (Already done)
2. Broward
3. Orange
4. Palm Beach
5. Hillsborough
6. Pinellas
7. Duval
8. Brevard
9. Polk
10. Volusia

### Medium Priority (Mid-Size Counties):
- Lee, Seminole, Pasco, Sarasota, Osceola, etc.

### Lower Priority (Smaller Counties):
- Rural counties with fewer firms

## Next Steps:
1. Research and compile data sources
2. Start with top 10 largest counties
3. Validate data accuracy
4. Implement in code
5. Test thoroughly
6. Expand to remaining counties

