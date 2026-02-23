# Day 23 – Git Branching & Working with GitHub

## Why Branching Matters

Branching allows isolated development.  
You can build features, test ideas, and fix bugs without breaking the main branch.

In real DevOps workflows:
- Every feature = separate branch
- Every fix = separate branch
- Pull Requests merge changes into main after review

---

# Task 1 – Understanding Branches

## What is a Branch in Git?

A branch is a movable pointer to a commit.
It represents an independent line of development.

## Why Use Branches Instead of Committing Everything to main?

- Prevents breaking production code
- Allows parallel development
- Enables code review before merging
- Keeps history clean and organized

## What is HEAD?

HEAD is a pointer to the current active branch.
It tells Git where you are working.

## What Happens When You Switch Branches?

- Working directory changes to match that branch’s latest commit
- Files that do not exist in that branch disappear
- Commits unique to other branches are not visible

---

# Task 2 – Branching Commands (Hands-On)

## List Branches

```bash
git branch
```

---

## Create New Branch

```bash
git branch feature-1
```

---

## Switch to feature-1

```bash
git checkout feature-1
```

OR modern way:

```bash
git switch feature-1
```

---

## Create & Switch in One Command

```bash
git checkout -b feature-2
```

OR modern way:

```bash
git switch -c feature-2
```

---

## Make a Commit on feature-1

Switch:

```bash
git switch feature-1
```

Edit a file.

```bash
git add git-commands.md
git commit -m "Add branching commands on feature-1"
```

---

## Switch Back to main

```bash
git switch main
```

Verify commit is not present:

```bash
git log --oneline
```

You will not see feature-1 commit here.

---

## Delete a Branch

```bash
git branch -d feature-2
```

Force delete (if needed):

```bash
git branch -D feature-2
```

---

# Task 3 – Push to GitHub

## Create Repository on GitHub

Important:
Do NOT initialize with README.

---

## Connect Local Repo to GitHub

```bash
git remote add origin https://github.com/your-username/devops-git-practice.git
```

Verify remote:

```bash
git remote -v
```

---

## Push main Branch

```bash
git push -u origin main
```

---

## Push feature-1 Branch

```bash
git push -u origin feature-1
```

Now both branches should be visible on GitHub.

---

## What is origin vs upstream?

origin:
Default name for your remote repository.

upstream:
Used when working with forks.
It refers to the original repository you forked from.

Example:

```bash
git remote add upstream https://github.com/original-owner/repo.git
```

---

# Task 4 – Pull from GitHub

Make change directly on GitHub (edit file in browser).

Then locally:

```bash
git pull origin main
```

---

## git fetch vs git pull

git fetch:
Downloads changes but does NOT merge.

git pull:
Fetches + automatically merges.

So:

pull = fetch + merge

---

# Task 5 – Clone vs Fork

## Clone a Public Repository

```bash
git clone https://github.com/some-user/some-repo.git
```

---

## Fork Repository (On GitHub Website)

Then clone your fork:

```bash
git clone https://github.com/your-username/some-repo.git
```

---

## Difference Between Clone and Fork

Clone:
Copies repository to your local machine.

Fork:
Creates a copy of repository under your GitHub account.

Clone = Git concept  
Fork = GitHub concept

---

## When To Use Clone vs Fork?

Clone:
When you just want local copy.

Fork:
When you want to contribute to someone else's repository.

---

## Keeping Fork in Sync

Add upstream:

```bash
git remote add upstream https://github.com/original-owner/repo.git
```

Fetch latest changes:

```bash
git fetch upstream
```

Merge upstream main:

```bash
git merge upstream/main
```

---

# Branching Workflow Model

```
main
  |
  |--- feature-1
  |
  |--- feature-2
```

Each branch starts from the commit you are currently on.

---

# Commands Learned Today

- git branch
- git checkout
- git checkout -b
- git switch
- git switch -c
- git branch -d
- git remote add
- git remote -v
- git push
- git push -u origin <branch>
- git pull
- git fetch
- git clone

Add all these to git-commands.md.

---

# DevOps Relevance

In real production:

- Developers create feature branches
- CI pipeline runs on every branch push
- Pull Requests merge into main
- main is production-ready branch

No professional team commits directly to main.

---

# Final Verification

Check branches:

```bash
git branch -a
```

Check history:

```bash
git log --oneline --graph --all
```

Push everything:

```bash
git push --all
```

---

# End of Day 23