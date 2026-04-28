# Care+ – Advanced Hospital Management System 🏥

## 🚀 New Features Added (vs Original)

| Feature | Description |
|---|---|
| **AI Health Chatbot** | Floating chatbot with symptom checker, health tips, specialist routing |
| **Priority Appointments** | Normal / Urgent / Emergency priority levels |
| **Time Slot Selection** | Choose specific appointment time (9AM–5PM slots) |
| **Admin Dashboard Charts** | Bar chart for appointment status using Chart.js |
| **Doctor Dashboard Charts** | Doughnut chart for patient overview |
| **Live Search** | Filter doctors on homepage by specialist/name |
| **Doctor Notes** | Doctors can write prescription/notes per appointment |
| **Today's Schedule** | Doctor sees only today's appointments on dashboard |
| **Table Search** | Admin can search patients & appointments in real-time |
| **Blood Group & DOB** | Extended patient profile fields |
| **Consultation Fee** | Shown on doctor cards on homepage |
| **Better Status Badges** | Color-coded Pending/Confirmed/Completed/Cancelled |
| **Improved UI** | Gradient navbar, cards, animations, Poppins font |
| **Mobile Responsive** | Full Bootstrap 5 responsive layout |

---

## ⚙️ Setup Instructions

### 1. Database Setup
```bash
mysql -u root -p < careplus_db.sql
```

### 2. Configure DB Connection
Edit `src/main/java/com/Db/DBConnection.java`:
```java
private static final String URL      = "jdbc:mysql://localhost:3306/careplus_db";
private static final String USER     = "root";
private static final String PASSWORD = "your_password";
```

### 3. Build & Deploy
```bash
mvn clean package
# Copy care_plus.war to Tomcat webapps/ folder
```
Or in Eclipse/IntelliJ: Run on Server (Tomcat 10+)

### 4. Access the App
| Portal | URL |
|---|---|
| Home | http://localhost:8080/care_plus/ |
| Admin | http://localhost:8080/care_plus/admin_login.jsp |
| Doctor | http://localhost:8080/care_plus/doctor_login.jsp |

### 5. Default Credentials
| Role | Email | Password |
|---|---|---|
| Admin | admin@careplus.com | admin123 |
| Sample Doctor | doctor@careplus.com | doctor123 |

---

## 🛠️ Tech Stack
- **Backend:** Java Servlets, JSP, JDBC
- **Database:** MySQL 8+
- **Frontend:** Bootstrap 5, Font Awesome 6, Chart.js
- **Build:** Maven
- **Server:** Apache Tomcat 10+

## 📁 Project Structure
```
care_plus/
├── src/main/java/com/
│   ├── Db/DBConnection.java
│   ├── entity/          (User, Doctor, Appointment, Specialist)
│   ├── dao/             (UserDao, DoctorDao, AppointmentDao, SpecialistDao)
│   ├── user/servlet/    (Register, Login, Logout, Appointment, ChangePassword)
│   ├── doctor/servlet/  (Login, Logout, EditProfile, ChangePassword, UpdateStatus)
│   ├── admin/servlet/   (Login, Logout, AddDoctor, UpdateDoctor, DeleteDoctor, AddSpecialist)
│   └── welcome/servlet/ (AIChatServlet)
└── src/main/webapp/
    ├── index.jsp          (Homepage with AI chatbot)
    ├── signup.jsp
    ├── user_login.jsp
    ├── doctor_login.jsp
    ├── admin_login.jsp
    ├── user_appointment.jsp
    ├── view_appointment.jsp
    ├── change_password.jsp
    ├── component/         (navbar, footer, allcss)
    ├── admin/             (dashboard, doctors, appointments, patients)
    └── doctor/            (dashboard, patients, profile, password)
```
