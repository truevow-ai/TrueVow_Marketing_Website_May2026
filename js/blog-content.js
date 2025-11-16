/**
 * TrueVow Blog Content Engine
 * Fetches blog content from Supabase and renders dynamically
 * 
 * Configuration: Update SUPABASE_URL and SUPABASE_ANON_KEY with your Supabase project credentials
 */

// =====================================================
// CONFIGURATION - Update these with your Supabase credentials
// =====================================================
const SUPABASE_URL = 'https://napwpkagxzqfpbearkjs.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5hcHdwa2FneHpxZnBiZWFya2pzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI0NDg3ODcsImV4cCI6MjA3ODAyNDc4N30.OSHgEylvGsDBwi4xI7Rs0_hpWtULmqadCr_m_eV_EgE';

// =====================================================
// BLOG CONTENT FETCHER
// =====================================================

/**
 * Fetch published blog content from Supabase
 * @param {Object} options - Filter options
 * @param {string} options.type - Filter by type: 'article' | 'video' | null (all)
 * @param {boolean} options.featured - Filter by featured: true | false | null (all)
 * @param {number} options.limit - Limit number of results
 * @returns {Promise<Array>} Array of content items
 */
async function fetchBlogContent(options = {}) {
    try {
        let url = `${SUPABASE_URL}/rest/v1/blog_content?status=eq.published&order=publish_date.desc`;
        
        // Add filters
        if (options.type) {
            url += `&type=eq.${options.type}`;
        }
        if (options.featured !== null && options.featured !== undefined) {
            url += `&is_featured=eq.${options.featured}`;
        }
        if (options.limit) {
            url += `&limit=${options.limit}`;
        }
        
        // Select columns
        url += `&select=id,title,teaser,canonical_url,publish_date,thumbnail_url,type,platform_name,read_time_minutes,watch_time_minutes,is_featured,view_count,click_count`;
        
        const response = await fetch(url, {
            method: 'GET',
            headers: {
                'apikey': SUPABASE_ANON_KEY,
                'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
                'Content-Type': 'application/json',
                'Prefer': 'return=representation'
            }
        });
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const data = await response.json();
        return data;
    } catch (error) {
        console.error('Error fetching blog content:', error);
        throw error;
    }
}

/**
 * Track content analytics (view or click)
 * @param {string} contentId - Content item ID
 * @param {string} eventType - 'view' | 'click' | 'share'
 * @param {Object} metadata - Additional metadata
 */
async function trackContentAnalytics(contentId, eventType, metadata = {}) {
    try {
        const response = await fetch(`${SUPABASE_URL}/rest/v1/blog_analytics`, {
            method: 'POST',
            headers: {
                'apikey': SUPABASE_ANON_KEY,
                'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
                'Content-Type': 'application/json',
                'Prefer': 'return=minimal'
            },
            body: JSON.stringify({
                content_id: contentId,
                event_type: eventType,
                ip_addr: metadata.ipAddr,
                user_agent: metadata.userAgent || navigator.userAgent,
                referrer: metadata.referrer || document.referrer,
                utm_source: metadata.utmSource,
                utm_medium: metadata.utmMedium,
                utm_campaign: metadata.utmCampaign,
                created_at: new Date().toISOString()
            })
        });
        
        if (!response.ok) {
            console.warn('Analytics tracking failed:', response.status);
        }
    } catch (error) {
        // Silently fail analytics - don't break the page
        console.warn('Analytics tracking error:', error);
    }
}

/**
 * Render blog content cards
 * @param {Array} contentItems - Array of content items from Supabase
 * @param {HTMLElement} container - Container element to render into
 */
