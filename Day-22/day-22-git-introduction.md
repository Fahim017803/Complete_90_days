# Day 22 – Introduction to Git: Your First Repository

## What is Git?

Git is a distributed version control system.

It tracks changes in files, stores project history, and allows you to revert to previous versions.

In DevOps, Git is the foundation of CI/CD, collaboration, and infrastructure management.

---

# Task 1 – Install & Configure Git

## Verify Git Installation

```bash
git --version
```

If not installed:

Ubuntu:
```bash
sudo apt update
sudo apt install git
```

Mac (Homebrew):
```bash
brew install git
```

---

## Configure Git Identity

```bash
git config --global user.name "Md Mainul Islam Fahim"
git config --global user.email "your-email@example.com"
```

Verify configuration:

```bash
git config --list
```

---

# Task 2 – Create First Git Repository

## Create Project Folder

```bash
mkdir devops-git-practice
cd devops-git-practice
```

## Initialize Repository

```bash
git init
```

Check status:

```bash
git status
```

---

## Explore .git Directory

```bash
ls -a
```

You will see:
```
.git
```

The `.git` folder stores:
- commit history
- objects
- branches
- configuration

If deleted:
The folder becomes a normal directory and all Git history is lost.

---

# Task 3 – Git Commands Reference (git-commands.md)

Create file:

```bash
touch git-commands.md
```

Add:

```markdown
# Git Commands Reference

## Setup & Config

### git config
What it does: Sets Git user identity.
Example:
git config --global user.name "Fahim"

### git init
What it does: Initializes a Git repository.
Example:
git init

## Basic Workflow

### git status
What it does: Shows current repository state.
Example:
git status

### git add
What it does: Moves changes to staging area.
Example:
git add file.txt

### git commit
What it does: Saves staged changes to repository.
Example:
git commit -m "Initial commit"

## Viewing Changes

### git log
What it does: Shows commit history.
Example:
git log

### git log --oneline
What it does: Shows compact commit history.
Example:
git log --oneline

### git diff
What it does: Shows unstaged changes.
Example:
git diff

### git rm
What it does: Removes tracked file.
Example:
git rm file.txt
```

---

# Task 4 – Stage and Commit

Stage file:

```bash
git add git-commands.md
```

Check staged files:

```bash
git status
```

Commit:

```bash
git commit -m "Add initial git commands reference"
```

View history:

```bash
git log --oneline
```

---

# Task 5 – Build Commit History

Edit `git-commands.md`.

Add new commands.

Check changes:

```bash
git status
git diff
```

Stage:

```bash
git add git-commands.md
```

Commit:

```bash
git commit -m "Update git command reference"
```

Repeat at least 3 times to build history.

View compact history:

```bash
git log --oneline
```

---

# Task 6 – Git Workflow Understanding

Create:

```bash
touch day-22-notes.md
```

Add:

```markdown
# Day 22 Notes – Git Basics

## Difference Between git add and git commit

git add moves changes to staging area.
git commit saves staged changes permanently into repository history.

## What is the Staging Area?

The staging area is an intermediate layer between working directory and repository.
It allows selective commits instead of committing everything.

## What Does git log Show?

- Commit hash
- Author
- Date
- Commit message

## What is .git Folder?

It contains:
- commit objects
- branches
- repository metadata

If deleted, all version history is permanently lost.

## Working Directory vs Staging Area vs Repository

Working Directory:
Where files are edited.

Staging Area:
Where selected changes are prepared.

Repository:
Where committed snapshots are stored permanently.
```

---

# Git Workflow Model

```
Working Directory
        ↓
     git add
        ↓
   Staging Area
        ↓
    git commit
        ↓
    Repository
```

---

# Minimum Commands Mastered Today

- git init
- git status
- git add
- git commit
- git log
- git log --oneline
- git diff
- git config
- git rm

---

# DevOps Relevance

Git is used in:

- CI/CD pipelines
- Docker builds
- Infrastructure as Code (Terraform)
- Code reviews (Pull Requests)

Without Git, DevOps workflows do not function.

---

# Expected Final Result

You should have:

- A local Git repository
- Multiple commits
- Clean commit messages
- git-commands.md updated
- day-22-notes.md completed

Check history:

```bash
git log --oneline
```

Maintain one logical commit per change.

---

# End of Day 22