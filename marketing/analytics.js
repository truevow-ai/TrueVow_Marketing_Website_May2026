/**
 * TrueVow Website Analytics Tracker
 * Deterministic session tracking for ai_website_analytics_agent
 * Zero external dependencies, Supabase-native
 */

(function() {
  'use strict';

  // Configuration
  const CONFIG = {
    STORAGE_KEY: 'tv_analytics_session',
    SESSION_TTL_MS: 30 * 60 * 1000, // 30 minutes
    FLUSH_INTERVAL_MS: 10000, // 10 seconds
    MAX_BATCH_SIZE: 20,
    SCROLL_THROTTLE_MS: 250,
    API_ENDPOINT: 'https://sales.truevow.com/api/analytics/events',
    LINK_ENDPOINT: 'https://sales.truevow.com/api/analytics/link'
  };

  // Session counter for deterministic ID generation
  let sessionCounter = 0;
  let eventCounter = 0;

  // State
  let sessionId = null;
  let events = [];
  let scrollThresholds = [25, 50, 75, 100];
  let reachedThresholds = [];
  let pageStartTime = Date.now();
  let lastActivityTime = Date.now();
  let isFlushing = false;

  /**
   * Generate deterministic session ID
   * Format: sess_{timestamp}_{counter}
   */
  function generateSessionId() {
    const timestamp = Date.now();
    const counter = ++sessionCounter;
    return `sess_${timestamp}_${counter}`;
  }

  /**
   * Get or create session
   */
  function getSession() {
    try {
      const stored = localStorage.getItem(CONFIG.STORAGE_KEY);
      if (stored) {
        const parsed = JSON.parse(stored);
        const age = Date.now() - parsed.created_at;
        if (age < CONFIG.SESSION_TTL_MS) {
          return parsed.id;
        }
      }
    } catch (e) {
      // localStorage unavailable (private mode)
    }

    const newId = generateSessionId();
    const sessionData = {
      id: newId,
      created_at: Date.now(),
      entry_page: window.location.pathname + window.location.search
    };

    try {
      localStorage.setItem(CONFIG.STORAGE_KEY, JSON.stringify(sessionData));
    } catch (e) {
      // Ignore
    }

    return newId;
  }

  /**
   * Parse UTM parameters from URL
   */
  function parseUTMs() {
    const params = new URLSearchParams(window.location.search);
    return {
      source: params.get('utm_source') || null,
      medium: params.get('utm_medium') || null,
      campaign: params.get('utm_campaign') || null,
      term: params.get('utm_term') || null,
      content: params.get('utm_content') || null
    };
  }

  /**
   * Track event
   */
  function track(eventType, data = {}) {
    lastActivityTime = Date.now();

    const event = {
      session_id: sessionId,
      event_type: eventType,
      event_data: data,
      page_path: window.location.pathname + window.location.search,
      timestamp: Date.now(),
      sequence: ++eventCounter
    };

    events.push(event);

    // Auto-flush if batch size reached
    if (events.length >= CONFIG.MAX_BATCH_SIZE) {
      flush();
    }
  }

  /**
   * Flush events to server
   */
  function flush() {
    if (isFlushing || events.length === 0) return;

    isFlushing = true;
    const batch = events.splice(0, events.length);

    // Use sendBeacon if available for reliability on unload
    const payload = JSON.stringify({ events: batch, session_id: sessionId });

    if (navigator.sendBeacon) {
      navigator.sendBeacon(CONFIG.API_ENDPOINT, new Blob([payload], { type: 'application/json' }));
      isFlushing = false;
    } else {
      fetch(CONFIG.API_ENDPOINT, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: payload,
        keepalive: true
      }).catch(() => {
        // Re-queue on failure (limited retry)
        if (batch.length < CONFIG.MAX_BATCH_SIZE) {
          events.unshift(...batch);
        }
      }).finally(() => {
        isFlushing = false;
      });
    }
  }

  /**
   * Initialize scroll depth tracking
   */
  function initScrollTracking() {
    let ticking = false;

    window.addEventListener('scroll', () => {
      if (!ticking) {
        ticking = true;
        setTimeout(() => {
          const scrollTop = window.scrollY || document.documentElement.scrollTop;
          const docHeight = document.documentElement.scrollHeight - window.innerHeight;
          const depth = docHeight > 0 ? Math.round((scrollTop / docHeight) * 100) : 0;

          const threshold = scrollThresholds.find(t => depth >= t && !reachedThresholds.includes(t));
          if (threshold) {
            reachedThresholds.push(threshold);
            track('scroll_depth', { depth: threshold, actual_percent: depth });
          }

          ticking = false;
        }, CONFIG.SCROLL_THROTTLE_MS);
      }
    }, { passive: true });
  }

  /**
   * Initialize CTA click tracking
   */
  function initCTATracking() {
    document.addEventListener('click', (e) => {
      const el = e.target.closest('[data-track]');
      if (el) {
        track('cta_click', {
          element: el.dataset.track,
          text: (el.textContent || '').trim().slice(0, 100),
          href: el.href || null,
          tag: el.tagName.toLowerCase()
        });
      }
    });
  }

  /**
   * Track page view
   */
  function trackPageView() {
    const utms = parseUTMs();
    track('page_view', {
      title: document.title,
      referrer: document.referrer || null,
      utm_source: utms.source,
      utm_medium: utms.medium,
      utm_campaign: utms.campaign,
      utm_term: utms.term,
      utm_content: utms.content
    });
  }

  /**
   * Track time on page (heartbeat)
   */
  function initHeartbeat() {
    setInterval(() => {
      const timeOnPage = Date.now() - pageStartTime;
      // Send heartbeat every 30 seconds
      if (timeOnPage % 30000 < CONFIG.FLUSH_INTERVAL_MS) {
        track('heartbeat', { time_on_page_ms: timeOnPage });
      }
    }, 30000);
  }

  /**
   * Handle page visibility changes (tab switch)
   */
  function initVisibilityTracking() {
    document.addEventListener('visibilitychange', () => {
      if (document.visibilityState === 'hidden') {
        track('tab_hidden', { time_on_page_ms: Date.now() - pageStartTime });
        flush();
      } else {
        track('tab_visible', { time_hidden_ms: Date.now() - lastActivityTime });
      }
    });
  }

  /**
   * Initialize session
   */
  function init() {
    sessionId = getSession();
    pageStartTime = Date.now();

    trackPageView();
    initScrollTracking();
    initCTATracking();
    initHeartbeat();
    initVisibilityTracking();

    // Periodic flush
    setInterval(flush, CONFIG.FLUSH_INTERVAL_MS);

    // Flush on unload
    window.addEventListener('beforeunload', () => {
      track('page_exit', { time_on_page_ms: Date.now() - pageStartTime });
      flush();
    });

    // Flush on pagehide (mobile)
    window.addEventListener('pagehide', flush);
  }

  // Public API
  window.TrueVowAnalytics = {
    /**
     * Link current session to a lead ID (call after form submission)
     * @param {string} leadId - The lead UUID from sales_leads table
     */
    linkToLead: function(leadId) {
      track('lead_identified', { lead_id: leadId });
      flush();

      // Send link request
      fetch(CONFIG.LINK_ENDPOINT, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ session_id: sessionId, lead_id: leadId }),
        keepalive: true
      }).catch(() => {});
    },

    /**
     * Track custom event
     * @param {string} eventName - Event name
     * @param {object} data - Event data
     */
    track: function(eventName, data = {}) {
      track(eventName, data);
    },

    /**
     * Get current session ID
     */
    getSessionId: function() {
      return sessionId;
    },

    /**
     * Force flush events
     */
    flush: flush
  };

  // Auto-init when DOM is ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
