/**
 * Admin Component: Add Blog Content Form
 * Used for adding new articles/videos to the blog hub
 */

'use client'

import { useState } from 'react'
import { supabase } from '@/lib/supabaseClient'

interface AddContentFormProps {
  onSuccess?: () => void
  onCancel?: () => void
}

export default function AddContentForm({ onSuccess, onCancel }: AddContentFormProps) {
  const [formData, setFormData] = useState({
    title: '',
    teaser: '',
    canonicalUrl: '',
    publishDate: new Date().toISOString().split('T')[0],
    thumbnailUrl: '',
    type: 'article' as 'article' | 'video',
    platformName: 'linkedin' as 'linkedin' | 'youtube',
    readTimeMinutes: '',
    watchTimeMinutes: '',
    isFeatured: false,
    status: 'draft' as 'draft' | 'published' | 'archived',
  })

  const [isSubmitting, setIsSubmitting] = useState(false)
  const [submitMessage, setSubmitMessage] = useState<{ type: 'success' | 'error'; text: string } | null>(null)

  const validateForm = () => {
    if (!formData.title.trim()) {
      setSubmitMessage({ type: 'error', text: 'Title is required' })
      return false
    }
    if (!formData.teaser.trim()) {
      setSubmitMessage({ type: 'error', text: 'Teaser is required' })
      return false
    }
    if (!formData.canonicalUrl.trim()) {
      setSubmitMessage({ type: 'error', text: 'Canonical URL is required' })
      return false
    }
    if (!formData.publishDate) {
      setSubmitMessage({ type: 'error', text: 'Publish date is required' })
      return false
    }
    if (formData.type === 'article' && !formData.readTimeMinutes) {
      setSubmitMessage({ type: 'error', text: 'Read time is required for articles' })
      return false
    }
    if (formData.type === 'video' && !formData.watchTimeMinutes) {
      setSubmitMessage({ type: 'error', text: 'Watch time is required for videos' })
      return false
    }
    return true
  }

  // Handle form submission
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    
    if (!validateForm()) {
      return
    }

    setIsSubmitting(true)
    setSubmitMessage(null)

    try {
      // Add UTM parameters if not already present
      let canonicalUrl = formData.canonicalUrl
      if (!canonicalUrl.includes('utm_source')) {
        const separator = canonicalUrl.includes('?') ? '&' : '?'
        canonicalUrl += `${separator}utm_source=truevow_blog`
      }

      // Prepare data for insertion
      const insertData = {
        title: formData.title.trim(),
        teaser: formData.teaser.trim(),
        canonical_url: canonicalUrl,
        publish_date: formData.publishDate,
        thumbnail_url: formData.thumbnailUrl.trim() || null,
        type: formData.type,
        platform_name: formData.platformName,
        read_time_minutes: formData.type === 'article' ? parseInt(formData.readTimeMinutes) : null,
        watch_time_minutes: formData.type === 'video' ? parseInt(formData.watchTimeMinutes) : null,
        is_featured: formData.isFeatured,
        status: formData.status,
      }

      const { data, error } = await supabase
        .from('web_blog_content')
        .insert(insertData)
        .select()
        .single()

      if (error) {
        throw error
      }

      setSubmitMessage({
        type: 'success',
        text: `Content "${formData.title}" added successfully! ${formData.status === 'published' ? 'It will appear on the blog shortly.' : 'Saved as draft.'}`,
      })

      // Reset form
      setFormData({
        title: '',
        teaser: '',
        canonicalUrl: '',
        publishDate: new Date().toISOString().split('T')[0],
        thumbnailUrl: '',
        type: 'article',
        platformName: 'linkedin',
        readTimeMinutes: '',
        watchTimeMinutes: '',
        isFeatured: false,
        status: 'draft',
      })

      // Call success callback
      if (onSuccess) {
        setTimeout(() => {
          onSuccess()
        }, 2000)
      }
    } catch (error: any) {
      console.error('Error adding content:', error)
      setSubmitMessage({
        type: 'error',
        text: error.message || 'Failed to add content. Please try again.',
      })
    } finally {
      setIsSubmitting(false)
    }
  }

  return (
    <div className="max-w-2xl mx-auto p-6 bg-white rounded-lg shadow-lg">
      <h2 className="text-2xl font-bold mb-6">Add Blog Content</h2>

      <form onSubmit={handleSubmit} className="space-y-6">
        {/* Title */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Title <span className="text-red-500">*</span>
          </label>
          <input
            type="text"
            value={formData.title}
            onChange={(e) => setFormData({ ...formData, title: e.target.value })}
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            placeholder="Article or video title (max 70 chars)"
            maxLength={70}
            required
          />
        </div>

        {/* Teaser */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Teaser <span className="text-red-500">*</span>
          </label>
          <textarea
            value={formData.teaser}
            onChange={(e) => setFormData({ ...formData, teaser: e.target.value })}
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            placeholder="Short description (max 160 chars)"
            rows={3}
            maxLength={160}
            required
          />
        </div>

        {/* Canonical URL */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Canonical URL <span className="text-red-500">*</span>
          </label>
          <input
            type="url"
            value={formData.canonicalUrl}
            onChange={(e) => setFormData({ ...formData, canonicalUrl: e.target.value })}
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            placeholder="https://linkedin.com/pulse/... or https://youtu.be/..."
            required
          />
          <p className="text-xs text-gray-500 mt-1">UTM parameter will be added automatically</p>
        </div>

        {/* Type and Platform */}
        <div className="grid grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Type <span className="text-red-500">*</span>
            </label>
            <select
              value={formData.type}
              onChange={(e) => setFormData({ ...formData, type: e.target.value as 'article' | 'video' })}
              className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              required
            >
              <option value="article">Article (LinkedIn)</option>
              <option value="video">Video (YouTube)</option>
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Platform <span className="text-red-500">*</span>
            </label>
            <select
              value={formData.platformName}
              onChange={(e) => setFormData({ ...formData, platformName: e.target.value as 'linkedin' | 'youtube' })}
              className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              required
            >
              <option value="linkedin">LinkedIn</option>
              <option value="youtube">YouTube</option>
            </select>
          </div>
        </div>

        {/* Read/Watch Time */}
        {formData.type === 'article' ? (
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Read Time (minutes) <span className="text-red-500">*</span>
            </label>
            <input
              type="number"
              value={formData.readTimeMinutes}
              onChange={(e) => setFormData({ ...formData, readTimeMinutes: e.target.value })}
              className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              min="1"
              required
            />
          </div>
        ) : (
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Watch Time (minutes) <span className="text-red-500">*</span>
            </label>
            <input
              type="number"
              value={formData.watchTimeMinutes}
              onChange={(e) => setFormData({ ...formData, watchTimeMinutes: e.target.value })}
              className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              min="1"
              required
            />
          </div>
        )}

        {/* Publish Date */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Publish Date <span className="text-red-500">*</span>
          </label>
          <input
            type="date"
            value={formData.publishDate}
            onChange={(e) => setFormData({ ...formData, publishDate: e.target.value })}
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            required
          />
        </div>

        {/* Thumbnail URL (optional) */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Thumbnail URL (optional)
          </label>
          <input
            type="url"
            value={formData.thumbnailUrl}
            onChange={(e) => setFormData({ ...formData, thumbnailUrl: e.target.value })}
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            placeholder="https://..."
          />
        </div>

        {/* Status and Featured */}
        <div className="grid grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Status <span className="text-red-500">*</span>
            </label>
            <select
              value={formData.status}
              onChange={(e) => setFormData({ ...formData, status: e.target.value as 'draft' | 'published' | 'archived' })}
              className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              required
            >
              <option value="draft">Draft</option>
              <option value="published">Published</option>
              <option value="archived">Archived</option>
            </select>
          </div>

          <div className="flex items-center">
            <input
              type="checkbox"
              id="isFeatured"
              checked={formData.isFeatured}
              onChange={(e) => setFormData({ ...formData, isFeatured: e.target.checked })}
              className="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
            />
            <label htmlFor="isFeatured" className="ml-2 block text-sm text-gray-700">
              Featured Content
            </label>
          </div>
        </div>

        {/* Submit Message */}
        {submitMessage && (
          <div
            className={`p-4 rounded-md ${
              submitMessage.type === 'success'
                ? 'bg-green-50 text-green-800 border border-green-200'
                : 'bg-red-50 text-red-800 border border-red-200'
            }`}
          >
            {submitMessage.text}
          </div>
        )}

        {/* Action Buttons */}
        <div className="flex gap-4">
          <button
            type="submit"
            disabled={isSubmitting}
            className="flex-1 bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {isSubmitting ? 'Adding...' : 'Add Content'}
          </button>
          {onCancel && (
            <button
              type="button"
              onClick={onCancel}
              className="px-4 py-2 border border-gray-300 rounded-md text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-gray-500"
            >
              Cancel
            </button>
          )}
        </div>
      </form>
    </div>
  )
}

