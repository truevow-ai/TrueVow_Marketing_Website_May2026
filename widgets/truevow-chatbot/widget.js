/**
 * TrueVow Website Widget — Self-Contained Chat + Voice
 *
 * Drop one <script> tag into any page. All configuration via data-* attributes.
 *
 * Usage (centered avatar mode):
 *   <div id="benjaminPanel"></div>
 *   <script src="widget.js"
 *     data-tenant-id="oakwood-injury-law"
 *     data-display-mode="centered"
 *     data-visual-mode="avatar"
 *     data-target-element="benjaminPanel"
 *     data-api-base="http://localhost:3056"
 *     data-agent-name="Benjamin"
 *     data-primary-color="#0A2463">
 *   </script>
 *
 * Supported data-* attributes (all optional, defaults shown):
 *   data-tenant-id         (none)            — SaaS Admin tenant ID
 *   data-display-mode      "bottom-right"    — bottom-right | centered
 *   data-visual-mode       "default"         — default | avatar (centered only)
 *   data-target-element    (none)            — element ID for centered mode
 *   data-api-base          ""                — base URL for API calls
 *   data-endpoint          "/api/v1/widget/chat"
 *   data-agent-name        "Benjamin"
 *   data-primary-color     "#1a56db"
 *   data-position          "bottom-right"
 *   data-show-launcher     "true"
 */

