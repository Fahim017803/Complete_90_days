# Day 12 – Breather & Revision (Days 01–11)

## Goal
Take a short pause to consolidate the fundamentals learned over the past 11 days and reinforce core Linux skills for long-term retention.

---

## Revision Summary

### Mindset & Plan
Revisited my Day 01 learning plan to ensure my direction toward becoming a DevOps engineer is still aligned.

**Adjustment made:**
- Continue prioritizing Linux fundamentals before moving deeper into cloud and automation.
- Focus more on troubleshooting speed rather than memorizing commands.

---

### Processes & Services Review

**Commands rerun:**
    ps aux
    systemctl status ssh
    journalctl -u ssh -n 20

**Observations:**
- Verified running processes and resource usage.
- Confirmed SSH service is active and healthy.
- Checked recent logs — no errors detected.

✅ Reinforced the habit: **Always check logs before restarting a service.**

---

### File Skills Practice

**Commands practiced:**
    echo "revision test" >> testfile.txt
    chmod 755 testfile.txt
    cp testfile.txt /tmp/testfile-copy
    mkdir /tmp/revision-demo
    ls -l testfile.txt

**Result:**
- Successfully modified permissions.
- Confirmed file creation and copying.
- Strengthened confidence in everyday file operations.

---

### Cheat Sheet Refresh — Top 5 Incident Commands

These are the first commands I would run during a system issue:

    df -h
    top
    systemctl status <service>
    ss -ltnp
    journalctl -xe

✅ Realization: Fast diagnosis starts with checking system health before taking action.

---

### User & Group Sanity Check

**Scenario recreated:** Created a test user and verified ownership.

**Commands:**
    sudo useradd -m revisionuser
    id revisionuser
    ls -l /home

**Observation:**
- User created successfully with a home directory.
- Permissions appeared correctly configured.

✅ Reinforced understanding of Linux access control.

---

## Mini Self-Check

### ✅ Which 3 commands save you the most time right now, and why?

**1. `systemctl status`**  
Instantly reveals whether a service is running and shows recent errors.

**2. `journalctl -xe`**  
Provides detailed logs for rapid root-cause detection.

**3. `df -h`**  
Quickly identifies disk-space issues — a common cause of production incidents.

---

### ✅ How do you check if a service is healthy?

First commands I run:

    systemctl status <service>
    ss -ltnp
    journalctl -u <service> -n 50

This confirms:
- Service state  
- Port availability  
- Recent errors  

---

### ✅ How do you safely change ownership and permissions?

**Example:**
    sudo chown user:group filename
    sudo chmod 755 filename

Always verify afterward:

    ls -l filename

Key rule → **Change, then verify. Never assume.**

---

### ✅ What will you focus on improving in the next 3 days?

- Increase troubleshooting speed  
- Build stronger command recall without referencing notes  
- Get more comfortable reading logs  
- Develop deeper understanding of permissions  

---

## Key Takeaways
- Fundamentals become powerful only through repetition.  
- Logs should be checked before taking corrective action.  
- Structured troubleshooting prevents guesswork.  
- Small daily practice compounds into real engineering skill.

---

## Reflection
Day 12 reinforced that DevOps is not about knowing hundreds of commands —  
it is about understanding **which command to use and when.**

Consistency in fundamentals is what builds real operational confidence.
