# Supabase CLI Setup for Automated Database Updates

## Installation

### Windows (PowerShell)
```powershell
# Install via Scoop (if you have it)
scoop bucket add supabase https://github.com/supabase/scoop-bucket.git
scoop install supabase

# Or download from: https://github.com/supabase/cli/releases
```

### Alternative: Use Direct PostgreSQL Connection
Since CLI installation can be complex, we'll use direct PostgreSQL connection with proper error handling.

## Configuration

Create `.env.local` file in project root:
```
SUPABASE_DB_HOST=db.napwpkagxzqfpbearkjs.supabase.co
SUPABASE_DB_PORT=5432
SUPABASE_DB_NAME=postgres
SUPABASE_DB_USER=postgres
SUPABASE_DB_PASSWORD=your_database_password_here
```

Get password from: Supabase Dashboard → Settings → Database → Connection string

