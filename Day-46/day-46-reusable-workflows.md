# Day 46 – Reusable Workflows & Composite Actions

## Overview

Today I learned how to stop repeating workflow logic across pipelines by building a **reusable workflow** (callable like a function via `workflow_call`) and a **composite action** (a packaged, reusable set of steps).

Applied this in my **github-actions-practice** repo: `github.com/Fahim017803/github-actions-practice`

---

## Task 1 — Understanding `workflow_call`

**What is a reusable workflow?**
A `.yml` file that doesn't run on its own triggers like `push` or `pull_request`. It only runs when another workflow calls it — like a function.

**What is the `workflow_call` trigger?**
A special `on:` trigger that makes a workflow *callable* from other workflows instead of self-triggering.

**How is calling a reusable workflow different from using a regular action (`uses:`)?**
An action is one reusable unit nested inside a job's `steps:`. A reusable workflow is called at the **job level** (`jobs.<id>.uses:`) and can bring its own full job(s), inputs, secrets, and outputs — much bigger scope than a single action.

**Where must a reusable workflow file live?**
`.github/workflows/` — same folder as any normal workflow, just with `workflow_call` instead of `push`/`pull_request`.

---

## Task 2 — Reusable Workflow

**File:** `.github/workflows/reusable-build.yml`

```yaml
name: Reusable Build Workflow

on:
  workflow_call:
    inputs:
      app_name:
        type: string
        required: true
      environment:
        type: string
        required: false
        default: staging
    secrets:
      docker_token:
        required: true

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - run: echo "Building ${{ inputs.app_name }} for ${{ inputs.environment }}"

      - env:
          DOCKER_TOKEN: ${{ secrets.docker_token }}
        run: |
          if [ -n "$DOCKER_TOKEN" ]; then
            echo "Docker token is set: true"
          else
            echo "Docker token is set: false"
          fi
```

**Verify:** This file alone doesn't run — confirmed in the Actions tab that it stays idle with no triggers until a caller references it ✅

---

## Task 3 — Caller Workflow

**File:** `.github/workflows/call-build.yml`

```yaml
name: Call Build Workflow

on:
  push:
    branches: [main]

jobs:
  build:
    uses: ./.github/workflows/reusable-build.yml
    with:
      app_name: "my-web-app"
      environment: "production"
    secrets:
      docker_token: ${{ secrets.DOCKER_TOKEN }}
```

**Secrets configured in GitHub:**

| Type | Name | Value |
|------|------|-------|
| Secret | `DOCKER_TOKEN` | Placeholder token for this exercise |

**Verify:** GitHub Actions → `Call Build Workflow` run → `build` job shown nested inside the caller, with `app_name`/`environment` printed in the log ✅

---

## Task 4 — Outputs

Extended `reusable-build.yml` to expose a `build_version` output:

```yaml
on:
  workflow_call:
    inputs:
      app_name:
        type: string
        required: true
      environment:
        type: string
        required: false
        default: staging
    secrets:
      docker_token:
        required: true
    outputs:
      build_version:
        value: ${{ jobs.build.outputs.build_version }}

jobs:
  build:
    runs-on: ubuntu-latest
    outputs:
      build_version: ${{ steps.version.outputs.version }}
    steps:
      - uses: actions/checkout@v4

      - run: echo "Building ${{ inputs.app_name }} for ${{ inputs.environment }}"

      - env:
          DOCKER_TOKEN: ${{ secrets.docker_token }}
        run: |
          if [ -n "$DOCKER_TOKEN" ]; then
            echo "Docker token is set: true"
          else
            echo "Docker token is set: false"
          fi

      - id: version
        run: echo "version=v1.0-$(git rev-parse --short HEAD)" >> "$GITHUB_OUTPUT"
```

Added a second job to `call-build.yml` to read it:

```yaml
  show-version:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - run: echo "Build version was ${{ needs.build.outputs.build_version }}"
```

**Verify:** `show-version` job log printed `Build version was v1.0-<short-sha>` ✅

---

## Task 5 — Composite Action

**File:** `.github/actions/setup-and-greet/action.yml`

```yaml
name: "Setup and Greet"
description: "Greets a user in their chosen language and prints runner info"

inputs:
  name:
    required: true
  language:
    required: false
    default: en

outputs:
  greeted:
    value: ${{ steps.greet.outputs.greeted }}

runs:
  using: "composite"
  steps:
    - name: Greet
      id: greet
      shell: bash
      run: |
        case "${{ inputs.language }}" in
          en) echo "Hello, ${{ inputs.name }}!" ;;
          bn) echo "হ্যালো, ${{ inputs.name }}!" ;;
          es) echo "¡Hola, ${{ inputs.name }}!" ;;
          *) echo "Hi, ${{ inputs.name }}!" ;;
        esac
        echo "greeted=true" >> "$GITHUB_OUTPUT"

    - name: Show date and runner OS
      shell: bash
      run: |
        echo "Current date: $(date)"
        echo "Runner OS: ${{ runner.os }}"
```

**Used in a workflow:**

```yaml
name: Test Composite Action
on: workflow_dispatch

jobs:
  greet:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: ./.github/actions/setup-and-greet
        with:
          name: "Fahim"
          language: "bn"
```

**Verify:** Triggered manually via `workflow_dispatch` → log printed the Bengali greeting, current date, and `Runner OS: Linux` ✅

---

## Task 6 — Reusable Workflow vs Composite Action

| | Reusable Workflow | Composite Action |
|---|---|---|
| Triggered by | `workflow_call` | `uses:` inside a step |
| Can contain jobs? | Yes — one or more full jobs | No — steps only |
| Can contain multiple steps? | Yes, within its job(s) | Yes |
| Lives where? | `.github/workflows/*.yml` | `.github/actions/<name>/action.yml` |
| Can accept secrets directly? | Yes, via a `secrets:` block | No — only as a plain input |
| Best for | Sharing an entire pipeline/job sequence across repos | Sharing a repeated chunk of steps inside a single job |

---

## Full Journey: Push → Reusable Workflow → Output

```
Step 1: Push to main
        git push origin main

Step 2: call-build.yml triggers
        → job "build" calls reusable-build.yml
            → checkout code
            → print app_name + environment
            → confirm DOCKER_TOKEN secret is set
            → generate build_version (v1.0-<short-sha>)
        → job "show-version" (needs: build)
            → reads build_version output from the reusable workflow
            → prints it to the log

Step 3: Composite action tested separately
        → workflow_dispatch on Test Composite Action
        → setup-and-greet action runs inside the job
        → prints greeting + date + runner OS
```

---

## What I Learned

| Concept | What I Learned |
|---------|----------------|
| `workflow_call` | Turns a workflow into something other workflows can call, like a function |
| Reusable workflow inputs/secrets | Declared once in `workflow_call`, passed in by the caller via `with:`/`secrets:` |
| Reusable workflow outputs | Job-level output bubbles up via `value: ${{ jobs.<id>.outputs.<name> }}` |
| `needs:` | Lets a later job consume outputs from an earlier (even reusable) job |
| Composite actions | Package multiple steps into one `uses:` call, scoped to a single job |
| `shell: bash` in composite steps | Required explicitly — not inherited like in normal jobs |
| Reusable workflow vs composite action | Workflow-level reuse (jobs) vs step-level reuse (snippets) |

---

## Links

- **Repo:** https://github.com/Fahim017803/github-actions-practice

---

*Part of [#90DaysOfDevOps](https://github.com/TrainWithShubham/90DaysOfDevOps) — Josh Batch 10*
*#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham*
