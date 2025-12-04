# Copilot Instructions - Fastrank HTML

## Project Overview
This is a marketing website for FASTRANK, a Shopify/WordPress speed optimization service. Built with vanilla HTML, Tailwind CSS 4.0, and minimal JavaScript for optimal performance (practicing what we preach).

## Architecture & Stack

### Build System
- **Tailwind CSS 4.0** via CLI (not PostCSS)
- **No framework**: Pure HTML pages with shared layout patterns
- **Development**: `npm run dev` — watches `css/style.css` and outputs compiled `style.css` at root
- **Production**: `npm run build` — one-time compilation

### CSS Architecture
**Source**: `css/style.css` imports:
- `tailwindcss` core
- `css/additional-styles/utility-patterns.css` (custom components layer)
- `css/additional-styles/theme.css` (design tokens)
- `@tailwindcss/forms` and `@tailwindcss/typography` plugins

**Output**: Root `style.css` (compiled, never edit directly)

**Key patterns**:
- Design tokens defined in `@theme` block (`--text-*`, `--color-*`, custom animations)
- Complex grid layouts use `[&>div:nth-*]` pseudo-selectors for responsive card patterns
- Gradient backgrounds: `bg-linear-to-r from-purple-500 to-purple-200` (custom Tailwind extension)
- Performance-first: Lazy-load vendor CSS (`media="print" onload="this.media='all'"`)

### JavaScript Architecture
**Entry**: `js/main.js` — Single file, vanilla JS with class-based components

**Performance patterns**:
- Batch DOM reads before writes to prevent layout thrashing
- `requestIdleCallback` for non-critical init (Swiper carousels)
- `requestAnimationFrame` for animation loops (particle effects, hover interactions)
- Passive event listeners (`{ passive: true }`) for scroll/resize/mousemove
- Cached `getBoundingClientRect()` results with 100ms TTL

**Key components**:
1. **AOS** (Animate On Scroll) — initialized at top, runs once per element
2. **Swiper** — client carousel (infinite auto-scroll) and stellar carousel (3-column)
3. **ParticleAnimation** — canvas-based interactive particles (hero sections)
4. **Highlighter** — mouse-tracking gradient effect on cards (`data-highlighter`)
5. **Back-to-top button** — injected globally, positioned to avoid Crisp chat widget

### Page Structure
- **Homepage**: `index.html` — Services, pricing, testimonials, FAQ
- **About**: `about.html`
- **Blog index**: `blog/index.html` — Three silos: Shopify, WordPress, Core Web Vitals
- **Blog articles**: `blog/{slug}/index.html` — Full SEO-optimized articles
- **Policy pages**: `privacy-policy/`, `terms-of-service/`, etc.
- **Service pages**: `shopify-speed-optimization/index.html`

## Content Management

### Blog Article Structure
Each article lives in `blog/{slug}/index.html`:
- **Header**: Full SEO meta (title, description, OG, Twitter, canonical, schema.org)
- **Hero**: Category badge, title, date, read time
- **Content**: HTML article with Tailwind prose (`prose-lg prose-slate`)
- **CTA**: Purple button to pricing + back-to-blog link
- **FAQ**: Structured as `<details>` with schema.org FAQ markup

**PowerShell scripts automate article generation**:
- `generate-remaining-articles.ps1` — Creates new blog posts from templates
- `add-button.ps1` — Injects CTAs into existing articles

### SEO Patterns
- Canonical URLs for all pages
- Structured data (JSON-LD): `Organization`, `WebSite`, `BreadcrumbList`, `FAQPage`, `Article`
- Meta description exactly matches article intro paragraph
- Open Graph + Twitter Card images
- Internal linking uses full article slugs in URLs

## Development Workflows

### Starting Development
```powershell
# Install dependencies (first time)
npm install

# Start dev server (auto-recompile CSS)
npm run dev
```

### Making Changes
1. **Edit HTML**: Modify any `.html` file directly
2. **Edit CSS**: Change `css/style.css` or `css/additional-styles/*.css`
3. **Edit JS**: Update `js/main.js`
4. **Check output**: `npm run dev` auto-rebuilds `style.css`

