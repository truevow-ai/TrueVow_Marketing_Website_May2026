-- ============================================
-- RENAME ALL TABLES TO WEB_* PREFIX
-- Marketing Website Database
-- ============================================
-- This script renames all existing tables to use the web_* prefix
-- to maintain consistent naming convention across the marketing website database

-- ============================================
-- STEP 1: RENAME APPLICATION TABLES
-- ============================================

-- affiliate_applications → web_affiliate_applications
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'affiliate_applications') THEN
        ALTER TABLE affiliate_applications RENAME TO web_affiliate_applications;
        RAISE NOTICE '✅ Renamed affiliate_applications → web_affiliate_applications';
    END IF;
END $$;

-- partner_applications → web_partner_applications
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'partner_applications') THEN
        ALTER TABLE partner_applications RENAME TO web_partner_applications;
        RAISE NOTICE '✅ Renamed partner_applications → web_partner_applications';
    END IF;
END $$;

-- ============================================
-- STEP 2: RENAME BLOG TABLES
-- ============================================

-- blog_analytics → web_blog_analytics
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'blog_analytics') THEN
        ALTER TABLE blog_analytics RENAME TO web_blog_analytics;
        RAISE NOTICE '✅ Renamed blog_analytics → web_blog_analytics';
    END IF;
END $$;

-- blog_content → web_blog_content
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'blog_content') THEN
        ALTER TABLE blog_content RENAME TO web_blog_content;
        RAISE NOTICE '✅ Renamed blog_content → web_blog_content';
    END IF;
END $$;

-- blog_content_tags → web_blog_content_tags
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'blog_content_tags') THEN
        ALTER TABLE blog_content_tags RENAME TO web_blog_content_tags;
        RAISE NOTICE '✅ Renamed blog_content_tags → web_blog_content_tags';
    END IF;
END $$;

-- blog_tags → web_blog_tags
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'blog_tags') THEN
        ALTER TABLE blog_tags RENAME TO web_blog_tags;
        RAISE NOTICE '✅ Renamed blog_tags → web_blog_tags';
    END IF;
END $$;

-- ============================================
-- STEP 3: RENAME CONTACT/SUBMISSION TABLES
-- ============================================

-- contact_submissions → web_contact_submissions
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'contact_submissions') THEN
        ALTER TABLE contact_submissions RENAME TO web_contact_submissions;
        RAISE NOTICE '✅ Renamed contact_submissions → web_contact_submissions';
    END IF;
END $$;

-- ============================================
-- STEP 4: RENAME CONTENT TABLES
-- ============================================

-- content_pillars → web_content_pillars
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'content_pillars') THEN
        ALTER TABLE content_pillars RENAME TO web_content_pillars;
        RAISE NOTICE '✅ Renamed content_pillars → web_content_pillars';
    END IF;
END $$;

-- ============================================
-- STEP 5: RENAME DEMO TABLES
-- ============================================

-- demo_request_events → web_demo_request_events
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'demo_request_events') THEN
        ALTER TABLE demo_request_events RENAME TO web_demo_request_events;
        RAISE NOTICE '✅ Renamed demo_request_events → web_demo_request_events';
    END IF;
END $$;

-- demo_requests → web_demo_requests
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'demo_requests') THEN
        ALTER TABLE demo_requests RENAME TO web_demo_requests;
        RAISE NOTICE '✅ Renamed demo_requests → web_demo_requests';
    END IF;
END $$;

-- ============================================
-- STEP 6: RENAME NEWSLETTER TABLE
-- ============================================

-- newsletter_subscribers → web_newsletter_subscribers
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'newsletter_subscribers') THEN
        ALTER TABLE newsletter_subscribers RENAME TO web_newsletter_subscribers;
        RAISE NOTICE '✅ Renamed newsletter_subscribers → web_newsletter_subscribers';
    END IF;
END $$;

-- ============================================
-- STEP 7: RENAME ANALYTICS TABLES
-- ============================================

-- page_analytics → web_page_analytics
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'page_analytics') THEN
        ALTER TABLE page_analytics RENAME TO web_page_analytics;
        RAISE NOTICE '✅ Renamed page_analytics → web_page_analytics';
    END IF;
END $$;

-- ============================================
-- STEP 8: RENAME PLATFORMS TABLE
-- ============================================

-- platforms → web_platforms
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'platforms') THEN
        ALTER TABLE platforms RENAME TO web_platforms;
        RAISE NOTICE '✅ Renamed platforms → web_platforms';
    END IF;
END $$;

-- ============================================
-- STEP 9: UPDATE FOREIGN KEY REFERENCES
-- ============================================

