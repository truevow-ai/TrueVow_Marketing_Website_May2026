// ============================================
// Multi-Source Law Firm Count Validation
// Validates law firm counts from 5 independent sources
// ============================================

const { Client } = require('pg');
const fs = require('fs');
require('dotenv').config({ path: '.env.local' });

// Get connection details
let SUPABASE_DB_HOST, SUPABASE_DB_PORT, SUPABASE_DB_NAME, SUPABASE_DB_USER, SUPABASE_DB_PASSWORD;
let decodedPassword = null;

const connectionString = process.env.SUPABASE_DB_URL || process.env.MARKETING_DATABASE_URL;
if (connectionString && connectionString.startsWith('postgresql://')) {
    try {
        const url = new URL(connectionString);
        SUPABASE_DB_USER = url.username || 'postgres';
        SUPABASE_DB_PASSWORD = url.password ? decodeURIComponent(url.password) : null;
        SUPABASE_DB_HOST = url.hostname;
        SUPABASE_DB_PORT = parseInt(url.port || '5432');
        SUPABASE_DB_NAME = url.pathname.slice(1) || 'postgres';
    } catch (e) {}
}

SUPABASE_DB_HOST = SUPABASE_DB_HOST || process.env.MARKETING_DB_HOST || 'db.napwpkagxzqfpbearkjs.supabase.co';
SUPABASE_DB_PORT = SUPABASE_DB_PORT || parseInt(process.env.MARKETING_DB_PORT || '5432');
SUPABASE_DB_NAME = SUPABASE_DB_NAME || process.env.MARKETING_DB_NAME || 'postgres';
SUPABASE_DB_USER = SUPABASE_DB_USER || process.env.MARKETING_DB_USER || 'postgres';

const rawPassword = SUPABASE_DB_PASSWORD || process.env.MARKETING_DATABASE_PASSWORD;
SUPABASE_DB_PASSWORD = rawPassword;

if (rawPassword && rawPassword.includes('%')) {
    try {
        decodedPassword = decodeURIComponent(rawPassword);
    } catch (e) {}
}

// ============================================
// VALIDATION SOURCES
// ============================================

const VALIDATION_SOURCES = {
    'BLS_QCEW': {
        name: 'BLS QCEW Database',
        url: 'https://www.bls.gov/cew/',
        description: 'U.S. Bureau of Labor Statistics Quarterly Census of Employment and Wages',
        industry: 'NAICS 54111 (Offices of Lawyers)',
        method: 'manual', // Requires manual data entry from BLS website
        reliability: 'high'
    },
    'FLORIDA_BAR': {
        name: 'Florida Bar Association',
        url: 'https://www.floridabar.org/',
        description: 'Florida Bar member directory by county',
        method: 'manual', // May require membership or data request
        reliability: 'high'
    },
    'MARTINDALE_HUBBELL': {
        name: 'Martindale-Hubbell',
        url: 'https://www.martindale.com/',
        description: 'Legal directory - attorney listings by county',
        method: 'web_scrape', // Can be scraped or manually counted
        reliability: 'medium'
    },
    'AVVO': {
        name: 'Avvo',
        url: 'https://www.avvo.com/',
        description: 'Attorney directory and ratings - search by location',
        method: 'web_scrape', // Can be scraped or manually counted
        reliability: 'medium'
    },
    'FINDLAW': {
        name: 'FindLaw',
        url: 'https://www.findlaw.com/',
        description: 'Attorney directory - search by county',
        method: 'web_scrape', // Can be scraped or manually counted
        reliability: 'medium'
    },
    'CENSUS_BUSINESS_PATTERNS': {
        name: 'Census County Business Patterns',
        url: 'https://www.census.gov/data/datasets.html',
        description: 'Census Bureau County Business Patterns - NAICS 5411',
        method: 'manual', // Requires data download
        reliability: 'high'
    }
};

// ============================================
// VALIDATION FUNCTIONS
// ============================================