(function () {
  var script = document.currentScript
  if (!script) { var scripts = document.getElementsByTagName('script'); script = scripts[scripts.length - 1] }

  var CONFIG = {
    tenantId:      script.getAttribute('data-tenant-id')      || null,
    displayMode:   script.getAttribute('data-display-mode')   || 'bottom-right',
    visualMode:    script.getAttribute('data-visual-mode')    || 'default',
    targetElement: script.getAttribute('data-target-element') || null,
    apiBase:       script.getAttribute('data-api-base')       || '',
    endpoint:      script.getAttribute('data-endpoint')       || '/api/v1/widget/chat',
    agentName:     script.getAttribute('data-agent-name')     || 'Benjamin',
    primaryColor:  script.getAttribute('data-primary-color')  || '#1a56db',
    position:      script.getAttribute('data-position')       || 'bottom-right',
    showLauncher:  script.getAttribute('data-show-launcher')  !== 'false',
  }

  var chatUrl = CONFIG.apiBase ? CONFIG.apiBase + CONFIG.endpoint : CONFIG.endpoint
  var isCentered = CONFIG.displayMode === 'centered'
  var isAvatar = isCentered && CONFIG.visualMode === 'avatar'
  var targetRoot = isCentered && CONFIG.targetElement
    ? document.getElementById(CONFIG.targetElement)
    : null

  // ── CSS ──────────────────────────────────────────────────────────
  var style = document.createElement('style')
  var cssRules = []

  if (!isCentered) {
    cssRules = [
      '.tvw-widget *{box-sizing:border-box;margin:0;padding:0;font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,sans-serif}',
      '.tvw-launcher{position:fixed;z-index:99998;cursor:pointer;display:flex;align-items:center;gap:10px;background:#fff;border-radius:50px;padding:8px 18px 8px 8px;box-shadow:0 4px 20px rgba(0,0,0,.15);transition:transform .2s}',
      '.tvw-launcher:hover{transform:scale(1.05)}',
      '.tvw-launcher-avatar{width:44px;height:44px;border-radius:50%;background:' + CONFIG.primaryColor + ';display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700;font-size:18px}',
      '.tvw-launcher-text{font-size:13px;color:#333;line-height:1.3}',
      '.tvw-launcher-text span{display:block;font-weight:600}',
      '.tvw-launcher-text span+span{font-weight:400;font-size:11px;color:#666}',
    ]
  }

  if (isAvatar) {
    cssRules = cssRules.concat([
      // Card wrapper — fixed height, no external growth
      '.tvw-centered-avatar{width:100%;max-width:520px;margin:0 auto;height:min(680px,calc(100vh - 160px));max-height:680px;min-height:560px;display:flex;flex-direction:column;overflow:hidden;border-radius:28px;background:rgba(255,255,255,.96);box-shadow:0 28px 80px rgba(0,0,0,.38);border:1px solid rgba(214,177,90,.35)}',
      // Top avatar area — does not grow
      '.tvw-avatar-stage{flex:0 0 auto;padding:28px 28px 18px;text-align:center}',
      '.tvw-centered-avatar.is-engaged .tvw-avatar-stage{padding:18px 24px 12px}',
      '.tvw-centered-avatar.is-engaged .tvw-avatar-shell{width:110px;height:110px}',
      '.tvw-centered-avatar.is-engaged .tvw-avatar-img{width:86px;height:86px}',
      '.tvw-centered-avatar.is-engaged .tvw-avatar-img img{width:100%;height:100%}',
      '.tvw-centered-avatar.is-engaged .tvw-avatar-message{display:none}',
      '.tvw-centered-avatar.is-engaged .tvw-avatar-controls{display:none}',
      // Chat area fills remaining, scrolls internally
      '.tvw-chat-shell{flex:1 1 auto;min-height:0;display:flex;flex-direction:column;border-top:1px solid #E5E7EB}',
      '.tvw-chat-body{flex:1 1 auto;min-height:0;overflow-y:auto;padding:18px;display:flex;flex-direction:column;gap:10px}',
      '.tvw-chat-input{flex:0 0 auto;padding:14px 18px 18px;border-top:1px solid #E5E7EB;background:#fff}',
      // Status pill
      '.tvw-avatar-status{display:inline-flex;align-items:center;padding:7px 13px;border-radius:999px;background:#EFF6FF;color:#0A2463;font-size:12px;font-weight:800;text-transform:uppercase;letter-spacing:.8px;margin-bottom:22px}',
      '.tvw-centered-avatar.is-engaged .tvw-avatar-status{margin-bottom:12px}',
      // Avatar shell + ring
      '.tvw-avatar-shell{position:relative;width:190px;height:190px;margin:0 auto 26px;display:flex;align-items:center;justify-content:center}',
      '.tvw-centered-avatar.is-engaged .tvw-avatar-shell{margin-bottom:12px}',
      '.tvw-avatar-ring{position:absolute;inset:0;border-radius:50%;border:2px solid rgba(10,36,99,.18)}',
      '.tvw-panel.is-speaking .tvw-avatar-ring,.tvw-panel.is-listening .tvw-avatar-ring{animation:tvw-avatarPulse 1.5s infinite ease-in-out;border-color:rgba(16,185,129,.75);box-shadow:0 0 0 12px rgba(16,185,129,.08)}',
      // Avatar image
      '.tvw-avatar-img{width:148px;height:148px;border-radius:50%;overflow:hidden;background:linear-gradient(135deg,#0A2463,#101827);display:flex;align-items:center;justify-content:center;border:5px solid #fff;box-shadow:0 14px 32px rgba(10,36,99,.28)}',
      '.tvw-avatar-img img{width:100%;height:100%;object-fit:cover}',
      '.tvw-avatar-fallback{display:none;color:#fff;font-size:64px;font-weight:900;font-family:Montserrat,sans-serif}',
      '.tvw-avatar-img.tvw-fallback .tvw-avatar-fallback{display:block}',
      '.tvw-centered-avatar.is-engaged .tvw-avatar-fallback{font-size:36px}',
      // Waveform
      '.tvw-waveform{position:absolute;bottom:-4px;display:flex;gap:4px;align-items:center;justify-content:center;height:28px}',
      '.tvw-waveform span{width:5px;height:10px;border-radius:999px;background:#0A2463;opacity:.35}',
      '.tvw-panel.is-speaking .tvw-waveform span,.tvw-panel.is-listening .tvw-waveform span{animation:tvw-wave 1s infinite ease-in-out;opacity:.9}',
      '.tvw-waveform span:nth-child(2){animation-delay:.12s}.tvw-waveform span:nth-child(3){animation-delay:.24s}.tvw-waveform span:nth-child(4){animation-delay:.36s}.tvw-waveform span:nth-child(5){animation-delay:.48s}',
      // Intro message
      '.tvw-avatar-message{text-align:center}',
      '.tvw-avatar-message strong{display:block;color:#0A2463;font-size:20px;margin-bottom:8px}',
      '.tvw-avatar-message p{color:#444;font-size:15px;line-height:1.65}',
      // Controls
      '.tvw-avatar-controls{display:flex;gap:10px;justify-content:center;margin-top:20px;flex-wrap:wrap}',
      '.tvw-avatar-controls button{border:none;border-radius:10px;padding:12px 20px;font-weight:800;cursor:pointer;font-size:14px}',
      '.tvw-avatar-controls .tvw-btn-voice{background:#0A2463;color:#fff}.tvw-avatar-controls .tvw-btn-chat{background:rgba(10,36,99,.08);color:#0A2463;border:1px solid rgba(10,36,99,.15)}',
      // Keyframes
      '@keyframes tvw-avatarPulse{0%,100%{transform:scale(1);box-shadow:0 0 0 6px rgba(16,185,129,.08)}50%{transform:scale(1.04);box-shadow:0 0 0 18px rgba(16,185,129,.02)}}',
      '@keyframes tvw-wave{0%,100%{height:8px}50%{height:24px}}',
    ])
  }

  // Chat widget CSS (both modes — slimmed for avatar since chat-body handles it)
  cssRules = cssRules.concat([
    '.tvw-chat{position:' + (isCentered ? 'static' : 'fixed') + ';z-index:99999;width:' + (isCentered ? '100%' : '380px') + ';max-height:' + (isCentered ? 'none' : '600px') + ';display:' + (isCentered ? 'contents' : 'none') + ';flex-direction:column;overflow:' + (isCentered ? 'visible' : 'hidden') + '}',
    '.tvw-chat.open{display:' + (isCentered ? 'contents' : 'flex') + '}',
    isCentered ? '' : '.tvw-chat-header{background:' + CONFIG.primaryColor + ';color:#fff;padding:16px 20px;display:flex;align-items:center;justify-content:space-between}',
    isCentered ? '' : '.tvw-chat-header h3{font-size:16px;font-weight:600}',
    isCentered ? '' : '.tvw-chat-header button{background:none;border:none;color:#fff;font-size:22px;cursor:pointer;opacity:.8}',
    isCentered ? '' : '.tvw-chat-header button:hover{opacity:1}',
    '.tvw-message{max-width:85%;padding:10px 14px;border-radius:12px;font-size:14px;line-height:1.5;word-wrap:break-word}',
    '.tvw-message.agent{align-self:flex-start;background:#f1f5f9;color:#1e293b;border-bottom-left-radius:4px}',
    '.tvw-message.user{align-self:flex-end;background:' + CONFIG.primaryColor + ';color:#fff;border-bottom-right-radius:4px}',
    '.tvw-message.system{align-self:center;background:#fef3c7;color:#92400e;font-size:12px;border-radius:8px}',
    '.tvw-message.tvw-error{align-self:center;background:#fef2f2;color:#991b1b;font-size:13px;font-weight:600;padding:12px 16px;max-width:90%}',
    '.tvw-typing .tvw-dot{display:inline-block;width:7px;height:7px;border-radius:50%;background:#94a3b8;margin:0 2px;animation:tvw-bounce 1.4s infinite both}',
    '.tvw-typing .tvw-dot:nth-child(2){animation-delay:.2s}.tvw-typing .tvw-dot:nth-child(3){animation-delay:.4s}',
    '@keyframes tvw-bounce{0%,80%,100%{transform:scale(0)}40%{transform:scale(1)}}',
    '.tvw-input-row{display:flex;gap:8px}',
    '.tvw-input-row input{flex:1;border:1px solid #e2e8f0;border-radius:24px;padding:10px 16px;font-size:14px;outline:none}',
    '.tvw-input-row input:focus{border-color:' + CONFIG.primaryColor + '}',
    '.tvw-input-row input:disabled{background:#f8fafc;color:#94a3b8;cursor:not-allowed}',
    '.tvw-mic-btn{width:40px;height:40px;border-radius:50%;border:1px solid #e2e8f0;background:#fff;cursor:pointer;font-size:18px;display:flex;align-items:center;justify-content:center;transition:all .2s}',
    '.tvw-mic-btn:disabled{opacity:.4;cursor:not-allowed}',
    '.tvw-mic-btn[data-active=true]{background:#ef4444;color:#fff;border-color:#ef4444;animation:tvw-pulse 1s infinite}',
    '@keyframes tvw-pulse{0%,100%{box-shadow:0 0 0 0 rgba(239,68,68,.4)}50%{box-shadow:0 0 0 10px rgba(239,68,68,0)}}',
    '.tvw-send-btn{width:40px;height:40px;border-radius:50%;border:none;background:' + CONFIG.primaryColor + ';color:#fff;cursor:pointer;font-size:16px;display:flex;align-items:center;justify-content:center}',
    '.tvw-send-btn:disabled{opacity:.4;cursor:not-allowed}',
  ].filter(Boolean))

  if (!isCentered) {
    cssRules.push(
      CONFIG.position === 'bottom-left'
        ? '.tvw-launcher{bottom:24px;left:24px} .tvw-chat{bottom:90px;left:24px}'
        : '.tvw-launcher{bottom:24px;right:24px} .tvw-chat{bottom:90px;right:24px}'
    )
  }

  style.textContent = cssRules.join('\n')
  document.head.appendChild(style)

  // ── DOM ──────────────────────────────────────────────────────────
  var sessionId = crypto.randomUUID ? crypto.randomUUID() : Date.now().toString(36)
  var isListening = false
  var recognition = null
  var isEngaged = false
  var connectionErrorShown = false
  var tenantUnavailable = false

  function el(tag, cls, html) {
    var e = document.createElement(tag)
    if (cls) e.className = cls
    if (html) e.innerHTML = html
    return e
  }

  function disableInput() {
    var inp = document.getElementById('tvwInput')
    var send = document.getElementById('tvwSend')
    var mic = document.getElementById('tvwMic')
    if (inp) { inp.disabled = true; inp.placeholder = 'Chat unavailable' }
    if (send) send.disabled = true
    if (mic) mic.disabled = true
  }

  function engage() {
    if (isEngaged || !isAvatar) return
    isEngaged = true
    var card = document.querySelector('.tvw-centered-avatar')
    if (card) card.classList.add('is-engaged')
  }

  // ── Build DOM ────────────────────────────────────────────────────
  var messagesContainer = null
  var chat = el('div', 'tvw-chat' + (isCentered ? ' open' : ''))

  if (isAvatar && targetRoot) {
    targetRoot.innerHTML = ''
    targetRoot.className = (targetRoot.className || '') + ' tvw-panel'

    // Outer fixed-height card
    var card = el('div', 'tvw-centered-avatar')

    // Avatar stage
    var avatarStage = el('div', 'tvw-avatar-stage')
    avatarStage.innerHTML =
      '<div class="tvw-avatar-status" id="tvwStatus">Voice ready</div>' +
      '<div class="tvw-avatar-shell">' +
        '<div class="tvw-avatar-ring"></div>' +
        '<div class="tvw-avatar-img" aria-label="' + CONFIG.agentName + '">' +
          '<img src="https://truevow.com/assets/benjamin-avatar.jpeg" alt="' + CONFIG.agentName + '"' +
            ' onerror="this.style.display=\'none\';this.parentElement.classList.add(\'tvw-fallback\')">' +
          '<span class="tvw-avatar-fallback">' + CONFIG.agentName.charAt(0) + '</span>' +
        '</div>' +
        '<div class="tvw-waveform" aria-hidden="true">' +
          '<span></span><span></span><span></span><span></span><span></span>' +
        '</div>' +
      '</div>' +
      '<div class="tvw-avatar-message">' +
        '<strong>' + CONFIG.agentName + '</strong>' +
        '<p>Hi, I\'m ' + CONFIG.agentName + '. I can show you how TrueVow\'s template-based intake flow works on a law firm website. You can speak to me or type.</p>' +
      '</div>' +
      '<div class="tvw-avatar-controls">' +
        '<button class="tvw-btn-voice" id="tvwVoiceBtn">Start Voice Demo</button>' +
        '<button class="tvw-btn-chat" id="tvwChatBtn">Type Instead</button>' +
      '</div>'
    card.appendChild(avatarStage)

    // Chat shell
    var chatShell = el('div', 'tvw-chat-shell')
    var chatBody = el('div', 'tvw-chat-body')
    chatBody.id = 'tvwMessages'
    messagesContainer = chatBody

    var chatInput = el('div', 'tvw-chat-input')
    chatInput.innerHTML =
      '<div class="tvw-input-row">' +
        '<button class="tvw-mic-btn" id="tvwMic" title="Voice input">🎤</button>' +
        '<input id="tvwInput" type="text" placeholder="Type your message..." autocomplete="off">' +
        '<button class="tvw-send-btn" id="tvwSend">➤</button>' +
      '</div>'

    chatShell.appendChild(chatBody)
    chatShell.appendChild(chatInput)
    card.appendChild(chatShell)
    targetRoot.appendChild(card)

  } else if (isCentered && targetRoot) {
    // Non-avatar centered — plain chat
    chat.innerHTML =
      '<div class="tvw-chat-header"><div><h3>' + CONFIG.agentName + '</h3></div></div>' +
      '<div class="tvw-chat-body" id="tvwMessages"></div>' +
      '<div class="tvw-chat-input"><div class="tvw-input-row">' +
        '<button class="tvw-mic-btn" id="tvwMic" title="Voice input">🎤</button>' +
        '<input id="tvwInput" type="text" placeholder="Type your message..." autocomplete="off">' +
        '<button class="tvw-send-btn" id="tvwSend">➤</button>' +
      '</div></div>'
    messagesContainer = chat.querySelector('#tvwMessages')
    targetRoot.appendChild(chat)
  } else {
    // Bottom-right launcher mode
    if (CONFIG.showLauncher) {
      var launcher = el('div', 'tvw-launcher',
        '<div class="tvw-launcher-avatar">' + CONFIG.agentName.charAt(0) + '</div>' +
        '<div class="tvw-launcher-text"><span>' + CONFIG.agentName + '</span><span>Click to chat</span></div>')
      launcher.onclick = toggleChat
      document.body.appendChild(launcher)
    }
    chat.innerHTML =
      '<div class="tvw-chat-header">' +
        '<div><h3>' + CONFIG.agentName + '</h3></div>' +
        '<button onclick="this.closest(\'.tvw-chat\').classList.remove(\'open\')">&times;</button>' +
      '</div>' +
      '<div class="tvw-chat-messages" id="tvwMessages"></div>' +
      '<div class="tvw-input-row">' +
        '<button class="tvw-mic-btn" id="tvwMic" title="Voice input">🎤</button>' +
        '<input id="tvwInput" type="text" placeholder="Type your message..." autocomplete="off">' +
        '<button class="tvw-send-btn" id="tvwSend">➤</button>' +
      '</div>'
    messagesContainer = document.getElementById('tvwMessages') || chat.querySelector('#tvwMessages')
    document.body.appendChild(chat)
  }

  function toggleChat() { chat.classList.toggle('open') }

  // ── Avatar state helpers ──────────────────────────────────────────
  function setAvatarState(state) {
    var panel = targetRoot
    if (!panel) return
    panel.classList.remove('is-speaking', 'is-listening')
    if (state === 'speaking') { panel.classList.add('is-speaking'); var s = document.getElementById('tvwStatus'); if (s) s.textContent = CONFIG.agentName + ' speaking' }
    else if (state === 'listening') { panel.classList.add('is-listening'); var s = document.getElementById('tvwStatus'); if (s) s.textContent = 'Listening' }
    else { var s = document.getElementById('tvwStatus'); if (s) s.textContent = 'Voice ready' }
  }

  // ── Public API ────────────────────────────────────────────────────
  window.TrueVowWidget = {
    open: function () { engage(); var inp = document.getElementById('tvwInput'); if (inp) inp.focus() },
    close: function () { chat.classList.remove('open') },
    toggle: toggleChat,
    sendMessage: function (text) { engage(); addMsg('user', text); send(text) },
    focusInput: function () { engage(); var inp = document.getElementById('tvwInput'); if (inp) inp.focus() },
    setVisualState: setAvatarState,
  }

  // ── Avatar control buttons ────────────────────────────────────────
  var voiceBtn = document.getElementById('tvwVoiceBtn')
  var chatBtn = document.getElementById('tvwChatBtn')

  if (voiceBtn) {
    voiceBtn.addEventListener('click', function () {
      engage()
      setAvatarState('speaking')
      var inp = document.getElementById('tvwInput'); if (inp) inp.focus()
      setTimeout(function () { setAvatarState('listening') }, 2200)
    })
  }

  if (chatBtn) {
    chatBtn.addEventListener('click', function () {
      engage()
      setAvatarState('ready')
      var inp = document.getElementById('tvwInput'); if (inp) inp.focus()
    })
  }

  // ── Voice ─────────────────────────────────────────────────────────
  var SR = window.SpeechRecognition || window.webkitSpeechRecognition
  if (SR) {
    recognition = new SR()
    recognition.continuous = false
    recognition.interimResults = false
    recognition.lang = 'en-US'
    recognition.onresult = function(e) { engage(); var t = e.results[0][0].transcript; addMsg('user', t); send(t) }
    recognition.onerror = recognition.onend = function() { isListening = false; updateMic() }
  }

  function toggleMic() {
    if (!recognition) return
    if (isListening) { recognition.stop() } else { recognition.start(); isListening = true; updateMic() }
  }

  function updateMic() {
    var b = document.getElementById('tvwMic')
    if (b) b.setAttribute('data-active', isListening ? 'true' : 'false')
  }

  var micBtn = document.getElementById('tvwMic')
  if (micBtn) micBtn.onclick = toggleMic

  // ── Send ──────────────────────────────────────────────────────────
  function showConnectionError() {
    if (connectionErrorShown) return
    connectionErrorShown = true
    tenantUnavailable = true
    var container = messagesContainer
    if (!container) return
    // Remove any existing error
    var existing = container.querySelector('.tvw-error')
    if (existing) existing.remove()
    var errDiv = el('div', 'tvw-message system tvw-error', 'Benjamin is not available right now. Please try again later.')
    container.appendChild(errDiv)
    container.scrollTop = container.scrollHeight
    disableInput()
  }

  async function send(text) {
    if (tenantUnavailable) return

    var container = messagesContainer
    if (!container) return
    var typing = el('div', 'tvw-message tvw-typing agent',
      '<div class="tvw-dot"></div><div class="tvw-dot"></div><div class="tvw-dot"></div>')
    container.appendChild(typing)
    container.scrollTop = container.scrollHeight

    try {
      var payload = { message: text, session_id: sessionId }
      if (CONFIG.tenantId) payload.tenant_id = CONFIG.tenantId

      var res = await fetch(chatUrl, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      })
      var data = await res.json()

      if (data.unavailable) {
        if (typing) typing.remove()
        showConnectionError()
        return
      }

      var response = data.response || 'I didn\'t catch that.'

      if (typing) typing.remove()
      addMsg('agent', response)
    } catch (_) {
      if (typing) typing.remove()
      showConnectionError()
    }
  }

  function addMsg(role, text) {
    var container = messagesContainer
    if (!container) return
    var div = el('div', 'tvw-message ' + role)
    div.textContent = text
    container.appendChild(div)
    container.scrollTop = container.scrollHeight
  }

  var sendBtn = document.getElementById('tvwSend')
  if (sendBtn) {
    sendBtn.onclick = function() {
      var input = document.getElementById('tvwInput')
      var text = input.value.trim()
      if (!text || tenantUnavailable) return
      engage()
      addMsg('user', text)
      send(text)
      input.value = ''
    }
  }

  var chatInputEl = document.getElementById('tvwInput')
  if (chatInputEl) {
    chatInputEl.addEventListener('keydown', function(e) {
      if (e.key === 'Enter') { var sb = document.getElementById('tvwSend'); if (sb) sb.click() }
    })
  }
})()
