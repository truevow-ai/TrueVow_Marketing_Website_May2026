# Run Texas population script using Supabase CLI connection
# PowerShell version

# Get connection string from Supabase CLI
$connectionString = supabase db remote get-connection-string 2>&1

if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrEmpty($connectionString)) {
    Write-Host "❌ Could not get connection string from Supabase CLI"
    Write-Host "   Make sure you're linked: supabase link --project-ref napwpkagxzqfpbearkjs"
    exit 1
}

# Export connection string for Node.js script
$env:SUPABASE_DB_URL = $connectionString.Trim()

# Run the population script
node scripts/comprehensive_texas_validation_and_update.js

