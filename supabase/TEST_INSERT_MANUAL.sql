-- ============================================
-- MANUAL TEST: Try Inserting a Row
-- Run this to test if INSERT works
-- ============================================

-- This simulates what the form does
-- If this fails, the policy isn't working
-- If this succeeds, the policy works but there might be a different issue

INSERT INTO firm_applications (
    first_name,
    last_name,
    email,
    phone,
    firm_name,
    practice_area,
    state,
    desired_county,
    firm_size,
    monthly_calls,
    referral_source,
    bar_number,
    firm_website,
    eligibility_1,
    eligibility_2,
    eligibility_3,
    eligibility_4,
    founding_member_interest,
    settle_interest,
    terms_agree,
    consider_founding_member_future,
    early_access_settle,
    application_source,
    status
) VALUES (
    'Test',
    'User',
    'test@example.com',
    '5551234567',
    'Test Firm',
    'personal-injury',
    'FL',
    'Miami-Dade',
    'solo',
    '10-20',
    'google',
    '123456',
    NULL,
    true,
    true,
    true,
    true,
    false,
    false,
    true,
    false,
    false,
    'apply_page',
    'pending'
);

-- If this succeeds, you should see 1 row returned
-- If it fails, you'll see an error message

SELECT * FROM firm_applications WHERE email = 'test@example.com';

