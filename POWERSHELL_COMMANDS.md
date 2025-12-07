# PowerShell Commands - Copy & Paste

## Step 1: Check if password is set

```powershell
node scripts/check_env_setup.js
```

## Step 2: If password is missing, add it to .env.local

### Option A: Using PowerShell (if .env.local exists)
```powershell
Add-Content -Path .env.local -Value "SUPABASE_DB_PASSWORD=your_password_here"
```

### Option B: Edit manually
```powershell
notepad .env.local
```
Then add this line:
```
SUPABASE_DB_PASSWORD=your_actual_password_from_supabase
```

## Step 3: Verify password is set

```powershell
node scripts/check_env_setup.js
```

## Step 4: Test database connection

```powershell
npm run db:execute supabase/CREATE_COUNTY_AVAILABILITY_TABLES.sql
```

## Step 5: Populate county data

```powershell
npm run db:populate
```

## Quick Check (see what's in .env.local without showing password)

```powershell
Get-Content .env.local | Select-String -Pattern "SUPABASE" | ForEach-Object { if ($_ -match "PASSWORD") { "SUPABASE_DB_PASSWORD=***hidden***" } else { $_ } }
```

