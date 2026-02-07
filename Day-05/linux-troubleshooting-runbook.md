# Linux Troubleshooting Runbook
## Day 05 – CPU, Memory, and Logs Drill

### Target Service
**Service inspected:** SSH  

This drill builds on Day-02 where process and systemd behavior were practiced.  
**Objective:** Capture system health using a structured troubleshooting approach before taking action.

---

## Initial Triage Commands

    df -h
    top
    systemctl status ssh
    ss -ltnp
    journalctl -xe

---

## 1. Environment Basics

**Command**
    uname -a  

**Meaning:** `-a` = show all system information  

**Observation**
- Kernel version and architecture confirmed.

---

**Command**
    cat /etc/os-release  

**Meaning:** `cat` = read and display file content  

**Observation**
- OS distribution and version verified.

---

## 2. Filesystem Sanity Check

**Commands**
    mkdir /tmp/runbook-demo  
    cp /etc/hosts /tmp/runbook-demo/hosts-copy  
    ls -l /tmp/runbook-demo  

**Meaning**
- `mkdir` = create directory  
- `cp` = copy files  
- `ls` = list directory contents  
- `-l` = long format (permissions, owner, size, timestamp)

**Observation**
- File operations functioning normally.  
- No permission or filesystem errors detected.

---

## 3. Snapshot: CPU & Memory

**Command**
    top  

**Meaning:** Real-time process and resource monitor  

**Observation**
- CPU usage stable.  
- No abnormal resource consumption from SSH.

---

**Command**
    ps -o pid,pcpu,pmem,comm -p $(pgrep sshd)

**Meaning**
- `ps` = process status  
- `-o` = custom output format  
- `-p` = specify PID  
- `pgrep` = locate process by name  

**Fields**
- `pid` → process ID  
- `pcpu` → CPU usage  
- `pmem` → memory usage  
- `comm` → command name  

**Observation**
- SSH consuming minimal CPU and memory.

---

## 4. Snapshot: Disk & IO

**Command**
    df -h  

**Meaning**
- `df` = filesystem disk usage  
- `-h` = human readable  

**Observation**
- Adequate disk space available.

---

**Command**
    du -sh /var/log  

**Meaning**
- `du` = disk usage  
- `-s` = summarized total  
- `-h` = human readable  

**Observation**
- Log directory size within normal limits.

---

## 5. Snapshot: Network

**Command**
    ss -tulpn  

**Meaning**
- `ss` = socket statistics  
- `-t` TCP  
- `-u` UDP  
- `-l` listening ports  
- `-p` process info  
- `-n` numeric output  

**Observation**
- SSH listening on the expected port.

---

**Command**
    curl -I http://localhost  

**Meaning**
- `curl` = transfer data from server  
- `-I` = fetch headers only  

**Observation**
- Local network responding correctly.

---

## 6. Logs Reviewed

**Command**
    journalctl -u ssh -n 50  

**Meaning**
- `journalctl` = view systemd logs  
- `-u` = filter by service  
- `-n` = last N entries  

**Observation**
- No recent SSH errors detected.

---

**Command**
    tail -n 50 /var/log/syslog  

**Meaning**
- `tail` = show end of file  
- `-n` = number of lines  

**Observation**
- System activity appears normal.

---

## Quick Findings
- CPU and memory stable  
- Disk healthy  
- Network ports active  
- Logs clean  
- SSH operating normally  

---

## If This Worsens (Next Steps)
1. Restart SSH and monitor logs  
2. Increase log verbosity  
3. Capture deeper metrics using `strace` or `vmstat`

---

## Reflection
Day-02 built foundational knowledge of processes and services.  
Day-05 reinforced applying that knowledge through a structured troubleshooting workflow.
