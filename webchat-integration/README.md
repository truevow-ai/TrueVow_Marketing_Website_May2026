# Sales WebChat Widget Integration Guide

**Purpose:** Integrate TrueVow Sales WebChat widget into the marketing website  
**Target:** PROSPECTS/LEADS (NOT existing customers)  
**Date:** January 15, 2026

---

## 🎯 **Overview**

This widget is designed for the **marketing website** to convert **prospects into leads**. It is **NOT** for customer support.

### Key Features:
- ✅ **Automatic customer detection** - Existing customers are redirected to customer portal
- ✅ **Sales-focused** - Conversations go to Sales inbox, not CS
- ✅ **Lead capture** - Collects prospect email/name
- ✅ **Real-time chat** - Live chat with sales team
- ✅ **Mobile-responsive** - Works on all devices

---

## 📁 **Files Provided**

```
webchat-integration/
├── README.md (this file)
├── widget.js (Standalone JavaScript widget)
├── widget.css (Widget styles)
└── integration-example.html (Example integration)
```

---

## 🚀 **Quick Start**

### Option 1: Standalone JavaScript (Recommended)

1. **Add to your HTML** (before closing `</body>` tag):

```html
<!-- TrueVow Sales WebChat Widget -->
<link rel="stylesheet" href="/webchat-integration/widget.css">
<script src="/webchat-integration/widget.js"></script>
<script>
  TrueVowSalesChat.init({
    apiBaseUrl: 'https://cs-support.truevow.com', // CS-Support service URL
    position: 'bottom-right', // or 'bottom-left'
  });
</script>
```

2. **That's it!** The widget will appear automatically.

### Option 2: React Component (If using React)

```tsx
import { SalesWebChatWidget } from '@truevow/cs-support/components/marketing-website/SalesWebChatWidget'

<SalesWebChatWidget
  position="bottom-right"
  apiBaseUrl="https://cs-support.truevow.com"
/>
```

---

## ⚙️ **Configuration Options**

### JavaScript Widget Options:

```javascript
TrueVowSalesChat.init({
  apiBaseUrl: 'https://cs-support.truevow.com', // Required: CS-Support API URL
  position: 'bottom-right', // Optional: 'bottom-right' | 'bottom-left' (default: 'bottom-right')
  zIndex: 9999, // Optional: CSS z-index (default: 9999)
});
```

### React Component Props:

```tsx
interface SalesWebChatWidgetProps {
  position?: 'bottom-right' | 'bottom-left';
  apiBaseUrl?: string; // Default: process.env.NEXT_PUBLIC_API_URL
}
```

---

## 🔄 **How It Works**

### 1. **Customer Detection Flow**

```
Visitor opens widget
    ↓
Enters email
    ↓
Widget checks: Is this an existing customer?
    ↓
YES → Shows redirect message → Links to /customer-portal/support
NO → Creates sales chat session → Connects to Sales team
```

### 2. **Sales Chat Flow**

```
Prospect starts chat
    ↓
Conversation created in Sales context
    ↓
Sales team sees in unified inbox (Sales context)
    ↓
Sales team responds
    ↓
Prospect receives message
```

---

## 📡 **API Endpoints Used**

The widget uses these endpoints from the CS-Support service:

1. **POST `/api/v1/sales-webchat/check-customer`**
   - Checks if email/phone belongs to existing customer
   - Returns: `{ is_customer: boolean, redirect_url?: string }`

2. **POST `/api/v1/sales-webchat/session`**
   - Creates or retrieves sales chat session
   - Returns: `{ conversation_id, session_id, ... }`

3. **GET `/api/v1/sales-webchat/[id]/messages`**
   - Fetches chat messages
   - Polls every 3 seconds

4. **POST `/api/v1/sales-webchat/[id]/messages`**
   - Sends chat message
   - From prospect or agent

---

## 🎨 **Customization**

### Styling

The widget uses CSS variables for easy customization. Override in your CSS:

```css
:root {
  --truevow-chat-primary: #2563eb; /* Blue */
  --truevow-chat-primary-hover: #1d4ed8;
  --truevow-chat-bg: #ffffff;
  --truevow-chat-text: #1f2937;
  --truevow-chat-border: #e5e7eb;
}
```

### Positioning

Change position via config:
- `bottom-right` (default)
- `bottom-left`

---

## 🔒 **Security & Privacy**

- ✅ **No authentication required** for prospects
- ✅ **Customer detection** is privacy-safe (email-only check)
- ✅ **HTTPS required** for API calls
- ✅ **CORS configured** for marketing website domain

---

## 📱 **Mobile Support**

The widget is fully responsive:
- ✅ Touch-friendly buttons (44px minimum)
- ✅ Mobile-optimized layout
- ✅ Keyboard support
- ✅ Screen reader accessible

---

## 🐛 **Troubleshooting**

### Widget doesn't appear:
1. Check browser console for errors
2. Verify `apiBaseUrl` is correct
3. Check CORS settings on CS-Support service
4. Verify JavaScript files are loaded

### Customer detection not working:
1. Check API endpoint is accessible
2. Verify email format is correct
3. Check CS-Support service logs

### Messages not sending:
1. Check network tab for API errors
2. Verify session was created successfully
3. Check CS-Support service status

---

## 📊 **Analytics & Tracking**

The widget automatically tracks:
- Widget opens
- Customer detection events
- Session creation
- Message sent/received

(Integration with your analytics tool can be added)

---

## 🔗 **Related Documentation**

- **CS-Support Service:** `/docs/UNIFIED_INBOX_ARCHITECTURE.md`
- **Sales WebChat Service:** `/lib/services/sales-webchat-service.ts`
- **Customer Portal Widget:** `/components/customer-portal/WebChatWidget.tsx` (different widget for customers)

---

## ✅ **Integration Checklist**

- [ ] Add widget files to marketing website
- [ ] Configure `apiBaseUrl` to point to CS-Support service
- [ ] Test customer detection (use existing customer email)
- [ ] Test prospect chat (use new email)
- [ ] Verify redirect to customer portal works
- [ ] Test on mobile devices
- [ ] Verify sales team receives chats in Sales inbox
- [ ] Customize styling if needed
- [ ] Add analytics tracking (optional)

---

## 📞 **Support**

For integration issues:
1. Check this README
2. Review API documentation
3. Contact TrueVow development team

---

**Last Updated:** January 15, 2026  
**Version:** 1.0.0
