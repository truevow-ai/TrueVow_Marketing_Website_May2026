/**
 * Component Loader for TrueVow Website
 * Loads navigation and footer from single source files
 */

(function() {
    'use strict';
    
    /**
     * Load HTML content from a file and inject it into a target element
     * @param {string} filePath - Path to the HTML component file
     * @param {string} targetId - ID of the element to inject content into
     */
    async function loadComponent(filePath, targetId) {
        try {
            const response = await fetch(filePath);
            if (!response.ok) {
                console.error(`Failed to load ${filePath}: ${response.status} ${response.statusText}`);
                return;
            }
            const html = await response.text();
            const targetElement = document.getElementById(targetId);
            if (targetElement) {
                targetElement.innerHTML = html;
            } else {
                console.error(`Target element #${targetId} not found`);
            }
        } catch (error) {
            console.error(`Error loading ${filePath}:`, error);
        }
    }
    
    /**
     * Initialize component loading when DOM is ready
     */
    function init() {
        // Load navigation if placeholder exists
        const navPlaceholder = document.getElementById('truevow-navigation');
        if (navPlaceholder) {
            loadComponent('/components/STANDARD_NAVIGATION.html', 'truevow-navigation');
        }
        
        // Load footer if placeholder exists
        const footerPlaceholder = document.getElementById('truevow-footer');
        if (footerPlaceholder) {
            loadComponent('/components/STANDARD_FOOTER.html', 'truevow-footer');
        }
    }
    
    // Wait for DOM to be ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();

