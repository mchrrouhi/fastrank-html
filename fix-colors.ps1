# Fix blog colors - change all Read article links to purple
$file = 'c:\Users\Mouhsine\Documents\GitHub\fastrank-html\blog\index.html'
$content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

# Change blue to purple (WordPress section)
$content = $content.Replace('text-blue-300 group-hover:text-blue-200 transition">Read article', 'text-purple-300 group-hover:text-purple-200 transition">Read article')

# Change green to purple (Core Web Vitals section)
$content = $content.Replace('text-green-300 group-hover:text-green-200 transition">Read article', 'text-purple-300 group-hover:text-purple-200 transition">Read article')

# Save
[System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)

Write-Host "✅ Changed all Read article links to purple!" -ForegroundColor Green
