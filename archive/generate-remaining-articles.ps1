# PowerShell script to generate remaining 6 blog articles
# Article metadata
$articles = @(
    @{
        slug = "shopify-speed-optimization-guide-2025"
        title = "Shopify Speed Optimization Guide 2025"
        desc = "Complete guide to optimizing Shopify store speed in 2025. Learn proven techniques to improve Core Web Vitals, reduce load times, and increase conversions."
        date = "2025-01-15"
        dateDisplay = "January 15, 2025"
        read = "14"
        silo = "Shopify Speed & Core Web Vitals"
        badgeColor = "purple"
        ctaTitle = "Need Shopify Speed Optimization?"
        ctaDesc = "We optimize Shopify stores with proven techniques that improve Core Web Vitals and conversion rates by 15-30%. Get expert help today."
        ctaPlatform = "Shopify"
    },
    @{
        slug = "how-speed-audits-improve-seo-rankings-technical-breakdown"
        title = "How Speed Audits Improve SEO Rankings: Technical Breakdown"
        desc = "Learn how speed audits identify technical SEO issues and improve rankings. Detailed breakdown of Core Web Vitals impact on search visibility."
        date = "2025-05-28"
        dateDisplay = "May 28, 2025"
        read = "10"
        silo = "Performance & SEO"
        badgeColor = "green"
        ctaTitle = "Want Better SEO Through Speed?"
        ctaDesc = "Our performance audits identify technical SEO issues and optimize your site for better rankings and user experience."
        ctaPlatform = "Speed"
    },
    @{
        slug = "how-to-optimize-wordpress-core-web-vitals-real-client-example"
        title = "How to Optimize WordPress Core Web Vitals: Real Client Example"
        desc = "Real client case study: how we improved WordPress Core Web Vitals from failing to passing. Step-by-step breakdown of optimization techniques."
        date = "2025-04-22"
        dateDisplay = "April 22, 2025"
        read = "15"
        silo = "WordPress Speed & Core Web Vitals"
        badgeColor = "blue"
        ctaTitle = "Failing WordPress Core Web Vitals?"
        ctaDesc = "We optimize WordPress sites to pass Core Web Vitals assessments and improve conversion rates by 15-30%. Get a comprehensive audit."
        ctaPlatform = "WordPress"
    },
    @{
        slug = "wordpress-speed-optimization-services-what-you-should-expect"
        title = "WordPress Speed Optimization Services: What You Should Expect"
        desc = "What to expect from professional WordPress speed optimization services. Learn about techniques, timelines, and realistic performance improvements."
        date = "2025-05-18"
        dateDisplay = "May 18, 2025"
        read = "11"
        silo = "WordPress Speed & Core Web Vitals"
        badgeColor = "blue"
        ctaTitle = "Ready for Professional Optimization?"
        ctaDesc = "Fastrank delivers measurable WordPress speed improvements with safe, white-hat techniques. See what our service includes."
        ctaPlatform = "WordPress"
    },
    @{
        slug = "why-website-speed-matters-for-seo-and-ads-performance"
        title = "Why Website Speed Matters for SEO & Ads Performance"
        desc = "Discover how website speed directly impacts SEO rankings and ads performance. Learn why faster sites get better Quality Scores and conversions."
        date = "2025-05-20"
        dateDisplay = "May 20, 2025"
        read = "9"
        silo = "Performance & SEO"
        badgeColor = "green"
        ctaTitle = "Improve Speed for Better ROI"
        ctaDesc = "Faster sites mean better SEO rankings, lower ad costs, and higher conversions. Let us optimize your performance."
        ctaPlatform = "Speed"
    },
    @{
        slug = "wordpress-speed-optimization-guide-2025"
        title = "WordPress Speed Optimization Guide 2025"
        desc = "Comprehensive WordPress speed optimization guide for 2025. Proven techniques to improve Core Web Vitals, load times, and user experience."
        date = "2025-04-18"
        dateDisplay = "April 18, 2025"
        read = "16"
        silo = "WordPress Speed & Core Web Vitals"
        badgeColor = "blue"
        ctaTitle = "Need WordPress Speed Help?"
        ctaDesc = "We optimize WordPress sites with proven techniques that improve Core Web Vitals and conversion rates by 15-30%. Get expert help."
        ctaPlatform = "WordPress"
    }
)

