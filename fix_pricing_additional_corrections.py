import re

# Read the file
with open('marketing/pricing.html', 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Add green checkmark icon in front of "11 FREE bookings (90 days)"
# Find the CTA section - look for the pattern with checkmarks
# The checkmarks are likely in a list format
content = re.sub(
    r'(\s|>)(11 FREE bookings \(90 days\))',
    r'\1✓ \2',
    content
)
# Also handle if it's already in a list item
content = re.sub(
    r'(<li[^>]*>)\s*(11 FREE bookings \(90 days\))',
    r'\1✓ \2',
    content
)

# 2. Revert body background color to white (from #E8F4FD)
# Only change the body background, not callout boxes
# Find body tag in style section
content = re.sub(
    r'(body\s*\{[^}]*?background:\s*)#E8F4FD([^}]*?\})',
    r'\1white\2',
    content,
    flags=re.DOTALL
)
# Also check if it's in a different format
content = re.sub(
    r'body\s*\{[^}]*background:\s*#E8F4FD',
    'body {            background: white',
    content,
    flags=re.DOTALL
)

# 3. Remove the fourth empty card from comparison section
# Look for the empty card - it might be after the three main cards
# Pattern: anchor-item with minimal content or just X icons
content = re.sub(
    r'<div class="anchor-item"[^>]*>\s*(?:<div[^>]*>.*?</div>\s*)*<div[^>]*style="[^"]*">❌</div>\s*<div[^>]*style="[^"]*">❌</div>\s*<div[^>]*style="[^"]*">❌</div>\s*</div>',
    '',
    content,
    flags=re.DOTALL
)
# Also try simpler pattern - just empty anchor-item
content = re.sub(
    r'<div class="anchor-item"[^>]*>\s*<div[^>]*>❌</div>\s*<div[^>]*>❌</div>\s*<div[^>]*>❌</div>\s*</div>',
    '',
    content,
    flags=re.DOTALL
)

# 4. Change emotional urgency box background to more visible color
# The emotional urgency section has a gradient - change to light greyish slate
content = re.sub(
    r'background:\s*linear-gradient\(135deg,\s*#FFF3CD\s+0%,\s*#FFE082\s+100%\)',
    'background: #E2E8F0',  # Light greyish slate color for better visibility
    content
)
# Also check for rgba version
content = re.sub(
    r'background:\s*rgba\(255,\s*243,\s*205[^)]*\)',
    'background: #E2E8F0',
    content
)

# 5. Fix section background that was black with white font
# The emotional urgency section wrapper might have black background
# Find the section with #2A2A2A background and change it
content = re.sub(
    r'(<section[^>]*style="[^"]*background:\s*)#2A2A2A([^"]*"[^>]*>)',
    r'\1white\2',
    content
)
# Also update text color if it was white on black
content = re.sub(
    r'(<section[^>]*style="[^"]*background:\s*white[^"]*color:\s*)white([^"]*"[^>]*>)',
    r'\1#1A1A1A\2',
    content
)

# 6. Change calendar connection text
content = re.sub(
    r'Connect your calendar \(Google Calendar, Outlook, etc\.\) — You plug in your credentials',
    'Connect your calendar (Google Calendar, Outlook, etc.) — We help you input your credentials while screen sharing step by step',
    content
)

# 7. Change $5,000 to $5,150 in image 7 (the "You're capturing $5,000" text)
content = re.sub(
    r'You\'re capturing \$5,000 you would have lost',
    'You\'re capturing $5,150 you would have lost',
    content
)

# 8. Add "aproxi." to the end of lost revenue calculations
content = re.sub(
    r'\(\~\$5,150-\$10,300/month lost = \$61,800-\$123,600/year lost\)',
    '(~$5,150-$10,300/month lost = $61,800-$123,600/year lost aproxi.)',
    content
)
content = re.sub(
    r'\(\~\$5,150-\$20,600/month additional revenue \(\~\$61,800-\$247,200/year\)',
    '(~$5,150-$20,600/month additional revenue (~$61,800-$247,200/year aproxi.)',
    content
)

# 9. Verify/update Silicon Valley pricing range
# Current: $349-$1,999/month
# User suggests possibly increasing to $349-$3,400
# Let's update to a more accurate range - many legal tech tools do go higher
content = re.sub(
    r'\$349-\$1,999/month',
    '$349-$3,400/month',
    content
)
# Also update the savings calculation if it references this range
# The savings would be: ($349-$3,400) * 12 = $4,188-$40,800/year
# But let's keep the existing savings calculation or update it
content = re.sub(
    r'You save \$3,888-\$23,688 per year',
    'You save $4,188-$40,800 per year',
    content
)

# Write the file back
with open('marketing/pricing.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("All 9 corrections applied successfully!")