### Performance Testing
This site is optimized for speed (business value: we sell speed optimization). When editing:
- Test Core Web Vitals (LCP, CLS, INP) after changes
- Keep JS under 50KB (currently ~12KB main.js)
- Lazy-load non-critical resources
- Use `loading="lazy"` and `decoding="async"` on images

### Code Style Conventions
- **HTML**: 4-space indentation, semantic tags (`<section>`, `<article>`)
- **CSS**: Tailwind utility-first, custom classes only in `utility-patterns.css`
- **JS**: Class-based components, descriptive method names, JSDoc for complex logic
- **Comments**: Explain "why" not "what" (e.g., "Keep above Crisp chat bubble")

## Project-Specific Conventions

### Tailwind Customization
- **Gradients**: Use `bg-linear-to-r` (not `bg-gradient-to-r`) — defined in theme
- **Text colors**: `text-slate-{N}` for body, `text-purple-{N}` for CTAs
- **Animations**: `animate-infinite-scroll`, `animate-float`, custom keyframes in `@theme`

### Component Patterns
**Card grids** (features, services):
```css
[&>div:nth-of-type(3n+1)]:bg-transparent
[&>div:nth-of-type(3n+3)]:before:border-purple-500
```
These create 3-column layouts with alternating backgrounds and highlighted every 3rd item.

**Hero sections**: Always include particle animation canvas:
```html
<div class="absolute inset-0 -z-10" aria-hidden="true">
  <canvas data-particle-animation data-particle-quantity="15"></canvas>
</div>
```

**CTAs**: Purple gradient buttons with hover animations:
```html
<a class="btn-sm text-white bg-purple-500 hover:bg-purple-600 transition duration-150 ease-in-out group">
  Text <span class="group-hover:translate-x-0.5 transition-transform">→</span>
</a>
```

### External Integrations
- **Crisp Chat**: Loaded via inline script in `<head>` (ID: `883b2d77-164f-457f-add0-22394a2a3bb2`)
- **Google Analytics**: GA4 (`G-EZ9KWQEM4F`) + Google Ads conversion (`AW-17714543566`)
- **Ahrefs Analytics**: Async script with key `EjNmLeOeDJ1ZJgrx1SjNXw`

## File Naming Conventions
- Blog articles: Lowercase with hyphens (`shopify-speed-optimization-guide-2025`)
- Policy pages: Title case folders with `index.html` inside
- Images: Descriptive names, WebP format preferred (`before-after-comparison.webp`)

## Common Tasks

### Adding a New Blog Article
1. Create folder: `blog/{slug}/`
2. Copy template from existing article
3. Update metadata (title, description, date, schema)
4. Write content in prose-optimized HTML
5. Add internal links to related articles
6. Generate with PowerShell script (see `generate-remaining-articles.ps1`)

### Adding a New Service Page
1. Copy `shopify-speed-optimization/index.html` as template
2. Update hero, features, pricing sections
3. Add to navigation in `index.html`
4. Update sitemap.xml and schema.org breadcrumbs

### Updating Pricing
All pricing tables are in `index.html` (search for `#pricing` section). Update HTML directly — no dynamic data.

## Testing & Validation
- **Manual**: Test in Chrome DevTools (mobile viewport), check Network/Performance tabs
- **Lighthouse**: Run on key pages (home, blog, service pages) — target 90+ on Performance
- **HTML validation**: Use W3C validator for schema.org markup
- **Cross-browser**: Test in Chrome, Firefox, Safari (especially animations)

## Important Notes
- **Never edit `style.css` at root** — it's auto-generated by Tailwind CLI
- **Back-to-top button** positioned at `bottom: 108px` (desktop) / `132px` (mobile) to avoid Crisp chat
- **Blog CTAs** dynamically enhanced by `main.js` (converts spans to clickable anchors)
- **Performance budgets**: Keep HTML under 200KB, JS under 50KB, CSS under 100KB (compiled)

## Questions to Ask Me
1. Should blog articles use a templating system (e.g., Eleventy, Astro) or stay pure HTML?
2. Do you want automatic image optimization (WebP conversion, resizing)?
3. Should pricing be moved to a JSON file for easier updates?
4. Any plans for internationalization (i18n) or multi-language support?
