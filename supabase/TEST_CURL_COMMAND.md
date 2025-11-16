# Test Form Submission with cURL

## Quick Test (Replace with your values)

```bash
curl -X POST 'https://napwpkagxzqfpbearkjs.supabase.co/rest/v1/firm_applications' \
-H "apikey: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5hcHdwa2FneHpxZnBiZWFya2pzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI0NDg3ODcsImV4cCI6MjA3ODAyNDc4N30.OSHgEylvGsDBwi4xI7Rs0_hpWtULmqadCr_m_eV_EgE" \
-H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5hcHdwa2FneHpxZnBiZWFya2pzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI0NDg3ODcsImV4cCI6MjA3ODAyNDc4N30.OSHgEylvGsDBwi4xI7Rs0_hpWtULmqadCr_m_eV_EgE" \
-H "Content-Type: application/json" \
-H "Prefer: return=representation" \
-d '{"email":"test@example.com","first_name":"Test","last_name":"User","phone":"5551234567","firm_name":"Test Firm"}'
```

## Expected Response

**Success (201 Created):**
```json
[{"id":"...","email":"test@example.com",...}]
```

**Failure (401/42501):**
```json
{"code":"42501","message":"new row violates row-level security policy..."}
```

## If cURL Works But Form Doesn't

The issue is in the front-end code, not the database.