function calculatePerCapitaRatio(lawOffices, population) {
    if (!population || population === 0) return null;
    return lawOffices / population;
}

function validatePerCapitaRatio(ratio, countyType) {
    const benchmarks = {
        'rural': { min: 0.0003, max: 0.0010 },
        'small_metro': { min: 0.0008, max: 0.0015 },
        'medium_metro': { min: 0.0010, max: 0.0018 },
        'major_metro': { min: 0.0012, max: 0.0020 }
    };
    
    const range = benchmarks[countyType] || benchmarks.rural;
    return {
        valid: ratio >= range.min && ratio <= range.max,
        range: range,
        ratio: ratio
    };
}

function determineCountyType(population) {
    if (population < 50000) return 'rural';
    if (population < 200000) return 'small_metro';
    if (population < 1000000) return 'medium_metro';
    return 'major_metro';
}

function calculateConsensusValue(sources) {
    // Remove null/undefined values
    const validSources = sources.filter(s => s.value !== null && s.value !== undefined);
    
    if (validSources.length === 0) return null;
    if (validSources.length === 1) return validSources[0].value;
    
    // Calculate median (more robust than mean for outliers)
    const values = validSources.map(s => s.value).sort((a, b) => a - b);
    const mid = Math.floor(values.length / 2);
    const median = values.length % 2 === 0 
        ? (values[mid - 1] + values[mid]) / 2 
        : values[mid];
    
    // Calculate mean
    const mean = values.reduce((sum, val) => sum + val, 0) / values.length;
    
    // Use median if sources vary widely, otherwise use mean
    const variance = values.reduce((sum, val) => sum + Math.pow(val - mean, 2), 0) / values.length;
    const stdDev = Math.sqrt(variance);
    
    return stdDev > mean * 0.3 ? median : Math.round(mean);
}

function validateSourceAgreement(sources) {
    const validSources = sources.filter(s => s.value !== null && s.value !== undefined);
    
    if (validSources.length < 2) {
        return {
            agreement: 'insufficient',
            confidence: 'low',
            message: 'Need at least 2 sources for validation'
        };
    }
    
    const values = validSources.map(s => s.value);
    const min = Math.min(...values);
    const max = Math.max(...values);
    const range = max - min;
    const avg = values.reduce((sum, val) => sum + val, 0) / values.length;
    const percentDifference = (range / avg) * 100;
    
    let agreement, confidence;
    if (percentDifference < 10) {
        agreement = 'excellent';
        confidence = 'high';
    } else if (percentDifference < 25) {
        agreement = 'good';
        confidence = 'medium';
    } else if (percentDifference < 50) {
        agreement = 'fair';
        confidence = 'medium';
    } else {
        agreement = 'poor';
        confidence = 'low';
    }
    
    return {
        agreement,
        confidence,
        percentDifference: percentDifference.toFixed(1),
        range: `${min} - ${max}`,
        consensus: calculateConsensusValue(sources)
    };
}

// ============================================
// MAIN VALIDATION FUNCTION
// ============================================

