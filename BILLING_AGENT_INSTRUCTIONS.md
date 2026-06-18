# Billing Sub-Agent — Pricing Model Overhaul Instructions

**Date:** June 17, 2026
**Reference:** `ICP_STATS_AND_PRICING.md` (Section O — Final Pricing, Locked)

---

## Summary of Changes

The INTAKE pricing model has been completely redesigned based on extensive ICP research. The unlock model is removed entirely. All records are visible on every tier. Call overflow replaces unlock billing. Attorney count is a hard firmographic gate, not a billable add-on. FOLLOW-UP is renamed to Nurture Agent. COMPLETE is removed from INTAKE. Recordings shift from minute-based to retention-based tiers. Four add-ons remain. Platform add-ons referencing unlocks are deleted.

---

## 1. INTAKE Base Plans — Replace Entirely

Delete all current INTAKE plan definitions and replace with:

```python
INTAKE_PLANS = {
    "solo": {
        "name": "Solo",
        "display_name": "Solo",
        "price_monthly_cents": 49900,       # $499.00
        "attorneys_max": 1,
        "calls_included": 40,
        "minutes_included": 440,            # 40 calls × 11 min avg
        "call_overflow_price_cents": 1500,  # $15.00 per call beyond cap
        "a_plus_visibility": "all",         # "all" = no unlock. All records visible.
        "a_plus_unlock_price_cents": None,  # REMOVED
        "recording_retention_default_days": 7,  # Solo: 7-day default
        "features": {
            "intake_workflow": True,
            "a_to_d_scoring": True,
            "a_plus_qualification": True,
            "consult_booking": True,
            "calendar_integration": True,
            "practice_area_routing": True,
            "language_routing": True,
            "sms_alerts": True,
            "basic_dashboard": True,
            "spanish_intake": True,
            "recording_7day": True,
            # NOT included: website_widget, lead_reporting, conversion_reporting, recording_30day
        },
    },
    "growth": {
        "name": "Growth",
        "display_name": "Growth",
        "price_monthly_cents": 129900,      # $1,299.00
        "attorneys_max": 5,
        "calls_included": 100,
        "minutes_included": 1100,           # 100 calls × 11 min avg
        "call_overflow_price_cents": 1200,  # $12.00 per call beyond cap
        "a_plus_visibility": "all",
        "a_plus_unlock_price_cents": None,
        "recording_retention_default_days": 30,  # Growth: 30-day default
        "features": {
            "intake_workflow": True,
            "a_to_d_scoring": True,
            "a_plus_qualification": True,
            "consult_booking": True,
            "calendar_integration": True,
            "practice_area_routing": True,
            "language_routing": True,
            "sms_alerts": True,
            "basic_dashboard": True,
            "spanish_intake": True,
            "recording_7day": True,
            "website_widget": True,          # Benjamin on Your Website
            "lead_reporting": True,           # Lead source reporting
            "conversion_reporting": True,     # Conversion reporting
            "recording_30day": True,          # 30-day retention included
            # NOT included: custom_routing, auto_priority, advanced_reporting, crm_export
        },
    },
    "team": {
        "name": "Team",
        "display_name": "Team",
        "price_monthly_cents": 199900,      # $1,999.00
        "attorneys_max": 11,
        "calls_included": 200,
        "minutes_included": 2200,           # 200 calls × 11 min avg
        "call_overflow_price_cents": 1000,  # $10.00 per call beyond cap
        "a_plus_visibility": "all",
        "a_plus_unlock_price_cents": None,
        "recording_retention_default_days": 30,  # Team: 30-day default
        "features": {
            "intake_workflow": True,
            "a_to_d_scoring": True,
            "a_plus_qualification": True,
            "consult_booking": True,
            "calendar_integration": True,
            "practice_area_routing": True,
            "language_routing": True,
            "sms_alerts": True,
            "basic_dashboard": True,
            "spanish_intake": True,
            "recording_7day": True,
            "website_widget": True,
            "lead_reporting": True,
            "conversion_reporting": True,
            "recording_30day": True,
            "custom_routing": True,          # Case-type granularity, seniority, availability windows
            "auto_priority_rules": True,     # Firm-defined A+ criteria, auto-book, auto-alert
            "advanced_reporting": True,      # By grade, outcome, source, booked consult
            "crm_export_included": True,     # Free on Team. $49/mo on Solo/Growth.
            "priority_onboarding": True,
            "priority_support": True,
            "recording_90day": True,         # 90-day retention option available
            "recording_180day": True,        # 180-day retention option available
        },
    },
}
```

