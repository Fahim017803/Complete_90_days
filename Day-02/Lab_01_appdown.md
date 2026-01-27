### Service down?
 - systemctl status
### inactive?
- systemctl start
### reboot এ আবার নামছে?
- systemctl enable

### Lab-1: systemd service lifecycle (ssh)

Commands practiced:
```- sudo systemctl stop ssh
- sudo systemctl status ssh
- sudo systemctl start ssh
- sudo systemctl enable ssh
```
Key learning:
- start = run now
- enable = run after reboot
- systemd controls all Linux services