-- Update foreign keys in web_blog_content_tags
DO $$
BEGIN
    -- Update foreign key to web_blog_content
    IF EXISTS (SELECT FROM information_schema.table_constraints 
               WHERE constraint_name LIKE '%blog_content%'
               AND table_name = 'web_blog_content_tags') THEN
        
        ALTER TABLE web_blog_content_tags 
        DROP CONSTRAINT IF EXISTS blog_content_tags_content_id_fkey;
        
        ALTER TABLE web_blog_content_tags 
        ADD CONSTRAINT web_blog_content_tags_content_id_fkey
        FOREIGN KEY (content_id) 
        REFERENCES web_blog_content(id) 
        ON DELETE CASCADE;
        
        RAISE NOTICE '✅ Updated foreign key in web_blog_content_tags';
    END IF;
    
    -- Update foreign key to web_blog_tags
    IF EXISTS (SELECT FROM information_schema.table_constraints 
               WHERE constraint_name LIKE '%blog_tags%'
               AND table_name = 'web_blog_content_tags') THEN
        
        ALTER TABLE web_blog_content_tags 
        DROP CONSTRAINT IF EXISTS blog_content_tags_tag_id_fkey;
        
        ALTER TABLE web_blog_content_tags 
        ADD CONSTRAINT web_blog_content_tags_tag_id_fkey
        FOREIGN KEY (tag_id) 
        REFERENCES web_blog_tags(id) 
        ON DELETE CASCADE;
        
        RAISE NOTICE '✅ Updated foreign key in web_blog_content_tags';
    END IF;
    
    -- Update foreign key in web_blog_analytics
    IF EXISTS (SELECT FROM information_schema.table_constraints 
               WHERE constraint_name LIKE '%blog_content%'
               AND table_name = 'web_blog_analytics') THEN
        
        ALTER TABLE web_blog_analytics 
        DROP CONSTRAINT IF EXISTS blog_analytics_content_id_fkey;
        
        ALTER TABLE web_blog_analytics 
        ADD CONSTRAINT web_blog_analytics_content_id_fkey
        FOREIGN KEY (content_id) 
        REFERENCES web_blog_content(id) 
        ON DELETE CASCADE;
        
        RAISE NOTICE '✅ Updated foreign key in web_blog_analytics';
    END IF;
END $$;

-- ============================================
-- STEP 10: RENAME INDEXES
-- ============================================

-- Rename all indexes that reference old table names
DO $$
DECLARE
    idx_record RECORD;
    new_indexname TEXT;
BEGIN
    FOR idx_record IN 
        SELECT indexname, tablename
        FROM pg_indexes 
        WHERE schemaname = 'public' 
        AND (
            tablename IN ('affiliate_applications', 'partner_applications', 'blog_analytics', 
                         'blog_content', 'blog_content_tags', 'blog_tags', 'contact_submissions',
                         'content_pillars', 'demo_request_events', 'demo_requests',
                         'newsletter_subscribers', 'page_analytics', 'platforms')
            OR indexname LIKE 'idx_%' AND indexname NOT LIKE 'idx_web_%'
        )
    LOOP
        -- Skip if already has web_ prefix
        IF idx_record.indexname LIKE 'idx_web_%' THEN
            CONTINUE;
        END IF;
        
        -- Generate new index name
        new_indexname = 'idx_web_' || SUBSTRING(idx_record.indexname FROM 5);
        
        -- Only rename if new name doesn't exist
        IF NOT EXISTS (SELECT 1 FROM pg_indexes WHERE indexname = new_indexname) THEN
            EXECUTE format('ALTER INDEX %I RENAME TO %I', idx_record.indexname, new_indexname);
            RAISE NOTICE '✅ Renamed index: % → %', idx_record.indexname, new_indexname;
        END IF;
    END LOOP;
END $$;

-- ============================================
-- STEP 11: UPDATE VIEWS
-- ============================================

-- Rename published_blog_content view if it exists
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.views 
               WHERE table_schema = 'public' 
               AND table_name = 'published_blog_content') THEN
        
        -- Drop and recreate view with new table names
        DROP VIEW IF EXISTS published_blog_content;
        
        -- Recreate view (adjust query based on actual view definition)
        CREATE VIEW published_blog_content AS
        SELECT * FROM web_blog_content WHERE status = 'published';
        
        RAISE NOTICE '✅ Updated published_blog_content view';
    END IF;
END $$;

-- ============================================
-- STEP 12: VERIFICATION
-- ============================================

SELECT '✅ Migration complete!' AS status;

SELECT 
    table_name,
    CASE 
        WHEN table_name LIKE 'web_%' THEN '✅ Has web_ prefix'
        ELSE '❌ Missing web_ prefix'
    END AS status
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_type = 'BASE TABLE'
AND table_name NOT LIKE 'pg_%'
AND table_name NOT LIKE '_%'
ORDER BY 
    CASE WHEN table_name LIKE 'web_%' THEN 0 ELSE 1 END,
    table_name;
