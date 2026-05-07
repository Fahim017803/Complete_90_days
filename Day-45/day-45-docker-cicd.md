# Day 45 – Docker Build & Push in GitHub Actions

## Overview

Today I built a complete CI/CD pipeline where every `git push` automatically builds a Docker image and ships it to Docker Hub — no manual steps required.

I applied this directly to my **mdfahim.dev** portfolio project which is live in production at **https://ec2.mdfahim.dev** running on AWS EC2 (Tokyo region).

---

## Task 1 — Prepare

**App:** My personal portfolio site — `mdfahim.dev`

**Dockerfile (`dockerfile`):**
```dockerfile
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
```

**Secrets configured in GitHub:**

| Type | Name | Value |
|------|------|-------|
| Secret | `DOCKERHUB_TOKEN` | Docker Hub PAT (Read + Write) |
| Variable | `DOCKERHUB_USER` | `fahim017803` |

**Repository:** `github.com/Fahim017803/mdfahim.dev`

---

## Task 2 — Build the Docker Image in CI

**Workflow:** `.github/workflows/docker-push.yml`

```yaml
name: docker build and push
on:
  push:
    branches: [main, staging]
jobs:
  build-and-push:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3
      - name: login to docker
        uses: docker/login-action@v3
        with:
          username: ${{ vars.DOCKERHUB_USER }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}
      - name: build and push
        uses: docker/build-push-action@v6
        with:
          push: true
          tags: |
            fahim017803/mdfahim.dev:latest
            fahim017803/mdfahim.dev:${{ github.sha }}
          cache-from: type=gha
          cache-to: type=gha,mode=max
```

**Verify:** GitHub Actions → `docker build and push` → `build-and-push` step → logs show image built successfully ✅

---

## Task 3 — Push to Docker Hub

Two tags are pushed on every build:

```
fahim017803/mdfahim.dev:latest
fahim017803/mdfahim.dev:<full-commit-sha>
```

**Why two tags?**
- `latest` — always points to newest build, easy to pull
- `<commit-sha>` — exact version tracking, rollback possible

**Docker Hub:** https://hub.docker.com/r/fahim017803/mdfahim.dev

**Verify:** Docker Hub → Tags tab → both `latest` and `<sha>` tags visible ✅

---

## Task 4 — Only Push on Main

In my pipeline, `docker-push.yml` triggers on both `main` and `staging` branches.
For feature branches — the workflow does NOT trigger at all:

```yaml
on:
  push:
    branches: [main, staging]  # feature branches are excluded
```

**Test with feature branch:**
```bash
git checkout -b feature/test-task4
echo "<!-- test -->" >> index.html
git add .
git commit -m "test: feature branch push"
git push origin feature/test-task4
```

**Result:** `feature/test-task4` is NOT in `branches: [main, staging]` → workflow does not trigger → image NOT built, NOT pushed ✅

---

## Task 5 — Status Badge

**Badge URL:**
```
https://github.com/Fahim017803/mdfahim.dev/actions/workflows/docker-push.yml/badge.svg
```

**Added to `README.md`:**
```markdown
![docker build and push](https://github.com/Fahim017803/mdfahim.dev/actions/workflows/docker-push.yml/badge.svg)
```

**How to get badge URL:**
1. GitHub → Actions → `docker build and push` workflow
2. Top right `...` menu → **Create status badge**
3. Copy the markdown

---

## Task 6 — Pull and Run It

**Pull and run locally:**
```bash
# Pull latest image from Docker Hub
docker pull fahim017803/mdfahim.dev:latest

# Run it locally on port 8080
docker run -p 8080:80 fahim017803/mdfahim.dev:latest
```

**Visit:** `http://localhost:8080` → portfolio site loads ✅

---

## Full Journey: `git push` to Running Container

```
Step 1: Developer writes code
        git add . && git commit && git push origin staging

Step 2: GitHub Actions triggers docker-push.yml
        → Checkout code
        → Set up Docker Buildx
        → Login to Docker Hub (using DOCKERHUB_TOKEN secret)
        → Build nginx:alpine image (with GHA cache for speed)
        → Push 2 tags to Docker Hub:
            fahim017803/mdfahim.dev:latest
            fahim017803/mdfahim.dev:<commit-sha>

Step 3: deploy-staging.yml triggers automatically
        → Runs on self-hosted runner (My-porfolio-staging)
        → Staging EC2 (52.196.204.12, Tokyo ap-northeast-1)
        → docker compose -f docker-compose.staging.yml down
        → docker compose -f docker-compose.staging.yml pull
        → docker compose -f docker-compose.staging.yml up -d

Step 4: Staging site is live
        → http://52.196.204.12 ✅
        → Test and verify

Step 5: Create Pull Request
        → GitHub → Pull requests → base: main ← compare: staging
        → Merge pull request

Step 6: Deploy Production (Manual Approval)
        → Actions → Deploy Production → Run workflow
        → Reviewer approves
        → Runs on self-hosted runner (My-porfolio-production)
        → Production EC2 (18.183.212.236, Tokyo ap-northeast-1)
        → docker compose down && pull && up -d (with SSL)

Step 7: Production site is live
        → https://ec2.mdfahim.dev 🔒✅
        → OWASP ZAP security scan runs automatically
        → Lighthouse CI performance scan runs automatically
```

**Total time: ~5-7 minutes** (including manual approval)

---

## Bonus: Docker Layer Cache

```yaml
cache-from: type=gha
cache-to: type=gha,mode=max
```

- First build: `Cached: 0%` — ~45 seconds
- Subsequent builds: `Cached: 80%+` — much faster ✅

Cache visible at: GitHub → Actions → **Caches** (left sidebar)

---

## What I Learned

| Concept | What I Learned |
|---------|----------------|
| `docker/login-action@v3` | Securely authenticates to Docker Hub using GitHub Secrets |
| `docker/build-push-action@v6` | Builds and pushes Docker image in a single step |
| Commit SHA tagging | Every build gets a unique, traceable identifier |
| GHA Cache | `cache-from/cache-to: type=gha` reuses Docker layers |
| Branch filtering | Controls which branches trigger the workflow |
| Self-hosted runner | EC2 runner pulls and runs the image directly |
| Multi-environment | staging (auto) → review → production (manual approval) |

---

## Links

- **Live site:** https://ec2.mdfahim.dev
- **GitHub repo:** https://github.com/Fahim017803/mdfahim.dev
- **Docker Hub:** https://hub.docker.com/r/fahim017803/mdfahim.dev

---

*Part of [#90DaysOfDevOps](https://github.com/TrainWithShubham/90DaysOfDevOps) — Josh Batch 10*
*#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham*