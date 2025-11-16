/**
 * API Route: Fetch Published Blog Content
 * GET /api/blog/content
 * 
 * Query Parameters:
 * - type: 'article' | 'video' (optional)
 * - featured: 'true' | 'false' (optional)
 * - limit: number (optional)
 */

import type { NextApiRequest, NextApiResponse } from 'next'
import { getPublishedContent } from '../../../lib/supabaseClient'

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  // Only allow GET requests
  if (req.method !== 'GET') {
    return res.status(405).json({ error: 'Method not allowed' })
  }

  try {
    const { type, featured, limit } = req.query

    // Validate and parse query parameters
    const options: {
      type?: 'article' | 'video'
      featured?: boolean
      limit?: number
    } = {}

    if (type && (type === 'article' || type === 'video')) {
      options.type = type
    }

    if (featured === 'true') {
      options.featured = true
    }

    if (limit && typeof limit === 'string') {
      const parsedLimit = parseInt(limit, 10)
      if (!isNaN(parsedLimit) && parsedLimit > 0) {
        options.limit = parsedLimit
      }
    }

    // Fetch content from Supabase
    const content = await getPublishedContent(options)

    // Set cache headers (cache for 5 minutes)
    res.setHeader(
      'Cache-Control',
      'public, s-maxage=300, stale-while-revalidate=600'
    )

    return res.status(200).json({
      success: true,
      count: content.length,
      data: content,
    })
  } catch (error) {
    console.error('Error fetching blog content:', error)
    return res.status(500).json({
      success: false,
      error: 'Failed to fetch blog content',
    })
  }
}

