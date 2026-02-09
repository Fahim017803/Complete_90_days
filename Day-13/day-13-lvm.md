# Day 13 – Linux Volume Management (LVM)

## Goal
Learn how LVM enables flexible storage by creating, mounting, and extending volumes without downtime.

---

## Why LVM Matters
Traditional partitions are fixed and difficult to resize.  
LVM allows live storage expansion, improving system reliability.

**Focus Today:**
- Understand LVM architecture  
- Create storage layers  
- Extend a running volume safely  

✅ Mindset shift: from simply using disks → to managing scalable storage.

---

## Storage Inspection

**Commands:**
    lsblk  
    pvs  
    vgs  
    lvs  
    df -h  

✅ Always inspect the system before making storage changes.

---

## LVM Setup

### Physical Volume
    pvcreate /dev/nvme1n1
    pvcreate /dev/nvme2n1
    pvs

/Users/fahim/Downloads/WhatsApp Image 2026-02-10 at 02.18.30 (1).jpeg

---

### Volume Group
    vgcreate devops-vg /dev/
    vgs

/Users/fahim/Downloads/WhatsApp Image 2026-02-10 at 02.27.18.jpeg

---

### Logical Volume
    lvcreate -L 500M -n app-data devops-vg
    lvs

A flexible virtual disk for applications.

---

## Format and Mount

    mkdir -p /mnt/app-data 
    mkfs.ext4 /dev/devops-vg/app-data   
    mount /dev/devops-vg/app-data /mnt/app-data  
    df -h  
![alt text](<WhatsApp Image 2026-02-10 at 02.18.31.jpeg>)

---

## Extend the Volume (Key Skill)

    lvextend -L +200M /dev/devops-vg/app-data  
    resize2fs /dev/devops-vg/app-data  
    df -h  

![alt text](<WhatsApp Image 2026-02-10 at 02.18.31-1.jpeg>)

**Critical Rule:**  
> Extending the logical volume does NOT extend usable space — always resize the filesystem.

---

## LVM Architecture

[ Physical Disk ]
↓
[ Physical Volume (PV) ]
↓
[ Volume Group (VG) ]
↓
[ Logical Volume (LV) ]
↓
[ Filesystem (ext4/xfs) ]
↓
[ Mount Point (/mnt/app-data) ]

## Key Takeaways
- LVM provides scalable and flexible storage.
- Inspection must happen before modification.
- Live disk extension prevents production outages.
- Filesystem resizing is mandatory after volume expansion.

---

## Reflection
Day 13 strengthened my understanding that storage is a core reliability component.  
Knowing how to scale disks safely is an essential DevOps capability.