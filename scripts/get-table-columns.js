/**
 * Get actual column names for empty tables
 * Uses Supabase REST API to query table structure
 */

require('dotenv').config({ path: '.env.local' })

const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://napwpkagxzqfpbearkjs.supabase.co'
const SUPABASE_ANON_KEY = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

if (!SUPABASE_ANON_KEY) {
  console.error('ERROR: NEXT_PUBLIC_SUPABASE_ANON_KEY not set')
  process.exit(1)
}

async function getTableInfo(tableName) {
  try {
    // Try to insert a dummy row to see what columns are expected
    // Then delete it immediately
    const testData = {
      // For blog_analytics
      content_id: '00000000-0000-0000-0000-000000000000',
      event_type: 'test',
      created_at: new Date().toISOString()
    }
    
    const response = await fetch(SUPABASE_URL + '/rest/v1/' + tableName, {
      method: 'POST',
      headers: {
        'apikey': SUPABASE_ANON_KEY,
        'Authorization': 'Bearer ' + SUPABASE_ANON_KEY,
        'Content-Type': 'application/json',
        'Prefer': 'return=minimal'
      },
      body: JSON.stringify(testData)
    })

    const errorText = await response.text()
    
    if (response.status === 201) {
      // Insert succeeded - delete it
      console.log('Test insert succeeded for ' + tableName)
      return { success: true }
    } else if (response.status === 400 || response.status === 409) {
      // Parse error to see what columns are expected
      try {
        const error = JSON.parse(errorText)
        console.log('Error for ' + tableName + ':', error.message)
        return { error: error.message }
      } catch {
        return { error: errorText }
      }
    } else {
      return { error: 'HTTP ' + response.status + ': ' + errorText }
    }
  } catch (error) {
    return { error: error.message }
  }
}

async function main() {
  console.log('Attempting to infer table structure from error messages...\n')
  
  const tables = ['blog_analytics', 'newsletter_subscribers', 'firm_applications']
  
  for (const table of tables) {
    console.log('\nChecking: ' + table)
    const result = await getTableInfo(table)
    if (result.error) {
      console.log('  Error (this may reveal column structure):', result.error)
    }
  }
}

main().catch(console.error)

