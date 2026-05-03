# Day 42 – GitHub Actions Runners: GitHub-Hosted & Self-Hosted

## 📌 Overview

Every GitHub Actions job needs a **runner** — a machine that actually executes the workflow steps. Today I explored two types:
- **GitHub-Hosted Runners** — managed by GitHub, ready to use
- **Self-Hosted Runners** — your own machine/VM registered to your repo

---

## ✅ Task 1: GitHub-Hosted Runners (Multi-OS)

**Workflow:** `.github/workflows/multi-os.yml`

Created a workflow with **3 parallel jobs**, each on a different OS:

| Job | OS | Runner |
|-----|----|--------|
| ubuntu-job | `ubuntu-latest` | GitHub-hosted Ubuntu VM |
| windows-job | `windows-latest` | GitHub-hosted Windows VM |
| macos-job | `macos-latest` | GitHub-hosted macOS VM |

Each job prints: OS name, hostname, and current user.

### 📸 Screenshot – 3 Jobs Running in Parallel
> *(Add screenshot of Actions tab showing 3 jobs running simultaneously)*

### 📝 Notes: What is a GitHub-Hosted Runner?

A **GitHub-hosted runner** is a virtual machine (VM) provided and fully managed by GitHub. When a workflow is triggered:
- GitHub automatically spins up a fresh VM
- Your job runs on it
- The VM is destroyed after the job completes

**Who manages it?** → **GitHub** manages everything — the hardware, OS updates, software installation, scaling, and security. You just write the workflow YAML and GitHub does the rest.

---

## ✅ Task 2: Pre-installed Tools on ubuntu-latest

**Workflow:** `.github/workflows/check-tools.yml`

On `ubuntu-latest`, I printed the versions of pre-installed tools:

```
🐳 Docker Version  : Docker 24.x.x
🐍 Python Version  : Python 3.12.x
🟢 Node Version    : v20.x.x
📦 Git Version     : git version 2.x.x
```

### 📸 Screenshot – Tool Versions Output
> *(Add screenshot of the job logs showing all version outputs)*

### 📝 Notes: Why Pre-installed Tools Matter

GitHub-hosted runners come with hundreds of tools **already installed** — Docker, Python, Node.js, Git, Java, Maven, AWS CLI, kubectl, and many more.

**Why does this matter?**
- ✅ **No setup time** — you don't need to install tools in every job
- ✅ **Faster pipelines** — skip lengthy installation steps
- ✅ **Less YAML** — your workflow stays clean and focused
- ✅ **Consistency** — everyone on the team gets the same environment
- ✅ **Maintained by GitHub** — tools are kept reasonably up to date

