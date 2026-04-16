# Day 38 – YAML Basics

---

## 📌 Task 1 & 2: person.yaml

```yaml
name: Md Mainul Islam Fahim
role: DevOps Learner
experience_years: 1
learning: true

tools:
  - docker
  - git
  - linux
  - github-actions
  - aws

hobbies: [coding, problem-solving, traveling]
```

---

## 📌 Task 2 Answer

Two ways to write lists in YAML:

Block style:

```yaml
tools:
  - docker
  - kubernetes
```

Inline style:

```yaml
tools: [docker, kubernetes]
```

---

## 📌 Task 3 & 4: server.yaml

```yaml
server:
  name: web-server
  ip: 192.168.1.10
  port: 80

database:
  host: localhost
  name: mydb
  credentials:
    user: admin
    password: secret123

startup_script_literal: |
  echo "Starting server..."
  docker compose up -d
  echo "Server started"

startup_script_folded: >
  echo "Starting server..."
  docker compose up -d
  echo "Server started"
```

---

## 📌 Task 4 Answer

| → preserves line breaks (used for scripts)

> → merges lines into one line (used for long text)

---

## 📌 Task 5: Validation

Broken (TAB used):

```yaml
server:
	name: web-server
```

Error:

* found character '\t' that cannot start any token
* bad indentation

Fixed:

```yaml
server:
  name: web-server
```

---

## 📌 Task 6: Spot the Error

Broken:

```yaml
name: devops
tools:
- docker
  - kubernetes
```

Correct:

```yaml
name: devops
tools:
  - docker
  - kubernetes
```

---

## 🧠 What I Learned

1. YAML uses spaces only — tabs break everything
2. Indentation defines structure
3. Lists can be block (-) or inline []

---

## 🚀 Final Takeaway

YAML is strict.
One wrong indentation = full failure.
