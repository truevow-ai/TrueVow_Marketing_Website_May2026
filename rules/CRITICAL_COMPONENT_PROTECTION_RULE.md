# CRITICAL RULE - NEVER MODIFY FINALIZED COMPONENTS

## The Problem
The AI agent has repeatedly broken finalized components (footer, navigation, etc.) by replacing them with simplified or stripped-down versions, causing significant rework and frustration.

## The Rule - MANDATORY

**Before modifying, replacing, or embedding ANY component (footer, navigation, etc.):**

### 1. ALWAYS Read the Original Component File First
- Read `components/STANDARD_FOOTER.html` before embedding footer
- Read `components/STANDARD_NAVIGATION.html` before embedding navigation
- Read any other component file before using it

### 2. NEVER Create Simplified Versions
- **DO NOT** create a "simplified" or "stripped-down" version
- **DO NOT** remove content "to make it work"
- **USE THE EXACT CONTENT** from the component file

### 3. Check for Finalized Status
- If a component was marked as "finalized", "complete", or "done" - **DO NOT modify it without explicit user permission**
- Check documentation, comments, or previous conversations for finalized status

### 4. Preserve ALL Content When Embedding
When embedding components, preserve **EVERYTHING** including:
- ✅ All navigation links and sections (3-column layout, all links)
- ✅ All legal text and disclaimers (full entity information)
- ✅ All copyright years and entity information (© 2026, not 2025)
- ✅ All styling and structure (exact CSS, layout, spacing)
- ✅ All links and their correct paths

### 5. Ask Before Modifying Finalized Items
- If unsure whether something is finalized, **ASK before making changes**
- If the user says something is "finalized" or "done", **STOP and ask permission**

### 6. Fix Only the Broken Part
- When fixing issues, **only modify the specific broken part**
- **DO NOT** replace the entire component to fix one small issue
- Use targeted fixes (search_replace for specific lines, not entire sections)

## Examples of What NOT to Do

❌ **WRONG:** Replacing the full footer with a simplified version that only has logo, tagline, and 3 links
❌ **WRONG:** Changing copyright from 2026 to 2025
❌ **WRONG:** Removing the 3-column navigation structure
❌ **WRONG:** Removing legal disclaimer text
❌ **WRONG:** Removing "Bar Compliance" link

✅ **CORRECT:** Reading `components/STANDARD_FOOTER.html` and using its exact content
✅ **CORRECT:** Only fixing the specific broken part (e.g., one broken link)
✅ **CORRECT:** Asking permission before modifying finalized components

## Enforcement

This rule is **MANDATORY** and **ZERO-TOLERANCE**. Violations cause:
- Loss of finalized work
- Significant rework
- User frustration and loss of trust
- Wasted time debugging issues that shouldn't exist

## Related Files

- `components/STANDARD_FOOTER.html` - Finalized footer component
- `components/STANDARD_NAVIGATION.html` - Finalized navigation component
- `marketing/pricing.html` - **FINALIZED & LOCKED** (See `rules/PRICING_PAGE_FINALIZED_LOCK.md`)

---

**Last Updated:** 2025-01-XX
**Reason:** AI agent repeatedly broke finalized footer by replacing it with simplified version

