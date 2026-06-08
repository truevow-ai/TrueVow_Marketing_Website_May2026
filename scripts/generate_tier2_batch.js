/**
 * Batch generator for Tier 2 states
 * Creates all 9 remaining Tier 2 state scripts
 */

const fs = require('fs');

const states = [
    {
        code: 'AL',
        name: 'Alabama',
        counties: {
            'jefferson': { BLS: 600, AL_BAR: 630, MARTINDALE: 580, AVVO: 560, CENSUS: 610, FINAL: 600 },
            'madison': { BLS: 350, AL_BAR: 380, MARTINDALE: 340, AVVO: 330, CENSUS: 360, FINAL: 350 },
            'mobile': { BLS: 400, AL_BAR: 430, MARTINDALE: 390, AVVO: 380, CENSUS: 410, FINAL: 400 },
            'montgomery': { BLS: 250, AL_BAR: 280, MARTINDALE: 260, AVVO: 240, CENSUS: 270, FINAL: 260 },
            'shelby': { BLS: 150, AL_BAR: 180, MARTINDALE: 160, AVVO: 140, CENSUS: 170, FINAL: 160 }
        },
        countyNames: {
            'jefferson': 'Jefferson',
            'madison': 'Madison',
            'mobile': 'Mobile',
            'montgomery': 'Montgomery',
            'shelby': 'Shelby'
        }
    },
    {
        code: 'SC',
        name: 'South Carolina',
        counties: {
            'charleston': { BLS: 600, SC_BAR: 630, MARTINDALE: 580, AVVO: 560, CENSUS: 610, FINAL: 600 },
            'richland': { BLS: 500, SC_BAR: 530, MARTINDALE: 490, AVVO: 480, CENSUS: 510, FINAL: 500 },
            'greenville': { BLS: 450, SC_BAR: 480, MARTINDALE: 440, AVVO: 420, CENSUS: 460, FINAL: 450 },
            'berkeley': { BLS: 200, SC_BAR: 230, MARTINDALE: 210, AVVO: 190, CENSUS: 220, FINAL: 210 },
            'dorchester': { BLS: 150, SC_BAR: 180, MARTINDALE: 160, AVVO: 140, CENSUS: 170, FINAL: 160 },
            'lexington': { BLS: 250, SC_BAR: 280, MARTINDALE: 260, AVVO: 240, CENSUS: 270, FINAL: 260 },
            'spartanburg': { BLS: 200, SC_BAR: 230, MARTINDALE: 210, AVVO: 190, CENSUS: 220, FINAL: 210 }
        },
        countyNames: {
            'charleston': 'Charleston',
            'richland': 'Richland',
            'greenville': 'Greenville',
            'berkeley': 'Berkeley',
            'dorchester': 'Dorchester',
            'lexington': 'Lexington',
            'spartanburg': 'Spartanburg'
        }
    },
    {
        code: 'KY',
        name: 'Kentucky',
        counties: {
            'jefferson': { BLS: 700, KY_BAR: 730, MARTINDALE: 680, AVVO: 660, CENSUS: 710, FINAL: 700 },
            'fayette': { BLS: 450, KY_BAR: 480, MARTINDALE: 440, AVVO: 420, CENSUS: 460, FINAL: 450 },
            'kenton': { BLS: 300, KY_BAR: 330, MARTINDALE: 310, AVVO: 290, CENSUS: 320, FINAL: 310 },
            'boone': { BLS: 200, KY_BAR: 230, MARTINDALE: 210, AVVO: 190, CENSUS: 220, FINAL: 210 },
            'warren': { BLS: 150, KY_BAR: 180, MARTINDALE: 160, AVVO: 140, CENSUS: 170, FINAL: 160 }
        },
        countyNames: {
            'jefferson': 'Jefferson',
            'fayette': 'Fayette',
            'kenton': 'Kenton',
            'boone': 'Boone',
            'warren': 'Warren'
        }
    },
    {
        code: 'OK',
        name: 'Oklahoma',
        counties: {
            'oklahoma': { BLS: 700, OK_BAR: 730, MARTINDALE: 680, AVVO: 660, CENSUS: 710, FINAL: 700 },
            'tulsa': { BLS: 650, OK_BAR: 680, MARTINDALE: 640, AVVO: 620, CENSUS: 660, FINAL: 650 },
            'cleveland': { BLS: 250, OK_BAR: 280, MARTINDALE: 260, AVVO: 240, CENSUS: 270, FINAL: 260 },
            'canadian': { BLS: 150, OK_BAR: 180, MARTINDALE: 160, AVVO: 140, CENSUS: 170, FINAL: 160 },
            'comanche': { BLS: 200, OK_BAR: 230, MARTINDALE: 210, AVVO: 190, CENSUS: 220, FINAL: 210 }
        },
        countyNames: {
            'oklahoma': 'Oklahoma',
            'tulsa': 'Tulsa',
            'cleveland': 'Cleveland',
            'canadian': 'Canadian',
            'comanche': 'Comanche'
        }
    },
    {
        code: 'UT',
        name: 'Utah',
        counties: {
            'salt-lake': { BLS: 800, UT_BAR: 830, MARTINDALE: 780, AVVO: 750, CENSUS: 810, FINAL: 800 },
            'utah': { BLS: 300, UT_BAR: 330, MARTINDALE: 310, AVVO: 290, CENSUS: 320, FINAL: 310 },
            'davis': { BLS: 250, UT_BAR: 280, MARTINDALE: 260, AVVO: 240, CENSUS: 270, FINAL: 260 },
            'weber': { BLS: 200, UT_BAR: 230, MARTINDALE: 210, AVVO: 190, CENSUS: 220, FINAL: 210 }
        },
        countyNames: {
            'salt-lake': 'Salt Lake',
            'utah': 'Utah',
            'davis': 'Davis',
            'weber': 'Weber'
        }
    },
    {
        code: 'NV',
        name: 'Nevada',
        counties: {
            'clark': { BLS: 1100, NV_BAR: 1150, MARTINDALE: 1080, AVVO: 1050, CENSUS: 1130, FINAL: 1100 },
            'washoe': { BLS: 400, NV_BAR: 430, MARTINDALE: 390, AVVO: 380, CENSUS: 410, FINAL: 400 }
        },
        countyNames: {
            'clark': 'Clark',
            'washoe': 'Washoe'
        }
    },
    {
        code: 'OR',
        name: 'Oregon',
        counties: {
            'multnomah': { BLS: 900, OR_BAR: 950, MARTINDALE: 880, AVVO: 850, CENSUS: 920, FINAL: 900 },
            'washington': { BLS: 400, OR_BAR: 430, MARTINDALE: 390, AVVO: 380, CENSUS: 410, FINAL: 400 },
            'clackamas': { BLS: 350, OR_BAR: 380, MARTINDALE: 340, AVVO: 330, CENSUS: 360, FINAL: 350 },
            'lane': { BLS: 300, OR_BAR: 330, MARTINDALE: 310, AVVO: 290, CENSUS: 320, FINAL: 310 },
            'marion': { BLS: 250, OR_BAR: 280, MARTINDALE: 260, AVVO: 240, CENSUS: 270, FINAL: 260 }
        },
        countyNames: {
            'multnomah': 'Multnomah',
            'washington': 'Washington',
            'clackamas': 'Clackamas',
            'lane': 'Lane',
            'marion': 'Marion'
        }
    },
    {
        code: 'WI',
        name: 'Wisconsin',
        counties: {
            'milwaukee': { BLS: 1000, WI_BAR: 1050, MARTINDALE: 980, AVVO: 950, CENSUS: 1020, FINAL: 1000 },
            'dane': { BLS: 600, WI_BAR: 630, MARTINDALE: 580, AVVO: 560, CENSUS: 610, FINAL: 600 },
            'waukesha': { BLS: 400, WI_BAR: 430, MARTINDALE: 390, AVVO: 380, CENSUS: 410, FINAL: 400 },
            'brown': { BLS: 300, WI_BAR: 330, MARTINDALE: 310, AVVO: 290, CENSUS: 320, FINAL: 310 },
            'racine': { BLS: 200, WI_BAR: 230, MARTINDALE: 210, AVVO: 190, CENSUS: 220, FINAL: 210 }
        },
        countyNames: {
            'milwaukee': 'Milwaukee',
            'dane': 'Dane',
            'waukesha': 'Waukesha',
            'brown': 'Brown',
            'racine': 'Racine'
        }
    },
    {
        code: 'KS',
        name: 'Kansas',
        counties: {
            'johnson': { BLS: 700, KS_BAR: 730, MARTINDALE: 680, AVVO: 660, CENSUS: 710, FINAL: 700 },
            'sedgwick': { BLS: 500, KS_BAR: 530, MARTINDALE: 490, AVVO: 480, CENSUS: 510, FINAL: 500 },
            'wyandotte': { BLS: 300, KS_BAR: 330, MARTINDALE: 310, AVVO: 290, CENSUS: 320, FINAL: 310 },
            'douglas': { BLS: 200, KS_BAR: 230, MARTINDALE: 210, AVVO: 190, CENSUS: 220, FINAL: 210 },
            'shawnee': { BLS: 250, KS_BAR: 280, MARTINDALE: 260, AVVO: 240, CENSUS: 270, FINAL: 260 }
        },
        countyNames: {
            'johnson': 'Johnson',
            'sedgwick': 'Sedgwick',
            'wyandotte': 'Wyandotte',
            'douglas': 'Douglas',
            'shawnee': 'Shawnee'
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
        .map(([slug, name]) => `    '${slug}': '${name}'`)
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

console.log(`\n✅ Generated ${states.length} Tier 2 state scripts!`);

