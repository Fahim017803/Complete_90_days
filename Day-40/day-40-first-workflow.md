# Day 40 – Your First GitHub Actions Workflow

---

# 📌 Task 1: Set Up

## Repository Created

Public GitHub repository name:

github-actions-practice

## Cloned Locally

```bash
git clone https://github.com/YOUR_USERNAME/github-actions-practice.git
cd github-actions-practice
```

## Created Workflow Folder

```bash
mkdir -p .github/workflows
```

---

# 📌 Task 2: Hello Workflow

Created file:

`.github/workflows/hello.yml`

## Workflow Code

```yaml
name: Hello Workflow

on:
  push:

jobs:
  greet:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Print Hello
        run: echo "Hello from GitHub Actions!"
```

## Result After Push

* GitHub Actions triggered automatically
* Workflow started
* Pipeline passed successfully ✅

---

# 📌 Task 3: Understand the Anatomy

## on:

Defines trigger event.

```yaml
on:
  push:
```

Runs on every push.

## jobs:

Contains all jobs.

## runs-on:

Defines runner machine.

```yaml
runs-on: ubuntu-latest
```

## steps:

Commands/actions run sequentially.

## uses:

Uses prebuilt GitHub Action.

```yaml
uses: actions/checkout@v4
```

## run:

Runs shell command.

```yaml
run: echo "Hello"
```

## name:

Readable label for workflow/job/step.

---

# 📌 Task 4: Add More Steps

Updated workflow:

```yaml
name: Hello Workflow

on:
  push:

jobs:
  greet:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Print Hello
        run: echo "Hello from GitHub Actions!"

      - name: Show date and time
        run: date

      - name: Show branch name
        run: echo "Branch: ${{ github.ref_name }}"

      - name: List repo files
        run: ls -la

      - name: Show operating system
        run: uname -a
```

## Result

Logs displayed:

* Current time
* Branch name
* Files in repo
* Linux OS details

Pipeline green ✅

---

# 📌 Task 5: Break It On Purpose

Added failing step:

```yaml
- name: Force Fail
  run: exit 1
```

## Result

Pipeline failed ❌

Error log:

```text
Error: Process completed with exit code 1
```

## What Failed Pipeline Looks Like

* Red X mark
* Failed step highlighted
* Later steps stopped

## How to Read Error

1. Open Actions tab
2. Click failed run
3. Click failed step
4. Read logs

## Fix

Removed failing step and pushed again.

Pipeline became green ✅

---

# 📌 Screenshot
![alt text](image.png)

---

# 📌 Final Learnings

1. Git push can trigger automation
2. YAML controls workflow behavior
3. GitHub provides cloud runner machine
4. Logs help debugging
5. Red pipeline is useful, not bad

---

# 📌 Final Takeaway

This was my first real CI/CD pipeline.

Push code → GitHub runs job → steps execute → result shown automatically.
