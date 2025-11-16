# Test Form Submission After RLS Fix

## Step 1: Run the RLS Fix Script

1. Go to Supabase Dashboard
2. SQL Editor
3. Copy and paste the ENTIRE contents of `supabase/WORKING_RLS_FIX.sql`
4. Click "Run"
5. Check the output - you should see the policy listed

## Step 2: Wait 10-15 seconds

Supabase schema cache takes a moment to refresh.

## Step 3: Test the Form

1. Go to http://localhost:8000/marketing/apply.html
2. Fill out the form
3. Submit
4. Should work now

## Step 4: If Still Not Working

Check in Supabase:
1. Table Editor → firm_applications
2. Click "Policies" tab
3. You should see: "Public can insert firm applications" with INSERT command

If the policy isn't there, the script didn't run successfully.

