# 🎯 Web-Based Complaint Management System

> A modern JSP-based complaint tracking system built with Jakarta EE for municipal IT operations

[![Java](https://img.shields.io/badge/Java-11+-orange?style=flat-square&logo=java)](https://www.oracle.com/java/)
[![JSP](https://img.shields.io/badge/JSP-2.3-blue?style=flat-square&logo=apache)](https://jakarta.ee/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=flat-square&logo=mysql)](https://www.mysql.com/)
[![Tomcat](https://img.shields.io/badge/Tomcat-10.x-yellow?style=flat-square&logo=apache-tomcat)](https://tomcat.apache.org/)

## 📋 Overview

Municipal IT Division complaint management prototype enabling employees and admins to efficiently handle complaint submission, tracking, and resolution through a clean web interface.

### ✨ Key Features

- 🔐 **Role-Based Access** - Employee & Admin authentication
- 📝 **Smart Complaint System** - Submit, track, and manage complaints
- 📊 **Real-time Status Updates** - Track complaint progress
- 🛡️ **Secure Sessions** - Protected user authentication
- 🏗️ **MVC Architecture** - Clean, maintainable codebase

## 🚀 Tech Stack

| Frontend | Backend | Database | Server |
|----------|---------|----------|--------|
| 🎨 JSP + HTML/CSS | ⚡ Jakarta EE | 🗄️ MySQL | 🚀 Tomcat |

## 📁 Project Structure

```
📦 AAD_Assignment_CMS/
├── 📂 src/main/java/
│   ├── 🎮 controller/     # Servlets
│   ├── 💾 dao/           # Database Access
│   └── 📊 model/         # Data Models
├── 📂 webapp/view/       # JSP Pages
├── 🗄️ db/schema.sql     # Database Schema
└── 📖 README.md
```

## ⚡ Quick Setup

### 1️⃣ Prerequisites
```bash
☑️ Java 11+
☑️ Apache Tomcat 10.x
☑️ MySQL 8.0+
☑️ Maven 3.6+
```

### 2️⃣ Database Setup
```sql
-- Create database
CREATE DATABASE complaint_management_system;

-- Import schema
mysql -u username -p complaint_management_system < db/schema.sql
```

### 3️⃣ Deploy & Run
```bash
# Clone repository
git clone https://github.com/your-username/AAD_Assignment_CMS.git

# Build project
mvn clean compile

# Deploy to Tomcat
# Access: http://localhost:8080/AAD_Assignment_CMS
```

## 👥 User Roles

### 👤 Employee Features
- ➕ Submit new complaints
- 📋 View personal complaints
- ✏️ Edit pending complaints
- 🗑️ Delete unresolved complaints

### 👨‍💼 Admin Features
- 📊 View all complaints
- 🔄 Update complaint status
- 💬 Add administrative remarks
- 🗑️ Delete any complaint

## 🛠️ Technical Highlights

### 🔄 Form-Based Processing
- **GET** → Data Display
- **POST** → Data Submission
- **No AJAX** → Pure JSP/Servlet interaction

### 🏗️ MVC Implementation
- **🎨 View** → JSP Pages
- **🎮 Controller** → Servlets
- **📊 Model** → POJOs + DAOs

### 🔒 Security Features
- Session management
- Role-based access control
- SQL injection prevention
- Input validation

## 📊 System Flow

```
🔐 Login → 🏠 Dashboard → 📝 Complaint Actions → 💾 Database → 🔄 Response
```

## 🎯 Assignment Compliance

✅ JSP-based frontend  
✅ Jakarta EE backend  
✅ MVC architecture  
✅ Form-only interactions  
✅ MySQL integration  
✅ Role-based authentication  

## 🔧 Troubleshooting

| Issue | Solution |
|-------|----------|
| 🔌 Database Connection | Check MySQL service & credentials |
| 📄 JSP Errors | Verify Tomcat JSP support |
| 🔐 Session Issues | Clear cookies & check timeout |


## 📄 License

📚 Educational Project - IJSE GDSE Program

---

<div align="center">

**🚀 Built with Jakarta EE & JSP | 💡 IJSE Advanced API Development**

</div>
