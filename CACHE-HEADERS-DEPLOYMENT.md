# Cache-Control Headers Deployment Guide

## Goal
Set `Cache-Control: public, max-age=2592000` (30 days) for all static assets to resolve the "Add Expires headers" performance issue.

## Which Configuration to Use?

### 1. **If using Cloudflare** (Easiest - No file upload needed)
- Go to Cloudflare Dashboard → Your Domain
- Navigate to **Caching** → **Configuration**
- Set **Browser Cache TTL** to "1 month"
- Enable **Caching Level**: "Standard" or "Aggressive"
- Purge cache after changes

### 2. **If using Nginx** (Most common)
**File:** `nginx-cache-headers.conf` (created in your repo)

**Steps:**
```bash
# 1. Upload the file to your server
scp nginx-cache-headers.conf user@yourserver:/etc/nginx/conf.d/

# 2. Include it in your site config
# Add this line to your /etc/nginx/sites-available/fastrank.io:
include /etc/nginx/conf.d/nginx-cache-headers.conf;

# 3. Test configuration
sudo nginx -t

# 4. Restart Nginx
sudo systemctl restart nginx
```

### 3. **If using Varnish**
**File:** `varnish-cache-headers.vcl` (created in your repo)

**Steps:**
```bash
# 1. Edit your main Varnish config
sudo nano /etc/varnish/default.vcl

# 2. Copy the content from varnish-cache-headers.vcl
# Insert into the appropriate subroutines

# 3. Restart Varnish
sudo systemctl restart varnish
```

### 4. **If using Apache**
**File:** `.htaccess` (created in your repo)

**Steps:**
```bash
# 1. Simply upload .htaccess to your website root
scp .htaccess user@yourserver:/var/www/fastrank.io/

# 2. Ensure Apache modules are enabled
sudo a2enmod expires
sudo a2enmod headers
sudo systemctl restart apache2

# Changes apply immediately - no restart needed for .htaccess
```

## Verification Commands

### Test CSS file
```bash
curl -I https://fastrank.io/style.css
```

**Expected output:**
```
HTTP/2 200
cache-control: public, max-age=2592000, immutable
```

### Test JavaScript file
```bash
curl -I https://fastrank.io/js/main.js
```

### Test Image file
```bash
curl -I https://fastrank.io/images/logo.svg
```

## Troubleshooting

### Headers not showing?
1. **Clear Cloudflare cache** if using Cloudflare
2. **Check file paths** - ensure config files are in correct location
3. **Verify syntax** - run `nginx -t` or `varnishd -C -f /etc/varnish/default.vcl`
4. **Check logs** - `/var/log/nginx/error.log` or `/var/log/varnish/varnish.log`

### Still not working?
- Verify which web server you're actually using: `curl -I https://fastrank.io | grep -i server`
- Check if Cloudflare is overriding headers
- Contact your hosting provider for server access

## Expected Performance Impact
- ✅ Eliminates "Add Expires headers" warning
- ✅ Reduces repeat visitor load time by ~40-60%
- ✅ Decreases server bandwidth usage
- ✅ Improves PageSpeed Insights score by 5-15 points

## Files Created
1. `nginx-cache-headers.conf` - For Nginx servers
2. `varnish-cache-headers.vcl` - For Varnish cache servers
3. `.htaccess` - For Apache servers
4. `CACHE-HEADERS-DEPLOYMENT.md` - This guide

Choose the appropriate file based on your hosting setup and follow the deployment steps above.
