# Infinity Global - Deployment Guide

This guide covers deploying the Infinity Global website to a production environment using Docker.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Initial Setup](#initial-setup)
- [Environment Configuration](#environment-configuration)
- [Building and Deploying](#building-and-deploying)
- [SSL/HTTPS Configuration](#sslhttps-configuration)
- [Updating the Application](#updating-the-application)
- [Monitoring and Logs](#monitoring-and-logs)
- [Troubleshooting](#troubleshooting)
- [Security Checklist](#security-checklist)

## Prerequisites

- Linux VM with SSH access
- Docker and Docker Compose installed on the VM
- Git installed on the VM
- Domain name configured to point to VM IP (for SSL)
- Port 3847 (or your chosen port) available and open in firewall

### Installing Docker on Ubuntu/Debian

```bash
# Update package index
sudo apt-get update

# Install required packages
sudo apt-get install -y ca-certificates curl gnupg

# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Set up the repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify installation
sudo docker --version
sudo docker compose version
```

## Initial Setup

### 1. Clone the Repository

```bash
# SSH to your VM
ssh user@your-vm-ip

# Clone the repository
git clone https://github.com/yourusername/infinityglobal.git
cd infinityglobal
```

### 2. Configure Environment Variables

```bash
# Copy the example environment file
cp .env.example .env

# Generate a secret key base
docker compose run --rm web bin/rails secret

# Edit the .env file with your production values
nano .env
```

## Environment Configuration

Edit `.env` file with the following values:

```bash
# Application Port
# Choose a unique port between 3000-9999 to avoid conflicts
PORT=3847

# Rails Environment
RAILS_ENV=production

# Secret Key Base
# Replace with the output from: docker compose run --rm web bin/rails secret
SECRET_KEY_BASE=your_generated_secret_key_here

# Enable static file serving
RAILS_SERVE_STATIC_FILES=true

# Optional: Set log level
# RAILS_LOG_LEVEL=info
```

**IMPORTANT**:
- Never commit your `.env` file to git
- Keep your `SECRET_KEY_BASE` secure and unique for each deployment
- Use a unique port number to avoid conflicts with other applications

## Building and Deploying

### Build the Docker Image

```bash
# Build the Docker image
sudo docker compose build

# This will:
# - Install Ruby 3.3.4
# - Install all gem dependencies
# - Precompile assets (CSS, JS, images)
# - Create a production-ready container
```

### Start the Application

```bash
# Start the application in detached mode
sudo docker compose up -d

# The application will start on the configured port (default: 3847)
```

### Verify Deployment

```bash
# Check container status
sudo docker compose ps

# View logs
sudo docker compose logs -f

# Test the application
curl http://localhost:3847

# Or from another machine
curl http://your-vm-ip:3847
```

## SSL/HTTPS Configuration

For production deployment, you should configure SSL/HTTPS using a reverse proxy like Nginx or Caddy.

### Option 1: Using Nginx with Let's Encrypt

#### Install Nginx and Certbot

```bash
sudo apt-get install -y nginx certbot python3-certbot-nginx
```

#### Configure Nginx

Create `/etc/nginx/sites-available/infinityglobal`:

```nginx
server {
    listen 80;
    server_name infinityglobalcorp.com www.infinityglobalcorp.com;

    location / {
        proxy_pass http://localhost:3847;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Enable the site:

```bash
sudo ln -s /etc/nginx/sites-available/infinityglobal /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

#### Obtain SSL Certificate

```bash
# Get SSL certificate from Let's Encrypt
sudo certbot --nginx -d infinityglobalcorp.com -d www.infinityglobalcorp.com

# Certbot will automatically configure HTTPS and set up auto-renewal
```

#### Verify SSL Configuration

```bash
# Test HTTPS
curl https://infinityglobalcorp.com

# Verify auto-renewal
sudo certbot renew --dry-run
```

### Option 2: Using Caddy (Automatic HTTPS)

Caddy automatically handles SSL certificates from Let's Encrypt.

#### Install Caddy

```bash
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy
```

#### Configure Caddy

Create `/etc/caddy/Caddyfile`:

```
infinityglobalcorp.com www.infinityglobalcorp.com {
    reverse_proxy localhost:3847
}
```

Start Caddy:

```bash
sudo systemctl restart caddy
sudo systemctl enable caddy
```

Caddy will automatically obtain and renew SSL certificates.

## Updating the Application

When you need to deploy updates:

```bash
# SSH to the VM
ssh user@your-vm-ip
cd infinityglobal

# Pull latest changes
git pull origin main

# Rebuild and restart
sudo docker compose down
sudo docker compose build
sudo docker compose up -d

# Verify the update
sudo docker compose logs -f
```

### Rolling Back

If you need to roll back to a previous version:

```bash
# View git history
git log --oneline

# Checkout previous commit
git checkout <commit-hash>

# Rebuild and restart
sudo docker compose down
sudo docker compose build
sudo docker compose up -d
```

## Monitoring and Logs

### View Logs

```bash
# View all logs
sudo docker compose logs

# Follow logs in real-time
sudo docker compose logs -f

# View last 100 lines
sudo docker compose logs --tail=100

# View logs for specific time period
sudo docker compose logs --since 1h
```

### Check Application Status

```bash
# Check if container is running
sudo docker compose ps

# Check container resource usage
sudo docker stats

# Check application health
curl http://localhost:3847/up
```

### Restart Application

```bash
# Restart the application
sudo docker compose restart

# Stop the application
sudo docker compose down

# Start the application
sudo docker compose up -d
```

## Troubleshooting

### Application Won't Start

```bash
# Check logs for errors
sudo docker compose logs

# Check if port is already in use
sudo netstat -tulpn | grep 3847

# Rebuild from scratch
sudo docker compose down
sudo docker compose build --no-cache
sudo docker compose up -d
```

### 500 Internal Server Error

```bash
# Check Rails logs
sudo docker compose logs | grep ERROR

# Verify SECRET_KEY_BASE is set
sudo docker compose exec web env | grep SECRET_KEY_BASE

# Verify assets are precompiled
sudo docker compose exec web ls -la public/assets
```

### Permission Issues

```bash
# Fix file permissions
sudo chown -R $USER:$USER .

# Fix Docker socket permissions
sudo usermod -aG docker $USER
newgrp docker
```

### Port Already in Use

```bash
# Find what's using the port
sudo lsof -i :3847

# Kill the process
sudo kill -9 <PID>

# Or change the port in .env file
nano .env
# Update PORT=3848
sudo docker compose down
sudo docker compose up -d
```

### Assets Not Loading

```bash
# Verify static file serving is enabled
grep RAILS_SERVE_STATIC_FILES .env

# Should show: RAILS_SERVE_STATIC_FILES=true

# Rebuild with asset precompilation
sudo docker compose down
sudo docker compose build --no-cache
sudo docker compose up -d
```

## Security Checklist

Before deploying to production, ensure:

- [ ] `.env` file contains unique `SECRET_KEY_BASE`
- [ ] `.env` file is not committed to git (check `.gitignore`)
- [ ] Port number is unique and not conflicting
- [ ] Firewall configured to allow only necessary ports
- [ ] SSL/HTTPS configured via Nginx or Caddy
- [ ] Force SSL enabled in Rails production config
- [ ] Security headers configured (HSTS, X-Frame-Options, etc.)
- [ ] Regular updates applied (OS, Docker, dependencies)
- [ ] Logs are monitored regularly
- [ ] Backups configured (if needed)
- [ ] Domain DNS configured correctly
- [ ] SSL certificate auto-renewal working

## Production URLs

After deployment with SSL configured:

- **Homepage**: https://infinityglobalcorp.com
- **About**: https://infinityglobalcorp.com/about
- **Contact**: https://infinityglobalcorp.com/contact
- **Terms**: https://infinityglobalcorp.com/terms
- **Privacy**: https://infinityglobalcorp.com/privacy

## Support

For issues or questions:

- Check application logs: `sudo docker compose logs`
- Review this deployment guide
- Check the README.md file
- Contact: contact@infinityglobalcorp.com

## Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Rails Production Guide](https://guides.rubyonrails.org/configuring.html#running-in-production)
- [Let's Encrypt Documentation](https://letsencrypt.org/docs/)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [Caddy Documentation](https://caddyserver.com/docs/)
