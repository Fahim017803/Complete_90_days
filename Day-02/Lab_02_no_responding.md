# SPPLR Production Debugging Playbook (Service → Process → Port → Logs → Restart)

This page is a practical incident-playbook you can reuse for **any Linux server** when an application is not responding.

**SPPLR =**
- **S — Service** (systemd says what?)
- **P — Process** (is it actually running?)
- **P — Port** (is it listening / reachable?)
- **L — Logs** (what is the system telling you?)
- **R — Restart** (only after diagnosis)

> **Rule:** `systemctl status` ≠ application working. Always verify with process + port + logs.

---

## 0) Quick 30-Second Triage (2-minute version)

Run these in order:

```bash
# 1) service
systemctl status <service>

# 2) process
pgrep -a <process-name>

# 3) port (example: 80/443)
sudo ss -tulpn | grep :80
sudo ss -tulpn | grep :443

# 4) logs (last 30 lines)
sudo journalctl -u <service> -n 30 --no-pager
If you identify the layer, then apply the correct fix below.

1) S — Service Layer (systemd)
Check
systemctl status nginx
systemctl is-enabled nginx
If service is inactive/dead
Fix

sudo systemctl start nginx
sudo systemctl enable nginx
Verify

curl -I localhost
If service shows active (running) but app still down
Move to Process and Port checks. systemd can be “happy” while users are still failing.

2) P — Process Layer (is the binary alive?)
Check
pgrep -a nginx
ps aux | grep nginx
If no process is found
Likely causes: crash, config error, missing dependency, permission, resource exhaustion.

Fix (temporary restore)

sudo systemctl restart nginx
Then immediately check logs:

sudo journalctl -u nginx -n 50 --no-pager
3) P — Port Layer (is it listening?)
Check listening ports
sudo ss -tulpn | grep :80
sudo ss -tulpn | grep :443
If process exists but port is NOT listening
Most likely: config error, binding error, port conflict.

Check config

sudo nginx -t
Common port conflict check

sudo ss -tulpn | grep :80
sudo lsof -i :80
Fix

Resolve config error / conflict

Restart:

sudo systemctl restart nginx
Verify

curl -I localhost
4) L — Logs Layer (truth source)
systemd logs
sudo journalctl -u nginx -n 80 --no-pager
nginx logs
sudo tail -n 80 /var/log/nginx/error.log
sudo tail -n 80 /var/log/nginx/access.log
Typical log patterns → what they mean
permission denied → ownership/permissions broken

bind() to 0.0.0.0:80 failed → port conflict / not allowed

syntax error → config typo

no space left on device → disk full

upstream timed out / 502 → backend down (nginx OK)

5) R — Restart Layer (only after diagnosis)
Restart safely
sudo systemctl restart nginx
Reload (when config changes but want minimal downtime)
sudo systemctl reload nginx
Verify after restart/reload
curl -I localhost
systemctl status nginx
Golden rule: Change → Verify → Document.

High-Probability Production Scenarios (Copy-Paste Solutions)
Scenario A — “Server UP, SSH works, service running, but app not responding”
Do this:

systemctl status nginx
pgrep -a nginx
sudo ss -tulpn | grep :80
sudo journalctl -u nginx -n 50 --no-pager
curl -I localhost
Interpretation:

Process missing → crash/config/resource issue

Port missing → bind/config/conflict issue

Local curl works but public fails → firewall / security group issue

Scenario B — Local works, public does NOT (cloud firewall/security group)
Local test

curl -I localhost
If local works, check firewall:

sudo ufw status
sudo iptables -S
Cloud: ensure inbound rules allow 80/443.

Scenario C — Service keeps dying after start (crash loop)
Check logs and config:

sudo journalctl -u nginx -n 100 --no-pager
sudo nginx -t
Then:

sudo systemctl restart nginx
Scenario D — 502 / 504 errors (nginx ok, backend broken)
Check backend services:

systemctl status <backend-service>
journalctl -u <backend-service> -n 80 --no-pager
Check upstream connectivity:

curl -I http://127.0.0.1:<backend-port>
sudo ss -tulpn | grep :<backend-port>
Scenario E — Disk full (silent outage)
Check:

df -h
Find large folders:

sudo du -sh /var/log/* | sort -h
Temporary mitigation:

sudo truncate -s 0 /var/log/nginx/error.log
Long-term fix: logrotate / retention.

Scenario F — Permissions broken (permission denied)
Check ownership/permissions:

ls -l /var/log/nginx
ls -l /var/www/html
Fix ownership (example only—depends on your setup):

sudo chown -R www-data:www-data /var/www/html
Scenario G — Works now, breaks after reboot
Check enabled state:

systemctl is-enabled nginx
Fix:

sudo systemctl enable nginx
sudo systemctl start nginx
Why SPPLR Works (DevOps mindset)
You don’t guess. You isolate.

Every outage is a failure in one layer.

SPPLR reduces downtime by shrinking the problem space quickly.

Quick Command Cheat Sheet
# service
systemctl status <svc>
systemctl start <svc>
systemctl restart <svc>
systemctl enable <svc>
systemctl is-enabled <svc>

# process
pgrep -a <name>
ps aux | grep <name>

# ports
sudo ss -tulpn
sudo ss -tulpn | grep :80

# logs
sudo journalctl -u <svc> -n 80 --no-pager
sudo tail -n 80 /var/log/<app>/error.log

# verification
curl -I localhost