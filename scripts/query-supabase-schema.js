/**
 * Direct Supabase Schema Query
 * Uses REST API to query actual table structure
 */

require('dotenv').config({ path: '.env.local' })

const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://napwpkagxzqfpbearkjs.supabase.co'
const SUPABASE_ANON_KEY = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

if (!SUPABASE_ANON_KEY) {
  console.error('ERROR: NEXT_PUBLIC_SUPABASE_ANON_KEY not set in environment')
  console.error('Please set it in .env.local or pass as environment variable')
  process.exit(1)
}

async function queryTable(tableName) {
  try {
    const url = SUPABASE_URL + '/rest/v1/' + tableName + '?limit=1'
    const response = await fetch(url, {
      method: 'GET',
      headers: {
        'apikey': SUPABASE_ANON_KEY,
        'Authorization': 'Bearer ' + SUPABASE_ANON_KEY,
        'Content-Type': 'application/json'
      }
    })

    if (response.status === 404 || response.status === 406) {
      return { exists: false, error: 'Table not found' }
    }

    if (!response.ok) {
      const error = await response.text()
      return { exists: false, error: 'HTTP ' + response.status + ': ' + error }
    }

    const data = await response.json()
    
    if (Array.isArray(data) && data.length > 0) {
      return { exists: true, columns: Object.keys(data[0]), sampleRow: data[0] }
    } else if (Array.isArray(data)) {
      return { exists: true, columns: [], empty: true }
    }

    return { exists: true, columns: [], empty: true }
  } catch (error) {
    return { exists: false, error: error.message }
  }
}

async function main() {
  console.log('Querying Supabase Database Schema...\n')
  console.log('URL: ' + SUPABASE_URL + '\n')

  const tablesToCheck = [
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
    'page_analytics'
  ]

  const results = {}

  for (const table of tablesToCheck) {
    process.stdout.write('Checking ' + table + '... ')
    const result = await queryTable(table)
    results[table] = result
    
    if (result.exists) {
      if (result.columns && result.columns.length > 0) {
        console.log('EXISTS (' + result.columns.length + ' columns)')
      } else {
        console.log('EXISTS (empty)')
      }
    } else {
      console.log('NOT FOUND')
    }
  }

  console.log('\n\nRESULTS SUMMARY:\n')
  
  const existingTables = Object.entries(results)
    .filter(function(entry) { return entry[1].exists; })
    .map(function(entry) { return entry[0]; })

  const missingTables = Object.entries(results)
    .filter(function(entry) { return !entry[1].exists; })
    .map(function(entry) { return entry[0]; })

  console.log('EXISTING TABLES:')
  existingTables.forEach(function(table) {
    const result = results[table]
    if (result.columns && result.columns.length > 0) {
      console.log('   - ' + table + ' (columns: ' + result.columns.length + ')')
      console.log('     Columns: ' + result.columns.join(', '))
    } else {
      console.log('   - ' + table + ' (empty)')
    }
  })

  if (missingTables.length > 0) {
    console.log('\nMISSING TABLES:')
    missingTables.forEach(function(table) {
      console.log('   - ' + table)
    })
  }

  // Identify discrepancies
  console.log('\n\nDISCREPANCY ANALYSIS:\n')

  // Check content_items vs blog_content
  if (existingTables.indexOf('content_items') >= 0 && missingTables.indexOf('blog_content') >= 0) {
    console.log('DISCREPANCY: Code uses "content_items" (CORRECT), but docs mention "blog_content" (WRONG)')
    console.log('   -> Docs should be updated to use "content_items"')
  }

  if (existingTables.indexOf('blog_content') >= 0 && missingTables.indexOf('content_items') >= 0) {
    console.log('CRITICAL: Database has "blog_content" but code uses "content_items"')
    console.log('   -> Code needs to be updated OR database table needs to be renamed')
  }

  // Check notify_list vs newsletter_subscribers
  if (existingTables.indexOf('notify_list') >= 0 && missingTables.indexOf('newsletter_subscribers') >= 0) {
    console.log('DISCREPANCY: Code uses "notify_list" (CORRECT), but docs mention "newsletter_subscribers" (WRONG)')
    console.log('   -> Docs should be updated to use "notify_list"')
  }

  if (existingTables.indexOf('newsletter_subscribers') >= 0 && missingTables.indexOf('notify_list') >= 0) {
    console.log('CRITICAL: Database has "newsletter_subscribers" but code uses "notify_list"')
    console.log('   -> Code needs to be updated OR database table needs to be renamed')
  }

  // Check content_analytics vs blog_analytics
  if (existingTables.indexOf('content_analytics') >= 0 && missingTables.indexOf('blog_analytics') >= 0) {
    console.log('DISCREPANCY: Code uses "content_analytics" (CORRECT), but docs mention "blog_analytics" (WRONG)')
    console.log('   -> Docs should be updated to use "content_analytics"')
  }

  if (existingTables.indexOf('blog_analytics') >= 0 && missingTables.indexOf('content_analytics') >= 0) {
    console.log('CRITICAL: Database has "blog_analytics" but code uses "content_analytics"')
    console.log('   -> Code needs to be updated OR database table needs to be renamed')
  }

  // Generate fix recommendations
  console.log('\n\nFIX RECOMMENDATIONS:\n')

  if (existingTables.indexOf('content_items') >= 0) {
    console.log('Keep using "content_items" in code')
    console.log('   -> Update docs that mention "blog_content"')
  }

  if (existingTables.indexOf('notify_list') >= 0) {
    console.log('Keep using "notify_list" in code')
    console.log('   -> Update docs that mention "newsletter_subscribers"')
  }

  if (existingTables.indexOf('content_analytics') >= 0) {
    console.log('Keep using "content_analytics" in code')
    console.log('   -> Update docs that mention "blog_analytics"')
  }

  // Save results to file
  const fs = require('fs')
  const report = {
    timestamp: new Date().toISOString(),
    supabaseUrl: SUPABASE_URL,
    existingTables: existingTables,
    missingTables: missingTables,
    tableDetails: {}
  }

  existingTables.forEach(function(table) {
    report.tableDetails[table] = {
      columns: results[table].columns || [],
      empty: results[table].empty || false
    }
  })

  fs.writeFileSync('DATABASE_SCHEMA_VERIFICATION.json', JSON.stringify(report, null, 2))
  console.log('\nDetailed results saved to: DATABASE_SCHEMA_VERIFICATION.json')
  console.log('\nSchema verification complete!\n')
}

main().catch(console.error)
