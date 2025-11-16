/**
 * Database Schema Verification Script
 * Queries Supabase to get actual table names and columns
 * Identifies discrepancies between code and actual database
 */

require('dotenv').config({ path: '.env.local' })

const { createClient } = require('@supabase/supabase-js')

// Get credentials from environment
const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://napwpkagxzqfpbearkjs.supabase.co'
const SUPABASE_ANON_KEY = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

if (!SUPABASE_ANON_KEY) {
  console.error('❌ ERROR: NEXT_PUBLIC_SUPABASE_ANON_KEY not found in .env.local')
  console.error('Please add your Supabase anon key to .env.local file')
  process.exit(1)
}

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY)

/**
 * Query Supabase to get list of all tables
 */
async function getTableList() {
  try {
    // Query information_schema to get all tables
    const { data, error } = await supabase.rpc('exec_sql', {
      query: `
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'public' 
        AND table_type = 'BASE TABLE'
        ORDER BY table_name;
      `
    }).catch(() => {
      // RPC might not exist, try direct REST API query
      return { data: null, error: { message: 'RPC not available, using alternative method' } }
    })

    if (error) {
      // Alternative: Try to query each known table and see which exist
      console.log('⚠️  Cannot query information_schema directly. Testing known tables...\n')
      return await testKnownTables()
    }

    return data
  } catch (error) {
    console.error('Error getting table list:', error.message)
    return await testKnownTables()
  }
}

/**
 * Test known table names to see which exist
 */
async function testKnownTables() {
  const knownTables = [
    'content_items',
    'blog_content',
    'content_analytics',
    'blog_analytics',
    'notify_list',
    'newsletter_subscribers',
    'firm_applications',
    'contact_submissions',
    'platforms',
    'blog_tags',
    'blog_content_tags',
    'content_tags',
    'page_analytics',
    'published_content'
  ]

  const existingTables = []
  const missingTables = []

  for (const tableName of knownTables) {
    try {
      // Try to query the table (limit 0 to just check if it exists)
      const { data, error } = await supabase
        .from(tableName)
        .select('*')
        .limit(0)

      if (error) {
        if (error.code === 'PGRST116' || error.message.includes('does not exist')) {
          missingTables.push(tableName)
        } else {
          // Table exists but might have RLS or other issues
          existingTables.push(tableName)
        }
      } else {
        existingTables.push(tableName)
      }
    } catch (err) {
      missingTables.push(tableName)
    }
  }

  return { existingTables, missingTables }
}

/**
 * Get columns for a specific table
 */
async function getTableColumns(tableName) {
  try {
    // Try to get one row to see the structure
    const { data, error } = await supabase
      .from(tableName)
      .select('*')
      .limit(1)

    if (error) {
      if (error.code === 'PGRST116') {
        return { error: 'Table does not exist' }
      }
      return { error: error.message }
    }

    // Get column names from the data structure
    if (data && data.length > 0) {
      return { columns: Object.keys(data[0]) }
    }

    // If table is empty, try to get schema via REST API metadata
    // This is a workaround - we'll list what columns we expect
    return { columns: [], note: 'Table exists but is empty - cannot infer columns' }
  } catch (error) {
    return { error: error.message }
  }
}

/**
 * Main verification function
 */
