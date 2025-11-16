/**
 * Test Database Connections
 * Tests connection to all three Supabase databases
 */

require('dotenv').config({ path: '.env.local' })

const { createClient } = require('@supabase/supabase-js')

// Database 1: Marketing Website
const marketingUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
const marketingKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY

// Database 2: Tenant Application
const tenantAppUrl = process.env.TENANT_APP_SUPABASE_URL
const tenantAppKey = process.env.TENANT_APP_SUPABASE_ANON_KEY

// Database 3: SaaS Admin
const adminUrl = process.env.ADMIN_SUPABASE_URL
const adminKey = process.env.ADMIN_SUPABASE_ANON_KEY

async function testConnection(name, url, key) {
  try {
    if (!url || !key) {
      console.log(`❌ ${name}... ⚠️  NOT CONFIGURED (missing env vars)`)
      return false
    }

    const supabase = createClient(url, key)
    const { data, error } = await supabase.from('_test').select('count').limit(1)
    
    // Even if table doesn't exist, if we get a response, connection works
    if (error && error.code === 'PGRST116') {
      // Table doesn't exist, but connection works
      console.log(`✅ ${name}... ✅ CONNECTED`)
      return true
    }
    
    if (error) {
      console.log(`❌ ${name}... ❌ ERROR: ${error.message}`)
      return false
    }
    
    console.log(`✅ ${name}... ✅ CONNECTED`)
    return true
  } catch (error) {
    console.log(`❌ ${name}... ❌ ERROR: ${error.message}`)
    return false
  }
}

async function main() {
  console.log('🔍 Testing Supabase Database Connections...\n')
  
  await testConnection('1️⃣  Marketing Website Database', marketingUrl, marketingKey)
  await testConnection('2️⃣  Tenant Application Database', tenantAppUrl, tenantAppKey)
  await testConnection('3️⃣  SaaS Admin Database', adminUrl, adminKey)
  
  console.log('\n✅ Connection tests complete!')
}

main().catch(console.error)