# Common header and footer
$header = @'
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
<script async src="https://www.googletagmanager.com/gtag/js?id=G-EZ9KWQEM4F"></script>
<script>window.dataLayer=window.dataLayer||[];function gtag(){dataLayer.push(arguments);}gtag('js',new Date());gtag('config','G-EZ9KWQEM4F');</script>
<script id="Cookiebot" src="https://consent.cookiebot.com/uc.js" data-cbid="3a3581e5-019e-48bb-806f-24f31fbd1959" type="text/javascript" async></script>
<meta charset="utf-8">
'@

$footer = @'
<footer><div class="max-w-6xl mx-auto px-4 sm:px-6"><div class="grid grid-cols-1 md:grid-cols-4 gap-8 py-8 md:py-12 items-start"><div><a class="inline-flex" href="/" aria-label="Fastrank"><img src="/images/fastrank-logo.svg" alt="Fastrank logo" class="h-8 md:h-9 w-auto opacity-95 mb-4" /></a><div class="flex flex-col gap-2 text-slate-300 text-sm"><span class="font-semibold text-slate-100">Cadunlock LLC</span><span>131 Continental Dr, Suite 305</span><span>Newark, DE 19713, United States</span><span>Phone: +1 (302) 294-9394</span><a href="mailto:support@fastrank.io" class="hover:text-white transition">support@fastrank.io</a></div></div><div><h6 class="text-sm text-slate-50 font-medium mb-2">Products</h6><ul class="text-sm space-y-2"><li><a class="text-slate-400 hover:text-slate-200 transition" href="/">Services</a></li><li><a class="text-slate-400 hover:text-slate-200 transition" href="/get-report.html">Free Speed Report</a></li></ul></div><div><h6 class="text-sm text-slate-50 font-medium mb-2">Company</h6><ul class="text-sm space-y-2"><li><a class="text-slate-400 hover:text-slate-200 transition" href="/about.html">Our Expertise</a></li></ul></div><div><h6 class="text-sm text-slate-50 font-medium mb-2">Legals</h6><ul class="text-sm space-y-2"><li><a class="text-slate-400 hover:text-slate-200 transition" href="https://fastrank.io/guarantee/">Refund policy</a></li><li><a class="text-slate-400 hover:text-slate-200 transition" href="/terms-of-service.html">Terms of Service</a></li><li><a class="text-slate-400 hover:text-slate-200 transition" href="/privacy-policy.html">Privacy policy</a></li></ul></div></div><p class="mt-10 text-center text-xs text-slate-500">© 2025 Cadunlock LLC. All rights reserved.</p></div></footer>
</div>
<script src="/js/vendors/alpinejs.min.js" defer></script>
<script src="/js/main.js" defer></script>
<script>(function(){const t=document.querySelector('.blog-toc-toggle');const l=document.querySelector('.blog-toc-list');const i=document.querySelector('.blog-toc-icon');if(t&&l&&i){if(window.innerWidth<768){l.classList.add('hidden');i.style.transform='rotate(0deg)';}t.addEventListener('click',function(){if(window.innerWidth<768){const h=l.classList.contains('hidden');l.classList.toggle('hidden');t.setAttribute('aria-expanded',h?'true':'false');i.style.transform=h?'rotate(180deg)':'rotate(0deg)';}});}})();</script>
</body>
</html>
'@

Write-Host "Generating $($articles.Count) articles..." -ForegroundColor Cyan

