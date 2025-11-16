-- ============================================
-- SURE FIX: RLS Policy for Form Submissions
-- Supabase uses 'anon' role for anonymous requests
-- This creates policies for BOTH anon and public
-- ============================================

-- Enable RLS
ALTER TABLE firm_applications ENABLE ROW LEVEL SECURITY;

-- Drop ALL existing INSERT policies
DROP POLICY IF EXISTS "Anyone can submit firm application" ON firm_applications;
DROP POLICY IF EXISTS "Public can insert firm applications" ON firm_applications;
DROP POLICY IF EXISTS "anon_insert_firm_applications" ON firm_applications;
DROP POLICY IF EXISTS "public_insert_firm_applications" ON firm_applications;

-- Create policy for ANON role (this is what Supabase uses for anon key)
-- This is the MOST IMPORTANT one
CREATE POLICY "anon_insert_firm_applications"
ON firm_applications
FOR INSERT
TO anon
WITH CHECK (true);

-- Also create for public (just in case)
CREATE POLICY "public_insert_firm_applications"
ON firm_applications
FOR INSERT
TO public
WITH CHECK (true);

-- Verify
SELECT 
    policyname,
    cmd,
    roles,
    with_check
FROM pg_policies
WHERE tablename = 'firm_applications'
AND cmd = 'INSERT';

-- You MUST see at least one INSERT policy with role 'anon' or '{anon}'

