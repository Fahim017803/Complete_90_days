## System Connection Flow (সহজভাবে)

ধরো একজন user browser দিয়ে website খুলছে।

Flow টা এমন:

```
User Browser
     ↓
Nginx Container
     ↓
Backend Container (Flask API)
     ↓
db.py (Database Connection Layer)
     ↓
Database Container (PostgreSQL)
     ↓
Docker Volume (ডাটা সেভ থাকে)
```

---

## Step by Step কি হচ্ছে

### 1️⃣ User Website এ ঢুকে

User browser এ লিখে:

```
http://SERVER_IP:8080
```

এই request প্রথমে যায় **Nginx container এ**  
কারণ Nginx public port expose করে।

---

### 2️⃣ Nginx Frontend দেখায়

Nginx এর কাজ:

- HTML
- CSS
- JavaScript

এই ফাইলগুলো user কে দেখানো।

মানে dashboard UI এখান থেকেই load হয়।

---

### 3️⃣ User Note Save করলে

Frontend JavaScript API call দেয়:

```
/api/notes
```

এখন Nginx বুঝে:

👉 এটা static file না  
👉 এটা backend এর কাজ  

তখন Nginx request পাঠায় backend container এ।

---

### 4️⃣ Backend → db.py → Database

Backend সরাসরি database এ যায় না।

প্রথমে backend **db.py ফাইলকে বলে connection তৈরি করতে**।

তারপর flow হয়:

- db.py PostgreSQL এর সাথে connect করে  
- backend SQL query চালায়  
- note database এ save হয়  
- response আবার user এর কাছে ফিরে যায়  

---

### 5️⃣ Database ডাটা সেভ রাখে

PostgreSQL container note গুলো store করে।

Docker volume থাকার কারণে:

👉 container বন্ধ হলেও  
👉 ডাটা হারায় না  

---

## Real DevOps Learning

এই project এ শিখা হয়েছে:

- frontend → nginx → backend → db.py → database flow  
- reverse proxy architecture  
- container networking  
- persistent storage design  
- portable deployment system  

এটাই real DevOps deployment flow।