foreach ($article in $articles) {
    $filePath = "c:\Users\Mouhsine\Documents\GitHub\fastrank-html\blog\$($article.slug)\index.html"
    
    Write-Host "`nGenerating: $($article.title)" -ForegroundColor Yellow
    
    # Build complete HTML (simplified version - you'll need to add full content)
    $html = $header
    $html += @"
<title>$($article.title) - Fastrank Blog</title>
<meta name="description" content="$($article.desc)">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="robots" content="index, follow">
<link rel="canonical" href="https://fastrank.io/blog/$($article.slug)/" />
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700;800&display=swap">
<meta property="og:type" content="article">
<meta property="og:title" content="$($article.title) - Fastrank Blog">
<meta property="og:description" content="$($article.desc)">
<meta property="og:url" content="https://fastrank.io/blog/$($article.slug)/">
<meta property="og:image" content="https://fastrank.io/blog/images/$($article.slug).png">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="$($article.title)">
<meta name="twitter:description" content="$($article.desc)">
<meta name="twitter:image" content="https://fastrank.io/blog/images/$($article.slug).png">
<link href="/style.css" rel="stylesheet">
<script type="text/javascript">window.`$crisp=[];window.CRISP_WEBSITE_ID="883b2d77-164f-457f-add0-22394a2a3bb2";(function(){d=document;s=d.createElement('script');s.src='https://client.crisp.chat/l.js';s.async=1;d.getElementsByTagName('head')[0].appendChild(s);})();</script>
<link rel="icon" type="image/x-icon" href="/favicon.ico">
<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
<link rel="manifest" href="/site.webmanifest">
<script type="application/ld+json">{"@context":"https://schema.org","@type":"Article","mainEntityOfPage":{"@type":"WebPage","@id":"https://fastrank.io/blog/$($article.slug)/"},"headline":"$($article.title)","description":"$($article.desc)","image":["https://fastrank.io/blog/images/$($article.slug).png"],"author":{"@type":"Organization","name":"Fastrank","url":"https://fastrank.io/"},"publisher":{"@type":"Organization","name":"Fastrank","logo":{"@type":"ImageObject","url":"https://fastrank.io/images/fastrank-logo.svg"}},"datePublished":"$($article.date)","dateModified":"$($article.date)"}</script>
</head>
<body class="font-inter antialiased bg-slate-900 text-slate-100 tracking-tight">
<div class="flex flex-col min-h-screen overflow-hidden supports-[overflow:clip]:overflow-clip">
<header class="absolute w-full z-30"><div class="max-w-6xl mx-auto px-4 sm:px-6"><div class="flex items-center justify-between h-16 md:h-20"><div class="flex-1"><a class="inline-flex" href="/" aria-label="Fastrank"><img src="/images/logo.svg" width="38" height="38" alt="Fastrank"></a></div><nav class="hidden md:flex md:grow"><ul class="flex grow justify-center flex-wrap items-center"><li><a class="font-medium text-sm text-slate-300 hover:text-white mx-4 lg:mx-5 transition" href="/about.html">About</a></li><li><a class="font-medium text-sm text-slate-300 hover:text-white mx-4 lg:mx-5 transition" href="/index.html#pricing">Pricing</a></li><li><a class="font-medium text-sm text-white mx-4 lg:mx-5 transition" href="/blog/">Blog</a></li></ul></nav><ul class="flex-1 flex justify-end items-center"><li class="ml-6"><a class="btn-sm text-slate-300 hover:text-white transition w-full group [background:linear-gradient(var(--color-slate-900),var(--color-slate-900))_padding-box,conic-gradient(var(--color-slate-400),var(--color-slate-700)_25%,var(--color-slate-700)_75%,var(--color-slate-400)_100%)_border-box] relative before:absolute before:inset-0 before:bg-slate-800/30 before:rounded-full" href="/get-report.html"><span class="relative inline-flex items-center">Get Report <span class="text-purple-500 group-hover:translate-x-0.5 transition ml-1">-&gt;</span></span></a></li></ul><div class="md:hidden flex items-center ml-4" x-data="{ expanded: false }"><button class="group inline-flex w-8 h-8 text-slate-300 hover:text-white items-center justify-center transition" aria-controls="mobile-nav" :aria-expanded="expanded" @click.stop="expanded=!expanded"><span class="sr-only">Menu</span><svg class="w-4 h-4 fill-current" viewBox="0 0 16 16"><rect class="origin-center transition -translate-y-[5px] group-aria-expanded:rotate-[315deg] group-aria-expanded:translate-y-0" y="7" width="16" height="2" rx="1"></rect><rect class="origin-center group-aria-expanded:rotate-45 transition" y="7" width="16" height="2" rx="1"></rect><rect class="origin-center transition translate-y-[5px] group-aria-expanded:rotate-[135deg] group-aria-expanded:translate-y-0" y="7" width="16" height="2" rx="1"></rect></svg></button><nav id="mobile-nav" class="absolute top-full z-20 left-0 w-full px-4 sm:px-6 overflow-hidden transition-all duration-300 ease-in-out" x-ref="mobileNav" :style="expanded?'max-height: '+`$refs.mobileNav.scrollHeight+'px; opacity: 1':'max-height: 0; opacity: .8'" @click.outside="expanded=false" @keydown.escape.window="expanded=false" x-cloak><ul class="border border-transparent [background:linear-gradient(var(--color-slate-900),var(--color-slate-900))_padding-box,conic-gradient(var(--color-slate-400),var(--color-slate-700)_25%,var(--color-slate-700)_75%,var(--color-slate-400)_100%)_border-box] rounded-lg px-4 py-1.5"><li><a class="flex font-medium text-sm text-slate-300 hover:text-white py-1.5" href="/about.html">About</a></li><li><a class="flex font-medium text-sm text-slate-300 hover:text-white py-1.5" href="/index.html#pricing">Pricing</a></li><li><a class="flex font-medium text-sm text-white py-1.5" href="/blog/">Blog</a></li></ul></nav></div></div></div></header>
<main class="grow"><section class="relative"><div class="absolute inset-0 -z-10 h-[420px] bg-gradient-to-b from-slate-950 via-slate-900 to-slate-950 opacity-90"></div><div class="max-w-4xl mx-auto px-4 sm:px-6"><div class="pt-32 pb-20 md:pt-40 md:pb-32"><div class="mb-6"><a href="/blog/" class="inline-flex items-center text-sm text-slate-400 hover:text-slate-200 transition">← Back to blog</a></div><article class="max-w-3xl mx-auto blog-post-article" itemscope itemtype="https://schema.org/Article"><div class="flex flex-wrap items-center justify-between gap-3 mb-4 text-xs text-slate-400"><div class="inline-flex items-center gap-2"><span class="inline-flex items-center rounded-full border border-$($article.badgeColor)-500/60 bg-$($article.badgeColor)-500/10 px-3 py-1 text-[11px] font-medium uppercase tracking-wide text-$($article.badgeColor)-300"><span class="w-1.5 h-1.5 rounded-full bg-$($article.badgeColor)-400 mr-1"></span>$($article.silo)</span><span aria-hidden="true">•</span><span itemprop="datePublished" content="$($article.date)">$($article.dateDisplay)</span></div><div class="text-slate-400"><span>$($article.read) min read</span></div></div><header class="mb-10"><h1 itemprop="headline" class="mt-2 text-2xl sm:text-3xl md:text-4xl lg:text-[2.6rem] leading-snug md:leading-tight font-extrabold tracking-tight text-slate-100 mb-4">$($article.title)</h1><p class="text-base md:text-lg text-slate-300 max-w-2xl" itemprop="description">$($article.desc)</p></header><figure class="mb-10 rounded-3xl overflow-hidden border border-slate-800 bg-slate-900/60 blog-hero"><img src="/blog/images/$($article.slug).png" alt="$($article.title)" class="w-full h-auto" loading="eager" itemprop="image" width="1200" height="675"><figcaption class="px-6 py-3 text-xs text-slate-400 border-t border-slate-800">$($article.title)</figcaption></figure>
<div class="prose prose-lg prose-invert max-w-none text-slate-100" itemprop="articleBody">
<p><strong>Article content placeholder:</strong> Full migrated content from original HTML will be inserted here, preserving key sections, headings, and information while optimizing for the siloed structure.</p>
<p>This article covers comprehensive strategies for $($article.title.ToLower()), including technical implementation details, best practices, and real-world examples.</p>
</div>
<div class="mt-12 pt-10 border-t border-slate-800/60"><div class="rounded-2xl bg-gradient-to-br from-$($article.badgeColor)-600/10 via-$($article.badgeColor)-500/5 to-transparent border border-$($article.badgeColor)-500/30 p-8 md:p-10"><div class="flex flex-col md:flex-row md:items-center md:justify-between gap-6"><div class="flex-1 text-center md:text-left"><h3 class="text-2xl font-bold text-slate-50 mb-3">$($article.ctaTitle)</h3><p class="text-base text-slate-300 max-w-2xl mx-auto md:mx-0">$($article.ctaDesc)</p></div><div class="flex flex-col items-center md:items-end gap-4"><a href="/index.html#pricing" class="inline-flex items-center justify-center px-8 py-4 text-base font-semibold text-white bg-$($article.badgeColor)-600 hover:bg-$($article.badgeColor)-500 rounded-full shadow-lg shadow-$($article.badgeColor)-500/50 hover:shadow-$($article.badgeColor)-400/60 transition">See $($article.ctaPlatform) Plans →</a><a href="/blog/" class="inline-flex items-center text-sm text-slate-400 hover:text-slate-200 transition">← Back to all articles</a></div></div></div></div><div class="mt-16 pt-8 border-t border-slate-800/60"><div class="max-w-3xl"><h3 class="text-lg font-semibold text-slate-100 mb-3">About Fastrank</h3><p class="text-sm text-slate-400">Fastrank specializes in speed optimization for WordPress, WooCommerce, and Shopify stores. We improve Core Web Vitals scores by an average of 40+ points and increase conversion rates by 15–30% with safe, white-hat techniques.</p></div></div></article></div></div></section></main>
"@
    $html += $footer
    
    # Write to file
    Set-Content -Path $filePath -Value $html -Encoding UTF8
    Write-Host "✓ Generated: $filePath" -ForegroundColor Green
}

Write-Host "`n✓ All articles generated successfully!" -ForegroundColor Green
Write-Host "`nNote: Article content placeholders need to be replaced with full migrated content from original HTML files." -ForegroundColor Yellow
