/**
 * TrueVow Sales WebChat Widget
 * 
 * Standalone JavaScript widget for marketing website
 * Purpose: Convert prospects to leads (NOT customer support)
 */

(function() {
  'use strict';

  const TrueVowSalesChat = {
    config: {
      apiBaseUrl: 'https://cs-support.truevow.com',
      position: 'bottom-right',
      zIndex: 9999,
    },

    state: {
      isOpen: false,
      isMinimized: false,
      sessionId: null,
      messages: [],
      prospectEmail: '',
      prospectName: '',
      showEmailPrompt: true,
      isCustomer: false,
      redirectUrl: null,
      loading: false,
      sending: false,
    },

    init: function(options) {
      // Merge config
      Object.assign(this.config, options);

      // Create widget HTML
      this.createWidget();

      // Add event listeners
      this.attachEventListeners();

      console.log('TrueVow Sales WebChat initialized');
    },

    createWidget: function() {
      const widgetHTML = `
        <div id="truevow-sales-chat-widget" style="display: none;">
          <div class="truevow-chat-container">
            <!-- Header -->
            <div class="truevow-chat-header">
              <div class="truevow-chat-header-content">
                <svg class="truevow-chat-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                  <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
                </svg>
                <span class="truevow-chat-title">Chat with Sales</span>
              </div>
              <div class="truevow-chat-actions">
                <button class="truevow-chat-minimize" aria-label="Minimize">
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor">
                    <line x1="5" y1="12" x2="19" y2="12"></line>
                  </svg>
                </button>
                <button class="truevow-chat-close" aria-label="Close">
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor">
                    <line x1="18" y1="6" x2="6" y2="18"></line>
                    <line x1="6" y1="6" x2="18" y2="18"></line>
                  </svg>
                </button>
              </div>
            </div>

            <!-- Customer Redirect Message -->
            <div class="truevow-chat-customer-redirect" style="display: none;">
              <div class="truevow-chat-customer-content">
                <svg class="truevow-chat-alert-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                  <circle cx="12" cy="12" r="10"></circle>
                  <line x1="12" y1="8" x2="12" y2="12"></line>
                  <line x1="12" y1="16" x2="12.01" y2="16"></line>
                </svg>
                <h3>Existing Customer</h3>
                <p>You're already a TrueVow customer! For support, please visit our customer portal.</p>
                <a href="#" class="truevow-chat-redirect-btn">Go to Customer Portal</a>
              </div>
            </div>

            <!-- Email Prompt -->
            <div class="truevow-chat-email-prompt">
              <div class="truevow-chat-email-content">
                <h3>Let's get started!</h3>
                <p>Enter your email to start chatting with our sales team</p>
                <form class="truevow-chat-email-form">
                  <input type="email" class="truevow-chat-input" placeholder="your@email.com" required>
                  <input type="text" class="truevow-chat-input" placeholder="Your name (optional)">
                  <button type="submit" class="truevow-chat-submit-btn">Start Chat</button>
                </form>
              </div>
            </div>

            <!-- Messages -->
            <div class="truevow-chat-messages"></div>

            <!-- Input -->
            <div class="truevow-chat-input-container" style="display: none;">
              <input type="text" class="truevow-chat-message-input" placeholder="Type your message...">
              <button class="truevow-chat-send-btn" aria-label="Send">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor">
                  <line x1="22" y1="2" x2="11" y2="13"></line>
                  <polygon points="22 2 15 22 11 13 2 9 22 2"></polygon>
                </svg>
              </button>
            </div>
          </div>
        </div>

        <!-- Floating Button -->
        <button id="truevow-sales-chat-button" class="truevow-chat-button" aria-label="Chat with sales">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor">
            <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
          </svg>
        </button>
      `;

      // Inject styles
      this.injectStyles();

      // Add to DOM
      document.body.insertAdjacentHTML('beforeend', widgetHTML);
    },

    injectStyles: function() {
      if (document.getElementById('truevow-sales-chat-styles')) return;

      const styles = `
        <link rel="stylesheet" href="/webchat-integration/widget.css">
      `;
      document.head.insertAdjacentHTML('beforeend', styles);
    },

    attachEventListeners: function() {
      // Open button
      document.getElementById('truevow-sales-chat-button').addEventListener('click', () => {
        this.openWidget();
      });

      // Close button
      document.querySelector('.truevow-chat-close').addEventListener('click', () => {
        this.closeWidget();
      });

      // Minimize button
      document.querySelector('.truevow-chat-minimize').addEventListener('click', () => {
        this.toggleMinimize();
      });

      // Email form
      document.querySelector('.truevow-chat-email-form').addEventListener('submit', (e) => {
        e.preventDefault();
        this.handleEmailSubmit(e.target);
      });

      // Message input
      const messageInput = document.querySelector('.truevow-chat-message-input');
      messageInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter' && !this.state.sending) {
          this.sendMessage();
        }
      });

      // Send button
      document.querySelector('.truevow-chat-send-btn').addEventListener('click', () => {
        this.sendMessage();
      });
    },

    openWidget: function() {
      this.state.isOpen = true;
      document.getElementById('truevow-sales-chat-widget').style.display = 'block';
      document.getElementById('truevow-sales-chat-button').style.display = 'none';
    },

    closeWidget: function() {
      this.state.isOpen = false;
      document.getElementById('truevow-sales-chat-widget').style.display = 'none';
      document.getElementById('truevow-sales-chat-button').style.display = 'block';
    },

    toggleMinimize: function() {
      this.state.isMinimized = !this.state.isMinimized;
      const container = document.querySelector('.truevow-chat-container');
      if (this.state.isMinimized) {
        container.classList.add('minimized');
      } else {
        container.classList.remove('minimized');
      }
    },

    async handleEmailSubmit(form) {
      const email = form.querySelector('input[type="email"]').value;
      const name = form.querySelector('input[type="text"]').value;

      if (!email) return;

      this.state.prospectEmail = email;
      this.state.prospectName = name;

      // Check if customer
      const isCustomer = await this.checkCustomer(email);
      if (isCustomer) {
        this.showCustomerRedirect();
        return;
      }

      // Create session
      this.state.showEmailPrompt = false;
      document.querySelector('.truevow-chat-email-prompt').style.display = 'none';
      document.querySelector('.truevow-chat-messages').style.display = 'block';
      document.querySelector('.truevow-chat-input-container').style.display = 'flex';

      await this.createSession();
      this.startPolling();
    },

    async checkCustomer(email) {
      try {
        const response = await fetch(`${this.config.apiBaseUrl}/api/v1/sales-webchat/check-customer`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ email }),
        });

        if (response.ok) {
          const data = await response.json();
          if (data.data?.is_customer) {
            this.state.isCustomer = true;
            this.state.redirectUrl = data.data.redirect_url || '/customer-portal/support';
            return true;
          }
        }
      } catch (error) {
        console.error('Error checking customer:', error);
      }
      return false;
    },

    showCustomerRedirect() {
      document.querySelector('.truevow-chat-email-prompt').style.display = 'none';
      document.querySelector('.truevow-chat-customer-redirect').style.display = 'block';
      const redirectBtn = document.querySelector('.truevow-chat-redirect-btn');
      redirectBtn.href = this.state.redirectUrl;
    },

    async createSession() {
      try {
        this.state.loading = true;
        const response = await fetch(`${this.config.apiBaseUrl}/api/v1/sales-webchat/session`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            prospect_email: this.state.prospectEmail,
            prospect_name: this.state.prospectName,
          }),
        });

        if (response.ok) {
          const data = await response.json();
          this.state.sessionId = data.data?.conversation_id;
        }
      } catch (error) {
        console.error('Error creating session:', error);
      } finally {
        this.state.loading = false;
      }
    },

    async fetchMessages() {
      if (!this.state.sessionId) return;

      try {
        const response = await fetch(`${this.config.apiBaseUrl}/api/v1/sales-webchat/${this.state.sessionId}/messages`);
        if (response.ok) {
          const data = await response.json();
          this.state.messages = data.data || [];
          this.renderMessages();
        }
      } catch (error) {
        console.error('Error fetching messages:', error);
      }
    },

    async sendMessage() {
      const input = document.querySelector('.truevow-chat-message-input');
      const messageText = input.value.trim();

      if (!messageText || !this.state.sessionId || this.state.sending) return;

      try {
        this.state.sending = true;
        const response = await fetch(`${this.config.apiBaseUrl}/api/v1/sales-webchat/${this.state.sessionId}/messages`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            body: messageText,
            from_type: 'prospect',
          }),
        });

        if (response.ok) {
          const data = await response.json();
          this.state.messages.push(data.data);
          input.value = '';
          this.renderMessages();
        }
      } catch (error) {
        console.error('Error sending message:', error);
      } finally {
        this.state.sending = false;
      }
    },

    renderMessages() {
      const container = document.querySelector('.truevow-chat-messages');
      if (this.state.messages.length === 0) {
        container.innerHTML = '<div class="truevow-chat-empty">Start a conversation. Our sales team will respond shortly.</div>';
        return;
      }

      container.innerHTML = this.state.messages.map(msg => `
        <div class="truevow-chat-message ${msg.from_type === 'agent' ? 'agent' : 'prospect'}">
          <div class="truevow-chat-message-content">${this.escapeHtml(msg.body)}</div>
          <div class="truevow-chat-message-time">${new Date(msg.created_at).toLocaleTimeString()}</div>
        </div>
      `).join('');

      container.scrollTop = container.scrollHeight;
    },

    startPolling() {
      setInterval(() => {
        this.fetchMessages();
      }, 3000);
    },

    escapeHtml(text) {
      const div = document.createElement('div');
      div.textContent = text;
      return div.innerHTML;
    },
  };

  // Expose globally
  window.TrueVowSalesChat = TrueVowSalesChat;

  // Auto-init if config provided
  if (window.TrueVowSalesChatConfig) {
    TrueVowSalesChat.init(window.TrueVowSalesChatConfig);
  }
})();
