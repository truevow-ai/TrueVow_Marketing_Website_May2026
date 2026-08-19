const express = require('express');
const path = require('path');
const crypto = require('crypto');

const PORT = process.env.PORT || 80;
const SALES_OPS_URL = process.env.SALES_OPS_API_URL || '';
const SALES_OPS_KEY = process.env.SALES_OPS_API_KEY || '';
const MAX_BODY_SIZE = '64kb';

const app = express();

// ── Trust proxy (required on Fly.io for rate limiting to see real IPs) ──
app.set('trust proxy', true);

// ── Structured logging ──
function log(level, correlationId, message, detail) {
    const entry = {
        ts: new Date().toISOString(),
        level,
        correlationId,
        message,
        ...(detail ? { detail } : {})
    };
    if (level === 'error') console.error(JSON.stringify(entry));
    else console.log(JSON.stringify(entry));
}

// ── Rate limiting (in-memory, per-process — NOT globally distributed) ──
// This is a local abuse guard, not a strict platform-wide enforcement.
// With 2+ Fly machines, each process has its own counter. Restarts reset it.
// For production hardening: shared store (Redis) or edge-level enforcement.
// Sales Ops should also enforce its own rate/abuse controls at the boundary.
const rateLimitStore = new Map();
const RATE_LIMIT_WINDOW_MS = 60_000;
const RATE_LIMIT_MAX = 5;

function rateLimit(req, res, next) {
    const ip = req.ip;
    const now = Date.now();
    const entry = rateLimitStore.get(ip) || { count: 0, resetAt: now + RATE_LIMIT_WINDOW_MS };
    if (now > entry.resetAt) {
        entry.count = 1;
        entry.resetAt = now + RATE_LIMIT_WINDOW_MS;
    } else {
        entry.count++;
    }
    rateLimitStore.set(ip, entry);

    res.setHeader('X-RateLimit-Limit', RATE_LIMIT_MAX);
    res.setHeader('X-RateLimit-Remaining', Math.max(0, RATE_LIMIT_MAX - entry.count));
    res.setHeader('X-RateLimit-Reset', Math.ceil(entry.resetAt / 1000));

    if (entry.count > RATE_LIMIT_MAX) {
        return res.status(429).json({ error: 'Too many requests. Please wait before trying again.' });
    }
    next();
}

// Clean stale rate-limit entries periodically
setInterval(() => {
    const now = Date.now();
    for (const [ip, entry] of rateLimitStore) {
        if (now > entry.resetAt + RATE_LIMIT_WINDOW_MS) rateLimitStore.delete(ip);
    }
}, 300_000);

// ── Body parsing with size limit ──
app.use('/api', express.json({ limit: MAX_BODY_SIZE }));

// ── Schema validation helpers ──
function requiredString(val, maxLen = 255) {
    return typeof val === 'string' && val.trim().length > 0 && val.trim().length <= maxLen;
}
function optionalString(val, maxLen = 1024) {
    if (val === null || val === undefined || val === '') return true;
    return typeof val === 'string' && val.trim().length <= maxLen;
}
function validEmail(val) {
    return typeof val === 'string' && /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val) && val.length <= 255;
}
function validState(val) {
    const states = ['AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY','DC'];
    return states.includes(val);
}
function requiredBool(val) {
    return typeof val === 'boolean';
}

function validateTrialPayload(body) {
    const errors = [];

    // Attorney identity
    if (!requiredString(body.first_name)) errors.push('first_name is required');
    if (!requiredString(body.last_name)) errors.push('last_name is required');
    if (!validEmail(body.attorney_email)) errors.push('attorney_email must be a valid email');
    if (!requiredString(body.attorney_mobile)) errors.push('attorney_mobile is required');
    if (!validState(body.bar_state)) errors.push('bar_state must be a valid US state');
    if (!requiredString(body.bar_number)) errors.push('bar_number is required');

    // Firm identity
    if (!requiredString(body.firm_name)) errors.push('firm_name is required');
    if (!optionalString(body.firm_website, 2048)) errors.push('firm_website is invalid');
    if (!validEmail(body.firm_email)) errors.push('firm_email must be a valid email');
    if (!requiredString(body.firm_phone)) errors.push('firm_phone is required');
    if (!validState(body.state)) errors.push('state must be a valid US state');
    if (!requiredString(body.primary_county)) errors.push('primary_county is required');

    // Firm qualification
    if (!requiredString(body.primary_practice_area)) errors.push('primary_practice_area is required');
    if (!requiredString(body.firm_size)) errors.push('firm_size is required');
    if (!requiredString(body.monthly_inbound_calls)) errors.push('monthly_inbound_calls is required');

    // Governance (3 explicit checkboxes) — canonical field understands_setup_confirmation_required,
    // legacy alias understands_approval_required accepted for backward compatibility
    if (!requiredBool(body.agree_terms_privacy)) errors.push('agree_terms_privacy must be true');
    if (!requiredBool(body.confirm_accuracy_authority)) errors.push('confirm_accuracy_authority must be true');
    const setupConfirmation = body.understands_setup_confirmation_required !== undefined
        ? body.understands_setup_confirmation_required
        : body.understands_approval_required;
    if (!requiredBool(setupConfirmation)) errors.push('understands_setup_confirmation_required must be true');

    return errors;
}

