-- ============================================
-- Supabase RLS Policies Setup Script
-- ============================================
-- Copy and paste these into Supabase SQL Editor
-- Run each section separately
-- ============================================

-- ============================================
-- POLICY 1: Allow Public to View Published Blog Content
-- ============================================

-- Enable RLS on blog_content table (if not already enabled)
ALTER TABLE blog_content ENABLE ROW LEVEL SECURITY;

-- Drop existing policy if it exists (to avoid errors)
DROP POLICY IF EXISTS "Public can view published content" ON blog_content;

-- Create policy to allow public SELECT for published content only
CREATE POLICY "Public can view published content"
ON blog_content
FOR SELECT
TO public
USING (status = 'published');

-- Verify the policy was created
SELECT 
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd,
    qual
FROM pg_policies 
WHERE tablename = 'blog_content';

-- ============================================
-- POLICY 2: Allow Public to Insert Analytics Events
-- ============================================

-- Enable RLS on blog_analytics table (if not already enabled)
ALTER TABLE blog_analytics ENABLE ROW LEVEL SECURITY;

-- Drop existing policy if it exists (to avoid errors)
DROP POLICY IF EXISTS "Public can insert analytics" ON blog_analytics;

-- Create policy to allow public INSERT for analytics tracking
CREATE POLICY "Public can insert analytics"
ON blog_analytics
FOR INSERT
TO public
WITH CHECK (true);

-- Verify the policy was created
SELECT 
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd,
    qual
FROM pg_policies 
WHERE tablename = 'blog_analytics';

-- ============================================
-- OPTIONAL: Newsletter Policy (Skip for now)
-- ============================================
-- Uncomment below if you want to enable newsletter subscriptions later
/*
ALTER TABLE newsletter_subscribers ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Public can subscribe" ON newsletter_subscribers;

CREATE POLICY "Public can subscribe"
ON newsletter_subscribers
FOR INSERT
TO public
WITH CHECK (true);
*/

-- ============================================
-- VERIFY ALL POLICIES
-- ============================================
-- Run this to see all policies on your tables
SELECT 
    tablename,
    policyname,
    cmd as command,
    roles
FROM pg_policies
WHERE tablename IN ('blog_content', 'blog_analytics', 'newsletter_subscribers')
ORDER BY tablename, policyname;