---

## 2. Call Overflow Billing (New)

Replace all unlock billing logic with call overflow calculation:

```python
def calculate_overflow(plan, total_monthly_calls):
    overflow = max(0, total_monthly_calls - plan.calls_included)
    charge = overflow * plan.call_overflow_price_cents
    return overflow, charge

def check_upgrade_review(plan, monthly_history):
    """If firm exceeds cap 2+ consecutive months, flag for upgrade review."""
    overflow_months = sum(1 for m in monthly_history[-3:] if m > plan.calls_included)
    return overflow_months >= 2
```

---

## 3. Attorney Count Hard Gate

```python
ATTORNEY_GATES = {
    "solo": {"max": 1, "exceed_action": "must_upgrade_to_growth"},
    "growth": {"max": 5, "exceed_action": "must_upgrade_to_team"},
    "team": {"max": 11, "exceed_action": "enterprise_contact"},
}

def validate_attorney_count(plan, firm_attorney_count):
    gate = ATTORNEY_GATES[plan]
    if firm_attorney_count > gate["max"]:
        return {"valid": False, "action": gate["exceed_action"]}
    return {"valid": True}
```

No per-attorney billing anywhere. No multi-attorney add-on.

---

## 4. A+ Unlock Model — Delete Entirely

- Delete all code calculating A+ unlock overage charges
- Delete database columns: `a_plus_unlock_count`, `a_plus_unlock_overage_amount`
- Delete any billing waterfall logic referencing "unlock"
- The concept of "unlocking" a lead no longer exists. Every intake record is visible by default.

---

## 5. FOLLOW-UP → Rename to "Nurture Agent"

- Rename add-on ID: `follow_up` → `nurture_agent`
- Display name: "Nurture Agent"
- Keep existing tier structure:
  - Starter: $149/mo (200 actions + 300 connected voice min). Overage: $0.75/action, $0.25/min.
  - Scale: $299/mo (600 actions + 750 connected voice min). Overage: $0.50/action, $0.20/min.
- Restrict availability: Growth and Team only. Solo cannot purchase.
- An "action" = one outbound SMS, one outbound call attempt, or one scheduled reminder.
- Voice minutes are connected outbound minutes only (failed calls/voicemail = free).

---

## 6. COMPLETE — Remove from INTAKE

- Delete COMPLETE Starter ($99/mo, 15 packets + 250MB) and Scale ($199/mo, 55 packets + 1GB)
- Remove from INTAKE add-on catalog
- Note: If LEVERAGE/SETTLE billing references COMPLETE, relocate to that domain. If unused, delete entirely.

---

## 7. Recordings & Transcripts — Replace with Retention Tiers

Delete current per-minute add-ons:
- `recordings_only` ($49/mo, 1,500 min, $0.05/min overage)
- `transcripts_starter` ($199/mo, 1,500 min, $0.15/min overage)
- `transcripts_scale` ($399/mo, 4,500 min, $0.10/min overage)

Replace with retention-based tiers:

```python
RECORDING_RETENTION_ADDONS = {
    "recording_retention_90d": {
        "name": "Recordings & Transcripts — 90 Days",
        "price_monthly_cents": 2900,        # $29.00
        "retention_days": 90,
        "includes_transcripts": True,
        "available_on": ["growth", "team"],
    },
    "recording_retention_180d": {
        "name": "Recordings & Transcripts — 180 Days",
        "price_monthly_cents": 5900,        # $59.00
        "retention_days": 180,
        "includes_transcripts": True,
        "available_on": ["growth", "team"],
    },
    "recording_retention_1yr": {
        "name": "Recordings & Transcripts — 1 Year",
        "price_monthly_cents": 9900,        # $99.00
        "retention_days": 365,
        "includes_transcripts": True,
        "available_on": ["team"],            # Team only
    },
}
```

