# Day 39 – CI/CD Concepts

---

## 📌 Task 1: The Problem

### What can go wrong?

- Code conflicts when multiple devs push
- Bugs go to production
- Manual deployment errors
- No consistent testing
- Different environments → different results

---

### "It works on my machine" meaning

Code runs on developer’s local machine but fails in production.

Reason:
- Different OS / dependencies / environment

Why it's a problem:
- Unpredictable behavior
- Hard debugging
- Slows team down

---

### Manual deployment limit

- Safe: 1–2 times per day (even this is risky)
- More than that → high chance of breaking production

---

## 📌 Task 2: CI vs CD

### Continuous Integration (CI)

- Developers frequently push code to shared repo
- Code is automatically built and tested
- Catches bugs early

Example:
- Push code → tests run automatically via GitHub Actions

---

### Continuous Delivery (CD)

- Code is always ready to deploy
- Deployment requires manual approval

Example:
- Build + test passes → click "Deploy" button

---

### Continuous Deployment

- Fully automated deployment
- Every successful change goes to production

Example:
- Push → test → auto deploy live

---

## 📌 Task 3: Pipeline Anatomy

### Trigger
- Event that starts pipeline (push, pull request)

### Stage
- Major phase (build, test, deploy)

### Job
- Group of steps inside a stage

### Step
- Single command (run test, build image)

### Runner
- Machine that executes jobs

### Artifact
- Output (build files, Docker image)

---

## 📌 Task 4: Pipeline Diagram

Text-based pipeline:

```text
Developer Push Code
        ↓
   [Trigger]
        ↓
   ┌───────────┐
   │  Build    │
   │ install   │
   │ compile   │
   └───────────┘
        ↓
   ┌───────────┐
   │   Test    │
   │ unit test │
   │ lint      │
   └───────────┘
        ↓
   ┌───────────────┐
   │   Deploy      │
   │ Docker build  │
   │ push image    │
   │ deploy stage  │
   └───────────────┘