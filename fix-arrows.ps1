# Fix malformed arrows in blog index
$file = "c:\Users\Mouhsine\Documents\GitHub\fastrank-html\blog\index.html"
$content = Get-Content $file -Raw -Encoding UTF8
$content = $content.Replace("â†'", "→")
$content | Set-Content $file -Encoding UTF8 -NoNewline
Write-Host "Fixed all arrows in blog/index.html" -ForegroundColor Green
