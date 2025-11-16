# TrueVow Website Chatbot Widget

## Overview
- Location: `widgets/truevow-chatbot/`
- Purpose: Centralizes the embed-ready chat/voice intake widget so both the marketing demo landing page and the upcoming SaaS admin app can reference the same implementation.

## Files
- `chatbot.css` — visual system for launcher, chat window, animations, and theme dots. Namespaced under `.tv-chatbot` to prevent style collisions.
- `chatbot.js` — renders the widget markup (launcher, floating hand, chat shell) into any container and returns element handles for custom behaviour scripts.

## Usage
```
<link rel="stylesheet" href="../widgets/truevow-chatbot/chatbot.css">
<script src="../widgets/truevow-chatbot/chatbot.js"></script>
<div id="my-chatbot"></div>

<script>
  const chatbot = TrueVowChatbot.create(document.getElementById('my-chatbot'), {
    agentName: 'Benjamin',
    showLauncher: true,
    showFloatingHand: true
  });

  const { widget, launcher } = chatbot.getElements();
  // Attach project-specific behaviour, theme logic, Supabase calls, etc.
</script>
```

## Integration Notes
- The marketing page (`marketing/demo-oakwood.html`) keeps its bespoke behaviour script. It mounts the widget via `TrueVowChatbot.create` before wiring listeners.
- For the SaaS admin application, import the same files and bind firm-specific configuration inside the admin-generated embed script.
- The widget deliberately exposes raw DOM references instead of opinionated behaviour so different experiences (demo vs production tenant) can layer their own flows.

## Next Steps
- When the SaaS admin app provisions firm widgets, reuse this module and store firm-level settings (branding, theme, Supabase credentials) alongside a generated embed snippet.
- If shared behaviour becomes desirable, add optional helpers in `chatbot.js` (e.g., `TrueVowChatbot.behaviors.basic(elements, config)`), keeping the current passive create method backward compatible.
