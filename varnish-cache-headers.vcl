# Varnish Cache-Control Configuration
# File: varnish-cache-headers.vcl
#
# INSTRUCTIONS:
# 1. Add this to your default.vcl file (usually /etc/varnish/default.vcl)
# 2. Insert into the appropriate subroutines (vcl_backend_response)
# 3. Restart Varnish: sudo systemctl restart varnish
# 4. Verify with: curl -I https://fastrank.io/style.css

# Add to vcl_backend_response subroutine
sub vcl_backend_response {
    # Cache static assets for 30 days
    if (bereq.url ~ "\.(css|js|png|jpg|jpeg|gif|ico|svg|webp|woff|woff2|ttf|eot|otf)(\?.*)?$") {
        set beresp.ttl = 30d;
        set beresp.http.Cache-Control = "public, max-age=2592000, immutable";
        unset beresp.http.Set-Cookie;
    }
    
    # Cache HTML for 1 hour
    if (bereq.url ~ "\.(html|htm)(\?.*)?$") {
        set beresp.ttl = 1h;
        set beresp.http.Cache-Control = "public, max-age=3600";
    }
    
    # Cache JSON/XML for 1 day
    if (bereq.url ~ "\.(json|xml)(\?.*)?$") {
        set beresp.ttl = 1d;
        set beresp.http.Cache-Control = "public, max-age=86400";
    }
}

# Optional: Add to vcl_deliver to show cache status
sub vcl_deliver {
    if (obj.hits > 0) {
        set resp.http.X-Cache = "HIT";
    } else {
        set resp.http.X-Cache = "MISS";
    }
}
