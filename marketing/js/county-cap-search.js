/**
 * County Cap Search - Clean Implementation
 * Handles all county availability search functionality
 */

// Supabase Configuration
const SUPABASE_URL = 'https://napwpkagxzqfpbearkjs.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5hcHdwa2FneHpxZnBiZWFya2pzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI0NDg3ODcsImV4cCI6MjA3ODAyNDc4N30.OSHgEylvGsDBwi4xI7Rs0_hpWtULmqadCr_m_eV_EgE';

// Cache for county data (disabled for fresh data)
let countyDataCache = {};
let practiceAreaDataCache = {};

/**
 * Clear all caches
 */
function clearCountyCache() {
    countyDataCache = {};
    practiceAreaDataCache = {};
    console.log('County data cache cleared');
}

/**
 * Fetch counties for a state from database
 */
async function loadAvailabilityCounties() {
    try {
        const stateSelect = document.getElementById('availability-state');
        const countySelect = document.getElementById('availability-county');
        
        if (!stateSelect || !countySelect) {
            console.error('State or county select element not found');
            return;
        }
        
        const state = stateSelect.value;
        console.log('Loading counties for state:', state);
        
        if (!state) {
            countySelect.disabled = true;
            countySelect.innerHTML = '<option value="">First select a state</option>';
            return;
        }
        
        // Fetch counties from database
        const url = `${SUPABASE_URL}/rest/v1/web_availability_county?state_code=eq.${state}&select=county_slug,county_name,total_seats,filled&order=county_name.asc`;
        
        const response = await fetch(url, {
            headers: {
                'apikey': SUPABASE_ANON_KEY,
                'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
            }
        });
        
        if (!response.ok) {
            throw new Error(`Failed to fetch counties: ${response.status}`);
        }
        
        const counties = await response.json();
        console.log('Fetched counties from database:', counties);
        
        // Populate county dropdown
        countySelect.disabled = false;
        countySelect.innerHTML = '<option value="">Select your county</option>';
        
        counties.forEach(county => {
            const option = document.createElement('option');
            option.value = county.county_slug;
            option.textContent = county.county_name;
            option.dataset.name = county.county_name;
            option.dataset.total = county.total_seats || 0;
            option.dataset.filled = county.filled || 0;
            countySelect.appendChild(option);
        });
        
        // Add "Other County" option
        const otherOption = document.createElement('option');
        otherOption.value = 'other-county';
        otherOption.textContent = 'My county is not listed';
        countySelect.appendChild(otherOption);
        
    } catch (error) {
        console.error('Error loading counties:', error);
        const countySelect = document.getElementById('availability-county');
        if (countySelect) {
            countySelect.innerHTML = '<option value="">Error loading counties</option>';
        }
    }
}

/**
 * Fetch county data from database
 */
async function fetchCountyData(stateCode, countySlug) {
    const cacheKey = `${stateCode}-${countySlug}`;
    
    console.log('Fetching county data from database:', { stateCode, countySlug });
    
    try {
        const url = `${SUPABASE_URL}/rest/v1/web_availability_county?state_code=eq.${stateCode}&county_slug=eq.${countySlug}&select=*`;
        
        const response = await fetch(url, {
            headers: {
                'apikey': SUPABASE_ANON_KEY,
                'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
            }
        });
        
        if (!response.ok) {
            throw new Error(`Failed to fetch county data: ${response.status}`);
        }
        
        const data = await response.json();
        
        if (data && data.length > 0) {
            const county = data[0];
            const result = {
                overall: {
                    totalFirms: county.total_firms || 0,
                    totalSeats: county.total_seats || 0,
                    premiumTotal: county.premium_total || 0,
                    standardTotal: county.standard_total || 0,
                    filled: county.filled || 0,
                    premiumRemaining: county.premium_remaining || 0,
                    standardRemaining: county.standard_remaining || 0
                },
                countyId: county.id
            };
            countyDataCache[cacheKey] = result;
            return result;
        }
        
        return null;
    } catch (error) {
        console.error('Error fetching county data:', error);
        return null;
    }
}

