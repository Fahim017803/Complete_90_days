# Day 44 – Secrets, Artifacts & Running Real Tests in CI

## Overview

Today I learned how to securely manage secrets, save build outputs as artifacts, run real tests in CI, and cache dependencies — all applied directly to my **mdfahim.dev** production pipeline.

---

## Task 1 — GitHub Secrets

**Secret created:** `DOCKERHUB_TOKEN` (Docker Hub PAT — Read + Write)

**Workflow to verify secret is set (without printing the value):**

```yaml
name: Secret Check
on: [push]
jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - name: Verify secret is set
        run: |
          if [ -n "${{ secrets.DOCKERHUB_TOKEN }}" ]; then
            echo "The secret is set: true"
          else
            echo "The secret is set: false"
          fi
```

**What happens when you print `${{ secrets.MY_SECRET_MESSAGE }}` directly?**

GitHub automatically **masks** the value — it shows `***` in logs instead of the actual value.

**Why should you NEVER print secrets in CI logs?**
- CI logs are often accessible to all team members
- Logs can be stored for months — creates a permanent exposure window
- Third-party integrations might read logs
- Even if masked, bad practices can accidentally expose values in error messages
- Real world example: AWS keys leaked in CI logs cost companies thousands of dollars in crypto mining bills

---

## Task 2 — Secrets as Environment Variables

In my `docker-push.yml`, secrets are passed securely as environment variables:

```yaml
- name: login to docker
  uses: docker/login-action@v3
  with:
    username: ${{ vars.DOCKERHUB_USER }}
    password: ${{ secrets.DOCKERHUB_TOKEN }}
```

**Secrets configured:**

| Type | Name | Used For |
|------|------|----------|
| Secret | `DOCKERHUB_TOKEN` | Docker Hub authentication |
| Variable | `DOCKERHUB_USER` | Docker Hub username (`fahim017803`) |
| Secret | `GITHUB_TOKEN` | Gitleaks secret scanning (auto-provided) |

**Why Variable vs Secret?**
- `DOCKERHUB_USER` = `fahim017803` — not sensitive, visible in logs is fine → Variable
- `DOCKERHUB_TOKEN` = PAT token — sensitive, must be masked → Secret

---

## Task 3 — Upload Artifacts

**Three workflows now save artifacts:**

### code-quality.yml — HTMLHint Report
```yaml
- name: Run HTMLHint
  run: htmlhint index.html --format json > htmlhint-report.json || true
- name: Upload HTMLHint Report
  uses: actions/upload-artifact@v4
  with:
    name: htmlhint-report-${{ github.run_number }}
    path: htmlhint-report.json
    retention-days: 90
```

### dependencies-scan.yml — Trivy Security Report
```yaml
- name: Run Trivy scan
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: fahim017803/mdfahim.dev:latest
    format: json
    output: trivy-report.json
    exit-code: 0
- name: Upload Trivy Report
  uses: actions/upload-artifact@v4
  with:
    name: trivy-report-${{ github.run_number }}
    path: trivy-report.json
    retention-days: 90
```

### docker-lint.yml — Hadolint Report
```yaml
- name: Lint Dockerfile
  uses: hadolint/hadolint-action@v3.1.0
  with:
    dockerfile: dockerfile
    format: json
    output-file: hadolint-report.json
    no-fail: true
- name: Upload Hadolint Report
  uses: actions/upload-artifact@v4
  with:
    name: hadolint-report-${{ github.run_number }}
    path: hadolint-report.json
    retention-days: 90
```

**Verify:** GitHub Actions → workflow run → scroll down → **Artifacts** section → download button ✅

**Sample artifact content (`htmlhint-report.json`):**
```json
[]
```
Empty array = 0 errors found = HTML is perfect ✅

---

## Task 4 — Download Artifacts Between Jobs

In my pipeline, **Lighthouse CI** produces an artifact that can be downloaded and viewed:

```yaml
name: Lighthouse CI
jobs:
  lighthouse:
    steps:
      - name: Run Lighthouse
        uses: treosh/lighthouse-ci-action@v11
        with:
          urls: |
            https://ec2.mdfahim.dev
          uploadArtifacts: true   # ← saves HTML report as artifact
```

**Download and view:** Actions → Lighthouse CI run → Artifacts → `lighthouse-results.zip` → open `lhr-*.html` in browser → full performance report

**Multi-job artifact passing example:**
```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Generate report
        run: echo "Build report" > report.txt
      - uses: actions/upload-artifact@v4
        with:
          name: build-report
          path: report.txt

  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: build-report
      - name: Read report
        run: cat report.txt
```

**When would you use artifacts in a real pipeline?**
- Save test reports so QA team can download and review
- Pass compiled binaries between build and deploy jobs
- Archive security scan results for compliance audits
- Save Lighthouse/performance reports for trend analysis over time
- Keep 90 days of scan history for security reviews

---

## Task 5 — Run Real Tests in CI

My pipeline runs **multiple real tests** on every push:

### Secret Scan — Gitleaks
```yaml
name: Secret Scan
on:
  push:
    branches: [main, staging]
jobs:
  secret-scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      - name: Run Gitleaks
        uses: gitleaks/gitleaks-action@v2
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```
**Pipeline goes red if:** any secret/API key/password found in code ✅

### HTML Quality — HTMLHint
```yaml
- name: Run HTMLHint
  run: htmlhint index.html
  # exits non-zero if HTML errors found → pipeline fails
```
**Pipeline goes red if:** invalid HTML structure ✅

### Dockerfile Lint — Hadolint
```yaml
- name: Lint Dockerfile
  uses: hadolint/hadolint-action@v3.1.0
  with:
    dockerfile: dockerfile
```
**Pipeline goes red if:** Dockerfile best practices violated ✅

**Intentionally breaking and fixing test:**

Break:
```html
<!-- Add invalid HTML to index.html -->
<div>unclosed tag
```
→ Push → HTMLHint fails → pipeline red ❌

Fix:
```html
<div>properly closed</div>
```
→ Push → HTMLHint passes → pipeline green ✅

---

## Task 6 — Caching

### Docker Layer Cache in `docker-push.yml`

```yaml
- name: Set up Docker Buildx
  uses: docker/setup-buildx-action@v3

- name: build and push
  uses: docker/build-push-action@v6
  with:
    cache-from: type=gha
    cache-to: type=gha,mode=max
```

**What is being cached?**
Docker image layers — each `FROM`, `RUN`, `COPY` instruction in the Dockerfile creates a layer. These layers are cached in GitHub Actions Cache storage.

**Where is it stored?**
GitHub Actions Cache — visible at: repo → Actions → **Caches** (left sidebar)

**Time difference observed:**

| Run | Cached % | Duration |
|-----|----------|----------|
| First run | 0% | ~45 seconds |
| Second run | 80%+ | ~13 seconds |

**Result: ~3x faster builds after first run ✅**

---

## What I Learned About Secrets Management

| Rule | Why |
|------|-----|
| Never print secret values | Logs are permanent and accessible |
| Use Variables for non-sensitive data | Username, repo names — visible is fine |
| Use Secrets for tokens/passwords | Always masked in logs |
| Rotate secrets regularly | If leaked, old token becomes useless |
| Use minimum permissions | Docker PAT with Read+Write only, not Delete |
| `fetch-depth: 0` for secret scanning | Gitleaks needs full history to scan all commits |

---

## Links

- **Live site:** https://ec2.mdfahim.dev
- **GitHub repo:** https://github.com/Fahim017803/mdfahim.dev
- **Docker Hub:** https://hub.docker.com/r/fahim017803/mdfahim.dev

---

*Part of [#90DaysOfDevOps](https://github.com/TrainWithShubham/90DaysOfDevOps) — Josh Batch 10*
*#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham*