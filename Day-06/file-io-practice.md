# Day 06 – Linux Fundamentals: Read and Write Text Files

Today I practiced basic file read and write operations using fundamental Linux commands.

---

## 1. Creating a File

Command:
touch notes.txt

What it did:
- Created an empty file named notes.txt

---

## 2. Writing Text into the File

Command:
echo "Line 1" > notes.txt

What it did:
- Added Line 1 into the file
- Used `>` which overwrites existing content

---

## 3. Appending New Lines

Command:
echo "Line 2" >> notes.txt

What it did:
- Appended Line 2 to the file
- Used `>>` to add content without deleting previous lines

---

## 4. Writing and Displaying at the Same Time

Command:
echo "Line 3" | tee -a notes.txt

What it did:
- Added Line 3 to the file
- Displayed output on the terminal
- Used `tee` for simultaneous write and display

---

## Understanding the `-a` Option

- `-a` means **append**
- It adds new content without deleting existing data
- Without `-a`, tee would overwrite the file

Example:
echo "New Line" | tee -a notes.txt

---

## 5. Reading Full File

Command:
cat notes.txt

What it did:
- Displayed the full content of the file

---

## 6. Reading Partial File

Command:
head -n 2 notes.txt

What it did:
- Showed the first two lines of the file

Command:
tail -n 2 notes.txt

What it did:
- Showed the last two lines of the file

---

## Key Learning

- `>` overwrites file content
- `>>` appends new content
- `tee` helps write and display at the same time
- `-a` without -a, all data will be deleted.
- `cat`, `head`, and `tail` are useful for reading logs and configs
- Basic file handling is essential for DevOps tasks
