# Linux Commands Cheat Sheet
Day 03 – Linux Commands Practice

This file is my personal Linux command cheat sheet.
I created this to build confidence with daily-used commands in DevOps and server troubleshooting.

---

## File System Commands

- `pwd` – shows where I am currently
- `ls` – list files and folders
- `ls -lh` – list files with size and permissions
- `cd /path` – move to another directory
- `mkdir folder` – create a new folder
- `rm file` – delete a file
- `rm -r folder` – delete folder and its contents
- `cp file1 file2` – copy a file
- `mv old new` – rename or move a file
- `touch file` – create an empty file
- `cat file` – view file content
- `less file` – read file comfortably
- `tail -f file` – watch logs live
- `df -h` – check disk space
- `du -sh folder` – check folder size

---

## Process Management Commands

- `ps aux` – show all running processes
- `top` – monitor CPU and memory usage
- `htop` – better version of top (if installed)
- `kill PID` – stop a process
- `kill -9 PID` – force stop process
- `pkill name` – kill process by name
- `systemctl status service` – check service status
- `systemctl start service` – start a service
- `systemctl stop service` – stop a service
- `systemctl restart service` – restart a service

---

## Networking & Troubleshooting Commands

- `ip addr` – check IP address
- `ip route` – check routing table
- `ping google.com` – test network connectivity
- `curl url` – test API or website response
- `ss -tuln` – check listening ports
- `netstat -tuln` – legacy port checking
- `dig google.com` – DNS lookup
- `traceroute google.com` – trace network path

---

## Logs & Debugging

- `journalctl` – view system logs
- `journalctl -u service` – logs for a specific service
- `tail -n 50 file` – last 50 log lines
- `grep "error" file` – search error in file
- `grep -i error file` – case insensitive search

---

## Permissions & Users

- `ls -l` – check file permissions
- `chmod 644 file` – change permissions
- `chown user:user file` – change ownership
- `whoami` – show current user
- `id` – show user and group details

---

## Notes

These are the commands I will reuse again and again while working on Linux servers.
Knowing these commands helps reduce downtime and troubleshoot issues faster.
