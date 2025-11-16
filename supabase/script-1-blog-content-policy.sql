-- ============================================
-- SCRIPT 1: Allow Public to View Published Blog Content
-- ============================================
-- Copy this ENTIRE script and paste into Supabase SQL Editor
-- Then click "Run" button
-- ============================================

-- Enable RLS on blog_content table
ALTER TABLE blog_content ENABLE ROW LEVEL SECURITY;

-- Drop existing policy if it exists (to avoid errors)
DROP POLICY IF EXISTS "Public can view published content" ON blog_content;

-- Create policy to allow public SELECT for published content only
CREATE POLICY "Public can view published content"
ON blog_content
FOR SELECT
TO public
USING (status = 'published');

-- Verify it worked (you should see a table with the policy listed)
SELECT 
    tablename,
    policyname,
    cmd as command
FROM pg_policies 
WHERE tablename = 'blog_content';

