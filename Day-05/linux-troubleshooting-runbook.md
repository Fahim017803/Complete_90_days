# Linux Troubleshooting Runbook
Day 05 – CPU, Memory, and Logs Drill

## Target Service
Service inspected: ssh

This drill builds on Day-02 where I practiced process and systemd behavior.  
Today I followed a structured approach to capture system health before taking action.

---

## Environment Basics

Command:
uname -a  

Observation:
- Confirmed Linux kernel version and architecture.

Command:
cat /etc/os-release  

Observation:
- Verified OS distribution and version.

---

## Filesystem Sanity Check

Command:
mkdir /tmp/runbook-demo  

Command:
cp /etc/hosts /tmp/runbook-demo/hosts-copy  

Command:
ls -l /tmp/runbook-demo  

Observation:
- File operations working correctly.
- No permission or filesystem issues.

---

## Snapshot: CPU & Memory

Command:
top  

Observation:
- CPU usage stable.
- No abnormal spikes from ssh process.

Command:
ps -o pid,pcpu,pmem,comm -p $(pgrep sshd)  

Observation:
- ssh service consuming minimal CPU and memory.

---

## Snapshot: Disk & IO

Command:
df -h  

Observation:
- Sufficient disk space available.

Command:
du -sh /var/log  

Observation:
- Log size within normal range.

---

## Snapshot: Network

Command:
ss -tulpn  

Observation:
- ssh listening on expected port.

Command:
curl -I http://localhost  

Observation:
- Network responding normally.

---

## Logs Reviewed

Command:
journalctl -u ssh -n 50  

Observation:
- No recent errors found.

Command:
tail -n 50 /var/log/syslog  

Observation:
- Normal system activity recorded.

---

## Quick Findings
- CPU and memory usage stable
- Disk space healthy
- Network ports active
- No critical log errors
- ssh service functioning normally

---

## If This Worsens (Next Steps)
1. Restart ssh service safely and monitor logs
2. Increase log verbosity for deeper analysis
3. Capture process metrics using advanced tools (strace / vmstat)

---

## Reflection
Day-02 helped me understand processes and services.  
Day-05 helped me apply that knowledge in a structured troubleshooting scenario.
