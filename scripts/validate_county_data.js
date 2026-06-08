/**
 * VALIDATION SCRIPT - Run BEFORE generating SQL files
 * 
 * This script validates county data for anomalies and errors:
 * - Checks for unrealistic values (too high/low)
 * - Validates calculations (total_seats = 33% of total_firms)
 * - Flags counties that don't meet threshold
 * - Compares against known good values
 * - Generates validation report
 */

const fs = require('fs');

// Known good values for major counties (validation baseline)
const KNOWN_GOOD_VALUES = {
    'CA': {
        'los-angeles': { min: 8000, max: 10000, expected: 9000 },
        'san-diego': { min: 2500, max: 3000, expected: 2700 },
        'orange': { min: 2900, max: 3100, expected: 2974 },
        'san-francisco': { min: 1200, max: 1500, expected: 1400 },
        'santa-clara': { min: 850, max: 1000, expected: 950 },
        'alameda': { min: 700, max: 800, expected: 750 }
    },
    'TX': {
        'harris': { min: 3500, max: 4500, expected: 4000 },
        'dallas': { min: 3000, max: 4000, expected: 3500 },
        'travis': { min: 1500, max: 2000, expected: 1800 }
    },
    'FL': {
        'miami-dade': { min: 4000, max: 5500, expected: 5000 },
        'broward': { min: 2000, max: 3000, expected: 2500 },
        'palm-beach': { min: 1500, max: 2500, expected: 2000 }
    },
    'NY': {
        'new-york': { min: 8000, max: 12000, expected: 10000 },
        'kings': { min: 2000, max: 3000, expected: 2500 },
        'queens': { min: 1500, max: 2500, expected: 2000 }
    },
    'OH': {
        'cuyahoga': { min: 2400, max: 2600, expected: 2500 },
        'franklin': { min: 1700, max: 1900, expected: 1800 },
        'hamilton': { min: 1450, max: 1550, expected: 1500 },
        'lucas': { min: 750, max: 850, expected: 800 },
        'montgomery': { min: 550, max: 650, expected: 600 }
    },
    'GA': {
        'fulton': { min: 1700, max: 1900, expected: 1800 },
        'cobb': { min: 600, max: 650, expected: 620 },
        'dekalb': { min: 590, max: 630, expected: 610 },
        'gwinnett': { min: 430, max: 470, expected: 450 },
        'chatham': { min: 330, max: 370, expected: 350 }
    },
    'NC': {
        'mecklenburg': { min: 900, max: 950, expected: 920 },
        'wake': { min: 820, max: 860, expected: 840 },
        'guilford': { min: 260, max: 280, expected: 270 },
        'forsyth': { min: 190, max: 210, expected: 200 },
        'durham': { min: 190, max: 210, expected: 200 }
    },
    'MI': {
        'wayne': { min: 1700, max: 1900, expected: 1800 },
        'oakland': { min: 1150, max: 1250, expected: 1200 },
        'macomb': { min: 580, max: 620, expected: 600 },
        'washtenaw': { min: 430, max: 470, expected: 450 },
        'kent': { min: 530, max: 570, expected: 550 }
    },
    'NJ': {
        'bergen': { min: 660, max: 700, expected: 680 },
        'essex': { min: 570, max: 610, expected: 590 },
        'monmouth': { min: 440, max: 480, expected: 460 },
        'morris': { min: 400, max: 440, expected: 420 },
        'camden': { min: 340, max: 370, expected: 350 }
    },
    'VA': {
        'fairfax': { min: 1150, max: 1250, expected: 1200 },
        'arlington': { min: 430, max: 470, expected: 450 },
        'henrico': { min: 480, max: 520, expected: 500 },
        'chesterfield': { min: 370, max: 390, expected: 380 },
        'virginia-beach': { min: 390, max: 410, expected: 400 }
    },
    'MD': {
        'baltimore-city': { min: 1150, max: 1250, expected: 1200 },
        'montgomery': { min: 1350, max: 1450, expected: 1400 },
        'baltimore': { min: 780, max: 820, expected: 800 },
        'anne-arundel': { min: 580, max: 620, expected: 600 },
        'howard': { min: 480, max: 520, expected: 500 }
    }
};

// Validation rules
const VALIDATION_RULES = {
    MIN_FIRMS: 1,
    MAX_FIRMS: 20000, // Sanity check - no county should exceed this
    MIN_SEATS_THRESHOLD: 20, // Must have > 20 seats (63+ firms)
    SEATS_CALCULATION_TOLERANCE: 0.05, // 5% tolerance for rounding
    MAX_SEATS_TO_FIRMS_RATIO: 0.5 // Seats should never exceed 50% of firms (sanity check)
};

