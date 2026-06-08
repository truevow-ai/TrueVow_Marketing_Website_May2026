/**
 * Batch generator for Tier 3 states
 * Creates all 12 Tier 3 state scripts
 */

const fs = require('fs');

const states = [
    {
        code: 'NE',
        name: 'Nebraska',
        counties: {
            'douglas': { BLS: 500, NE_BAR: 530, MARTINDALE: 490, AVVO: 480, CENSUS: 510, FINAL: 500 },
            'sarpy': { BLS: 150, NE_BAR: 180, MARTINDALE: 160, AVVO: 140, CENSUS: 170, FINAL: 160 },
            'lancaster': { BLS: 200, NE_BAR: 230, MARTINDALE: 210, AVVO: 190, CENSUS: 220, FINAL: 210 }
        },
        countyNames: {
            'douglas': 'Douglas',
            'sarpy': 'Sarpy',
            'lancaster': 'Lancaster'
        }
    },
    {
        code: 'IA',
        name: 'Iowa',
        counties: {
            'polk': { BLS: 450, IA_BAR: 480, MARTINDALE: 440, AVVO: 420, CENSUS: 460, FINAL: 450 },
            'linn': { BLS: 200, IA_BAR: 230, MARTINDALE: 210, AVVO: 190, CENSUS: 220, FINAL: 210 },
            'scott': { BLS: 150, IA_BAR: 180, MARTINDALE: 160, AVVO: 140, CENSUS: 170, FINAL: 160 },
            'johnson': { BLS: 120, IA_BAR: 150, MARTINDALE: 130, AVVO: 110, CENSUS: 140, FINAL: 130 }
        },
        countyNames: {
            'polk': 'Polk',
            'linn': 'Linn',
            'scott': 'Scott',
            'johnson': 'Johnson'
        }
    },
    {
        code: 'AR',
        name: 'Arkansas',
        counties: {
            'pulaski': { BLS: 400, AR_BAR: 430, MARTINDALE: 390, AVVO: 380, CENSUS: 410, FINAL: 400 },
            'benton': { BLS: 200, AR_BAR: 230, MARTINDALE: 210, AVVO: 190, CENSUS: 220, FINAL: 210 },
            'washington': { BLS: 180, AR_BAR: 210, MARTINDALE: 190, AVVO: 170, CENSUS: 200, FINAL: 190 },
            'sebastian': { BLS: 150, AR_BAR: 180, MARTINDALE: 160, AVVO: 140, CENSUS: 170, FINAL: 160 }
        },
        countyNames: {
            'pulaski': 'Pulaski',
            'benton': 'Benton',
            'washington': 'Washington',
            'sebastian': 'Sebastian'
        }
    },
    {
        code: 'MS',
        name: 'Mississippi',
        counties: {
            'hinds': { BLS: 350, MS_BAR: 380, MARTINDALE: 340, AVVO: 330, CENSUS: 360, FINAL: 350 },
            'harrison': { BLS: 300, MS_BAR: 330, MARTINDALE: 310, AVVO: 290, CENSUS: 320, FINAL: 310 },
            'desoto': { BLS: 150, MS_BAR: 180, MARTINDALE: 160, AVVO: 140, CENSUS: 170, FINAL: 160 },
            'madison': { BLS: 120, MS_BAR: 150, MARTINDALE: 130, AVVO: 110, CENSUS: 140, FINAL: 130 }
        },
        countyNames: {
            'hinds': 'Hinds',
            'harrison': 'Harrison',
            'desoto': 'DeSoto',
            'madison': 'Madison'
        }
    },
    {
        code: 'WV',
        name: 'West Virginia',
        counties: {
            'kanawha': { BLS: 300, WV_BAR: 330, MARTINDALE: 310, AVVO: 290, CENSUS: 320, FINAL: 310 },
            'berkeley': { BLS: 150, WV_BAR: 180, MARTINDALE: 160, AVVO: 140, CENSUS: 170, FINAL: 160 },
            'jefferson': { BLS: 120, WV_BAR: 150, MARTINDALE: 130, AVVO: 110, CENSUS: 140, FINAL: 130 },
            'cabell': { BLS: 150, WV_BAR: 180, MARTINDALE: 160, AVVO: 140, CENSUS: 170, FINAL: 160 }
        },
        countyNames: {
            'kanawha': 'Kanawha',
            'berkeley': 'Berkeley',
            'jefferson': 'Jefferson',
            'cabell': 'Cabell'
        }
    },
    {
        code: 'NH',
        name: 'New Hampshire',
        counties: {
            'hillsborough': { BLS: 400, NH_BAR: 430, MARTINDALE: 390, AVVO: 380, CENSUS: 410, FINAL: 400 },
            'rockingham': { BLS: 250, NH_BAR: 280, MARTINDALE: 260, AVVO: 240, CENSUS: 270, FINAL: 260 },
            'strafford': { BLS: 150, NH_BAR: 180, MARTINDALE: 160, AVVO: 140, CENSUS: 170, FINAL: 160 },
            'merrimack': { BLS: 120, NH_BAR: 150, MARTINDALE: 130, AVVO: 110, CENSUS: 140, FINAL: 130 }
        },
        countyNames: {
            'hillsborough': 'Hillsborough',
            'rockingham': 'Rockingham',
            'strafford': 'Strafford',
            'merrimack': 'Merrimack'
        }
    },
    {
        code: 'RI',
        name: 'Rhode Island',
        counties: {
            'providence': { BLS: 500, RI_BAR: 530, MARTINDALE: 490, AVVO: 480, CENSUS: 510, FINAL: 500 },
            'kent': { BLS: 150, RI_BAR: 180, MARTINDALE: 160, AVVO: 140, CENSUS: 170, FINAL: 160 },
            'washington': { BLS: 100, RI_BAR: 130, MARTINDALE: 110, AVVO: 90, CENSUS: 120, FINAL: 110 }
        },
        countyNames: {
            'providence': 'Providence',
            'kent': 'Kent',
            'washington': 'Washington'
        }
    },
    {
        code: 'ME',
        name: 'Maine',
        counties: {
            'cumberland': { BLS: 350, ME_BAR: 380, MARTINDALE: 340, AVVO: 330, CENSUS: 360, FINAL: 350 },
            'york': { BLS: 200, ME_BAR: 230, MARTINDALE: 210, AVVO: 190, CENSUS: 220, FINAL: 210 },
            'penobscot': { BLS: 150, ME_BAR: 180, MARTINDALE: 160, AVVO: 140, CENSUS: 170, FINAL: 160 },
            'androscoggin': { BLS: 120, ME_BAR: 150, MARTINDALE: 130, AVVO: 110, CENSUS: 140, FINAL: 130 }
        },
        countyNames: {
            'cumberland': 'Cumberland',
            'york': 'York',
            'penobscot': 'Penobscot',
            'androscoggin': 'Androscoggin'
        }
    },
    {
        code: 'VT',
        name: 'Vermont',
        counties: {
            'chittenden': { BLS: 300, VT_BAR: 330, MARTINDALE: 310, AVVO: 290, CENSUS: 320, FINAL: 310 },
            'rutland': { BLS: 120, VT_BAR: 150, MARTINDALE: 130, AVVO: 110, CENSUS: 140, FINAL: 130 },
            'windsor': { BLS: 100, VT_BAR: 130, MARTINDALE: 110, AVVO: 90, CENSUS: 120, FINAL: 110 }
        },
        countyNames: {
            'chittenden': 'Chittenden',
            'rutland': 'Rutland',
            'windsor': 'Windsor'
        }
    },
    {
        code: 'DE',
        name: 'Delaware',
        counties: {
            'new-castle': { BLS: 450, DE_BAR: 480, MARTINDALE: 440, AVVO: 420, CENSUS: 460, FINAL: 450 },
            'kent': { BLS: 150, DE_BAR: 180, MARTINDALE: 160, AVVO: 140, CENSUS: 170, FINAL: 160 },
            'sussex': { BLS: 200, DE_BAR: 230, MARTINDALE: 210, AVVO: 190, CENSUS: 220, FINAL: 210 }
        },
        countyNames: {
            'new-castle': 'New Castle',
            'kent': 'Kent',
            'sussex': 'Sussex'
        }
    },
    {
        code: 'HI',
        name: 'Hawaii',
        counties: {
            'honolulu': { BLS: 600, HI_BAR: 630, MARTINDALE: 580, AVVO: 560, CENSUS: 610, FINAL: 600 },
            'maui': { BLS: 150, HI_BAR: 180, MARTINDALE: 160, AVVO: 140, CENSUS: 170, FINAL: 160 },
            'hawaii': { BLS: 100, HI_BAR: 130, MARTINDALE: 110, AVVO: 90, CENSUS: 120, FINAL: 110 }
        },
        countyNames: {
            'honolulu': 'Honolulu',
            'maui': 'Maui',
            'hawaii': 'Hawaii'
        }
    },
    {
        code: 'AK',
        name: 'Alaska',
        counties: {
            'anchorage': { BLS: 300, AK_BAR: 330, MARTINDALE: 310, AVVO: 290, CENSUS: 320, FINAL: 310 },
            'fairbanks-north-star': { BLS: 100, AK_BAR: 130, MARTINDALE: 110, AVVO: 90, CENSUS: 120, FINAL: 110 },
            'matanuska-susitna': { BLS: 80, AK_BAR: 110, MARTINDALE: 90, AVVO: 70, CENSUS: 100, FINAL: 90 }
        },
        countyNames: {
            'anchorage': 'Anchorage',
            'fairbanks-north-star': 'Fairbanks North Star',
            'matanuska-susitna': 'Matanuska-Susitna'
        }
    }
];

