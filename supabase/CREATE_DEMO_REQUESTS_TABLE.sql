-- ============================================
-- CREATE DEMO REQUESTS TABLE & RLS POLICIES
-- Run this once in Supabase SQL editor
-- ============================================

-- 1. Create table if it does not exist
CREATE TABLE IF NOT EXISTS demo_requests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name TEXT NOT NULL,
    last_name  TEXT NOT NULL,
    email      TEXT NOT NULL,
    phone      TEXT,
    practice_area TEXT,
    firm_name  TEXT,
    consent    BOOLEAN DEFAULT FALSE,
    source     TEXT DEFAULT 'homepage',
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 2. Ensure useful indexes
CREATE INDEX IF NOT EXISTS idx_demo_requests_email ON demo_requests (email);
CREATE INDEX IF NOT EXISTS idx_demo_requests_created_at ON demo_requests (created_at DESC);

-- 3. Enable Row Level Security
ALTER TABLE demo_requests ENABLE ROW LEVEL SECURITY;

-- 4. Drop existing policies to avoid duplicates
DROP POLICY IF EXISTS "Allow anon insert demo requests" ON demo_requests;
DROP POLICY IF EXISTS "Allow public insert demo requests" ON demo_requests;
DROP POLICY IF EXISTS "Allow authenticated read demo requests" ON demo_requests;

-- 5. Allow anon/public inserts (for marketing site forms)
CREATE POLICY "Allow anon insert demo requests"
    ON demo_requests
    FOR INSERT
    TO anon
    WITH CHECK (TRUE);

CREATE POLICY "Allow public insert demo requests"
    ON demo_requests
    FOR INSERT
    TO public
    WITH CHECK (TRUE);

-- 6. Allow authenticated users to read data (for admin dashboards)
CREATE POLICY "Allow authenticated read demo requests"
    ON demo_requests
    FOR SELECT
    TO authenticated
    USING (TRUE);

-- 6b. Explicit grants so anon/public can insert via REST
GRANT INSERT ON TABLE demo_requests TO anon;
GRANT INSERT ON TABLE demo_requests TO public;
GRANT SELECT ON TABLE demo_requests TO authenticated;

-- 7. For public marketing forms we disable RLS (table receives only non-sensitive leads)
ALTER TABLE demo_requests DISABLE ROW LEVEL SECURITY;

-- 8. Optional sanity check
SELECT '✅ demo_requests table ready' AS status,
       (SELECT COUNT(*) FROM demo_requests) AS current_rows;
