-- ============================================
-- QUICK FIX: RLS Policies for Blog Content
-- Run this script to fix the INSERT error
-- ============================================

-- Enable RLS on blog_content table
ALTER TABLE blog_content ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist
DROP POLICY IF EXISTS "Public can view published content" ON blog_content;
DROP POLICY IF EXISTS "Public can insert blog content" ON blog_content;

-- Policy 1: Allow public to view published content only
CREATE POLICY "Public can view published content"
ON blog_content
FOR SELECT
TO public
USING (status = 'published');

-- Policy 2: Allow public to insert content (for admin form)
-- THIS IS THE ONE THAT'S MISSING!
CREATE POLICY "Public can insert blog content"
ON blog_content
FOR INSERT
TO public
WITH CHECK (true);

-- Verify the policies were created
SELECT 
    tablename,
    policyname,
    cmd as command
FROM pg_policies 
WHERE tablename = 'blog_content'
ORDER BY policyname;

