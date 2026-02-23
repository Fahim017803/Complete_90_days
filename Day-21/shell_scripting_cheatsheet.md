# 🧠 Shell Scripting Cheat Sheet (Complete DevOps Reference + Comments)

Practical, production-ready, job-focused reference.

---

# 📌 Quick Reference Table

| Topic | Key Syntax | Example |
|-------|------------|----------|
| Variable | VAR="value" | NAME="DevOps" |
| Argument | $1, $2 | ./script.sh file.log |
| If | if [ cond ]; then | if [ -f file ]; then |
| For loop | for i in list; do | for i in 1 2 3; do |
| Function | name() { ... } | greet() { echo "Hi"; } |
| Grep | grep pattern file | grep -i "error" log.txt |
| Awk | awk '{print $1}' file | awk -F: '{print $1}' /etc/passwd |
| Sed | sed 's/old/new/g' | sed -i 's/foo/bar/g' config.txt |

---

# 1️⃣ BASICS

## Shebang

```bash
#!/bin/bash   # defines bash interpreter
```

---

## Run Script

```bash
chmod +x script.sh   # make executable
./script.sh          # run directly
bash script.sh       # run using bash
```

---

## Comments

```bash
# Single line comment
echo "Hello"  # Inline comment
```

---

## Variables

```bash
NAME="DevOps"    # declare variable
echo $NAME       # unquoted (unsafe if spaces)
echo "$NAME"     # safe quoting
echo '${NAME}'   # literal string
```

---

## Read Input

```bash
read -p "Enter name: " name   # prompt + read input
echo "$name"
```

---

## Command-line Arguments

```bash
echo $0   # script name
echo $1   # first argument
echo $#   # number of arguments
echo $@   # all arguments
echo $?   # exit code of last command
```

---

# 2️⃣ OPERATORS & CONDITIONALS

## String Comparison

```bash
[ "$a" = "$b" ]    # equal
[ "$a" != "$b" ]   # not equal
[ -z "$a" ]        # string empty
[ -n "$a" ]        # string not empty
```

---

## Integer Comparison

```bash
[ $a -eq $b ]   # equal
[ $a -ne $b ]   # not equal
[ $a -lt $b ]   # less than
[ $a -gt $b ]   # greater than
[ $a -le $b ]   # <=
[ $a -ge $b ]   # >=
```

---

## File Tests

```bash
[ -f file ]   # regular file exists
[ -d dir ]    # directory exists
[ -e file ]   # file exists
[ -r file ]   # readable
[ -w file ]   # writable
[ -x file ]   # executable
[ -s file ]   # not empty
```

---

## If / Elif / Else

```bash
if [ -f file ]; then        # check file
    echo "File exists"
elif [ -d file ]; then
    echo "Directory"
else
    echo "Not found"
fi
```

---

## Logical Operators

```bash
[ -f file ] && echo "Exists"    # run if true
[ -f file ] || echo "Missing"   # run if false
! [ -f file ]                   # NOT condition
```

---

## Case Statement

```bash
case "$var" in
    start) echo "Starting" ;;   # match start
    stop) echo "Stopping" ;;    # match stop
    *) echo "Unknown" ;;        # default
esac
```

---

# 3️⃣ LOOPS

## For Loop (List)

```bash
for i in 1 2 3; do
    echo "$i"
done
```

---

## C-Style For

```bash
for ((i=0; i<5; i++)); do
    echo "$i"
done
```

---

## While Loop

```bash
while read line; do
    echo "$line"
done < file.txt   # read file line by line
```

---

## Until Loop

```bash
until [ -f file ]; do   # run until file exists
    sleep 1
done
```

---

## Loop Over Files

```bash
for file in *.log; do
    echo "$file"
done
```

---

## Loop Over Command Output

```bash
ls | while read line; do
    echo "$line"
done
```

---

## Loop Control

```bash
break     # exit loop
continue  # skip iteration
```

---

# 4️⃣ FUNCTIONS

## Define Function

```bash
greet() {
    echo "Hello $1"   # $1 = argument
}
```

---

## Call Function

```bash
greet Fahim
```

---

## Return vs Echo

```bash
return 1        # return status code
echo "value"    # return output
```

---

## Local Variable

```bash
myfunc() {
    local x=5   # scoped variable
}
```

---

# 5️⃣ TEXT PROCESSING COMMANDS

## Grep

```bash
grep "error" file        # search pattern
grep -i "error" file     # ignore case
grep -r "pattern" .      # recursive
grep -c "error" file     # count matches
grep -n "error" file     # line numbers
grep -v "info" file      # exclude pattern
grep -E "error|fail" file # OR regex
```

---

## Awk

```bash
awk '{print $1}' file           # first column
awk -F: '{print $1}' file       # custom delimiter
awk '/ERROR/ {print}' file      # pattern match
awk 'BEGIN {print "Start"} END {print "Done"}'
```

---

## Sed

```bash
sed 's/old/new/g' file     # replace text
sed '/ERROR/d' file        # delete matching lines
sed -i 's/foo/bar/g' file  # edit in place
```

---

## Cut

```bash
cut -d: -f1 file   # extract first field
```

---

## Sort

```bash
sort file     # alphabetical
sort -n file  # numeric
sort -r file  # reverse
sort -u file  # unique
```

---

## Uniq

```bash
uniq file     # remove duplicates
uniq -c file  # count duplicates
```

---

## tr

```bash
tr 'a-z' 'A-Z'   # lowercase → uppercase
tr -d '\r'       # delete char
```

---

## wc

```bash
wc -l file   # count lines
wc -w file   # count words
wc -c file   # count bytes
```

---

## head / tail

```bash
head -n 10 file   # first 10 lines
tail -n 10 file   # last 10 lines
tail -f file      # follow mode
```

---

# 6️⃣ REAL-WORLD ONE-LINERS

```bash
find . -type f -mtime +7 -delete   # delete old files
wc -l *.log                        # count lines
sed -i 's/old/new/g' *.conf        # replace across files
systemctl is-active nginx          # check service
df -h | awk '$5+0 > 80'            # disk alert
tail -f app.log | grep "ERROR"     # live error monitor
```

---

# 7️⃣ ERROR HANDLING & DEBUGGING

```bash
echo $?      # check last exit code
exit 0       # success
exit 1       # failure

set -e       # exit on error
set -u       # error on unset variable
set -o pipefail
set -x       # debug mode

trap 'rm -f temp.txt' EXIT   # cleanup on exit
```

---

# 🔥 Incident Pattern

```bash
grep | awk | sort | uniq -c | sort -rn | head
```

Filter → Extract → Count → Rank → Alert

---

# 🚀 End of Cheat Sheet
Refine this as I grow into senior DevOps level.