function renderBlogCards(contentItems, container) {
    if (!contentItems || contentItems.length === 0) {
        container.innerHTML = `
            <div style="grid-column: 1 / -1; text-align: center; padding: 60px 20px; color: #666;">
                <p style="font-size: 18px;">No content available at the moment.</p>
                <p style="font-size: 14px; margin-top: 8px; color: #999;">Check back soon for new articles and videos!</p>
            </div>
        `;
        return;
    }
    
    // Clear container
    container.innerHTML = '';
    
    // Gradient options for card images
    const gradients = [
        'linear-gradient(135deg, #667eea 0%, #764ba2 100%)', // Purple
        'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)', // Pink
        'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)', // Blue
        'linear-gradient(135deg, #fa709a 0%, #fee140 100%)', // Peach
        'linear-gradient(135deg, #30cfd0 0%, #330867 100%)', // Dark
        'linear-gradient(135deg, #a8edea 0%, #fed6e3 100%)', // Soft
    ];
    
    // Emoji mapping based on title/keywords
    const getEmoji = (title, type) => {
        const titleLower = title.toLowerCase();
        if (titleLower.includes('ethic') || titleLower.includes('compliance')) return '⚖️';
        if (titleLower.includes('zero') || titleLower.includes('privacy') || titleLower.includes('security')) return '🔒';
        if (titleLower.includes('ai') || titleLower.includes('automation') || titleLower.includes('deterministic')) return '🤖';
        if (titleLower.includes('blockchain') || titleLower.includes('verify') || titleLower.includes('evidence')) return '⛓️';
        if (titleLower.includes('draft') || titleLower.includes('template') || titleLower.includes('disclaimer')) return '📝';
        if (titleLower.includes('roi') || titleLower.includes('county') || titleLower.includes('strategy') || titleLower.includes('marketing')) return '📊';
        if (titleLower.includes('billing') || titleLower.includes('revenue') || titleLower.includes('money')) return '💰';
        if (titleLower.includes('intake') || titleLower.includes('call')) return '📞';
        return type === 'article' ? '📄' : '🎥';
    };
    
    // Render each content item
    contentItems.forEach((item, index) => {
        const gradient = gradients[index % gradients.length];
        const emoji = getEmoji(item.title, item.type);
        const isVideo = item.type === 'video';
        const platformName = item.platform_name === 'linkedin' ? 'LinkedIn' : 'YouTube';
        const linkText = isVideo ? 'Watch on YouTube' : 'Read on LinkedIn';
        const linkClass = isVideo ? 'card-link video-link' : 'card-link';
        const badgeClass = isVideo ? 'badge-video' : 'badge-article';
        const badgeText = isVideo ? 'YouTube Video' : 'LinkedIn Article';
        
        // Format date
        const publishDate = new Date(item.publish_date);
        const formattedDate = publishDate.toLocaleDateString('en-US', { 
            month: 'short', 
            day: 'numeric', 
            year: 'numeric' 
        });
        const dateTime = publishDate.toISOString().split('T')[0];
        
        // Create card HTML
        const card = document.createElement('article');
        card.className = 'content-card';
        card.setAttribute('data-type', item.type);
        card.setAttribute('data-content-id', item.id);
        
        // Use thumbnail if available, otherwise use gradient with emoji
        const imageHtml = item.thumbnail_url
            ? `<img src="${item.thumbnail_url}" alt="${item.title}" class="card-image" style="width: 100%; height: 240px; object-fit: cover;">`
            : `<div class="card-image" style="background: ${gradient}; display: flex; align-items: center; justify-content: center; color: white; font-size: 48px; font-weight: 900; height: 240px;">${emoji}</div>`;
        
        card.innerHTML = `
            ${imageHtml}
            <div class="card-content">
                <span class="card-type-badge ${badgeClass}">${badgeText}</span>
                <h3 class="card-title">${escapeHtml(item.title)}</h3>
                <p class="card-teaser">${escapeHtml(item.teaser)}</p>
                <div class="card-footer">
                    <time class="card-date" datetime="${dateTime}">${formattedDate}</time>
                    <a href="${item.canonical_url}" 
                       target="_blank" 
                       rel="noopener" 
                       class="${linkClass}"
                       data-content-id="${item.id}"
                       data-content-type="${item.type}"
                       data-content-title="${escapeHtml(item.title)}">
                        ${linkText}
                        <svg class="external-icon" fill="${isVideo ? 'currentColor' : 'none'}" stroke="${isVideo ? 'currentColor' : 'currentColor'}" viewBox="0 0 24 24">
                            ${isVideo ? `
                                <path d="M10 15l5.19-3L10 9v6zm9.56-7.83c.13.47.22 1.1.28 1.9.07.8.1 1.49.1 2.09L20 12c0 2.19-.16 3.8-.44 4.83-.25.9-.83 1.48-1.73 1.73-.47.13-1.33.22-2.9.28-1.57.07-2.93.1-4.1.1H12c-1.17 0-2.53-.03-4.1-.1-1.57-.06-2.43-.15-2.9-.28-.9-.25-1.48-.83-1.73-1.73C3.16 15.8 3 14.19 3 12s.16-3.8.44-4.83c.25-.9.83-1.48 1.73-1.73.47-.13 1.33-.22 2.9-.28C7.47 5.03 8.83 5 10 5h2c1.17 0 2.53.03 4.1.1 1.57.06 2.43.15 2.9.28.9.25 1.48.83 1.73 1.73.28 1.03.44 2.64.44 4.83z"/>
                            ` : `
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"></path>
                            `}
                        </svg>
                    </a>
                </div>
            </div>
        `;
        
        container.appendChild(card);
    });
    
    // Attach click tracking to all links
    attachClickTracking(container);
    
    // Track page view for all visible items
    contentItems.forEach(item => {
        trackContentAnalytics(item.id, 'view', {
            referrer: document.referrer,
            userAgent: navigator.userAgent
        });
    });
}

/**
 * Attach click tracking to content links
 * @param {HTMLElement} container - Container with content cards
 */
