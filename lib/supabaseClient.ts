/**
 * Supabase Client Configuration
 * TrueVow Multi-Database Architecture
 */

import { createClient } from '@supabase/supabase-js'

// =====================================================
// DATABASE 1: MARKETING WEBSITE
// Used for: Blog, newsletter, contact forms, firm applications
// =====================================================
const marketingUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!
const marketingKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!

if (!marketingUrl || !marketingKey) {
  throw new Error(
    'Missing Marketing Website database credentials. Check .env.local for NEXT_PUBLIC_SUPABASE_URL and NEXT_PUBLIC_SUPABASE_ANON_KEY'
  )
}

// Marketing Website Database Client (default export for blog/website features)
export const supabase = createClient(marketingUrl, marketingKey)

// =====================================================
// DATABASE 2: TENANT APPLICATION
// Used for: Intake app, contacts, cases, appointments (per law firm)
// =====================================================
const tenantAppUrl = process.env.TENANT_APP_SUPABASE_URL!
const tenantAppKey = process.env.TENANT_APP_SUPABASE_ANON_KEY!

if (!tenantAppUrl || !tenantAppKey) {
  console.warn('⚠️ Tenant App database not configured. Intake features will not work.')
}

// Tenant Application Database Client (for intake app features)
export const tenantAppSupabase = tenantAppUrl && tenantAppKey 
  ? createClient(tenantAppUrl, tenantAppKey)
  : null

// =====================================================
// DATABASE 3: SAAS ADMIN
// Used for: Tenant management, billing, admin dashboard
// =====================================================
const adminUrl = process.env.ADMIN_SUPABASE_URL!
const adminKey = process.env.ADMIN_SUPABASE_ANON_KEY!

if (!adminUrl || !adminKey) {
  console.warn('⚠️ Admin database not configured. Admin features will not work.')
}

// Admin Database Client (for admin panel features)
export const adminSupabase = adminUrl && adminKey
  ? createClient(adminUrl, adminKey)
  : null

// TypeScript types for database tables
export interface ContentItem {
  id: string
  title: string
  teaser: string
  canonical_url: string
  publish_date: string
  thumbnail_url: string | null
  type: 'article' | 'video'
  status: 'draft' | 'published' | 'archived'
  platform_name: 'linkedin' | 'youtube'
  read_time_minutes: number | null
  watch_time_minutes: number | null
  is_featured: boolean
  view_count: number
  click_count: number
  created_at: string
  updated_at: string
  published_at: string | null
}

export interface Platform {
  name: string
  display_name: string
  icon_class: string
  outbound_label: string
  base_url: string
}

export interface Tag {
  id: string
  name: string
  slug: string
  description: string | null
  color: string
}

export interface PublishedContentView extends ContentItem {
  platform_display_name: string
  platform_icon_class: string
  platform_outbound_label: string
  tags: Tag[]
}

// Helper function to fetch published content
export async function getPublishedContent(options?: {
  type?: 'article' | 'video'
  featured?: boolean
  limit?: number
}) {
  let query = supabase
    .from('blog_content')
    .select('*')
    .eq('status', 'published')
    .order('publish_date', { ascending: false })

  if (options?.type) {
    query = query.eq('type', options.type)
  }

  if (options?.featured) {
    query = query.eq('is_featured', true)
  }

  if (options?.limit) {
    query = query.limit(options.limit)
  }

  const { data, error } = await query

  if (error) {
    console.error('Error fetching published content:', error)
    throw error
  }

  return data as PublishedContentView[]
}

// Helper function to track analytics
export async function trackContentAnalytics(
  contentId: string,
  eventType: 'view' | 'click' | 'share',
  metadata?: {
    ipAddr?: string
    userAgent?: string
    referrer?: string
    utmSource?: string
    utmMedium?: string
    utmCampaign?: string
  }
) {
  const { error } = await supabase.from('blog_analytics').insert({
    content_id: contentId,
    event_type: eventType,
    ip_addr: metadata?.ipAddr,
    user_agent: metadata?.userAgent,
    referrer: metadata?.referrer,
    utm_source: metadata?.utmSource,
    utm_medium: metadata?.utmMedium,
    utm_campaign: metadata?.utmCampaign,
  })

  if (error) {
    console.error('Error tracking analytics:', error)
    // Don't throw - analytics failures shouldn't break the app
  }
}

// Helper function to subscribe to newsletter
export async function subscribeToNewsletter(email: string, metadata?: {
  ipAddr?: string
  userAgent?: string
  source?: string
}) {
  const { data, error } = await supabase
    .from('newsletter_subscribers')
    .insert({
      email: email.toLowerCase().trim(),
      ip_addr: metadata?.ipAddr,
      user_agent: metadata?.userAgent,
      source: metadata?.source || 'blog_hub',
    })
    .select()
    .single()

  if (error) {
    // Check if error is due to duplicate email
    if (error.code === '23505') {
      throw new Error('This email is already subscribed.')
    }
    console.error('Error subscribing to newsletter:', error)
    throw error
  }

  return data
}

// Helper function to get content performance stats
export async function getContentPerformance() {
  const { data, error } = await supabase
    .from('content_performance')
    .select('*')
    .order('publish_date', { ascending: false })

  if (error) {
    console.error('Error fetching content performance:', error)
    throw error
  }

  return data
}

