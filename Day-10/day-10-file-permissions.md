# Day 10 Challenge – File Permissions & File Operations

## Files Created

```
touch devops.txt  
echo "DevOps Notes" > notes.txt  
vim script.sh
```

script.sh content:  
`echo "Hello DevOps" `

Verify files:  
`ls -l`

---

## Understanding Permission Structure

Linux permission format:

rwxrwxrwx  
u  g  o  

u = user (owner)  
g = group  
o = others  

Permission symbols:

r = read (4)  
w = write (2)  
x = execute (1)  

Operators:

+ → add permission  
- → remove permission  
= → set exact permission  

Example:

`sudo chmod u+x script.sh`  
(Add execute permission to owner)

`sudo chmod g-w file.txt`  
(Remove write from group)

chmod o=r file.txt  
(Set others to read-only)

---

## Default Permissions

After file creation:

devops.txt → 644 (-rw-r--r--)  
notes.txt → 644 (-rw-r--r--)  
script.sh → 644 (-rw-r--r--)  

Owner: read + write  
Group: read  
Others: read  

---

## Permission Changes

### Make script executable

`sudo chmod u+x script.sh`  

New permission:  
744 (-rwxr--r--)

Run script:  
`./script.sh`  

Output: Hello DevOps  

📸 Screenshot

---

### Remove write permission from devops.txt

chmod a-w devops.txt  

New permission:  
444 (-r--r--r--)  

Test write:

`echo "test" >> devops.txt`  

Result: Permission denied  

---

### Set notes.txt using "=" operator

chmod u=rw,g=r,o= notes.txt  

New permission:  
640 (-rw-r-----)

Owner → read/write  
Group → read  
Others → no access  

---

## Directory Permission

Create project directory:

`mkdir project`  

Set permission:

`sudo chmod 755 project`  

Permission result:  
drwxr-xr-x  

Owner → full control  
Group → read + execute  
Others → read + execute  

---

## Commands Used
touch  
echo  
vim  
cat  
head  
tail  
ls -l  
chmod  
mkdir  

---

## What I Learned
- Linux permissions control access using user, group, and others.
- Symbolic mode (`u,g,o` with `+,-,=`) provides precise permission control.
- Execute permission is mandatory for running scripts.
- Restricting write access protects system files from unintended changes.
