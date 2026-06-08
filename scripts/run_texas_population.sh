#!/bin/bash
# Run Texas population script using Supabase CLI connection

# Get connection string from Supabase CLI
CONNECTION_STRING=$(supabase db remote get-connection-string 2>/dev/null)

if [ -z "$CONNECTION_STRING" ]; then
    echo "❌ Could not get connection string from Supabase CLI"
    echo "   Make sure you're linked: supabase link --project-ref napwpkagxzqfpbearkjs"
    exit 1
fi

# Export connection string for Node.js script
export SUPABASE_DB_URL="$CONNECTION_STRING"

# Run the population script
node scripts/comprehensive_texas_validation_and_update.js

