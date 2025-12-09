#!/usr/bin/env python3
# -*- coding: utf-8 -*-

file_path = r"c:\Users\Mouhsine\Documents\GitHub\fastrank-html\blog\index.html"

# Read file with UTF-8 encoding
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Replace malformed arrow with correct one
content = content.replace('â†'', '→')

# Write back
with open(file_path, 'w', encoding='utf-8', newline='') as f:
    f.write(content)

print("✅ Fixed all arrows in blog/index.html")
