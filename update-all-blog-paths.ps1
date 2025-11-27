$articles = @(
    "blog\shopify-speed-optimization-guide-2025\index.html",
    "blog\shopify-core-web-vitals-why-your-store-is-slowing-down-and-how-to-fix-it\index.html",
    "blog\before-after-shopify-speed-optimization-case-study\index.html",
    "blog\best-shopify-apps-that-slow-down-your-store-2025-analysis\index.html",
    "blog\how-to-fix-slow-shopify-store-full-checklist\index.html",
    "blog\fix-slow-wordpress-website-10-real-causes-and-fixes\index.html",
    "blog\how-to-optimize-wordpress-core-web-vitals-real-client-example\index.html",
    "blog\wordpress-speed-optimization-services-what-you-should-expect\index.html",
    "blog\how-speed-audits-improve-seo-rankings-technical-breakdown\index.html",
    "blog\why-website-speed-matters-for-seo-and-ads-performance\index.html",
    "blog\inp-lcp-cls-explained-simply-with-examples\index.html"
)

foreach ($article in $articles) {
    $filePath = "c:\Users\Mouhsine\Documents\GitHub\fastrank-html\$article"
    
    if (Test-Path $filePath) {
        Write-Host "Processing: $article" -ForegroundColor Cyan
        
        $content = Get-Content $filePath -Raw -Encoding UTF8
        
        $content = $content -replace 'href="/style\.css"', 'href="../../style.css"'
        $content = $content -replace 'src="/images/logo\.svg"', 'src="../../images/logo.svg"'
        $content = $content -replace 'src="/images/fastrank-logo\.svg"', 'src="../../images/fastrank-logo.svg"'
        $content = $content -replace 'href="/about\.html"', 'href="../../about.html"'
        $content = $content -replace 'href="/index\.html#pricing"', 'href="../../index.html#pricing"'
        $content = $content -replace 'href="/get-report\.html"', 'href="../../get-report.html"'
        $content = $content -replace 'href="/refund-policy\.html"', 'href="../../refund-policy.html"'
        $content = $content -replace 'href="/terms-of-service\.html"', 'href="../../terms-of-service.html"'
        $content = $content -replace 'href="/privacy-policy\.html"', 'href="../../privacy-policy.html"'
        $content = $content -replace 'src="/js/vendors/alpinejs\.min\.js"', 'src="../../js/vendors/alpinejs.min.js"'
        $content = $content -replace 'src="/js/main\.js"', 'src="../../js/main.js"'
        $content = $content -replace 'src="/blog/images/', 'src="../images/'
        $content = $content -replace 'srcset="/blog/images/', 'srcset="../images/'
        
        Set-Content -Path $filePath -Value $content -Encoding UTF8 -NoNewline
        
        Write-Host "Done: $article" -ForegroundColor Green
    } else {
        Write-Host "Not found: $article" -ForegroundColor Red
    }
}

Write-Host "All done!" -ForegroundColor Yellow
