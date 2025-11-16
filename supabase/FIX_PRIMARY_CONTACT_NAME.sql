-- ============================================
-- FIX: primary_contact_name Column Issue
-- The table has primary_contact_name (NOT NULL) but form sends first_name/last_name
-- ============================================

-- Option 1: Make primary_contact_name nullable (if it's not needed)
ALTER TABLE firm_applications 
    ALTER COLUMN primary_contact_name DROP NOT NULL;

-- Option 2: Set a default value
-- ALTER TABLE firm_applications 
--     ALTER COLUMN primary_contact_name SET DEFAULT '';

-- Option 3: Create a trigger to auto-populate from first_name + last_name
-- (If you want to keep it NOT NULL but auto-fill it)
CREATE OR REPLACE FUNCTION set_primary_contact_name()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.primary_contact_name IS NULL THEN
        NEW.primary_contact_name := COALESCE(NEW.first_name || ' ' || NEW.last_name, '');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_set_primary_contact_name ON firm_applications;
CREATE TRIGGER trigger_set_primary_contact_name
    BEFORE INSERT ON firm_applications
    FOR EACH ROW
    EXECUTE FUNCTION set_primary_contact_name();

-- Verify the fix
SELECT 
    column_name,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_name = 'firm_applications'
AND column_name = 'primary_contact_name';

