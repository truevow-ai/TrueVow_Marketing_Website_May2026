# Test with cURL After Nuclear Reset

## Quick Test Command

```bash
curl -X POST 'https://napwpkagxzqfpbearkjs.supabase.co/rest/v1/firm_applications' \
-H "apikey: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5hcHdwa2FneHpxZnBiZWFya2pzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI0NDg3ODcsImV4cCI6MjA3ODAyNDc4N30.OSHgEylvGsDBwi4xI7Rs0_hpWtULmqadCr_m_eV_EgE" \
-H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5hcHdwa2FneHpxZnBiZWFya2pzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI0NDg3ODcsImV4cCI6MjA3ODAyNDc4N30.OSHgEylvGsDBwi4xI7Rs0_hpWtULmqadCr_m_eV_EgE" \
-H "Content-Type: application/json" \
-H "Prefer: return=representation" \
-d '{"email":"nuke@test.com"}'
```

## Expected Response

**Success (201 Created):**
```json
[{"id":"...","email":"nuke@test.com","created_at":"..."}]
```

**Failure (401/42501):**
```json
{"code":"42501","message":"..."}
```

## If You See 201 → VICTORY

The table is wide open. Now:
1. Run `supabase/ADD_ALL_COLUMNS_BACK.sql` to add all form fields
2. Test the form - it should work!

## JavaScript Test (Browser Console)

```javascript
fetch('https://napwpkagxzqfpbearkjs.supabase.co/rest/v1/firm_applications', {
  method: 'POST',
  headers: {
    'apikey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5hcHdwa2FneHpxZnBiZWFya2pzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI0NDg3ODcsImV4cCI6MjA3ODAyNDc4N30.OSHgEylvGsDBwi4xI7Rs0_hpWtULmqadCr_m_eV_EgE',
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5hcHdwa2FneHpxZnBiZWFya2pzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI0NDg3ODcsImV4cCI6MjA3ODAyNDc4N30.OSHgEylvGsDBwi4xI7Rs0_hpWtULmqadCr_m_eV_EgE',
    'Content-Type': 'application/json',
    'Prefer': 'return=representation'
  },
  body: JSON.stringify({email: 'nuke@test.com'})
})
.then(r => r.json())
.then(console.log)
.catch(console.error);
```