Full list of pre-installed software: [GitHub Docs – ubuntu-latest](https://docs.github.com/en/actions/using-github-hosted-runners/using-github-hosted-runners/about-github-hosted-runners#supported-runners-and-hardware-resources)

---

## ✅ Task 3: Self-Hosted Runner Setup

Registered a self-hosted runner on my **EC2 instance** (Tokyo region):
- **EC2:** `ubuntu@ec2-13-113-18-154.ap-northeast-1.compute.amazonaws.com`
- **Runner Name:** `Fahim`
- **Install Path:** `~/CI-CD/actions-runner`

### Steps Followed

```bash
# 1. Go to: GitHub Repo → Settings → Actions → Runners → New self-hosted runner
# 2. Select: Linux, x64

# On EC2:
mkdir -p ~/CI-CD/actions-runner && cd ~/CI-CD/actions-runner

# Download runner
curl -o actions-runner-linux-x64.tar.gz -L \
  https://github.com/actions/runner/releases/download/v2.x.x/actions-runner-linux-x64.tar.gz

tar xzf ./actions-runner-linux-x64.tar.gz

# Configure (token from GitHub)
./config.sh --url https://github.com/Fahim017803/mdfahim.dev --token <YOUR_TOKEN>

# Start runner
./run.sh

# OR install as persistent service:
sudo ./svc.sh install
sudo ./svc.sh start
```

### 📸 Screenshot – Runner Showing as Idle
> *(Add screenshot of GitHub → Settings → Actions → Runners showing green "Idle" dot)*

---

## ✅ Task 4: Using the Self-Hosted Runner

**Workflow:** `.github/workflows/self-hosted.yml`

```yaml
runs-on: self-hosted
```

Steps performed:
1. ✅ Printed hostname of my EC2 machine
2. ✅ Printed working directory (`pwd`)
3. ✅ Created `day42-selfhosted-test.txt` and verified it exists on EC2

### Verify File on EC2

After the workflow ran, I SSH'd into EC2 and confirmed:

```bash
ssh -i Batch-10-server-1-key.pem ubuntu@ec2-13-113-18-154.ap-northeast-1.compute.amazonaws.com
ls ~/CI-CD/actions-runner/_work/mdfahim.dev/mdfahim.dev/
cat day42-selfhosted-test.txt
# Output: Hello from GitHub Actions Self-Hosted Runner! - <date>
```

### 📸 Screenshot – Job Running on Self-Hosted Runner
> *(Add screenshot of workflow run showing hostname matching your EC2)*

---

## ✅ Task 5: Runner Labels

**Workflow:** `.github/workflows/labeled-runner.yml`

### Adding a Label to the Runner

```bash
# During config.sh setup, add label:
./config.sh --url https://github.com/Fahim017803/mdfahim.dev \
            --token <TOKEN> \
            --labels my-linux-runner

# OR re-configure existing runner with label via GitHub UI:
# Settings → Actions → Runners → Click runner → Edit → Add label
```

### Using the Label in Workflow

```yaml
runs-on: [self-hosted, my-linux-runner]
```

✅ The job was picked up correctly by the runner with label `my-linux-runner`.

### 📝 Notes: Why Are Labels Useful?

When you have **multiple self-hosted runners**, labels let you:

| Situation | Without Labels | With Labels |
|-----------|---------------|-------------|
| Different OS machines | Any runner picks up job ❌ | Target `[self-hosted, linux]` ✅ |
| High-memory jobs | Might run on weak VM ❌ | Target `[self-hosted, high-memory]` ✅ |
| GPU workloads | Runs on any machine ❌ | Target `[self-hosted, gpu]` ✅ |
| Staging vs Production | No separation ❌ | Target `[self-hosted, staging]` ✅ |

Labels give you **fine-grained control** over which runner handles which job.

---

## ✅ Task 6: GitHub-Hosted vs Self-Hosted Comparison

| Feature | GitHub-Hosted | Self-Hosted |
|---------|--------------|-------------|
| **Who manages it?** | GitHub manages everything (OS, updates, scaling) | You manage the machine, OS, and maintenance |
| **Cost** | Free for public repos; minutes-based billing for private | Free to run — you pay only for your VM/hardware |
| **Pre-installed tools** | Many tools pre-installed (Docker, Python, Node, Git, etc.) | Only what you install yourself |
| **Good for** | Standard CI/CD, open source, most projects | Long-running jobs, GPU tasks, private network access, custom environments |
| **Security concern** | Isolated VM, destroyed after job — very safe | Your machine is persistent; malicious PRs could run code on it |
| **Speed** | Depends on GitHub infrastructure | Depends on your hardware — can be faster with powerful VMs |
| **Setup time** | Zero — just use `runs-on: ubuntu-latest` | Requires installing and registering the runner agent |
| **Customization** | Limited — standard images only | Full control over environment and software |

---

## 📁 Workflow Files Created

| File | Purpose |
|------|---------|
| `.github/workflows/multi-os.yml` | Task 1 – 3 parallel jobs on Ubuntu, Windows, macOS |
| `.github/workflows/check-tools.yml` | Task 2 – Print pre-installed tool versions on ubuntu-latest |
| `.github/workflows/self-hosted.yml` | Task 4 – Job running on self-hosted EC2 runner |
| `.github/workflows/labeled-runner.yml` | Task 5 – Job targeting runner by label `my-linux-runner` |

---

## 🧠 Key Takeaways

1. **GitHub-hosted runners** are the easiest way to get started — zero setup, many tools pre-installed
2. **Self-hosted runners** give you control over hardware, environment, and cost
3. **Labels** are essential when managing multiple runners for different purposes
4. Self-hosted runners are great for **private network access**, **GPU workloads**, or **cost savings** on long jobs
5. Always consider **security** — use `if: github.event_name != 'pull_request'` or restrict to trusted branches when using self-hosted runners

---

*Day 42 of #90DaysOfDevOps | #DevOpsKaJosh | @TrainWithShubham*