async function validateCounty(countySlug, stateCode, countyName, population) {
    const report = {
        county: `${countyName} County, ${stateCode}`,
        slug: countySlug,
        population: population,
        sources: {},
        validation: {}
    };
    
    console.log(`\n${'='.repeat(70)}`);
    console.log(`Validating: ${report.county}`);
    console.log('='.repeat(70));
    
    // Source 1: Current Database Value
    report.sources.DATABASE = {
        name: 'Current Database',
        value: null, // Will be filled from database query
        reliability: 'medium',
        note: 'Current value stored in database'
    };
    
    // Source 2-6: Manual entry required (these would be filled by user or automated scraping)
    report.sources.BLS_QCEW = {
        name: VALIDATION_SOURCES.BLS_QCEW.name,
        value: null, // User must enter from BLS website
        url: VALIDATION_SOURCES.BLS_QCEW.url,
        reliability: VALIDATION_SOURCES.BLS_QCEW.reliability,
        note: 'Enter value from BLS QCEW database (NAICS 54111)'
    };
    
    report.sources.FLORIDA_BAR = {
        name: VALIDATION_SOURCES.FLORIDA_BAR.name,
        value: null, // User must enter from Florida Bar
        url: VALIDATION_SOURCES.FLORIDA_BAR.url,
        reliability: VALIDATION_SOURCES.FLORIDA_BAR.reliability,
        note: 'Enter value from Florida Bar directory'
    };
    
    report.sources.MARTINDALE_HUBBELL = {
        name: VALIDATION_SOURCES.MARTINDALE_HUBBELL.name,
        value: null, // Could be scraped or manually entered
        url: VALIDATION_SOURCES.MARTINDALE_HUBBELL.url,
        reliability: VALIDATION_SOURCES.MARTINDALE_HUBBELL.reliability,
        note: 'Count attorneys/firms listed for this county'
    };
    
    report.sources.AVVO = {
        name: VALIDATION_SOURCES.AVVO.name,
        value: null,
        url: VALIDATION_SOURCES.AVVO.url,
        reliability: VALIDATION_SOURCES.AVVO.reliability,
        note: 'Count attorneys listed for this county'
    };
    
    report.sources.FINDLAW = {
        name: VALIDATION_SOURCES.FINDLAW.name,
        value: null,
        url: VALIDATION_SOURCES.FINDLAW.url,
        reliability: VALIDATION_SOURCES.FINDLAW.reliability,
        note: 'Count attorneys/firms listed for this county'
    };
    
    // Get current database value
    let client;
    try {
        client = new Client({
            host: SUPABASE_DB_HOST,
            port: SUPABASE_DB_PORT,
            database: SUPABASE_DB_NAME,
            user: SUPABASE_DB_USER,
            password: SUPABASE_DB_PASSWORD,
            ssl: { rejectUnauthorized: false }
        });
        await client.connect();
        
        const result = await client.query(`
            SELECT total_firms
            FROM web_availability_county
            WHERE county_slug = $1 AND state_code = $2 AND is_active = true
        `, [countySlug, stateCode]);
        
        if (result.rows.length > 0) {
            const estimatedBLS = Math.round(result.rows[0].total_firms / 0.67);
            report.sources.DATABASE.value = estimatedBLS;
        }
        
        await client.end();
    } catch (error) {
        console.error('Database error:', error.message);
    }
    
    // Calculate per-capita validation
    if (population && report.sources.DATABASE.value) {
        const ratio = calculatePerCapitaRatio(report.sources.DATABASE.value, population);
        const countyType = determineCountyType(population);
        const perCapitaCheck = validatePerCapitaRatio(ratio, countyType);
        
        report.validation.perCapita = {
            ratio: ratio,
            countyType: countyType,
            valid: perCapitaCheck.valid,
            expectedRange: `${perCapitaCheck.range.min.toFixed(6)} - ${perCapitaCheck.range.max.toFixed(6)}`,
            status: perCapitaCheck.valid ? '✅ Valid' : '⚠️  Outside expected range'
        };
    }
    
    // Source agreement validation (when multiple sources are provided)
    const sourceValues = Object.values(report.sources).filter(s => s.value !== null);
    if (sourceValues.length >= 2) {
        const agreement = validateSourceAgreement(Object.values(report.sources));
        report.validation.sourceAgreement = agreement;
    }
    
    // Generate report
    console.log('\n📊 SOURCE VALUES:');
    Object.entries(report.sources).forEach(([key, source]) => {
        const value = source.value !== null ? source.value : 'Not entered';
        const status = source.value !== null ? '✅' : '⏳';
        console.log(`   ${status} ${source.name}: ${value}`);
        if (source.url) console.log(`      URL: ${source.url}`);
        if (source.note) console.log(`      Note: ${source.note}`);
    });
    
    if (report.validation.perCapita) {
        console.log('\n📈 PER-CAPITA VALIDATION:');
        console.log(`   Ratio: ${report.validation.perCapita.ratio.toFixed(6)}`);
        console.log(`   County Type: ${report.validation.perCapita.countyType}`);
        console.log(`   Expected Range: ${report.validation.perCapita.expectedRange}`);
        console.log(`   Status: ${report.validation.perCapita.status}`);
    }
    
    if (report.validation.sourceAgreement) {
        console.log('\n🤝 SOURCE AGREEMENT:');
        console.log(`   Agreement: ${report.validation.sourceAgreement.agreement}`);
        console.log(`   Confidence: ${report.validation.sourceAgreement.confidence}`);
        console.log(`   Percent Difference: ${report.validation.sourceAgreement.percentDifference}%`);
        console.log(`   Range: ${report.validation.sourceAgreement.range}`);
        if (report.validation.sourceAgreement.consensus) {
            console.log(`   Consensus Value: ${report.validation.sourceAgreement.consensus}`);
        }
    }
    
    return report;
}

