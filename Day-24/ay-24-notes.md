# Day 24 – Advanced Git: Merge, Rebase, Stash & Cherry Pick

## Overview
Today I practiced advanced Git workflows: Merge, Rebase, Squash, Stash, and Cherry-pick.  
Goal: Understand how branches integrate and how history is managed properly.

---

# 1️⃣ Git Merge

## Fast-Forward Merge

```bash
git checkout main
git pull origin main

git switch -c feature-login

echo "Login page v1" > login.txt
git add .
git commit -m "Add login file"

echo "Add validation" >> login.txt
git add .
git commit -m "Add validation logic"

git switch main
git merge feature-login
```

### Observation
Git performed a fast-forward merge.

### What is a Fast-Forward Merge?
When main has no new commits and feature branch is directly ahead, Git moves the main pointer forward. No merge commit is created.

---

## Merge Commit Scenario

```bash
git switch -c feature-signup

echo "Signup v1" > signup.txt
git add .
git commit -m "Add signup file"

git switch main
echo "Hotfix on main" > hotfix.txt
git add .
git commit -m "Hotfix on main"

git merge feature-signup
```

### Observation
Git created a merge commit because both branches had new commits.

### When does Git create a merge commit?
When histories diverge and Git must combine them.

---

## Merge Conflict

```bash
git merge feature-branch
```

Conflict markers example:

```
<<<<<<< HEAD
main change
=======
feature change
>>>>>>> feature-branch
```

Resolve manually:

```bash
git add .
git commit
```

### What is a merge conflict?
It occurs when Git cannot automatically decide which change to keep.

---

# 2️⃣ Git Rebase

```bash
git switch -c feature-dashboard

echo "Dashboard v1" > dashboard.txt
git add .
git commit -m "Add dashboard"

echo "Improve UI" >> dashboard.txt
git add .
git commit -m "Improve UI"

git switch main
echo "Main improvement" > main-update.txt
git add .
git commit -m "Main update"

git switch feature-dashboard
git rebase main
```

Check history:

```bash
git log --oneline --graph --all
```

### What does rebase do?
Rebase replays your commits on top of the updated main branch and rewrites commit history.

### Merge vs Rebase
Merge → Non-linear history  
Rebase → Linear history  

### Why not rebase shared commits?
Because rebase changes commit hashes and breaks collaborators’ history.

### When to use rebase?
Before creating a pull request to clean history.

---

# 3️⃣ Squash vs Regular Merge

## Squash Merge

```bash
git switch -c feature-profile

echo "Profile v1" > profile.txt
git add .
git commit -m "Add profile"

echo "Fix typo" >> profile.txt
git add .
git commit -m "Fix typo"

echo "Format file" >> profile.txt
git add .
git commit -m "Format"

git switch main
git merge --squash feature-profile
git commit -m "Add profile feature (squashed)"
```

Result: Only one commit added to main.

### What does squash do?
It combines multiple commits into one before merging.

Trade-off: Cleaner history but lose detailed commit breakdown.

---

## Regular Merge

```bash
git switch -c feature-settings

echo "Settings v1" > settings.txt
git add .
git commit -m "Add settings"

git switch main
git merge feature-settings
```

Result: All commits preserved.

---

# 4️⃣ Git Stash

Uncommitted change:

```bash
echo "Temporary work" >> login.txt
```

Save work:

```bash
git stash push -m "WIP login changes"
```

Switch branch:

```bash
git switch main
```

Restore:

```bash
git switch feature-login
git stash pop
```

List stashes:

```bash
git stash list
```

Apply specific stash:

```bash
git stash apply stash@{1}
```

### pop vs apply
pop → Apply and remove stash  
apply → Apply but keep stash  

---

# 5️⃣ Cherry Pick

```bash
git switch -c feature-hotfix

echo "Fix 1" > fix.txt
git add .
git commit -m "Fix 1"

echo "Fix 2" >> fix.txt
git add .
git commit -m "Fix 2"

echo "Fix 3" >> fix.txt
git add .
git commit -m "Fix 3"

git switch main
git log --oneline
```

Copy second commit hash:

```bash
git cherry-pick <commit-hash>
```

Verify:

```bash
git log --oneline
```

### What does cherry-pick do?
It applies one specific commit from another branch onto the current branch.

### Risks
Conflicts, duplicate changes, messy history.

---

# Summary

Fast-forward → Pointer moves  
Merge commit → Combine diverged histories  
Rebase → Rewrite history linearly  
Squash → Compress commits  
Stash → Temporary storage  
Cherry-pick → Selective commit transfer  

---

# Commands Used

```bash
git merge
git merge --squash
git rebase
git stash
git stash list
git stash pop
git stash apply
git cherry-pick
git log --oneline --graph --all
```

---

# Final Commit

```bash
git add 2026/day-24/day-24-notes.md
git commit -m "Day 24 - Advanced Git"
git push origin main
```
