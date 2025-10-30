# Infinity Global

Professional software engineering consulting website built with Ruby on Rails and TailwindCSS.

## Tech Stack

- **Ruby**: 3.3.8
- **Rails**: 8.1.1
- **CSS Framework**: TailwindCSS 4.4.0
- **Deployment**: Docker + Docker Compose
- **Web Server**: Thruster (Rails 8 default)

## Prerequisites

- Docker and Docker Compose installed on your system
- For local development: Ruby 3.3.8 and Bundler

## Quick Start with Docker

### 1. Clone the Repository

```bash
git clone <repository-url>
cd infinityglobal
```

### 2. Set Up Environment Variables

```bash
cp .env.example .env
```

Edit `.env` and update the following:

- `PORT`: Choose a unique port (e.g., 3847, 4921, 5932) to avoid conflicts on shared VMs
- `SECRET_KEY_BASE`: Generate with `docker-compose run --rm web bin/rails secret`

Example `.env` file:
```
PORT=3847
RAILS_ENV=production
SECRET_KEY_BASE=your_generated_secret_key_here
```

### 3. Build the Docker Image

```bash
docker-compose build
```

This will:
- Build a multi-stage Docker image
- Install all Ruby gems
- Precompile assets (CSS/JS)
- Create a production-ready container

### 4. Start the Application

```bash
docker-compose up
```

Or run in detached mode:
```bash
docker-compose up -d
```

### 5. Access the Application

Open your browser to:
```
http://localhost:3847
```
(Replace 3847 with your configured PORT)

### 6. Stop the Application

```bash
docker-compose down
```

## Local Development (Without Docker)

### Install Dependencies

```bash
bundle install
```

### Set Up Environment

```bash
cp .env.example .env
# Edit .env with development settings
```

### Start Development Server

```bash
bin/dev
```

This starts:
- Rails server on `localhost:3000`
- Tailwind CSS watcher for live CSS compilation

Access at: `http://localhost:3000`

### Build Tailwind CSS (Production)

```bash
bin/rails tailwindcss:build
```

## Project Structure

```
infinityglobal/
├── app/
│   ├── controllers/      # Rails controllers
│   ├── views/           # ERB templates
│   │   ├── layouts/     # Application layout
│   │   ├── shared/      # Shared partials (header, footer)
│   │   └── pages/       # Page views
│   ├── helpers/         # View helpers
│   └── assets/          # CSS, images
│       └── tailwind/    # TailwindCSS configuration
├── config/              # Rails configuration
├── docs/                # Documentation
│   ├── prd.md          # Product Requirements
│   ├── architecture.md  # Technical Architecture
│   ├── front-end-spec.md # UI/UX Specification
│   └── stories/        # User stories
├── Dockerfile          # Multi-stage production Docker image
├── docker-compose.yml  # Docker Compose configuration
└── .env.example        # Environment variable template
```

## Deployment to Production

For detailed production deployment instructions including:
- SSL/HTTPS configuration with Let's Encrypt or Caddy
- Nginx or Caddy reverse proxy setup
- Security hardening
- Monitoring and troubleshooting
- Update procedures

**See: [docs/DEPLOYMENT.md](docs/DEPLOYMENT.md)**

### Quick Deployment

```bash
# 1. SSH to your VM
ssh user@your-vm-address

# 2. Clone repository
git clone <repository-url>
cd infinityglobal

# 3. Configure environment
cp .env.example .env
nano .env  # Edit with production values

# 4. Generate secret key
docker-compose run --rm web bin/rails secret
# Copy output to SECRET_KEY_BASE in .env

# 5. Build and start
docker-compose build
docker-compose up -d

# 6. Verify
curl http://localhost:3847
```

For SSL/HTTPS setup and complete production configuration, see [docs/DEPLOYMENT.md](docs/DEPLOYMENT.md).

## Docker Commands Reference

```bash
# Build image
docker-compose build

# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f web

# Restart service
docker-compose restart web

# Execute command in container
docker-compose exec web bin/rails console

# Remove containers and volumes
docker-compose down -v
```

## Port Configuration

The application uses a configurable port via the `PORT` environment variable to support deployment on shared VMs without conflicts.

**Default**: 3847 (configurable via `.env`)

Choose a random port between 3000-9999 that doesn't conflict with other services on your VM.

## Health Check

The application includes a health check endpoint:

```
GET /up
```

Returns HTTP 200 if the application is running properly.

## No Database Required

This is a static marketing website with no database. All content is stored in views and partials. The Rails application serves server-side rendered pages only.

## Asset Compilation

Assets (CSS from Tailwind) are precompiled during the Docker build process. For local development, use `bin/dev` which includes the Tailwind watcher.

## Security

- **Production Security Headers**: HSTS, X-Frame-Options, X-Content-Type-Options, CSP configured
- **Force SSL**: Production environment forces HTTPS connections
- **Secret Management**: Environment variables keep secrets out of source code
- **Docker Security**: Non-root user (`rails`) for container execution
- **Image Optimization**: Multi-stage build reduces final image size and attack surface
- **Git Security**: `.gitignore` excludes `.env`, `tmp/`, `log/`, and sensitive files
- **SEO & Privacy**: robots.txt and privacy policy configured

For complete security configuration and SSL setup, see [docs/DEPLOYMENT.md](docs/DEPLOYMENT.md).

## Support

For issues or questions:
- **Phone**: +1 617-460-4451
- **Email**: contact@infinityglobalcorp.com

## License

Copyright © 2025 Infinity Global. All rights reserved.
