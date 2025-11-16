-- ============================================
-- WORKING RLS FIX - Copy and paste this EXACTLY
-- This will fix the "row-level security policy" error
-- ============================================

-- Step 1: Enable RLS (if not already enabled)
ALTER TABLE firm_applications ENABLE ROW LEVEL SECURITY;

-- Step 2: Drop any existing policies that might conflict
DROP POLICY IF EXISTS "Public can insert firm applications" ON firm_applications;
DROP POLICY IF EXISTS "Allow public insert" ON firm_applications;
DROP POLICY IF EXISTS "Enable insert for public" ON firm_applications;

-- Step 3: Create the INSERT policy for public/anonymous users
-- This allows form submissions from the website
CREATE POLICY "Public can insert firm applications"
ON firm_applications
FOR INSERT
TO public
WITH CHECK (true);

-- Step 4: Verify it worked
SELECT 
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd,
    qual,
    with_check
FROM pg_policies
WHERE tablename = 'firm_applications';

-- You should see a row with:
-- policyname: "Public can insert firm applications"
-- cmd: "INSERT"
-- roles: "{public}"
-- with_check: "true"