async function verifySchema() {
  console.log('🔍 Verifying Supabase Database Schema...\n')
  console.log(`📡 Connecting to: ${SUPABASE_URL}\n`)

  // Test connection
  try {
    const { data: testData, error: testError } = await supabase
      .from('content_items')
      .select('id')
      .limit(1)

    if (testError && testError.code === 'PGRST116') {
      console.log('⚠️  Table "content_items" does not exist!\n')
    } else if (testError) {
      console.log(`⚠️  Connection issue: ${testError.message}\n`)
    } else {
      console.log('✅ Successfully connected to Supabase\n')
    }
  } catch (error) {
    console.log(`⚠️  Connection test failed: ${error.message}\n`)
  }

  // Get table list
  console.log('📋 Checking for tables...\n')
  const tableResult = await getTableList()

  if (tableResult.existingTables) {
    console.log('✅ EXISTING TABLES:')
    tableResult.existingTables.forEach(table => console.log(`   - ${table}`))
    console.log('')

    if (tableResult.missingTables && tableResult.missingTables.length > 0) {
      console.log('❌ MISSING TABLES (referenced in code/docs but not found):')
      tableResult.missingTables.forEach(table => console.log(`   - ${table}`))
      console.log('')
    }
  }

  // Check columns for key tables
  console.log('\n📊 TABLE STRUCTURE ANALYSIS:\n')

  const keyTables = ['content_items', 'blog_content', 'notify_list', 'newsletter_subscribers', 'content_analytics', 'blog_analytics', 'firm_applications']

  for (const tableName of keyTables) {
    console.log(`\n🔍 Checking: ${tableName}`)
    const columns = await getTableColumns(tableName)
    
    if (columns.error) {
      if (columns.error.includes('does not exist')) {
        console.log(`   ❌ Table does not exist`)
      } else {
        console.log(`   ⚠️  Error: ${columns.error}`)
      }
    } else if (columns.columns && columns.columns.length > 0) {
      console.log(`   ✅ Found ${columns.columns.length} columns:`)
      columns.columns.forEach(col => console.log(`      - ${col}`))
    } else {
      console.log(`   ✅ Table exists (empty - cannot infer columns)`)
    }
  }

  // Identify discrepancies
  console.log('\n\n🔍 DISCREPANCIES IDENTIFIED:\n')

  const discrepancies = []

  // Check content_items vs blog_content
  const contentItemsExists = tableResult.existingTables?.includes('content_items')
  const blogContentExists = tableResult.existingTables?.includes('blog_content')

  if (contentItemsExists && blogContentExists) {
    discrepancies.push('⚠️  Both "content_items" AND "blog_content" tables exist - check which one is correct')
  } else if (!contentItemsExists && blogContentExists) {
    discrepancies.push('❌ Code uses "content_items" but database has "blog_content"')
  } else if (contentItemsExists && !blogContentExists) {
    discrepancies.push('✅ Using "content_items" (correct) - "blog_content" mentioned in docs is wrong')
  }

  // Check notify_list vs newsletter_subscribers
  const notifyListExists = tableResult.existingTables?.includes('notify_list')
  const newsletterSubscribersExists = tableResult.existingTables?.includes('newsletter_subscribers')

  if (notifyListExists && newsletterSubscribersExists) {
    discrepancies.push('⚠️  Both "notify_list" AND "newsletter_subscribers" tables exist - check which one is correct')
  } else if (!notifyListExists && newsletterSubscribersExists) {
    discrepancies.push('❌ Code uses "notify_list" but database has "newsletter_subscribers"')
  } else if (notifyListExists && !newsletterSubscribersExists) {
    discrepancies.push('✅ Using "notify_list" (correct) - "newsletter_subscribers" mentioned in docs is wrong')
  }

  // Check content_analytics vs blog_analytics
  const contentAnalyticsExists = tableResult.existingTables?.includes('content_analytics')
  const blogAnalyticsExists = tableResult.existingTables?.includes('blog_analytics')

  if (contentAnalyticsExists && blogAnalyticsExists) {
    discrepancies.push('⚠️  Both "content_analytics" AND "blog_analytics" tables exist - check which one is correct')
  } else if (!contentAnalyticsExists && blogAnalyticsExists) {
    discrepancies.push('❌ Code uses "content_analytics" but database has "blog_analytics"')
  } else if (contentAnalyticsExists && !blogAnalyticsExists) {
    discrepancies.push('✅ Using "content_analytics" (correct) - "blog_analytics" mentioned in docs is wrong')
  }

  if (discrepancies.length === 0) {
    console.log('✅ No discrepancies found!')
  } else {
    discrepancies.forEach(d => console.log(d))
  }

  console.log('\n\n📋 RECOMMENDATIONS:\n')
  console.log('1. Review discrepancies above')
  console.log('2. Update code to match actual database tables')
  console.log('3. Update documentation to reflect actual schema')
  console.log('4. Test all API endpoints after fixes')
  console.log('5. Verify blog hub displays correctly\n')
}

// Run verification
verifySchema().catch(console.error)

