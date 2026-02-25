# 11️⃣ Git Complete State Transitions (Full State Machine)

Git has 3 core areas:

1. Working Directory
2. Staging Area (Index)
3. Commit (Repository / HEAD)

---

# 🔵 Forward Flow (Normal Workflow)

Untracked → Staged → Commit

```bash
git add file.txt              # Untracked → Staged
git commit -m "message"       # Staged → Commit
```

---

# 🔁 Backward / Undo Transitions

## 1️⃣ Commit → Staged

```bash
git reset --soft HEAD~1
```

- Removes commit
- Keeps changes staged

---

## 2️⃣ Commit → Working (Unstaged)

```bash
git reset --mixed HEAD~1
```

- Removes commit
- Moves changes to working directory
- Not staged

(Default reset)

---

## 3️⃣ Commit → Deleted (Danger)

```bash
git reset --hard HEAD~1
```

- Removes commit
- Deletes changes completely

⚠ Destructive

---

## 4️⃣ Staged → Working (Unstage File)

```bash
git restore --staged file.txt
```

or

```bash
git reset file.txt
```

Effect:
Staged → Working

---

## 5️⃣ Staged → Untracked (Remove from Git Tracking)

```bash
git rm --cached file.txt
```

Effect:
Staged → Untracked  
File still exists in working directory.

---

## 6️⃣ Working (Modified) → Commit Version (Discard Changes)

```bash
git restore file.txt
```

or old way:

```bash
git checkout -- file.txt
```

Effect:
Working → Commit snapshot

---

## 7️⃣ Working → Deleted (Remove Untracked Files)

```bash
git clean -f
```

Effect:
Deletes untracked files permanently.

Preview first:

```bash
git clean -n
```

---

## 8️⃣ Commit → Safe Undo (History Preserved)

```bash
git revert <commit-id>
```

Effect:
Creates new commit that reverses changes  
History remains intact  

Safe for shared branches.

---

## 9️⃣ Working → Temporary Storage

```bash
git stash
git stash list
git stash pop
```

Working → stash stack → Working

---

# 🧠 Full State Diagram

```
Untracked
   │ git add
   ▼
Staged
   │ git commit
   ▼
Commit (HEAD)
```

Undo / Movement Paths:

```
Commit --soft--> Staged
Commit --mixed--> Working
Commit --hard--> Deleted
Staged --restore--> Working
Staged --rm --cached--> Untracked
Working --restore--> Commit snapshot
Working --clean--> Deleted
Commit --revert--> New opposite commit
Working --stash--> Stash stack
```

---

# 🔎 Extra Safety Tool

```bash
git reflog
```

Shows every HEAD movement  
Can recover after hard reset.

---

# 🧠 Mental Model

Working = Editing zone  
Staging = Preparing snapshot  
Commit = Permanent snapshot  

Reset = Move HEAD backward  
Revert = Add opposite commit  
Restore = Discard changes  
Clean = Delete untracked files  
Stash = Temporary shelf  

## Direct Answers (Task Compliance)

Should you use reset on pushed commits?
No. It rewrites history and breaks collaborators.

Is reverted commit still visible?
Yes. Revert creates a new commit that negates changes but keeps history intact.

Which reset is destructive?
--hard, because it deletes working directory changes.

Startup strategy?
GitHub Flow.

Large team with scheduled releases?
GitFlow.