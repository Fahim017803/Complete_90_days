# Day 43 – Jobs, Steps, Env Vars & Conditionals

## What I Learned Today

| Concept | Meaning |
|---------|---------|
| `needs:` | Run one job after another |
| `env:` | Store variables, use anywhere |
| `outputs:` | Pass data from one job to another |
| `if:` | Run a step/job only when a condition is met |

---

## Task 1: Multi-Job Workflow

### What does `needs:` do?
```
build succeeds → run test
test succeeds  → run deploy
build fails    → test and deploy won't run
```

### Workflow:
```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo "🔨 Building the app..."

  test:
    needs: [build]
    runs-on: ubuntu-latest
    steps:
      - run: echo "🧪 Running tests..."

  deploy:
    needs: [test]
    runs-on: ubuntu-latest
    steps:
      - run: echo "🚀 Deploying..."
```

### Dependency chain in Actions tab:
```
[build] → [test] → [deploy]
```

---

## Task 2: Environment Variables

### 3 levels of variables:
```
Workflow level → all jobs can access
      ↓
Job level      → only that job can access
      ↓
Step level     → only that step can access
```

### Workflow:
```yaml
env:
  APP_NAME: myapp              # Workflow level

jobs:
  print-vars:
    env:
      ENVIRONMENT: staging     # Job level
    steps:
      - env:
          VERSION: 1.0.0       # Step level
        run: |
          echo "App Name   : $APP_NAME"
          echo "Environment: $ENVIRONMENT"
          echo "Version    : $VERSION"
          echo "Commit SHA : ${{ github.sha }}"
          echo "Triggered by: ${{ github.actor }}"
```

### GitHub Context Variables:
```
${{ github.sha }}    → which commit triggered the run
${{ github.actor }}  → who pushed the code
```
GitHub provides these automatically — you don't need to set them.

---

## Task 3: Job Outputs

### Why do we need outputs?
```
Each job runs on a separate machine
So data cannot be shared directly
We use outputs: to pass data between jobs
```

### Formula:
```
Read output from a step:
steps.<step-id>.outputs.<name>

Read output from a job:
needs.<job-name>.outputs.<name>
```

### Workflow:
```yaml
jobs:
  create-output:
    outputs:
      today: ${{ steps.get-date.outputs.date }}
    steps:
      - id: get-date
        run: echo "date=$(date)" >> $GITHUB_OUTPUT

  use-output:
    needs: [create-output]
    steps:
      - run: echo "Date: ${{ needs.create-output.outputs.today }}"
```

### Real life use case:
```
job-1 → builds the app, generates a version number
job-2 → takes that version number, builds a Docker image
job-3 → deploys that image
```

---

## Task 4: Conditionals

### How does `if:` work?
```
if condition is true  → run step/job ✅
if condition is false → skip ⏭️
```

### 4 important conditionals:

#### 1. Run only on main branch:
```yaml
if: github.ref == 'refs/heads/main'
```

#### 2. Run only if previous step failed:
```yaml
if: failure()
```

#### 3. Run only on push events:
```yaml
if: github.event_name == 'push'
```

#### 4. Continue even if step fails:
```yaml
continue-on-error: true
```

### Real life use case:
```
deploy fails
      ↓
if: failure()
      ↓
send Slack notification to the team
```

---

## Task 5: Smart Pipeline

### Flow:
```
push to any branch
        ↓
lint ✅     test ✅    ← run in parallel
        ↓
    summary ✅         ← runs after both finish
        ↓
main branch?  → "✅ Main branch push!"
other branch? → "🌿 Feature branch push!"
              → "📝 Commit: <message>"
```

### Workflow:
```yaml
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - run: echo "🔍 Linting..."

  test:
    runs-on: ubuntu-latest
    steps:
      - run: echo "🧪 Testing..."

  summary:
    needs: [lint, test]
    runs-on: ubuntu-latest
    steps:
      - name: Branch Check
        run: |
          if [ "${{ github.ref }}" == "refs/heads/main" ]; then
            echo "✅ Main branch push!"
          else
            echo "🌿 Feature branch push!"
          fi

      - name: Commit Message
        run: echo "📝 Commit: ${{ github.event.commits[0].message }}"
```

---

## GitHub Context Variables — Quick Reference

| Variable | Meaning |
|----------|---------|
| `${{ github.ref }}` | Which branch am I on? |
| `${{ github.actor }}` | Who pushed? |
| `${{ github.sha }}` | Which commit? |
| `${{ github.event_name }}` | How was it triggered? |
| `${{ github.event.commits[0].message }}` | What is the commit message? |

---

*Day 43 of #90DaysOfDevOps | #DevOpsKaJosh | @TrainWithShubham*