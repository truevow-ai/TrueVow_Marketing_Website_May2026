# CRITICAL RULE: Component Modification Protection

## The Problem
The AI agent has repeatedly broken finalized components (footer, navigation, etc.) by replacing them with simplified or "improved" versions without checking the original component files first.

## The Rule (MANDATORY)

**NEVER modify, replace, or embed ANY component (footer, navigation, etc.) without:**

1. **ALWAYS read the original component file first**
   - Check `components/STANDARD_FOOTER.html`
   - Check `components/STANDARD_NAVIGATION.html`
   - Check any other component files in `components/` directory

2. **ALWAYS use the EXACT content from the component file**
   - NEVER create simplified or "improved" versions
   - NEVER assume a component needs changes
   - Copy the ENTIRE content exactly as it appears

3. **ALWAYS check if the component was finalized**
   - Look for "finalized", "complete", or "done" in previous conversations
   - If a component was finalized, it's correct as-is

4. **When embedding a component:**
   - Copy the ENTIRE content exactly from the component file
   - Only adjust paths if necessary (e.g., `/assets/logo.svg` → `../assets/logo.svg` for relative paths)
   - Do NOT simplify, improve, or modify the structure

5. **If unsure, ASK the user before making changes**

## Examples of Violations

❌ **WRONG:** Replacing finalized footer with simplified version (removed 3-column navigation, legal disclaimer, etc.)
❌ **WRONG:** Creating "improved" navigation without checking original
❌ **WRONG:** Assuming a component needs simplification

✅ **CORRECT:** Reading `components/STANDARD_FOOTER.html` first, then copying exact content
✅ **CORRECT:** Only adjusting paths for relative/absolute differences
✅ **CORRECT:** Asking user if component needs changes before modifying

## Why This Rule Exists

This rule was created after the AI agent broke the finalized footer component by replacing it with a stripped-down version, removing:
- 3-column navigation structure
- Full legal disclaimer text
- "Bar Compliance" link
- Correct copyright year (2026)
- Proper tagline

This caused significant frustration and wasted time for the user.