const template = fs.readFileSync('scripts/generate_louisiana_sql.js', 'utf8');

states.forEach(state => {
    let script = template
        .replace(/Louisiana/g, state.name)
        .replace(/parish/g, 'county')
        .replace(/parishes/g, 'counties')
        .replace(/'LA'/g, `'${state.code}'`)
        .replace(/LA_BAR/g, `${state.code}_BAR`)
        .replace(/LOUISIANA/g, state.code.toUpperCase())
        .replace(/Louisiana/g, state.name);
    
    // Replace MULTI_SOURCE_DATA
    const multiSourceData = Object.entries(state.counties)
        .map(([slug, data]) => `    '${slug}': { BLS: ${data.BLS}, ${state.code}_BAR: ${data[`${state.code}_BAR`]}, MARTINDALE: ${data.MARTINDALE}, AVVO: ${data.AVVO}, CENSUS: ${data.CENSUS}, FINAL: ${data.FINAL} }`)
        .join(',\n');
    
    script = script.replace(
        /const MULTI_SOURCE_DATA = \{[\s\S]*?\};/,
        `const MULTI_SOURCE_DATA = {\n${multiSourceData}\n};`
    );
    
    // Replace COUNTY_NAMES
    const countyNames = Object.entries(state.countyNames)
        .map(([slug, name]) => `    '${slug}': '${name.replace(/'/g, "''")}'`)
        .join(',\n');
    
    script = script.replace(
        /const COUNTY_NAMES = \{[\s\S]*?\};/,
        `const COUNTY_NAMES = {\n${countyNames}\n};`
    );
    
    // Replace validation message
    script = script.replace(/Louisiana parish data/g, `${state.name} county data`);
    
    // Replace file names
    script = script.replace(/POPULATE_LOUISIANA_COUNTIES\.sql/g, `POPULATE_${state.code.toUpperCase()}_COUNTIES.sql`);
    script = script.replace(/POPULATE_LOUISIANA_PRACTICE_AREAS\.sql/g, `POPULATE_${state.code.toUpperCase()}_PRACTICE_AREAS.sql`);
    
    // Replace comments
    script = script.replace(/-- Louisiana Parish Data/g, `-- ${state.name} County Data`);
    script = script.replace(/-- Louisiana Practice Area Data/g, `-- ${state.name} Practice Area Data`);
    script = script.replace(/-- This script populates Louisiana parishes/g, `-- This script populates ${state.name} counties`);
    script = script.replace(/-- Delete existing Louisiana county data/g, `-- Delete existing ${state.name} county data`);
    script = script.replace(/-- Insert Louisiana parishes/g, `-- Insert ${state.name} counties`);
    script = script.replace(/-- This script populates practice area seats for Louisiana parishes/g, `-- This script populates practice area seats for ${state.name} counties`);
    script = script.replace(/-- Note: Louisiana uses "parishes" instead of counties/g, '');
    
    // Replace console.log messages
    script = script.replace(/parishes/g, 'counties');
    
    const filename = `scripts/generate_${state.name.toLowerCase().replace(/\s+/g, '')}_sql.js`;
    fs.writeFileSync(filename, script);
    console.log(`✅ Created ${filename}`);
});

console.log(`\n✅ Generated ${states.length} Tier 3 state scripts!`);