function validateCountyData(stateCode, countySlug, countyName, totalFirms, totalSeats, premiumTotal, standardTotal) {
    const errors = [];
    const warnings = [];
    
    // 1. Check total_firms is within reasonable range
    if (totalFirms < VALIDATION_RULES.MIN_FIRMS) {
        errors.push(`total_firms (${totalFirms}) is below minimum (${VALIDATION_RULES.MIN_FIRMS})`);
    }
    if (totalFirms > VALIDATION_RULES.MAX_FIRMS) {
        errors.push(`total_firms (${totalFirms}) exceeds maximum sanity check (${VALIDATION_RULES.MAX_FIRMS})`);
    }
    
    // 2. Validate total_seats calculation (should be 33% of total_firms)
    const expectedSeats = Math.round(totalFirms * 0.33);
    const seatsDifference = Math.abs(totalSeats - expectedSeats);
    const tolerance = Math.max(1, Math.round(expectedSeats * VALIDATION_RULES.SEATS_CALCULATION_TOLERANCE));
    
    if (seatsDifference > tolerance) {
        errors.push(`total_seats (${totalSeats}) doesn't match 33% calculation. Expected: ${expectedSeats}, Difference: ${seatsDifference}`);
    }
    
    // 3. Check seats don't exceed firms (sanity check)
    if (totalSeats > totalFirms * VALIDATION_RULES.MAX_SEATS_TO_FIRMS_RATIO) {
        errors.push(`total_seats (${totalSeats}) exceeds ${VALIDATION_RULES.MAX_SEATS_TO_FIRMS_RATIO * 100}% of total_firms (${totalFirms})`);
    }
    
    // 4. Check threshold (must have > 20 seats)
    if (totalSeats <= VALIDATION_RULES.MIN_SEATS_THRESHOLD) {
        warnings.push(`total_seats (${totalSeats}) is ≤ ${VALIDATION_RULES.MIN_SEATS_THRESHOLD} - will be skipped`);
    }
    
    // 5. Validate premium/standard calculation
    const expectedPremium = Math.round(totalSeats * 0.21);
    const premiumDifference = Math.abs(premiumTotal - expectedPremium);
    if (premiumDifference > 2) { // Allow 2 seat difference for rounding
        errors.push(`premium_total (${premiumTotal}) doesn't match 21% calculation. Expected: ${expectedPremium}, Difference: ${premiumDifference}`);
    }
    
    const expectedStandard = totalSeats - premiumTotal;
    if (standardTotal !== expectedStandard) {
        errors.push(`standard_total (${standardTotal}) doesn't match calculation. Expected: ${expectedStandard}, Got: ${standardTotal}`);
    }
    
    // 6. Check against known good values (if available)
    if (KNOWN_GOOD_VALUES[stateCode] && KNOWN_GOOD_VALUES[stateCode][countySlug]) {
        const knownGood = KNOWN_GOOD_VALUES[stateCode][countySlug];
        if (totalFirms < knownGood.min || totalFirms > knownGood.max) {
            errors.push(`total_firms (${totalFirms}) is outside expected range [${knownGood.min}, ${knownGood.max}]. Expected: ~${knownGood.expected}`);
        }
    }
    
    // 7. Check for suspiciously round numbers (might indicate placeholder data)
    if (totalFirms % 100 === 0 && totalFirms > 1000) {
        warnings.push(`total_firms (${totalFirms}) is a round number - verify this is actual data, not placeholder`);
    }
    
    return { errors, warnings };
}

// State-level validation expectations
const STATE_EXPECTATIONS = {
    'OH': {
        expectedCountyCount: { min: 70, max: 80, expected: 75 },
        expectedTotalFirms: { min: 9000, max: 11000, expected: 10171 },
        description: 'Ohio: ~75 counties with >63 firms, ~10,171 total firms statewide'
    },
    'CA': {
        expectedCountyCount: { min: 40, max: 55, expected: 46 },
        expectedTotalFirms: { min: 25000, max: 35000, expected: 30000 },
        description: 'California: ~46 counties with >63 firms'
    },
    'TX': {
        expectedCountyCount: { min: 30, max: 35, expected: 32 },
        expectedTotalFirms: { min: 12000, max: 18000, expected: 15000 },
        description: 'Texas: ~32 counties with >63 firms'
    }
};

