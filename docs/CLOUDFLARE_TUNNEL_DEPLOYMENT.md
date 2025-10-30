# Cloudflare Tunnel Deployment - Infinity Global

## Deployment Summary

The Infinity Global website is successfully deployed using Cloudflare Tunnel for secure public access.

## Configuration

### Backend Application
- **Protocol**: HTTP (not HTTPS)
- **Host**: Internal VM IP address
- **Port**: 3847
- **Service URL**: `http://192.168.1.87:3847`

### Cloudflare Tunnel
- **SSL Termination**: Handled by Cloudflare at edge
- **Backend Connection**: HTTP to internal VM
- **Public Access**: HTTPS via Cloudflare domain

## Rails Configuration for Cloudflare Tunnel

The following settings were configured in `config/environments/production.rb`:

```ruby
# Assume SSL is terminated by reverse proxy (Cloudflare)
config.assume_ssl = true

# Do NOT force SSL at app level (Cloudflare handles it)
# config.force_ssl = true  # DISABLED

# No HSTS header from app (Cloudflare sets it if needed)
config.action_dispatch.default_headers = {
  'X-Frame-Options' => 'SAMEORIGIN',
  'X-Content-Type-Options' => 'nosniff',
  'X-XSS-Protection' => '1; mode=block',
  'Referrer-Policy' => 'strict-origin-when-cross-origin',
  'Permissions-Policy' => 'geolocation=(), microphone=(), camera=()'
  # NO 'Strict-Transport-Security' header
}
```

## Key Points

✅ **App accepts HTTP connections** - Cloudflare Tunnel connects via HTTP
✅ **SSL handled by Cloudflare** - Public traffic uses HTTPS at edge
✅ **No HSTS from app** - Prevents browser caching issues
✅ **assume_ssl enabled** - App trusts X-Forwarded-Proto headers
✅ **Security headers intact** - XSS, clickjacking protection still active

## Troubleshooting

### Issue: Bad Gateway / 502 Error
**Cause**: Cloudflare Tunnel trying to connect via HTTPS to HTTP backend
**Solution**: Configure tunnel to use `http://` (not `https://`) for backend

### Issue: Browser redirects HTTP → HTTPS
**Cause**: HSTS header cached in browser
**Solution**:
- Use incognito/private window
- Or clear HSTS: `chrome://net-internals/#hsts`

### Issue: Connection Refused
**Cause**: Docker container not running or port not exposed
**Solution**:
```bash
docker-compose ps  # Check if running
docker-compose logs  # Check for errors
curl http://localhost:3847  # Test locally
```

## Deployment Verification

The application is working when:
- ✅ Local HTTP access works: `curl http://192.168.1.87:3847/`
- ✅ Returns HTTP 200 OK
- ✅ Security headers present (except HSTS)
- ✅ No 301 redirects to HTTPS
- ✅ Cloudflare domain serves content via HTTPS

## Architecture

```
Internet (HTTPS)
    ↓
Cloudflare Edge (SSL Termination)
    ↓
Cloudflare Tunnel (Encrypted)
    ↓
Internal Network (HTTP)
    ↓
Rails App on VM:3847
```

## Security Notes

- SSL/TLS encryption: Cloudflare → Client ✅
- Tunnel encryption: Cloudflare → VM ✅
- Internal traffic: HTTP (within trusted network)
- Security headers: All present except HSTS
- HSTS optional: Can be enabled in Cloudflare dashboard

## Related Documentation

- Main deployment guide: [DEPLOYMENT.md](DEPLOYMENT.md)
- Project completion: [PROJECT_COMPLETION.md](PROJECT_COMPLETION.md)
- Stock images: [../images.md](../images.md)

---

**Deployment Date**: October 30, 2025
**Status**: ✅ Live and operational
**Access**: Via Cloudflare Tunnel domain
