(function (global) {
    const DEFAULT_OPTIONS = {
        agentName: 'Benjamin',
        showLauncher: true,
        showFloatingHand: true
    };

    const TEMPLATE = (config) => `
        ${config.showFloatingHand ? '<div class="floating-hand" id="floatingHand"></div>' : ''}
        ${config.showLauncher ? `
            <button id="chatLauncher" aria-label="Open ${config.agentName} chat demo" title="Open ${config.agentName} chat demo">
                <div class="launcher-pill">
                    <div class="launcher-text">
                        <span>Oakwood Law Firm</span>
                        <span>Book your consultation</span>
                    </div>
                    <span class="launcher-arrow">›</span>
                </div>
                <div class="launcher-avatar" aria-hidden="true"></div>
            </button>
        ` : ''}
        <div class="chat-widget" id="chatWidget">
            <div class="chat-header">
                <div class="chat-identity">
                    <div class="chat-identity-avatar" aria-hidden="true"></div>
                    <div class="chat-identity-info">
                        <h3>${config.agentName}</h3>
                    </div>
                </div>
                <div class="voice-toggle-group">
                    <span class="voice-label">Voice</span>
                    <button class="voice-switch" id="voiceToggle" aria-pressed="true"><span>On</span></button>
                </div>
                <button class="chat-minimize" aria-label="Minimize chat" onclick="minimizeChat()">−</button>
            </div>
            <div class="chat-body" id="chatBody">
                <div class="chat-turn benjamin speaking">
                    <div class="voice-indicator" aria-hidden="true">
                        <div class="wave"><span></span><span></span><span></span></div>
                        <span>${config.agentName} is speaking</span>
                    </div>
                    <div class="chat-bubble benjamin">
                        👋 "Welcome to Oakwood Law Firm! I'm ${config.agentName}. Can I start by confirming the type of matter you're dealing with?"
                    </div>
                </div>
            </div>
            <div class="chat-input-panel">
                <div class="input-row">
                    <input type="text" id="chatInputField" placeholder="Speak or type your response..." autocomplete="off">
                    <button type="button" class="mic-button" id="chatMicButton" aria-label="Hold to record">
                        <span class="mic-icon" aria-hidden="true"></span>
                        <span class="mic-timer" id="micTimer">00:00</span>
                    </button>
                </div>
                <div class="hint-row">
                    <div class="theme-switcher" id="chatThemeSwitcher" role="group" aria-label="Change chat theme">
                        <button type="button" class="theme-dot" data-theme="pastel" aria-label="Pastel theme"></button>
                        <button type="button" class="theme-dot" data-theme="emerald" aria-label="Emerald theme"></button>
                        <button type="button" class="theme-dot" data-theme="sand" aria-label="Sand theme"></button>
                        <button type="button" class="theme-dot" data-theme="slate" aria-label="Slate theme"></button>
                        <button type="button" class="theme-dot" data-theme="violet" aria-label="Violet theme"></button>
                    </div>
                    <span id="chatHintText">Powered by TrueVow.law</span>
                </div>
            </div>
        </div>
    `;

    function createTrueVowChatbot(targetElement, options = {}) {
        if (!targetElement) {
            throw new Error('TrueVowChatbot.create requires a valid target element.');
        }

        const config = Object.assign({}, DEFAULT_OPTIONS, options);
        const wrapper = document.createElement('div');
        wrapper.className = 'tv-chatbot';
        wrapper.innerHTML = TEMPLATE(config);
        targetElement.appendChild(wrapper);

        return {
            getRoot: () => wrapper,
            getElements: () => ({
                widget: wrapper.querySelector('#chatWidget'),
                launcher: wrapper.querySelector('#chatLauncher'),
                floatingHand: wrapper.querySelector('#floatingHand'),
                chatBody: wrapper.querySelector('#chatBody'),
                voiceToggle: wrapper.querySelector('#voiceToggle'),
                inputField: wrapper.querySelector('#chatInputField'),
                micButton: wrapper.querySelector('#chatMicButton'),
                micTimer: wrapper.querySelector('#micTimer'),
                themeSwitcher: wrapper.querySelector('#chatThemeSwitcher'),
                hintText: wrapper.querySelector('#chatHintText')
            })
        };
    }

    global.TrueVowChatbot = { create: createTrueVowChatbot };
})(window);
