/**
 * API Route: Track Content Analytics
 * POST /api/blog/track
 * 
 * Body:
 * {
 *   contentId: string
 *   eventType: 'view' | 'click' | 'share'
 *   referrer?: string
 *   utmSource?: string
 *   utmMedium?: string
 *   utmCampaign?: string
 * }
 */

import type { NextApiRequest, NextApiResponse } from 'next'
import { trackContentAnalytics } from '../../../lib/supabaseClient'

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  // Only allow POST requests
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' })
  }

  try {
    const { contentId, eventType, referrer, utmSource, utmMedium, utmCampaign } = req.body

    // Validate required fields
    if (!contentId || !eventType) {
      return res.status(400).json({
        success: false,
        error: 'Missing required fields: contentId, eventType',
      })
    }

    // Validate event type
    if (!['view', 'click', 'share'].includes(eventType)) {
      return res.status(400).json({
        success: false,
        error: 'Invalid eventType. Must be: view, click, or share',
      })
    }

    // Extract IP address and user agent from request
    const ipAddr = (req.headers['x-forwarded-for'] as string)?.split(',')[0]?.trim() ||
                   (req.headers['x-real-ip'] as string) ||
                   req.socket.remoteAddress
    
    const userAgent = req.headers['user-agent']

    // Track analytics
    await trackContentAnalytics(contentId, eventType, {
      ipAddr,
      userAgent,
      referrer,
      utmSource,
      utmMedium,
      utmCampaign,
    })

    return res.status(200).json({
      success: true,
      message: 'Analytics tracked successfully',
    })
  } catch (error) {
    console.error('Error tracking analytics:', error)
    return res.status(500).json({
      success: false,
      error: 'Failed to track analytics',
    })
  }
}