// Lightweight validation for non-trial waitlist forms (settle, trace, benjamin-ad)
function validateLightweightWaitlist(body) {
    const errors = [];
    const nameField = body.name || body.first_name;
    if (!requiredString(nameField)) errors.push('name/first_name is required');
    if (!validEmail(body.email)) errors.push('email must be a valid email');
    if (!requiredString(body.firm_name)) errors.push('firm_name is required');
    if (!validState(body.state)) errors.push('state must be a valid US state');
    return errors;
}

function validateDemoPayload(body) {
    const errors = [];
    if (!requiredString(body.first_name)) errors.push('first_name is required');
    if (!requiredString(body.last_name)) errors.push('last_name is required');
    if (!validEmail(body.email)) errors.push('email must be a valid email');
    if (!requiredString(body.cell_phone)) errors.push('cell_phone is required');
    if (!requiredString(body.law_firm_name)) errors.push('law_firm_name is required');
    if (!validState(body.state)) errors.push('state must be a valid US state');
    if (!requiredString(body.county)) errors.push('county is required');
    if (!requiredBool(body.demo_consent)) errors.push('demo_consent must be true');
    return errors;
}

// ── Sales Ops forwarding ──
async function forwardToSalesOps(endpoint, payload, correlationId) {
    if (!SALES_OPS_URL) {
        log('warn', correlationId, 'SALES_OPS_API_URL not configured — skipping Sales Ops forward');
        return { accepted: true, simulated: true };
    }

    try {
        const controller = new AbortController();
        const timeout = setTimeout(() => controller.abort(), 15_000);

        const response = await fetch(SALES_OPS_URL + endpoint, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-API-Key': SALES_OPS_KEY,
                'X-Correlation-Id': correlationId
            },
            body: JSON.stringify(payload),
            signal: controller.signal
        });

        clearTimeout(timeout);

        const responseBody = await response.text().catch(() => '');
        let responseJson = null;
        try { responseJson = JSON.parse(responseBody); } catch (_) { /* not JSON */ }

        if (!response.ok) {
            log('error', correlationId, 'Sales Ops rejected submission', {
                status: response.status,
                body: responseBody.substring(0, 500)
            });
            return {
                accepted: false,
                status: response.status,
                error: responseJson?.message || responseJson?.error || 'Sales Ops rejected the submission'
            };
        }

        log('info', correlationId, 'Sales Ops accepted submission', { status: response.status });
        return { accepted: true };
    } catch (err) {
        log('error', correlationId, 'Sales Ops request failed', { error: err.message });
        return {
            accepted: false,
            status: 502,
            error: 'Unable to reach intake service. Please try again.'
        };
    }
}

// ── Idempotency (in-memory, per-process — NOT durable dedup) ──
// This is a best-effort cache, not the integrity boundary.
// Two Fly machines or a restart can accept the same submission independently.
// Sales Ops MUST enforce durable submission dedup as the authoritative guard.
// Marketing-side caching is an optimization that reduces duplicate attempts,
// NOT the sole mechanism preventing duplicate canonical records.
const idempotencyStore = new Map();
const IDEMPOTENCY_TTL_MS = 86400_000; // 24 hours

function checkIdempotency(key) {
    const entry = idempotencyStore.get(key);
    if (!entry) return null;
    if (Date.now() > entry.expiresAt) {
        idempotencyStore.delete(key);
        return null;
    }
    return entry.result;
}

function saveIdempotency(key, result) {
    idempotencyStore.set(key, { result, expiresAt: Date.now() + IDEMPOTENCY_TTL_MS });
}

