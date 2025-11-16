-- ============================================
-- QUICK FIX: RLS Policy Only
-- If you're getting "row-level security policy" error
-- Run just this script
-- ============================================

-- Enable RLS (if not already enabled)
ALTER TABLE firm_applications ENABLE ROW LEVEL SECURITY;

-- Drop existing policy if it exists (to avoid conflicts)
DROP POLICY IF EXISTS "Public can insert firm applications" ON firm_applications;

-- Create policy to allow PUBLIC to INSERT
-- This is what's causing the "row-level security policy" error
CREATE POLICY "Public can insert firm applications"
ON firm_applications
FOR INSERT
TO public
WITH CHECK (true);

-- Verify the policy was created
SELECT 
    policyname,
    cmd as command,
    roles
FROM pg_policies
WHERE tablename = 'firm_applications';

-- You should see: "Public can insert firm applications" with command "INSERT"

