-- ============================================
-- Fix RLS Policies for Blog Content
-- Adds INSERT policy for blog_content table
-- ============================================

-- Enable RLS if not already enabled
ALTER TABLE blog_content ENABLE ROW LEVEL SECURITY;

-- Drop existing INSERT policy if it exists (using DROP POLICY IF EXISTS)
DROP POLICY IF EXISTS "Public can insert blog content" ON blog_content;

-- Create INSERT policy to allow public to insert content
-- This allows the admin form to add content
CREATE POLICY "Public can insert blog content"
ON blog_content
FOR INSERT
TO public
WITH CHECK (true);

-- Verify the policies
SELECT 
    tablename,
    policyname,
    cmd as command
FROM pg_policies 
WHERE tablename = 'blog_content'
ORDER BY policyname;