- Solo: 7-day retention if recording enabled. No extended options.
- Growth: 7-day default (included), 30-day (included), 90d ($29/mo), 180d ($59/mo).
- Team: 7-day default, 30-day, 90d, 180d, 1yr ($99/mo).
- Delete per-minute overage logic entirely.
- Recording is optional — firm enables during onboarding. If disabled, no retention add-on applies.
- Transcripts are included in all retention tiers (not a separate add-on).

---

## 8. Delete Platform Add-Ons

Remove from `infrastructure/database/migrations/005_register_platform_addons.sql`:
- `auto_unlock_a_plus` — Unlock model removed
- `outbound_agent` — Superseded by Nurture Agent

---

## 9. New Add-On: Intake-to-CRM Export

```python
INTAKE_CRM_EXPORT = {
    "id": "intake_crm_export",
    "name": "Intake-to-CRM Export",
    "price_monthly_cents": 4900,            # $49.00 per integration
    "available_on": ["solo", "growth", "team"],
    "free_on_team": True,                    # $0 on Team tier
    "description": "Auto-populates supported case-management systems with structured intake data on call completion. Custom native integrations quoted separately.",
    "setup_method": "self_serve_oauth",      # Firm enters own API credentials in customer portal
    "supported_platforms": "As built and tested — not a public commitment to specific named platforms",
    "billing_note": "Per integration. If firm connects multiple systems, each is $49/mo (unless on Team = $0)."
}
```

- Self-serve: firm connects credentials in customer portal. TrueVow stores encrypted.
- Push on call completion: TrueVow → case management API with mapped intake fields.
- API failure: alert to firm, retry queue.
- Team: free regardless of how many integrations connected.

---

## 10. New Add-On: Channel ROI Attribution

```python
CHANNEL_ROI_ATTRIBUTION = {
    "id": "channel_roi_attribution",
    "name": "Channel ROI Attribution",
    "price_monthly_cents": 4900,            # $49.00
    "available_on": ["growth", "team"],
    "description": "Matches intake source data to ad channels (Google Ads, Meta, LSA). Shows which campaigns produce calls, completed intakes, A+ opportunities, and booked consultations. Signed-case attribution requires firm to manually update case outcomes or connect a supported case-management source.",
    "setup_method": "read_only_ad_account_connection",
    "requires": ["google_ads_read_access", "meta_ads_read_access", "lsa_read_access"],
}
```

---

## 11. Migration File

Create `infrastructure/database/migrations/006_update_intake_pricing_model.sql`:

