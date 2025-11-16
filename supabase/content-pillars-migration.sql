-- ============================================
-- Content Pillars Migration
-- Creates table and adds column to blog_content
-- ============================================

-- Create content_pillars table
CREATE TABLE IF NOT EXISTS content_pillars (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    color VARCHAR(20) DEFAULT '#0A2463',
    display_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Add content_pillar_id column to blog_content
ALTER TABLE blog_content 
ADD COLUMN IF NOT EXISTS content_pillar_id UUID REFERENCES content_pillars(id) ON DELETE SET NULL;

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS idx_blog_content_pillar ON blog_content(content_pillar_id);

-- Insert/Update TrueVow's Content Pillars (Law Firm Owner-First)
-- Based on core anxieties and TrueVow's positioning
INSERT INTO content_pillars (name, description, color, display_order) VALUES
    ('BAR COMPLIANCE & MALPRACTICE SHIELD', 'Core Anxiety: "Will this new tool get me sued or disbarred?" Content Angle: Framing technology choices as ethical risk management, not feature upgrades.', '#DC2626', 1),
    ('OVERHEAD & REVENUE LEAK PLUGGING', 'Core Anxiety: "Am I systematically leaving money on the table and wasting cash on staff doing $15/hr tasks?" Content Angle: Exposing hidden, quantifiable financial drains that feel like "the cost of doing business."', '#F59E0B', 2),
    ('AUDIT-PROOF DOCUMENTATION', 'Core Anxiety: "If the Bar audits me, can I prove I did everything right?" Content Angle: Positioning immutable proof not as a "cool feature," but as an unbreakable shield against allegations.', '#10B981', 3),
    ('VENDOR LOCK-IN & COST CONTROL', 'Core Anxiety: "Am I signing up for another expensive, useless software subscription?" Content Angle: Aligning vendor success with firm success by eliminating fixed costs and tying fees to firm revenue.', '#3B82F6', 4)
ON CONFLICT (name) DO UPDATE 
SET 
    description = EXCLUDED.description,
    color = EXCLUDED.color,
    display_order = EXCLUDED.display_order,
    is_active = TRUE,
    updated_at = NOW();

-- Deactivate old 5th pillar if it exists (keep for historical reference, don't delete)
UPDATE content_pillars 
SET is_active = FALSE, updated_at = NOW()
WHERE name = 'ETHICAL AUTOMATION BLUEPRINT' AND is_active = TRUE;

-- Enable RLS
ALTER TABLE content_pillars ENABLE ROW LEVEL SECURITY;

-- Allow public SELECT for active pillars
DROP POLICY IF EXISTS "Public can view active pillars" ON content_pillars;
CREATE POLICY "Public can view active pillars"
ON content_pillars FOR SELECT
TO public
USING (is_active = true);

-- Allow public INSERT for admin form (since admin form uses anon key)
DROP POLICY IF EXISTS "Public can insert pillars" ON content_pillars;
CREATE POLICY "Public can insert pillars"
ON content_pillars FOR INSERT
TO public
WITH CHECK (true);

-- Verify the migration
SELECT 'Content pillars table created successfully!' as status;

