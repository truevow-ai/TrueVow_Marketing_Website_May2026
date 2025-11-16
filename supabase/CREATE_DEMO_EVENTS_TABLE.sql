-- ============================================
-- CREATE demo_request_events TABLE + POLICIES
-- Logs key actions visitors take during the demo flow
-- ============================================

CREATE TABLE IF NOT EXISTS demo_request_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    demo_request_id UUID NULL REFERENCES demo_requests(id) ON DELETE SET NULL,
    event_name TEXT NOT NULL,
    metadata JSONB DEFAULT '{}'::jsonb,
    ip_address INET,
    user_agent TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_demo_request_events_name ON demo_request_events (event_name);
CREATE INDEX IF NOT EXISTS idx_demo_request_events_demo_id ON demo_request_events (demo_request_id);
CREATE INDEX IF NOT EXISTS idx_demo_request_events_created ON demo_request_events (created_at DESC);

ALTER TABLE demo_request_events DISABLE ROW LEVEL SECURITY;

GRANT INSERT ON TABLE demo_request_events TO anon;
GRANT INSERT ON TABLE demo_request_events TO public;
GRANT SELECT, DELETE, UPDATE ON TABLE demo_request_events TO authenticated;

SELECT '✅ demo_request_events table ready' AS status,
       (SELECT COUNT(*) FROM demo_request_events) AS current_rows;