// ============================================
// VALIDATION TEMPLATE GENERATOR
// ============================================

function generateValidationTemplate(countySlug, stateCode, countyName, population) {
    const template = `
# Validation Template: ${countyName} County, ${stateCode}

## County Information
- **County**: ${countyName} County, ${stateCode}
- **Slug**: ${countySlug}
- **Population**: ${population || 'Unknown'}

## Source 1: BLS QCEW Database
- **URL**: https://www.bls.gov/cew/
- **Steps**:
  1. Go to "Single Screen Data Search"
  2. Select: NAICS 54111 (Offices of Lawyers)
  3. Select: ${stateCode} → ${countyName} County
  4. Period: Q1 2024
  5. Download establishment count
- **Value**: __________
- **Date Verified**: __________

## Source 2: ${stateCode === 'FL' ? 'Florida' : 'State'} Bar Association
- **URL**: ${stateCode === 'FL' ? 'https://www.floridabar.org/' : 'State Bar website'}
- **Method**: Search member directory by county
- **Value**: __________
- **Date Verified**: __________

## Source 3: Martindale-Hubbell
- **URL**: https://www.martindale.com/
- **Method**: Search attorneys by location (${countyName} County, ${stateCode})
- **Value**: __________
- **Date Verified**: __________

## Source 4: Avvo
- **URL**: https://www.avvo.com/
- **Method**: Search attorneys by location
- **Value**: __________
- **Date Verified**: __________

## Source 5: FindLaw
- **URL**: https://www.findlaw.com/
- **Method**: Search attorneys by county
- **Value**: __________
- **Date Verified**: __________

## Source 6: Census County Business Patterns
- **URL**: https://www.census.gov/data/datasets.html
- **Method**: Download County Business Patterns, filter by NAICS 5411
- **Value**: __________
- **Date Verified**: __________

## Validation Results
- **Consensus Value**: __________
- **Per-Capita Ratio**: __________
- **Status**: __________
`;
    
    return template;
}

// ============================================
// EXPORT FOR USE
// ============================================

if (require.main === module) {
    // Example usage
    const counties = [
        { slug: 'baker', state: 'FL', name: 'Baker', population: 27000 },
        { slug: 'calhoun', state: 'FL', name: 'Calhoun', population: 14000 }
    ];
    
    async function runValidation() {
        for (const county of counties) {
            const report = await validateCounty(county.slug, county.state, county.name, county.population);
            
            // Generate template
            const template = generateValidationTemplate(county.slug, county.state, county.name, county.population);
            const filename = `validation_${county.slug}_${county.state.toLowerCase()}.md`;
            fs.writeFileSync(filename, template);
            console.log(`\n📄 Template saved to: ${filename}`);
        }
    }
    
    runValidation().catch(console.error);
}

module.exports = {
    validateCounty,
    generateValidationTemplate,
    validateSourceAgreement,
    calculateConsensusValue,
    VALIDATION_SOURCES
};

