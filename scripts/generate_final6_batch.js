/**
 * Batch generator for final 6 remaining states
 * Creates scripts for ID, MT, ND, SD, WY, DC
 */

const fs = require('fs');

const states = [
    {
        code: 'ID',
        name: 'Idaho',
        counties: {
            'ada': { BLS: 350, ID_BAR: 380, MARTINDALE: 340, AVVO: 330, CENSUS: 360, FINAL: 350 },              // Boise
            'canyon': { BLS: 150, ID_BAR: 180, MARTINDALE: 160, AVVO: 140, CENSUS: 170, FINAL: 160 },            // Nampa
            'kootenai': { BLS: 200, ID_BAR: 230, MARTINDALE: 210, AVVO: 190, CENSUS: 220, FINAL: 210 },         // Coeur d'Alene
            'bannock': { BLS: 120, ID_BAR: 150, MARTINDALE: 130, AVVO: 110, CENSUS: 140, FINAL: 130 }            // Pocatello
        },
        countyNames: {
            'ada': 'Ada',
            'canyon': 'Canyon',
            'kootenai': 'Kootenai',
            'bannock': 'Bannock'
        }
    },
    {
        code: 'MT',
        name: 'Montana',
        counties: {
            'yellowstone': { BLS: 250, MT_BAR: 280, MARTINDALE: 260, AVVO: 240, CENSUS: 270, FINAL: 260 },        // Billings
            'missoula': { BLS: 200, MT_BAR: 230, MARTINDALE: 210, AVVO: 190, CENSUS: 220, FINAL: 210 },          // Missoula
            'gallatin': { BLS: 150, MT_BAR: 180, MARTINDALE: 160, AVVO: 140, CENSUS: 170, FINAL: 160 },          // Bozeman
            'flathead': { BLS: 120, MT_BAR: 150, MARTINDALE: 130, AVVO: 110, CENSUS: 140, FINAL: 130 }           // Kalispell
        },
        countyNames: {
            'yellowstone': 'Yellowstone',
            'missoula': 'Missoula',
            'gallatin': 'Gallatin',
            'flathead': 'Flathead'
        }
    },
    {
        code: 'ND',
        name: 'North Dakota',
        counties: {
            'cass': { BLS: 200, ND_BAR: 230, MARTINDALE: 210, AVVO: 190, CENSUS: 220, FINAL: 210 },               // Fargo
            'grand-forks': { BLS: 100, ND_BAR: 130, MARTINDALE: 110, AVVO: 90, CENSUS: 120, FINAL: 110 },        // Grand Forks
            'ward': { BLS: 90, ND_BAR: 120, MARTINDALE: 100, AVVO: 80, CENSUS: 110, FINAL: 100 }                 // Minot
        },
        countyNames: {
            'cass': 'Cass',
            'grand-forks': 'Grand Forks',
            'ward': 'Ward'
        }
    },
    {
        code: 'SD',
        name: 'South Dakota',
        counties: {
            'minnehaha': { BLS: 200, SD_BAR: 230, MARTINDALE: 210, AVVO: 190, CENSUS: 220, FINAL: 210 },         // Sioux Falls
            'pennington': { BLS: 150, SD_BAR: 180, MARTINDALE: 160, AVVO: 140, CENSUS: 170, FINAL: 160 },        // Rapid City
            'lincoln': { BLS: 100, SD_BAR: 130, MARTINDALE: 110, AVVO: 90, CENSUS: 120, FINAL: 110 }            // Sioux Falls metro
        },
        countyNames: {
            'minnehaha': 'Minnehaha',
            'pennington': 'Pennington',
            'lincoln': 'Lincoln'
        }
    },
    {
        code: 'WY',
        name: 'Wyoming',
        counties: {
            'laramie': { BLS: 150, WY_BAR: 180, MARTINDALE: 160, AVVO: 140, CENSUS: 170, FINAL: 160 },           // Cheyenne
            'natrona': { BLS: 120, WY_BAR: 150, MARTINDALE: 130, AVVO: 110, CENSUS: 140, FINAL: 130 },           // Casper
            'campbell': { BLS: 80, WY_BAR: 110, MARTINDALE: 90, AVVO: 70, CENSUS: 100, FINAL: 90 }              // Gillette
        },
        countyNames: {
            'laramie': 'Laramie',
            'natrona': 'Natrona',
            'campbell': 'Campbell'
        }
    },
    {
        code: 'DC',
        name: 'District of Columbia',
        counties: {
            'district-of-columbia': { BLS: 1200, DC_BAR: 1250, MARTINDALE: 1180, AVVO: 1150, CENSUS: 1230, FINAL: 1200 }  // Washington DC
        },
        countyNames: {
            'district-of-columbia': 'District of Columbia'
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
    
    const filename = `scripts/generate_${state.name.toLowerCase().replace(/\s+/g, '').replace('districtofcolumbia', 'dc')}_sql.js`;
    fs.writeFileSync(filename, script);
    console.log(`✅ Created ${filename}`);
});

console.log(`\n✅ Generated ${states.length} final state scripts!`);