/**
 * Fetch practice area data from database
 */
async function fetchPracticeAreaData(countyId) {
    try {
        const url = `${SUPABASE_URL}/rest/v1/web_availability_practice_area_seats?county_availability_id=eq.${countyId}&select=*&order=display_order.asc`;
        
        const response = await fetch(url, {
            headers: {
                'apikey': SUPABASE_ANON_KEY,
                'Authorization': `Bearer ${SUPABASE_ANON_KEY}`
            }
        });
        
        if (!response.ok) {
            throw new Error(`Failed to fetch practice area data: ${response.status}`);
        }
        
        const data = await response.json();
        
        if (data && data.length > 0) {
            const practiceAreas = {};
            data.forEach(pa => {
                practiceAreas[pa.practice_area_slug] = {
                    name: pa.practice_area_name,
                    totalFirms: pa.total_firms || 0,
                    firms: pa.total_firms || 0,
                    cap: pa.cap || pa.total_seats || 0,  // Use 'cap' first (correct column name)
                    premium: pa.premium || pa.premium_seats || 0,  // Use 'premium' first (correct column name)
                    standard: pa.standard || pa.standard_seats || 0,  // Use 'standard' first (correct column name)
                    filled: pa.filled || 0,
                    premiumRemaining: pa.premium_remaining || 0,
                    standardRemaining: pa.standard_remaining || 0
                };
            });
            console.log('Practice areas processed:', Object.keys(practiceAreas));
            practiceAreaDataCache[countyId] = practiceAreas;
            return practiceAreas;
        }
        
        console.warn('No practice area data returned from API');
        
        return {};
    } catch (error) {
        console.error('Error fetching practice area data:', error);
        return {};
    }
}

/**
 * Show county availability results
 */
async function showAvailability() {
    // Get elements
    let countySelect = document.getElementById('availability-county');
    let stateSelect = document.getElementById('availability-state');
    let resultDiv = document.getElementById('availability-result');
    
    // Fallback to check section IDs
    if (!countySelect) {
        countySelect = document.getElementById('check-county');
        stateSelect = document.getElementById('check-state');
        resultDiv = document.getElementById('availabilityResult');
    }
    
    // Validate elements
    if (!countySelect || !stateSelect) {
        console.warn('showAvailability: Required elements not found');
        return;
    }
    
    if (!countySelect.selectedOptions || countySelect.selectedOptions.length === 0) {
        if (resultDiv) resultDiv.style.display = 'none';
        return;
    }
    
    const selectedOption = countySelect.selectedOptions[0];
    
    if (!selectedOption || !selectedOption.value) {
        if (resultDiv) resultDiv.style.display = 'none';
        return;
    }
    
    // Handle "Other County" option
    if (selectedOption.value === 'other-county') {
        if (resultDiv) {
            resultDiv.style.display = 'block';
            resultDiv.innerHTML = `
                <div style="background: #E8F4FD; padding: 32px; border-radius: 12px; text-align: center; border-left: 4px solid #0A2463;">
                    <h3 style="font-size: 24px; font-weight: 800; color: #0A2463; margin-bottom: 16px;">
                        County Not Listed?
                    </h3>
                    <p style="color: #666; margin-bottom: 24px;">
                        No problem! We'll ask for your specific county in the application and calculate availability for you.
                    </p>
                    <a href="apply.html" style="display: inline-block; background: #0A2463; color: white; padding: 16px 32px; border-radius: 8px; font-weight: 700; text-decoration: none; transition: all 0.3s;">
                        Continue to Application →
                    </a>
                </div>
            `;
        }
        return;
    }
    
    // Fetch and display county data
    const selectedCounty = selectedOption.value;
    const selectedState = stateSelect.value;
    
    // Determine state code
    let stateCode = selectedState;
    if (!stateCode) {
        // Try to infer from common patterns
        const flCounties = ['miami-dade', 'broward', 'palm-beach', 'hillsborough', 'orange', 'duval'];
        if (flCounties.includes(selectedCounty)) {
            stateCode = 'FL';
        }
    }
    
    if (!stateCode) {
        console.error('Could not determine state code');
        if (resultDiv) {
            resultDiv.style.display = 'block';
            resultDiv.innerHTML = '<p style="color: red;">Error: Could not determine state. Please select a state.</p>';
        }
        return;
    }
    
    console.log('showAvailability - State code determined:', stateCode, 'County:', selectedCounty);
    
    // Fetch county data
    const countyData = await fetchCountyData(stateCode, selectedCounty);
    
    if (!countyData) {
        if (resultDiv) {
            resultDiv.style.display = 'block';
            resultDiv.innerHTML = '<p style="color: red;">County data not found. Please try again.</p>';
        }
        return;
    }
    
    // Fetch practice area data
    console.log('Fetching practice areas for county ID:', countyData.countyId);
    const practiceAreas = await fetchPracticeAreaData(countyData.countyId);
    console.log('Practice areas received:', Object.keys(practiceAreas).length, 'areas');
    
    // Render results
    renderCountyResults(countyData, practiceAreas, selectedOption, stateCode, resultDiv);
}