// Clean stale idempotency entries
setInterval(() => {
    const now = Date.now();
    for (const [key, entry] of idempotencyStore) {
        if (now > entry.expiresAt) idempotencyStore.delete(key);
    }
}, 3600_000);

// ── BUILD SALES OPS PAYLOAD ──
function buildSalesOpsTrialPayload(validated) {
    const setupConfirmation = validated.understands_setup_confirmation_required !== undefined
        ? validated.understands_setup_confirmation_required
        : validated.understands_approval_required;
    return {
        product: validated.product || 'INTAKE_TRIAL',
        source: validated.source || 'trial-page',

        first_name: validated.first_name,
        last_name: validated.last_name,
        attorney_email: validated.attorney_email,
        attorney_mobile: validated.attorney_mobile,
        bar_state: validated.bar_state,
        bar_number: validated.bar_number,

        firm_name: validated.firm_name,
        firm_website: validated.firm_website || null,
        firm_email: validated.firm_email,
        firm_phone: validated.firm_phone,
        state: validated.state,
        primary_county: validated.primary_county,

        primary_practice_area: validated.primary_practice_area,
        firm_size: validated.firm_size,
        monthly_inbound_calls: validated.monthly_inbound_calls,
        current_after_hours_process: validated.current_after_hours_process || null,
        calendar_booking_available: validated.calendar_booking_available || null,
        willing_to_forward_calls: validated.willing_to_forward_calls || null,
        referral_source: validated.referral_source || null,

        agree_terms_privacy: validated.agree_terms_privacy,
        confirm_accuracy_authority: validated.confirm_accuracy_authority,
        understands_setup_confirmation_required: setupConfirmation,
        understands_90_day_trial: validated.understands_90_day_trial,
        understands_onboarding_required: validated.understands_onboarding_required,

        // Disclosure/version evidence — not fabricated affirmative consent
        disclosure_version: 'trial-step3-2026-08',
        disclosure_text_displayed: true,

        landing_page: validated.landing_page || null,
        query_string: validated.query_string || null,
        utm_source: validated.utm_source || null,
        utm_medium: validated.utm_medium || null,
        utm_campaign: validated.utm_campaign || null,
        utm_content: validated.utm_content || null,
        utm_term: validated.utm_term || null,
        gclid: validated.gclid || null,
        fbclid: validated.fbclid || null,
        msclkid: validated.msclkid || null,

        submitted_at: validated.submitted_at || new Date().toISOString(),
        user_agent: validated.user_agent || null,
        referrer: validated.referrer || null,
        ip_addr: validated.ip_addr || null
    };
}

function buildSalesOpsDemoPayload(validated) {
    return {
        source: validated.source || 'benjamin-demo',
        first_name: validated.first_name,
        last_name: validated.last_name,
        email: validated.email,
        cell_phone: validated.cell_phone,
        law_firm_name: validated.law_firm_name,
        state: validated.state,
        county: validated.county,
        demo_consent: validated.demo_consent,
        page_url: validated.page_url || null,
        submitted_at: validated.submitted_at || new Date().toISOString()
    };
}

// ── API Routes ──

