## Lab-02: systemd Service Debugging (nginx)

## Scenario
Server UP  
SSH works  
Service says “running”  
But application is not responding  

This lab simulates a real production incident and how a DevOps engineer debugs it.

## One-time setup (only once)
```
sudo apt update  
sudo apt install -y nginx  
systemctl status nginx  
```
## Normal working state check
`curl localhost
`
Expected: nginx welcome page  

## Create fake incident (simulate crash)
`sudo pkill nginx
`

## Debug step-by-step (real DevOps flow)

1) Check service status  
`sudo systemctl status nginx
`

2) Check actual process  
`ps aux | grep nginx
`

Result: no nginx process running  

3) Check port listening  
`sudo ss -tulpn | grep nginx
`

Result: nothing listening on port 80  

4) Check logs (most important)  
`sudo journalctl -u nginx -n 50
`  
90% root cause is found here  

## Recover service properly
``
sudo systemctl restart nginx  
curl localhost  
``

Application works again  

## Simulate reboot failure (real production case)
```
sudo systemctl disable nginx  
sudo reboot  
```

After reconnect:  
`systemctl status nginx
`

Result: service inactive ❌  

## Permanent fix
```
sudo systemctl enable nginx  
sudo systemctl start nginx  
```

## Key Learnings
- systemctl status ≠ application working  
- Always verify:  
  process  
  port  
  logs  
- start = run now  
- enable = survive reboot  
- systemd controls full service lifecycle  

## DevOps rule
Fix today’s problem AND prevent tomorrow’s outage
