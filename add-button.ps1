$file = "blog/How to Fix Slow Shopify Store – Full Checklist.html"
$content = Get-Content $file -Raw -Encoding UTF8

$search = @"
                                    And if you'd rather have an expert handle everything, our team at FASTRANK offers a structured <strong>shopify site speed optimization</strong> service with clear pricing, guaranteed improvements, and a detailed before/after report.
                                </p>
"@

$button = @"


                                <!-- NEW PURPLE BUTTON CTA -->
                                <div class="my-8 flex flex-col sm:flex-row gap-4 items-center sm:items-start">
                                    <a href="../index.html#pricing" class="inline-flex items-center justify-center px-6 py-3 text-sm font-semibold text-white bg-purple-600 hover:bg-purple-500 rounded-full shadow-lg shadow-purple-500/50 hover:shadow-purple-400/60 transition-all duration-200">
                                        See Shopify Speed Plans →
                                    </a>
                                    <a href="/blog/" class="inline-flex items-center text-sm text-slate-400 hover:text-slate-200 transition">
                                        ← Back to all articles
                                    </a>
                                </div>
"@

$newContent = $content.Replace($search, $search + $button)
[System.IO.File]::WriteAllText((Resolve-Path $file), $newContent)
Write-Host "Button added successfully!" -ForegroundColor Green