function validateStateData(stateCode, countyDataArray) {
    const validationReport = {
        state: stateCode,
        totalCounties: countyDataArray.length,
        errors: [],
        warnings: [],
        passed: [],
        failed: [],
        skipped: []
    };
    
    // State-level validation checks
    if (STATE_EXPECTATIONS[stateCode]) {
        const expectations = STATE_EXPECTATIONS[stateCode];
        
        // Check county count (warning only - incomplete data is better than no data)
        if (validationReport.totalCounties < expectations.expectedCountyCount.min || 
            validationReport.totalCounties > expectations.expectedCountyCount.max) {
            validationReport.warnings.push(
                `County count (${validationReport.totalCounties}) is outside expected range [${expectations.expectedCountyCount.min}, ${expectations.expectedCountyCount.max}]. ` +
                `Expected: ~${expectations.expectedCountyCount.expected} counties. ${expectations.description} ` +
                `(Note: Partial data will be generated - can expand later)`
            );
        }
        
        // Check total firms (warning only - will be adjusted when more counties added)
        const totalFirms = countyDataArray.reduce((sum, c) => sum + c.totalFirms, 0);
        if (totalFirms < expectations.expectedTotalFirms.min || 
            totalFirms > expectations.expectedTotalFirms.max) {
            validationReport.warnings.push(
                `Total firms (${totalFirms}) is outside expected range [${expectations.expectedTotalFirms.min}, ${expectations.expectedTotalFirms.max}]. ` +
                `Expected: ~${expectations.expectedTotalFirms.expected} firms statewide. ` +
                `(Note: Will adjust when more counties are added)`
            );
        }
    }
    
    countyDataArray.forEach(county => {
        const { countySlug, countyName, totalFirms, totalSeats, premiumTotal, standardTotal } = county;
        
        const validation = validateCountyData(
            stateCode,
            countySlug,
            countyName,
            totalFirms,
            totalSeats,
            premiumTotal,
            standardTotal
        );
        
        const countyResult = {
            countySlug,
            countyName,
            totalFirms,
            totalSeats,
            errors: validation.errors,
            warnings: validation.warnings
        };
        
        if (validation.errors.length > 0) {
            validationReport.errors.push(...validation.errors.map(e => `${countyName}: ${e}`));
            validationReport.failed.push(countyResult);
        } else if (totalSeats <= VALIDATION_RULES.MIN_SEATS_THRESHOLD) {
            validationReport.skipped.push(countyResult);
        } else {
            validationReport.passed.push(countyResult);
        }
        
        if (validation.warnings.length > 0) {
            validationReport.warnings.push(...validation.warnings.map(w => `${countyName}: ${w}`));
        }
    });
    
    return validationReport;
}

function generateValidationReport(reports) {
    let report = '\n';
    report += '='.repeat(80) + '\n';
    report += 'COUNTY DATA VALIDATION REPORT\n';
    report += '='.repeat(80) + '\n\n';
    
    reports.forEach(stateReport => {
        report += `\nState: ${stateReport.state}\n`;
        report += '-'.repeat(80) + '\n';
        report += `Total Counties: ${stateReport.totalCounties}\n`;
        report += `✅ Passed: ${stateReport.passed.length}\n`;
        report += `❌ Failed: ${stateReport.failed.length}\n`;
        report += `⏭️  Skipped (≤20 seats): ${stateReport.skipped.length}\n\n`;
        
        if (stateReport.errors.length > 0) {
            report += '❌ ERRORS (MUST FIX):\n';
            stateReport.errors.forEach(error => {
                report += `   - ${error}\n`;
            });
            report += '\n';
        }
        
        if (stateReport.warnings.length > 0) {
            report += '⚠️  WARNINGS:\n';
            stateReport.warnings.forEach(warning => {
                report += `   - ${warning}\n`;
            });
            report += '\n';
        }
        
        if (stateReport.failed.length > 0) {
            report += 'Failed Counties:\n';
            stateReport.failed.forEach(county => {
                report += `   - ${county.countyName} (${county.countySlug}):\n`;
                report += `     Firms: ${county.totalFirms}, Seats: ${county.totalSeats}\n`;
                county.errors.forEach(error => {
                    report += `     ❌ ${error}\n`;
                });
            });
            report += '\n';
        }
    });
    
    const totalErrors = reports.reduce((sum, r) => sum + r.errors.length, 0);
    const totalWarnings = reports.reduce((sum, r) => sum + r.warnings.length, 0);
    
    report += '='.repeat(80) + '\n';
    report += `SUMMARY: ${totalErrors} errors, ${totalWarnings} warnings\n`;
    
    if (totalErrors > 0) {
        report += '❌ VALIDATION FAILED - DO NOT GENERATE SQL FILES\n';
        report += 'Fix all errors before proceeding.\n';
    } else {
        report += '✅ VALIDATION PASSED - Safe to generate SQL files\n';
    }
    
    report += '='.repeat(80) + '\n';
    
    return report;
}

// Export for use in other scripts
module.exports = {
    validateCountyData,
    validateStateData,
    generateValidationReport,
    VALIDATION_RULES,
    KNOWN_GOOD_VALUES
};

// If run directly, show usage
if (require.main === module) {
    console.log(`
County Data Validation Script

Usage:
  This script is imported by generation scripts to validate data before SQL generation.

  To validate data manually, import this module in your generation script:
  
  const { validateStateData, generateValidationReport } = require('./validate_county_data');
  
  // After calculating county data:
  const report = validateStateData('CA', countyDataArray);
  console.log(generateValidationReport([report]));
  
  // Check for errors:
  if (report.errors.length > 0) {
      console.error('❌ Validation failed - fix errors before generating SQL');
      process.exit(1);
  }
    `);
}

