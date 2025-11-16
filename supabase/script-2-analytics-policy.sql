-- ============================================
-- SCRIPT 2: Allow Public to Insert Analytics Events
-- ============================================
-- Copy this ENTIRE script and paste into Supabase SQL Editor
-- Then click "Run" button
-- ============================================

-- Enable RLS on blog_analytics table
ALTER TABLE blog_analytics ENABLE ROW LEVEL SECURITY;

-- Drop existing policy if it exists (to avoid errors)
DROP POLICY IF EXISTS "Public can insert analytics" ON blog_analytics;

-- Create policy to allow public INSERT for analytics tracking
CREATE POLICY "Public can insert analytics"
ON blog_analytics
FOR INSERT
TO public
WITH CHECK (true);

-- Verify it worked (you should see a table with the policy listed)
SELECT 
    tablename,
    policyname,
    cmd as command
FROM pg_policies 
WHERE tablename = 'blog_analytics';