function attachClickTracking(container) {
    const links = container.querySelectorAll('.card-link');
    links.forEach(link => {
        link.addEventListener('click', (e) => {
            const contentId = link.getAttribute('data-content-id');
            const contentType = link.getAttribute('data-content-type');
            const contentTitle = link.getAttribute('data-content-title');
            
            // Track click
            trackContentAnalytics(contentId, 'click', {
                referrer: document.referrer,
                userAgent: navigator.userAgent,
                utmSource: 'blog_hub'
            });
            
            // Log to console (can be replaced with Google Analytics)
            console.log(`Blog Hub Click: ${contentType} - ${contentTitle}`);
            
            // Optional: Send to Google Analytics
            if (typeof gtag !== 'undefined') {
                gtag('event', 'blog_click', {
                    content_type: contentType,
                    content_title: contentTitle,
                    destination_platform: contentType === 'video' ? 'youtube' : 'linkedin'
                });
            }
        });
    });
}

/**
 * Escape HTML to prevent XSS
 * @param {string} text - Text to escape
 * @returns {string} Escaped HTML
 */
function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

/**
 * Format date for display
 * @param {string} dateString - ISO date string
 * @returns {string} Formatted date
 */
function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', { 
        month: 'short', 
        day: 'numeric', 
        year: 'numeric' 
    });
}

/**
 * Show loading state
 * @param {HTMLElement} container - Container element
 */
function showLoading(container) {
    container.innerHTML = `
        <div style="grid-column: 1 / -1; text-align: center; padding: 60px 20px;">
            <div style="display: inline-block; width: 40px; height: 40px; border: 4px solid #E5E5E5; border-top-color: #0A2463; border-radius: 50%; animation: spin 1s linear infinite;"></div>
            <p style="margin-top: 20px; color: #666; font-size: 16px;">Loading content...</p>
        </div>
        <style>
            @keyframes spin {
                to { transform: rotate(360deg); }
            }
        </style>
    `;
}

/**
 * Show error state
 * @param {HTMLElement} container - Container element
 * @param {string} message - Error message
 */
function showError(container, message = 'Failed to load blog content. Please try again later.') {
    container.innerHTML = `
        <div style="grid-column: 1 / -1; text-align: center; padding: 60px 20px; color: #666;">
            <p style="font-size: 18px; color: #CC0000; margin-bottom: 12px;">⚠️ Error</p>
            <p style="font-size: 16px;">${escapeHtml(message)}</p>
            <button onclick="window.location.reload()" style="margin-top: 20px; padding: 12px 24px; background: #0A2463; color: white; border: none; border-radius: 8px; cursor: pointer; font-size: 14px; font-weight: 600;">
                Retry
            </button>
        </div>
    `;
}

/**
 * Initialize blog content engine
 * @param {Object} options - Initialization options
 */
async function initBlogContent(options = {}) {
    const container = document.getElementById('blog-grid');
    
    if (!container) {
        console.error('Blog container not found. Make sure you have <div id="blog-grid"></div> in your HTML.');
        return;
    }
    
    // Show loading state
    showLoading(container);
    
    try {
        // Fetch content from Supabase
        const content = await fetchBlogContent({
            type: options.type || null,
            featured: options.featured || null,
            limit: options.limit || null
        });
        
        // Render content
        renderBlogCards(content, container);
        
        // Update filter buttons if content is filtered
        if (options.type) {
            updateActiveFilter(options.type);
        }
        
    } catch (error) {
        console.error('Failed to load blog content:', error);
        showError(container, 'Failed to load blog content. Please check your Supabase configuration.');
    }
}

/**
 * Update active filter button
 * @param {string} filterValue - Filter value ('all', 'article', 'video')
 */
function updateActiveFilter(filterValue) {
    const filterButtons = document.querySelectorAll('.filter-btn');
    filterButtons.forEach(btn => {
        const btnFilter = btn.getAttribute('data-filter');
        if (btnFilter === filterValue || (filterValue === 'all' && btnFilter === 'all')) {
            btn.classList.add('active');
        } else {
            btn.classList.remove('active');
        }
    });
}

// =====================================================
// AUTO-INITIALIZE ON PAGE LOAD
// =====================================================

// Initialize when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
        initBlogContent();
    });
} else {
    initBlogContent();
}

// =====================================================
// FILTER FUNCTIONALITY
// =====================================================

// Attach filter button handlers
document.addEventListener('DOMContentLoaded', () => {
    const filterButtons = document.querySelectorAll('.filter-btn');
    const blogGrid = document.getElementById('blog-grid');
    
    filterButtons.forEach(button => {
        button.addEventListener('click', async () => {
            // Remove active class from all buttons
            filterButtons.forEach(btn => btn.classList.remove('active'));
            
            // Add active class to clicked button
            button.classList.add('active');
            
            // Get filter value
            const filterValue = button.getAttribute('data-filter');
            
            // Reload content with filter
            if (filterValue === 'all') {
                await initBlogContent({ type: null });
            } else {
                await initBlogContent({ type: filterValue });
            }
            
            // Scroll to top of content grid
            if (blogGrid) {
                blogGrid.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        });
    });
});

// Export functions for external use
window.BlogContentEngine = {
    fetchBlogContent,
    renderBlogCards,
    trackContentAnalytics,
    initBlogContent
};

