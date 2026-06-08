# County Data Calculation Formula - STANDARD PROCESS

## ✅ CORRECT FORMULA (Finalized)

### Step 1: Total Law Offices
- Source: BLS QCEW (NAICS 54111) or validated from 3-5 sources
- Stored as: `total_firms` in database
- Example: Miami-Dade = 4325 law offices

### Step 2: Total Seats Calculation
```javascript
total_seats = total_firms < 24 
    ? Math.max(2, Math.round(total_firms * 0.33))  // Small counties: min 2
    : Math.round(total_firms * 0.33)              // Larger counties: just 33%, no minimum
```

**Examples:**
- Miami-Dade (4325 firms): 4325 × 0.33 = **1427 seats**
- St Johns (180 firms): 180 × 0.33 = **59 seats**
- Glenn (34 firms): 34 × 0.33 = **11 seats**
- Baker (12 firms): 12 × 0.33 = **4 seats** (but min 2, so **2 seats**)

### Step 3: Practice Area Distribution
- Solo/Small firms (67% of total): Used for practice area firm distribution only
- Practice area caps: Proportional to total_seats, not 33% of practice area firms
- For small counties (< 9 seats): Only largest practice areas get seats

### Step 4: Premium/Standard Seats
- Premium seats: 21% of the 33% cap (not 21% of total firms)
- Standard seats: Remaining from the 33% cap
- Example: If total_seats = 100, premium = 21, standard = 79

## ❌ WRONG FORMULAS (Never Use)

1. **WRONG**: `total_seats = 33% of solo/small firms`
   - This gives lower numbers (e.g., 2898 × 0.33 = 956 instead of 1427)

2. **WRONG**: `total_seats = sum of practice area minimums (9 × 1 = 9)`
   - This inflates small counties to 72 seats

3. **WRONG**: `total_firms = solo/small firms (67%)`
   - Should store actual total law offices, not the 67% subset

## ✅ Files Using Correct Formula

- `scripts/comprehensive_florida_validation_and_update.js` ✅
- `scripts/calculate_all_states_county_data.js` ✅ (now fixed)

## 📋 Process for New States (e.g., Texas)

1. Validate law firm counts from 3-5 sources (BLS, State Bar, directories)
2. Store `total_firms` = actual total law offices (not solo/small)
3. Calculate `total_seats` = 33% of `total_firms` (formula above)
4. Distribute practice areas proportionally
5. Calculate premium (21% of cap) and standard (remaining)
6. Insert into database

**This formula is now standardized and will be used for all future states.**