// POST /api/waitlist — Trial intake form + lightweight waitlist forms
app.post('/api/waitlist', rateLimit, async (req, res) => {
    const correlationId = crypto.randomUUID();
    const ip = req.ip;
    const product = req.body.product || 'UNKNOWN';

    log('info', correlationId, 'POST /api/waitlist received', { ip, product, fields: Object.keys(req.body || {}) });

    // Select validator based on product type
    let errors;
    if (product === 'INTAKE_TRIAL') {
        errors = validateTrialPayload(req.body);
    } else {
        // Settle, Trace, Benjamin Ad, and any future lightweight waitlist forms
        errors = validateLightweightWaitlist(req.body);
    }

    if (errors.length > 0) {
        log('warn', correlationId, 'Validation failed', { product, errors });
        return res.status(400).json({ error: 'Validation failed', details: errors });
    }

    // Idempotency check
    const emailForDedup = (req.body.attorney_email || req.body.email || '').toLowerCase().trim();
    const firmForDedup = (req.body.firm_name || '').toLowerCase().trim();
    const idemKey = crypto.createHash('sha256')
        .update(`${product}:${emailForDedup}:${firmForDedup}`)
        .digest('hex');
    const cached = checkIdempotency(idemKey);
    if (cached) {
        log('info', correlationId, 'Idempotent submission — returning cached result', { idemKey: idemKey.substring(0, 12) });
        return res.status(cached.status).json(cached.body);
    }

    // Build Sales Ops payload — full for trial, pass-through for others
    const salesOpsPayload = product === 'INTAKE_TRIAL'
        ? buildSalesOpsTrialPayload(req.body)
        : { ...req.body, correlationId };

    // Forward to Sales Ops — only return success if Sales Ops durably accepts
    const endpoint = product === 'INTAKE_TRIAL'
        ? '/website/application-received'
        : '/website/waitlist-submission';

    const result = await forwardToSalesOps(endpoint, salesOpsPayload, correlationId);

    if (!result.accepted) {
        const statusCode = result.status || 502;
        const responseBody = { error: result.error || 'Unable to process your submission. Please try again.' };
        return res.status(statusCode).json(responseBody);
    }

    const successBody = {
        message: 'received',
        correlationId
    };

    saveIdempotency(idemKey, { status: 201, body: successBody });
    log('info', correlationId, 'Waitlist submission complete', { product, idemKey: idemKey.substring(0, 12) });
    return res.status(201).json(successBody);
});

// POST /api/demo-requests — Benjamin demo form
app.post('/api/demo-requests', rateLimit, async (req, res) => {
    const correlationId = crypto.randomUUID();
    const ip = req.ip;

    log('info', correlationId, 'POST /api/demo-requests received', { ip, fields: Object.keys(req.body || {}) });

    const errors = validateDemoPayload(req.body);
    if (errors.length > 0) {
        log('warn', correlationId, 'Demo validation failed', { errors });
        return res.status(400).json({ error: 'Validation failed', details: errors });
    }

    const idemKey = crypto.createHash('sha256')
        .update(`demo:${req.body.email.toLowerCase()}`)
        .digest('hex');
    const cached = checkIdempotency(idemKey);
    if (cached) {
        log('info', correlationId, 'Idempotent demo submission', { idemKey: idemKey.substring(0, 12) });
        return res.status(cached.status).json(cached.body);
    }

    const salesOpsPayload = buildSalesOpsDemoPayload(req.body);

    const result = await forwardToSalesOps('/demo-request', salesOpsPayload, correlationId);

    if (!result.accepted) {
        return res.status(result.status || 502).json({ error: result.error || 'Unable to process your demo request. Please try again.' });
    }

    const successBody = { message: 'received', correlationId };
    saveIdempotency(idemKey, { status: 201, body: successBody });
    log('info', correlationId, 'Demo submission complete', { idemKey: idemKey.substring(0, 12) });
    return res.status(201).json(successBody);
});

// ── Static file serving (replaces nginx) ──
// Marketing pages at root (trial.html → /trial.html)
app.use(express.static(path.join(__dirname, 'dist', 'marketing'), {
    index: 'index.html',
    extensions: ['html'],
    fallthrough: true
}));

// Legal pages at /legal/
app.use('/legal', express.static(path.join(__dirname, 'dist', 'legal')));

// Assets
app.use('/assets', express.static(path.join(__dirname, 'dist', 'assets')));

// JS
app.use('/js', express.static(path.join(__dirname, 'dist', 'js')));

// Components
app.use('/components', express.static(path.join(__dirname, 'dist', 'components')));

// Widgets
app.use('/widgets', express.static(path.join(__dirname, 'dist', 'widgets')));

// Root files (index.html, apply.html)
app.use(express.static(path.join(__dirname, 'dist')));

// Health check
app.get('/health', (req, res) => res.json({ status: 'ok', ts: new Date().toISOString() }));

// ── Start ──
if (!SALES_OPS_API_KEY) {
    console.warn('WARNING: SALES_OPS_API_KEY not set. Form submissions will NOT reach Sales Ops. Set via fly secrets.');
}

const server = app.listen(PORT, () => {
    console.log(JSON.stringify({
        ts: new Date().toISOString(),
        level: 'info',
        message: 'Marketing Website server started',
        port: PORT,
        salesOpsConfigured: !!SALES_OPS_URL
    }));
});

// Graceful shutdown
process.on('SIGTERM', () => {
    console.log(JSON.stringify({ ts: new Date().toISOString(), level: 'info', message: 'SIGTERM received — shutting down' }));
    server.close(() => process.exit(0));
});