```sql
-- 006: Update INTAKE pricing model — remove unlocks, rename FOLLOW-UP, delete COMPLETE, retention-based recordings

-- 1. Update INTAKE base plans
UPDATE plans SET
    price_monthly_cents = 49900,
    calls_included = 40,
    minutes_included = 440,
    call_overflow_price_cents = 1500,
    attorneys_max = 1,
    a_plus_visibility = 'all',
    a_plus_unlock_price_cents = NULL,
    recording_retention_default_days = 7
WHERE plan_id = 'solo';

UPDATE plans SET
    price_monthly_cents = 129900,
    calls_included = 100,
    minutes_included = 1100,
    call_overflow_price_cents = 1200,
    attorneys_max = 5,
    a_plus_visibility = 'all',
    a_plus_unlock_price_cents = NULL,
    recording_retention_default_days = 30
WHERE plan_id = 'growth';

UPDATE plans SET
    price_monthly_cents = 199900,
    calls_included = 200,
    minutes_included = 2200,
    call_overflow_price_cents = 1000,
    attorneys_max = 11,
    a_plus_visibility = 'all',
    a_plus_unlock_price_cents = NULL,
    recording_retention_default_days = 30
WHERE plan_id = 'team';

-- 2. Remove unlock-related columns
ALTER TABLE firm_subscriptions DROP COLUMN IF EXISTS a_plus_unlocked_count;
ALTER TABLE firm_subscriptions DROP COLUMN IF EXISTS a_plus_unlock_overage;

-- 3. Rename FOLLOW-UP to Nurture Agent
UPDATE addons SET
    addon_id = 'nurture_agent',
    display_name = 'Nurture Agent'
WHERE addon_id = 'follow_up';

-- 4. Remove COMPLETE
DELETE FROM addons WHERE addon_id IN ('complete_starter', 'complete_scale');

-- 5. Remove old recording add-ons
DELETE FROM addons WHERE addon_id IN ('recordings_only', 'transcripts_starter', 'transcripts_scale');

-- 6. Remove platform add-ons
DELETE FROM platform_addons WHERE addon_id IN ('auto_unlock_a_plus', 'outbound_agent');

-- 7. Register new add-ons
INSERT INTO addons (addon_id, display_name, price_monthly_cents, available_on, free_on_team) VALUES
    ('recording_retention_90d', 'Recordings & Transcripts — 90 Days', 2900, ARRAY['growth', 'team'], FALSE),
    ('recording_retention_180d', 'Recordings & Transcripts — 180 Days', 5900, ARRAY['growth', 'team'], FALSE),
    ('recording_retention_1yr', 'Recordings & Transcripts — 1 Year', 9900, ARRAY['team'], FALSE),
    ('intake_crm_export', 'Intake-to-CRM Export', 4900, ARRAY['solo', 'growth', 'team'], TRUE),
    ('channel_roi_attribution', 'Channel ROI Attribution', 4900, ARRAY['growth', 'team'], FALSE);
```

---

## 12. Pricing Catalog Endpoint

Update `app/api/v1/endpoints/pricing_catalog.py`:

- Return all three INTAKE plans with updated pricing, feature flags, attorney max, call overflow
- Return add-ons with availability restrictions per tier
- Return attorney hard gates
- No references to: "unlock," "FOLLOW-UP," "COMPLETE," "per-minute recording," "multi-attorney add-on"
- LEVERAGE and SETTLE pricing: unchanged
- Settlement rewards: unchanged
- Founding Member pricing: unchanged

---

## 13. Verification Checklist

After implementation, verify each item:

- [ ] Solo plan: $499/mo, 40 calls, 1 attorney max, no unlock fields, $15/call overflow
- [ ] Growth plan: $1,299/mo, 100 calls, 5 attorneys max, no unlock fields, $12/call overflow
- [ ] Team plan: $1,999/mo, 200 calls, 11 attorneys max, no unlock fields, $10/call overflow
- [ ] All plans: `a_plus_visibility = "all"`, `a_plus_unlock_price_cents = None`
- [ ] Call overflow: calculated correctly at $15/$12/$10 per tier
- [ ] Recording retention defaults: Solo 7d, Growth 30d, Team 30d
- [ ] Attorney gate: 2nd attorney on Solo → rejected with "must_upgrade_to_growth"
- [ ] Attorney gate: 6th attorney on Growth → rejected with "must_upgrade_to_team"
- [ ] Attorney gate: 12th attorney on Team → rejected with "enterprise_contact"
- [ ] Nurture Agent: appears as add-on (not FOLLOW-UP), restricted to Growth/Team
- [ ] COMPLETE: removed from add-on catalog
- [ ] Recordings: retention-based tiers ($29/$59/$99), not minute-based
- [ ] Intake-to-CRM Export: $49/mo on Solo/Growth, $0 on Team
- [ ] Channel ROI Attribution: $49/mo, restricted to Growth/Team
- [ ] Auto-Unlock and Outbound Agent: deleted from platform add-ons
- [ ] Pricing catalog endpoint: clean JSON, all changes reflected
- [ ] LEVERAGE pricing: unchanged ($99/$349/$899 standalone, $79/$279/$699 with INTAKE)
- [ ] SETTLE pricing: unchanged ($39 single, $349 10-pack, $799 25-pack, $29 ecosystem, $299 Pro)
- [ ] Settlement rewards: unchanged
- [ ] No references to "unlock," "FOLLOW-UP," or "COMPLETE" in any code or response
- [ ] (Optional) Backward compatibility: historical subscription data not corrupted
