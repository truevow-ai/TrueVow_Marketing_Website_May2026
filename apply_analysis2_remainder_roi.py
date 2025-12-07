"""
Apply Tier 1 Remainder from Analysis 2 (All 42 Gurus)
to marketing/profitability.html

Remainder from Analysis 2 Tier 1:
- Customer-Focused Language Throughout (Jeffrey Gitomer)
  - "You stop losing" not "TrueVow saves you"
  - "You capture" not "TrueVow captures"
"""

import re

def apply_customer_focused_language():
    file_path = 'marketing/profitability.html'
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    original_content = content
    
    print("Applying Customer-Focused Language...")
    
    # Pattern 1: "TrueVow saves you" -> "You stop losing"
    content = re.sub(
        r'TrueVow\s+saves\s+you',
        r'You stop losing',
        content,
        flags=re.IGNORECASE
    )
    
    # Pattern 2: "TrueVow saves" -> "You stop losing"
    content = re.sub(
        r'TrueVow\s+saves\s+(\$[0-9,]+)',
        r'You stop losing \1',
        content,
        flags=re.IGNORECASE
    )
    
    # Pattern 3: "TrueVow captures" -> "You capture"
    content = re.sub(
        r'TrueVow\s+captures',
        r'You capture',
        content,
        flags=re.IGNORECASE
    )
    
    # Pattern 4: "TrueVow helps" -> "You" (when appropriate)
    # Be careful with this one - only change when it makes sense
    content = re.sub(
        r'TrueVow\s+helps\s+you\s+([a-z]+)',
        lambda m: f'You {m.group(1)}',
        content,
        flags=re.IGNORECASE
    )
    
    # Pattern 5: "TrueVow answers" -> "You never miss a call" (when in context of answering)
    # This is more contextual, so we'll be selective
    
    # Pattern 6: "TrueVow stops" -> "You stop" (when it's about stopping losses)
    content = re.sub(
        r'TrueVow\s+stops\s+the\s+silent\s+bleed',
        r'You stop the silent bleed',
        content,
        flags=re.IGNORECASE
    )
    
    # Pattern 7: "TrueVow turns" -> Keep as is (this is about transformation, not customer action)
    # Actually, let's change: "TrueVow turns intake into" -> "You turn intake into"
    content = re.sub(
        r'TrueVow\s+turns\s+intake\s+into',
        r'You turn intake into',
        content,
        flags=re.IGNORECASE
    )
    
    # Pattern 8: "TrueVow handles" -> "You handle" (when it's about the customer's benefit)
    # Actually, be careful - "TrueVow handles" is fine when it's about the service
    # Let's focus on outcome language: "TrueVow handles" -> "You get" when appropriate
    
    # Pattern 9: "TrueVow charges" -> Keep as is (this is factual)
    
    # Pattern 10: "TrueVow is" -> Keep as is (this is descriptive)
    
    # Pattern 11: "with TrueVow" -> Keep as is (this is fine)
    
    # Pattern 12: "TrueVow's" -> Keep as is (possessive is fine)
    
    # More specific patterns for common phrases:
    
    # "TrueVow answers calls" -> "You never miss a call"
    content = re.sub(
        r'TrueVow\s+answers\s+calls',
        r'You never miss a call',
        content,
        flags=re.IGNORECASE
    )
    
    # "TrueVow qualifies" -> "You qualify" (when it's about the customer's benefit)
    # Actually, be careful - "TrueVow qualifies leads" is about the service
    # Let's change: "TrueVow qualifies them" -> "You qualify them" when in context of customer action
    
    # Write the updated content
    if content != original_content:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"\n✅ Successfully applied Customer-Focused Language from Analysis 2")
        print(f"   - Changed 'TrueVow saves' to 'You stop losing'")
        print(f"   - Changed 'TrueVow captures' to 'You capture'")
        print(f"   - Changed 'TrueVow answers' to 'You never miss a call'")
        print(f"   - Changed 'TrueVow turns' to 'You turn' (where appropriate)")
    else:
        print("\n⚠️  No changes were made. Content may already be updated or patterns not found.")

if __name__ == '__main__':
    apply_customer_focused_language()

