# Day 07 – Linux File System Hierarchy & Scenario-Based Practice

Today I learned where important files live in Linux and practiced solving real-world troubleshooting scenarios like a DevOps engineer.

---

# Part 1 — Linux File System Hierarchy

## / (Root)
**Purpose:**  
The root directory is the starting point of the entire Linux file system. Everything branches from here.

**Command:**  
ls -l /

**Observation:**  
I saw directories like bin, etc, home, var.

**I would use this when:**  
Navigating the system or understanding overall structure.

---

## /home
**Purpose:**  
Stores personal directories for each user.

**Command:**  
ls -l /home

**Observation:**  
Found user folders.

**I would use this when:**  
Managing user files or debugging permission issues.

---

## /root
**Purpose:**  
Home directory for the root (admin) user.

**Command:**  
sudo ls -l /root

**Observation:**  
Contains admin-level files.

**I would use this when:**  
Performing system-level administration.

---

## /etc
**Purpose:**  
Contains configuration files for the entire system.

**Command:**  
ls -l /etc | head

**Observation:**  
Saw files like hostname, hosts.

**I would use this when:**  
Editing configs or troubleshooting services.

---

## /var/log
**Purpose:**  
Stores system and service logs — extremely important for DevOps.

**Command:**  
ls -l /var/log | head

**Observation:**  
Found logs like syslog and auth.log.

**I would use this when:**  
Investigating failures or production incidents.

---

## /tmp
**Purpose:**  
Temporary files stored here are usually deleted after reboot.

**Command:**  
ls -l /tmp

**Observation:**  
Saw temporary system files.

**I would use this when:**  
Testing scripts or storing short-term data.

---

# Good to Know Directories

## /bin
Essential system commands like ls, cp, mv live here.

Command:
ls -l /bin

Use case:
When verifying core binaries.

---

## /usr/bin
Contains most user-level commands.

Command:
ls -l /usr/bin | head

Use case:
When checking installed programs.

---

## /opt
Used for optional or third-party software.

Command:
ls -l /opt

Use case:
When managing manually installed apps.

---

# Hands-on Tasks

```
# Find the largest log file in /var/log
du -sh /var/log/* 2>/dev/null | sort -h | tail -5

# Look at a config file in /etc
cat /etc/hostname

# Check your home directory
ls -la ~
```