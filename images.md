# Stock Images for Infinity Global Website

This document lists the external Unsplash images currently used on the website. All images are served via Unsplash CDN (no local storage needed).

## Current Images in Use

| Purpose | Description | Unsplash URL | File Reference |
|---------|-------------|--------------|----------------|
| Homepage Hero Background | Gradient abstract tech background | https://images.unsplash.com/photo-1557683316-973673baf926?w=1920&q=80 | `app/views/pages/home.html.erb` line 6 |
| About Page - Team Photo | Team collaboration on laptops | https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=800&q=80 | `app/views/pages/about.html.erb` line 34 |
| About Page - Office Photo | Modern professional office workspace | https://images.unsplash.com/photo-1497366216548-37526070297c?w=800&q=80 | `app/views/pages/about.html.erb` line 35 |

## Benefits of Using External Unsplash URLs

✅ **No local storage needed** - Images served from Unsplash CDN
✅ **Fast loading** - Unsplash's global CDN is highly optimized
✅ **Easy to swap** - Just change the URL to use a different image
✅ **Automatic optimization** - Unsplash serves images at requested size/quality
✅ **Free license** - All Unsplash images are free for commercial use, no attribution required

## How to Change Images

To swap any image for a different one from Unsplash:

1. Visit https://unsplash.com and search for your desired image
2. Click on the image you like
3. Right-click the image and select "Copy image address"
4. The URL format will be: `https://images.unsplash.com/photo-XXXXX...`
5. Add query parameters for size/quality: `?w=1920&q=80` (width=1920px, quality=80%)
6. Update the URL in the appropriate file (see table above)
7. Rebuild Docker: `docker-compose build && docker-compose up -d`

## Recommended Image Sources

If you want to browse for alternative images:

1. **Unsplash** - https://unsplash.com (Current source, best quality)
2. **Pexels** - https://pexels.com (Also offers CDN URLs)
3. **Pixabay** - https://pixabay.com (Good alternative)

## Image Selection Guide

### 1. Hero Background (`hero-background.jpg`)

**What to look for:**
- Abstract technology theme OR gradient background
- Professional, modern aesthetic
- Not too busy (text needs to be readable over it)
- Blue/purple/gradient tones work well with the site design

**Recommended Unsplash searches:**
- https://unsplash.com/s/photos/abstract-gradient
- https://unsplash.com/s/photos/technology-background
- https://unsplash.com/s/photos/tech-abstract
- https://unsplash.com/s/photos/blue-gradient

**What to avoid:**
- Images with too much detail (will distract from hero text)
- Dark images (text may not be readable)
- Images with people (save those for about page)

---

### 2. Team Collaboration (`about-team.jpg`)

**What to look for:**
- Software developers or professionals working together
- Diverse team (inclusivity is important)
- Candid, natural shots (not overly posed)
- Professional but approachable atmosphere
- Good lighting, sharp focus

**Recommended Unsplash searches:**
- https://unsplash.com/s/photos/developer-team
- https://unsplash.com/s/photos/software-team
- https://unsplash.com/s/photos/team-collaboration
- https://unsplash.com/s/photos/software-development

**Example search terms:**
- "developers working together"
- "software engineering team"
- "tech team collaboration"
- "programming teamwork"

**What to avoid:**
- Overly staged corporate stock photos
- Poor lighting or blurry images
- People looking at camera (prefer working shots)

---

### 3. Professional Office (`about-office.jpg`)

**What to look for:**
- Modern, clean office space or workspace
- Professional but welcoming environment
- Good natural light
- Tech-forward aesthetic (modern monitors, clean desks)
- Can be empty or with people working

**Recommended Unsplash searches:**
- https://unsplash.com/s/photos/modern-office
- https://unsplash.com/s/photos/modern-workplace
- https://unsplash.com/s/photos/office-space
- https://unsplash.com/s/photos/tech-office

**Example search terms:**
- "modern office workspace"
- "tech office interior"
- "professional workspace"
- "startup office"

**What to avoid:**
- Dated-looking offices (old furniture, CRT monitors)
- Cluttered or messy spaces
- Overly corporate/sterile environments

