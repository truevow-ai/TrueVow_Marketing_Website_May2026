-- ============================================
-- Complete RLS Policy Fix for Blog Content
-- Run this script to fix all RLS policies
-- ============================================

-- ============================================
-- 1. BLOG_CONTENT TABLE POLICIES
-- ============================================

-- Enable RLS
ALTER TABLE blog_content ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist
DROP POLICY IF EXISTS "Public can view published content" ON blog_content;
DROP POLICY IF EXISTS "Public can view all content for admin" ON blog_content;
DROP POLICY IF EXISTS "Public can insert blog content" ON blog_content;
DROP POLICY IF EXISTS "Public can update blog content" ON blog_content;
DROP POLICY IF EXISTS "Public can delete blog content" ON blog_content;
DROP POLICY IF EXISTS "Authenticated users can manage blog content" ON blog_content;

-- Policy 1: Allow public to view published content (for blog page)
CREATE POLICY "Public can view published content"
ON blog_content
FOR SELECT
TO public
USING (status = 'published');

-- Policy 1b: Allow public to view ALL content (for admin interface)
-- Note: This is needed so admin can see drafts and archived content
-- The admin form needs to see all content to edit/delete
CREATE POLICY "Public can view all content for admin"
ON blog_content
FOR SELECT
TO public
USING (true);

-- Policy 2: Allow public to insert content (for admin form)
CREATE POLICY "Public can insert blog content"
ON blog_content
FOR INSERT
TO public
WITH CHECK (true);

-- Policy 3: Allow public to update content (for admin form)
CREATE POLICY "Public can update blog content"
ON blog_content
FOR UPDATE
TO public
USING (true)
WITH CHECK (true);

-- Policy 4: Allow public to delete content (for admin form)
CREATE POLICY "Public can delete blog content"
ON blog_content
FOR DELETE
TO public
USING (true);

-- Verify blog_content policies
SELECT 
    tablename,
    policyname,
    cmd as command
FROM pg_policies 
WHERE tablename = 'blog_content'
ORDER BY policyname;

-- ============================================
-- 2. BLOG_ANALYTICS TABLE POLICIES
-- ============================================

-- Enable RLS
ALTER TABLE blog_analytics ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist
DROP POLICY IF EXISTS "Public can insert analytics" ON blog_analytics;
DROP POLICY IF EXISTS "Authenticated users can view all analytics" ON blog_analytics;

-- Policy 1: Allow public to insert analytics (for tracking)
CREATE POLICY "Public can insert analytics"
ON blog_analytics
FOR INSERT
TO public
WITH CHECK (true);

-- Verify blog_analytics policies
SELECT 
    tablename,
    policyname,
    cmd as command
FROM pg_policies 
WHERE tablename = 'blog_analytics'
ORDER BY policyname;

-- ============================================
-- 3. CONTENT_PILLARS TABLE POLICIES
-- ============================================

-- Enable RLS
ALTER TABLE content_pillars ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist
DROP POLICY IF EXISTS "Public can view active pillars" ON content_pillars;
DROP POLICY IF EXISTS "Public can insert pillars" ON content_pillars;

-- Policy 1: Allow public to view active pillars
CREATE POLICY "Public can view active pillars"
ON content_pillars
FOR SELECT
TO public
USING (is_active = true);

-- Policy 2: Allow public to insert pillars (for admin form)
CREATE POLICY "Public can insert pillars"
ON content_pillars
FOR INSERT
TO public
WITH CHECK (true);

-- Verify content_pillars policies
SELECT 
    tablename,
    policyname,
    cmd as command
FROM pg_policies 
WHERE tablename = 'content_pillars'
ORDER BY policyname;

-- ============================================
-- VERIFICATION
-- ============================================
-- Run this to see all policies
SELECT 
    tablename,
    policyname,
    cmd as command,
    roles
FROM pg_policies
WHERE tablename IN ('blog_content', 'blog_analytics', 'content_pillars')
ORDER BY tablename, policyname;