/**
 * Render county availability results
 */
function renderCountyResults(countyData, practiceAreas, selectedOption, stateCode, resultDiv) {
    if (!resultDiv) return;
    
    const overall = countyData.overall;
    const countyName = selectedOption.dataset.name || selectedOption.value.replace(/-/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
    
    // Generate practice area dropdown options
    const practiceAreaOrder = [
        'personal-injury',
        'family-law',
        'immigration',
        'criminal-defense',
        'employment-law',
        'bankruptcy',
        'real-estate',
        'estate-planning',
        'workers-comp'
    ];
    
    const practiceAreaOptions = practiceAreaOrder
        .filter(key => practiceAreas[key] && practiceAreas[key].cap > 0)  // Only show practice areas with seats
        .map(key => `<option value="${key}">${practiceAreas[key].name}</option>`)
        .join('');
    
    console.log('Practice area options generated:', practiceAreaOptions ? 'Yes' : 'No', 'Count:', practiceAreaOrder.filter(key => practiceAreas[key] && practiceAreas[key].cap > 0).length);
    
    // Render HTML
    resultDiv.style.display = 'block';
    resultDiv.innerHTML = `
        <div style="background: linear-gradient(135deg, #F8F9FA 0%, #FFFFFF 100%); padding: 40px; border-radius: 12px; text-align: center; border: 3px solid #0A2463; width: 85%; max-width: 1200px; margin: 0 auto; box-sizing: border-box;">
            <h3 style="font-size: 28px; font-weight: 800; color: #0A2463; margin-bottom: 24px;">
                ${countyName} County - Overall Statistics
            </h3>
            
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px; max-width: 600px; margin: 0 auto 32px;">
                <div style="background: white; padding: 24px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.08);">
                    <div style="font-size: 36px; font-weight: 800; color: #0A2463;">${overall.totalFirms.toLocaleString()}</div>
                    <div style="font-size: 14px; color: #666; margin-top: 8px;">Total Solo & Small Law Firms</div>
                </div>
                <div style="background: white; padding: 24px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.08);">
                    <div style="font-size: 36px; font-weight: 800; color: #0A2463;">${overall.totalSeats.toLocaleString()}</div>
                    <div style="font-size: 14px; color: #666; margin-top: 8px;">Total Seats</div>
                </div>
            </div>
            
            <p style="color: #666; margin-bottom: 32px; font-size: 16px;">
                Select your practice area below to see availability specific to your competitive market.
            </p>
            
            <div style="max-width: 500px; margin: 0 auto 32px;">
                <label for="practice-area-select" style="display: block; font-weight: 700; color: #0A2463; margin-bottom: 12px; text-align: left;">
                    Select Your Practice Area:
                </label>
                <select id="practice-area-select" onchange="showPracticeAreaAvailability('${selectedOption.value}', '${stateCode}')" style="width: 100%; padding: 16px; border: 2px solid #0A2463; border-radius: 8px; font-size: 16px; font-weight: 600; color: #0A2463; background: white; cursor: pointer;">
                    <option value="">-- Select Practice Area --</option>
                    ${practiceAreaOptions}
                </select>
            </div>
        </div>
    `;
    
    // Store county data for practice area function
    window.currentCountyData = {
        countySlug: selectedOption.value,
        stateCode: stateCode,
        countyId: countyData.countyId,
        practiceAreas: practiceAreas
    };
}

/**
 * Show practice area specific availability
 */
async function showPracticeAreaAvailability(countyValue, stateCode) {
    const practiceAreaSelect = document.getElementById('practice-area-select');
    const practiceAreaResult = document.getElementById('practice-area-result-container');
    
    if (!practiceAreaSelect || !practiceAreaResult) {
        console.error('Practice area elements not found');
        return;
    }
    
    const selectedArea = practiceAreaSelect.value;
    if (!selectedArea) {
        practiceAreaResult.style.display = 'none';
        return;
    }
    
    // Get state code if not provided
    if (!stateCode) {
        const stateSelect = document.getElementById('availability-state') || document.getElementById('check-state');
        stateCode = stateSelect ? stateSelect.value : null;
    }
    
    // Get county data (from window or fetch)
    let countyData = window.currentCountyData;
    if (!countyData || countyData.countySlug !== countyValue || countyData.stateCode !== stateCode) {
        // Need to fetch data
        if (!stateCode) {
            console.error('State code not available');
            return;
        }
        
        console.log('Fetching county data for practice area:', { stateCode, countyValue });
        const fetchedData = await fetchCountyData(stateCode, countyValue);
        if (!fetchedData) {
            console.error('Failed to fetch county data');
            return;
        }
        
        console.log('Fetching practice area data for county:', fetchedData.countyId);
        const practiceAreas = await fetchPracticeAreaData(fetchedData.countyId);
        console.log('Practice areas fetched:', Object.keys(practiceAreas));
        
        countyData = {
            countySlug: countyValue,
            stateCode: stateCode,
            countyId: fetchedData.countyId,
            practiceAreas: practiceAreas
        };
        
        // Update window cache
        window.currentCountyData = countyData;
    }
    
    const areaData = countyData.practiceAreas[selectedArea];
    if (!areaData) {
        console.error('Practice area data not found:', selectedArea);
        console.error('Available practice areas:', Object.keys(countyData.practiceAreas));
        return;
    }
    
    // Render practice area results
    renderPracticeAreaResults(areaData, selectedArea, practiceAreaResult);
}

/**
 * Render practice area specific results
 */
function renderPracticeAreaResults(areaData, areaSlug, resultContainer) {
    const areaName = areaData.name;
    const totalRemaining = areaData.premiumRemaining + areaData.standardRemaining;
    const totalCap = areaData.cap;
    const fillPercent = totalCap > 0 ? Math.round(((totalCap - totalRemaining) / totalCap) * 100) : 0;
    
    // Determine status
    let statusColor, statusIcon, statusText;
    if (totalRemaining <= 2) {
        statusColor = '#DC2626';
        statusIcon = '🚨';
        statusText = 'ALMOST FULL';
    } else if (fillPercent >= 50) {
        statusColor = '#F59E0B';
        statusIcon = '⚡';
        statusText = 'FILLING FAST';
    } else {
        statusColor = '#10B981';
        statusIcon = '✅';
        statusText = 'SEATS AVAILABLE';
    }
    
    resultContainer.style.display = 'block';
    resultContainer.innerHTML = `
        <div style="background: linear-gradient(135deg, #F8F9FA 0%, #FFFFFF 100%); padding: 40px; border-radius: 12px; text-align: center; border: 3px solid ${statusColor}; margin-top: 32px; width: 85%; max-width: 1200px; margin-left: auto; margin-right: auto; box-sizing: border-box;">
            <div style="font-size: 64px; margin-bottom: 16px;">${statusIcon}</div>
            <h3 style="font-size: 28px; font-weight: 800; color: #0A2463; margin-bottom: 8px;">
                ${areaName}
            </h3>
            <div style="display: inline-block; background: ${statusColor}; color: white; padding: 8px 20px; border-radius: 20px; font-weight: 700; font-size: 14px; margin-bottom: 24px;">
                ${statusText}
            </div>
            
            <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 24px; max-width: 600px; margin: 0 auto 32px;">
                <!-- Left Column: Total Capacity -->
                <div style="background: white; padding: 20px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.08);">
                    <div style="font-size: 36px; font-weight: 800; color: #666;">${totalCap}</div>
                    <div style="font-size: 14px; color: #666; margin-top: 4px;">Total Capacity<br>(Maximum Seats)</div>
                </div>
                <!-- Right Column: Available Now -->
                <div style="background: white; padding: 20px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.08);">
                    <div style="font-size: 36px; font-weight: 800; color: #0A2463;">${totalRemaining}</div>
                    <div style="font-size: 14px; color: #666; margin-top: 4px;">Seats Available Now</div>
                </div>
                <!-- Premium Remaining - HIGHLIGHTED with top border only -->
                <div style="background: white; padding: 20px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); border-top: 3px solid #8B5CF6; position: relative;">
                    <div style="position: absolute; top: 8px; right: 8px; background: #8B5CF6; color: white; padding: 4px 8px; border-radius: 6px; font-size: 10px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px;">PREMIUM</div>
                    <div style="font-size: 36px; font-weight: 800; color: #0A2463; margin-top: 8px;">${areaData.premiumRemaining}</div>
                    <div style="font-size: 14px; color: #666; margin-top: 4px;">Premium Seats Available</div>
                    <div style="font-size: 12px; color: #999; margin-top: 2px;">Out of ${areaData.premium} total premium seats</div>
                </div>
                <!-- Standard Remaining -->
                <div style="background: white; padding: 20px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.08);">
                    <div style="font-size: 36px; font-weight: 800; color: #666;">${areaData.standardRemaining}</div>
                    <div style="font-size: 14px; color: #666; margin-top: 4px;">Standard Seats Available</div>
                    <div style="font-size: 12px; color: #999; margin-top: 2px;">Out of ${areaData.standard} total standard seats</div>
                </div>
            </div>
            
            <a href="apply.html?county=${window.currentCountyData.countySlug}&state=${window.currentCountyData.stateCode}&practice=${areaSlug}"
                style="display: inline-block; background: #0A2463; color: white; padding: 18px 48px; border-radius: 12px; font-weight: 700; text-decoration: none; font-size: 18px; transition: all 0.3s; box-shadow: 0 4px 12px rgba(0,102,255,0.3);"
                onmouseover="this.style.background='#0052CC'; this.style.transform='translateY(-2px)'"
                onmouseout="this.style.background='#0A2463'; this.style.transform='translateY(0)'">
                Apply for ${areaName} →
            </a>
        </div>
    `;
}

// Make functions globally accessible
window.loadAvailabilityCounties = loadAvailabilityCounties;
window.showAvailability = showAvailability;
window.showPracticeAreaAvailability = showPracticeAreaAvailability;
window.clearCountyCache = clearCountyCache;

// Initialize on page load
document.addEventListener('DOMContentLoaded', function() {
    console.log('County Cap Search initialized');
    
    // Create practice area result container if it doesn't exist
    const resultDiv = document.getElementById('availability-result') || document.getElementById('availabilityResult');
    if (resultDiv && !document.getElementById('practice-area-result-container')) {
        const container = document.createElement('div');
        container.id = 'practice-area-result-container';
        container.style.cssText = 'margin-top: 32px; display: none; width: 85%; max-width: 1200px; margin-left: auto; margin-right: auto; box-sizing: border-box;';
        resultDiv.parentNode.insertBefore(container, resultDiv.nextSibling);
    }
});

