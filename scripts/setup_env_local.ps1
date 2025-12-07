# Setup .env.local with all required variables
# Run this script to create/update .env.local

$envContent = @"
MARKETING_DATABASE_URL=postgresql://postgres:Intakely%40786@db.napwpkagxzqfpbearkjs.supabase.co:5432/postgres
MARKETING_DATABASE_PORT=5432
MARKETING_DATABASE_NAME=postgres
MARKETING_DATABASE_USER=postgres
MARKETING_DATABASE_PASSWORD=Intakely@786
MARKETING_SUPABASE_URL=https://napwpkagxzqfpbearkjs.supabase.co
MARKETING_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5hcHdwa2FneHpxZnBiZWFya2pzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI0NDg3ODcsImV4cCI6MjA3ODAyNDc4N30.OSHgEylvGsDBwi4xI7Rs0_hpWtULmqadCr_m_eV_EgE
MARKETING_SUPABASE_SERVICE_ROLE_SECRET=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5hcHdwa2FneHpxZnBiZWFya2pzIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2MjQ0ODc4NywiZXhwIjoyMDc4MDI0Nzg3fQ.bn4oYCt9ZuxSaF0MnEjWHUOYKTHcp4gchtWkNTC6GAU
"@

$envContent | Out-File -FilePath .env.local -Encoding utf8 -NoNewline

Write-Host "✅ .env.local file created/updated!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Variables set:"
Write-Host "   MARKETING_DATABASE_URL=postgresql://postgres:Intakely%40786@db.napwpkagxzqfpbearkjs.supabase.co:5432/postgres
Write-Host "   MARKETING_DATABASE_PORT=5432"
Write-Host "   MARKETING_DATABASE_NAME=postgres"
Write-Host "   MARKETING_DATABASE_USER=postgres"
Write-Host "   MARKETING_DATABASE_PASSWORD=Intakely@786
Write-Host "   MARKETING_SUPABASE_URL=https://napwpkagxzqfpbearkjs.supabase.co"
Write-Host "   MARKETING_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5hcHdwa2FneHpxZnBiZWFya2pzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI0NDg3ODcsImV4cCI6MjA3ODAyNDc4N30.OSHgEylvGsDBwi4xI7Rs0_hpWtULmqadCr_m_eV_EgE"
Write-Host "   MARKETING_SUPABASE_SERVICE_ROLE_SECRET=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5hcHdwa2FneHpxZnBiZWFya2pzIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2MjQ0ODc4NywiZXhwIjoyMDc4MDI0Nzg3fQ.bn4oYCt9ZuxSaF0MnEjWHUOYKTHcp4gchtWkNTC6GAU
"@
Write-Host ""
Write-Host "🚀 You can now run:"
Write-Host "   npm run db:execute supabase/CREATE_COUNTY_AVAILABILITY_TABLES.sql"
Write-Host "   npm run db:populate"