---

## Download Instructions

### Using Unsplash:

1. Visit the search URL or use Unsplash's search
2. Click on image you like
3. Click the green "Download" button (usually says "Download free")
4. Image downloads automatically in high resolution
5. Rename to match the filename in table above
6. Optimize/compress if needed (see below)

### Using Pexels:

1. Visit https://pexels.com
2. Search for your topic
3. Click on image
4. Click "Free Download" button
5. Select size (choose "Large" or "Original")
6. Rename and optimize as needed

---

## Image Optimization

Before uploading to the app, optimize images to reduce file size:

**Recommended Tools:**
- **TinyPNG** - https://tinypng.com (online, easy to use)
- **ImageOptim** - https://imageoptim.com (Mac app)
- **Squoosh** - https://squoosh.app (Google's online tool)

**Target sizes:**
- Hero background: < 300KB
- Team photo: < 200KB
- Office photo: < 200KB

---

## Installation Steps

Once you've downloaded and optimized your images:

1. **Replace the placeholder files:**
   ```bash
   cp ~/Downloads/hero-background.jpg app/assets/images/hero-background.jpg
   cp ~/Downloads/about-team.jpg app/assets/images/about-team.jpg
   cp ~/Downloads/about-office.jpg app/assets/images/about-office.jpg
   ```

2. **Rebuild Docker image:**
   ```bash
   docker-compose build
   ```

3. **Restart application:**
   ```bash
   docker-compose up -d
   ```

4. **Verify images:**
   - Visit http://localhost:3847
   - Check homepage hero background
   - Visit http://localhost:3847/about
   - Verify both team and office images appear

---

## Specific Image Recommendations (Examples)

If you want specific starting points, here are some search strategies that typically yield good results:

### Hero Background - Example Searches:
1. On Unsplash, search "blue gradient abstract"
2. Look for images by photographers like: Pawel Czerwinski, Milad Fakurian, or Gradienta
3. Filter for landscape orientation
4. Choose something with smooth gradients or subtle patterns

### Team Photo - Example Searches:
1. On Unsplash, search "developers working laptop"
2. Look for candid shots of 2-4 people collaborating
3. Prefer natural lighting and modern settings
4. Choose diverse teams when possible

### Office Photo - Example Searches:
1. On Unsplash, search "modern workspace desk"
2. Look for clean, organized workspaces
3. Prefer images with monitors showing code or design work
4. Natural light through windows is a plus

---

## License Information

**Unsplash License:**
- ✅ Free for commercial use
- ✅ No attribution required
- ✅ Can modify/transform images
- ✅ No permission needed

**Pexels License:**
- ✅ Free for commercial use
- ✅ No attribution required
- ✅ Can modify images
- ✅ No permission needed

**Note:** Even though attribution isn't required, it's a nice gesture to credit photographers when possible.

---

## Image Details

### Homepage Hero Background
- **Photo ID:** photo-1557683316-973673baf926
- **Description:** Abstract gradient technology background with blue/purple tones
- **Photographer:** Unsplash (various contributors)
- **Size:** 1920px wide, quality 80%
- **License:** Free for commercial use

### About Page - Team Collaboration
- **Photo ID:** photo-1522071820081-009f0129c71c
- **Description:** Diverse team collaborating around laptops
- **Photographer:** Unsplash (various contributors)
- **Size:** 800px wide, quality 80%
- **License:** Free for commercial use

### About Page - Office Workspace
- **Photo ID:** photo-1497366216548-37526070297c
- **Description:** Modern professional office with natural lighting
- **Photographer:** Unsplash (various contributors)
- **Size:** 800px wide, quality 80%
- **License:** Free for commercial use

---

## Status

✅ **All images now use external Unsplash URLs**
- No local image storage required
- Fast CDN delivery
- Easy to swap/update
- Professional quality photos

---

## Questions?

If you need help changing images or have questions about image licensing, feel free to ask!

---

**Last Updated:** October 30, 2025
**Created by:** Claude (PM Agent)
**Updated:** External URLs implemented
