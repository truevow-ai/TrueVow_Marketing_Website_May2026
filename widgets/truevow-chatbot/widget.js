/**
 * TrueVow Website Widget — Self-Contained Chat + Voice
 *
 * Drop one <script> tag into any page. All configuration via data-* attributes.
 * Selects bridge at runtime — no hardcoded provider.
 *
 * Usage:
 *   <script src="widget.js"
 *     data-endpoint="/api/v1/widget/chat"
 *     data-agent-name="Benjamin"
 *     data-primary-color="#1a56db">
 *   </script>
 *
 * Supported data-* attributes (all optional, defaults shown):
 *   data-endpoint         "/api/v1/widget/chat"  — Sales Ops widget endpoint (isolated LLM, not Tenant App)
 *   data-agent-name       "Benjamin"
 *   data-primary-color    "#1a56db"
 *   data-position         "bottom-right"  — bottom-right | bottom-left
 *   data-show-launcher    "true"
 */

(function () {
  var script = document.currentScript
  if (!script) { var scripts = document.getElementsByTagName('script'); script = scripts[scripts.length - 1] }

  var CONFIG = {
    endpoint:     script.getAttribute('data-endpoint')      || '/api/v1/widget/chat',
    agentName:    script.getAttribute('data-agent-name')    || 'Benjamin',
    primaryColor: script.getAttribute('data-primary-color') || '#1a56db',
    position:     script.getAttribute('data-position')      || 'bottom-right',
    showLauncher: script.getAttribute('data-show-launcher') !== 'false',
  }

  // ── CSS ──────────────────────────────────────────────────────────
  var style = document.createElement('style')
  style.textContent = [
    '.tvw-widget *{box-sizing:border-box;margin:0;padding:0;font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,sans-serif}',
    '.tvw-launcher{position:fixed;z-index:99998;cursor:pointer;display:flex;align-items:center;gap:10px;background:#fff;border-radius:50px;padding:8px 18px 8px 8px;box-shadow:0 4px 20px rgba(0,0,0,.15);transition:transform .2s}',
    '.tvw-launcher:hover{transform:scale(1.05)}',
    '.tvw-launcher-avatar{width:44px;height:44px;border-radius:50%;background:' + CONFIG.primaryColor + ';display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700;font-size:18px}',
    '.tvw-launcher-text{font-size:13px;color:#333;line-height:1.3}',
    '.tvw-launcher-text span{display:block;font-weight:600}',
    '.tvw-launcher-text span+span{font-weight:400;font-size:11px;color:#666}',
    '.tvw-chat{position:fixed;z-index:99999;width:380px;max-height:600px;background:#fff;border-radius:16px;box-shadow:0 8px 40px rgba(0,0,0,.2);display:none;flex-direction:column;overflow:hidden}',
    '.tvw-chat.open{display:flex}',
    '.tvw-chat-header{background:' + CONFIG.primaryColor + ';color:#fff;padding:16px 20px;display:flex;align-items:center;justify-content:space-between}',
    '.tvw-chat-header h3{font-size:16px;font-weight:600}',
    '.tvw-chat-header button{background:none;border:none;color:#fff;font-size:22px;cursor:pointer;opacity:.8}',
    '.tvw-chat-header button:hover{opacity:1}',
    '.tvw-chat-messages{flex:1;overflow-y:auto;padding:16px;display:flex;flex-direction:column;gap:10px;max-height:380px}',
    '.tvw-message{max-width:85%;padding:10px 14px;border-radius:12px;font-size:14px;line-height:1.5;word-wrap:break-word}',
    '.tvw-message.agent{align-self:flex-start;background:#f1f5f9;color:#1e293b;border-bottom-left-radius:4px}',
    '.tvw-message.user{align-self:flex-end;background:' + CONFIG.primaryColor + ';color:#fff;border-bottom-right-radius:4px}',
    '.tvw-message.system{align-self:center;background:#fef3c7;color:#92400e;font-size:12px;border-radius:8px}',
    '.tvw-typing .tvw-dot{display:inline-block;width:7px;height:7px;border-radius:50%;background:#94a3b8;margin:0 2px;animation:tvw-bounce 1.4s infinite both}',
    '.tvw-typing .tvw-dot:nth-child(2){animation-delay:.2s}',
    '.tvw-typing .tvw-dot:nth-child(3){animation-delay:.4s}',
    '@keyframes tvw-bounce{0%,80%,100%{transform:scale(0)}40%{transform:scale(1)}}',
    '.tvw-input-row{display:flex;padding:12px 16px;border-top:1px solid #e2e8f0;gap:8px}',
    '.tvw-input-row input{flex:1;border:1px solid #e2e8f0;border-radius:24px;padding:10px 16px;font-size:14px;outline:none}',
    '.tvw-input-row input:focus{border-color:' + CONFIG.primaryColor + '}',
    '.tvw-mic-btn{width:40px;height:40px;border-radius:50%;border:1px solid #e2e8f0;background:#fff;cursor:pointer;font-size:18px;display:flex;align-items:center;justify-content:center;transition:all .2s}',
    '.tvw-mic-btn[data-active=true]{background:#ef4444;color:#fff;border-color:#ef4444;animation:tvw-pulse 1s infinite}',
    '@keyframes tvw-pulse{0%,100%{box-shadow:0 0 0 0 rgba(239,68,68,.4)}50%{box-shadow:0 0 0 10px rgba(239,68,68,0)}}',
    '.tvw-send-btn{width:40px;height:40px;border-radius:50%;border:none;background:' + CONFIG.primaryColor + ';color:#fff;cursor:pointer;font-size:16px;display:flex;align-items:center;justify-content:center}',
    CONFIG.position === 'bottom-left'
      ? '.tvw-launcher{bottom:24px;left:24px} .tvw-chat{bottom:90px;left:24px}'
      : '.tvw-launcher{bottom:24px;right:24px} .tvw-chat{bottom:90px;right:24px}',
  ].join('\n')
  document.head.appendChild(style)

  // ── DOM ──────────────────────────────────────────────────────────
  var sessionId = crypto.randomUUID ? crypto.randomUUID() : Date.now().toString(36)
  var isListening = false
  var recognition = null

  function el(tag, cls, html) {
    var e = document.createElement(tag)
    if (cls) e.className = cls
    if (html) e.innerHTML = html
    return e
  }

  var launcher = el('div', 'tvw-launcher',
    '<div class="tvw-launcher-avatar">' + CONFIG.agentName.charAt(0) + '</div>' +
    '<div class="tvw-launcher-text"><span>' + CONFIG.agentName + '</span><span>Click to chat</span></div>')
  launcher.onclick = toggleChat
  document.body.appendChild(launcher)

  var chat = el('div', 'tvw-chat')
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
  document.body.appendChild(chat)

  function toggleChat() { chat.classList.toggle('open') }

  // ── Voice ─────────────────────────────────────────────────────────
  var SR = window.SpeechRecognition || window.webkitSpeechRecognition
  if (SR) {
    recognition = new SR()
    recognition.continuous = false
    recognition.interimResults = false
    recognition.lang = 'en-US'
    recognition.onresult = function(e) { var t = e.results[0][0].transcript; addMsg('user', t); send(t) }
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

  document.getElementById('tvwMic').onclick = toggleMic

  // ── Send ──────────────────────────────────────────────────────────
  async function send(text) {
    var container = document.getElementById('tvwMessages')
    var typing = el('div', 'tvw-message tvw-typing agent',
      '<div class="tvw-dot"></div><div class="tvw-dot"></div><div class="tvw-dot"></div>')
    container.appendChild(typing)
    container.scrollTop = container.scrollHeight

    try {
      var res = await fetch(CONFIG.endpoint, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          message: text,
          session_id: sessionId,
        }),
      })
      var data = await res.json()
      var response = data.response || 'I didn\'t catch that.'

      if (typing) typing.remove()
      addMsg('agent', response)
    } catch (_) {
      if (typing) typing.remove()
      addMsg('agent', 'Connection issue. Please try again.')
    }
  }

  function addMsg(role, text) {
    var container = document.getElementById('tvwMessages')
    var div = el('div', 'tvw-message ' + role)
    div.textContent = text
    container.appendChild(div)
    container.scrollTop = container.scrollHeight
  }

  document.getElementById('tvwSend').onclick = function() {
    var input = document.getElementById('tvwInput')
    var text = input.value.trim()
    if (!text) return
    addMsg('user', text)
    send(text)
    input.value = ''
  }

  document.getElementById('tvwInput').addEventListener('keydown', function(e) {
    if (e.key === 'Enter') document.getElementById('tvwSend').click()
  })
})()
