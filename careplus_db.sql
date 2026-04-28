-- ============================================================
--  Care+  Hospital Management System – Database Setup Script
--  Run this in MySQL before starting the application
-- ============================================================

CREATE DATABASE IF NOT EXISTS careplus_db;
USE careplus_db;

-- ── Users (Patients) ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS user_details (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  full_name   VARCHAR(100) NOT NULL,
  email       VARCHAR(100) NOT NULL UNIQUE,
  password    VARCHAR(100) NOT NULL,
  phone       VARCHAR(20),
  gender      VARCHAR(15),
  dob         VARCHAR(20),
  blood_group VARCHAR(10),
  address     TEXT,
  created_at  DATETIME DEFAULT NOW()
);

-- ── Specialists ───────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS specialist (
  id        INT AUTO_INCREMENT PRIMARY KEY,
  spec_name VARCHAR(100) NOT NULL
);

-- Default specialists
INSERT IGNORE INTO specialist (spec_name) VALUES
  ('Cardiologist'),('Neurologist'),('Dermatologist'),
  ('Orthopedist'),('Ophthalmologist'),('Psychiatrist'),
  ('Pediatrician'),('General Physician'),('Gynecologist'),
  ('Endocrinologist'),('Urologist'),('ENT Specialist');

-- ── Doctors ───────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS doctor (
  id               INT AUTO_INCREMENT PRIMARY KEY,
  full_name        VARCHAR(100) NOT NULL,
  dob              VARCHAR(20),
  qualification    VARCHAR(100),
  email            VARCHAR(100) NOT NULL UNIQUE,
  specialist       VARCHAR(100),
  mobno            VARCHAR(20),
  password         VARCHAR(100) NOT NULL,
  status           VARCHAR(20) DEFAULT 'Active',
  experience       VARCHAR(10),
  consultation_fee VARCHAR(20),
  bio              TEXT,
  availability     VARCHAR(100),
  created_at       DATETIME DEFAULT NOW()
);

-- Sample doctor
INSERT IGNORE INTO doctor (full_name,dob,qualification,email,specialist,mobno,password,status,experience,consultation_fee,bio,availability)
VALUES ('Arun Kumar Sharma','1980-05-15','MBBS, MD (Cardiology)','doctor@careplus.com','Cardiologist','9876543210','doctor123','Active','15','800','Senior cardiologist with 15 years of experience in interventional cardiology.','Mon-Sat 9AM-5PM');

-- ── Appointments ──────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS appointment (
  id               INT AUTO_INCREMENT PRIMARY KEY,
  user_id          INT,
  fullname         VARCHAR(100),
  gender           VARCHAR(15),
  age              VARCHAR(10),
  appointment_date VARCHAR(30),
  appointment_time VARCHAR(20) DEFAULT '09:00',
  email            VARCHAR(100),
  phno             VARCHAR(20),
  diseases         TEXT,
  doctor_id        INT,
  address          TEXT,
  status           VARCHAR(30) DEFAULT 'Pending',
  priority         VARCHAR(20) DEFAULT 'Normal',
  notes            TEXT,
  created_at       DATETIME DEFAULT NOW(),
  FOREIGN KEY (user_id)   REFERENCES user_details(id) ON DELETE CASCADE,
  FOREIGN KEY (doctor_id) REFERENCES doctor(id)       ON DELETE CASCADE
);

-- ── Verify ────────────────────────────────────────────────────
SELECT 'Database careplus_db created successfully!' AS message;
SELECT CONCAT('Specialists loaded: ', COUNT(*)) AS info FROM specialist;
SELECT CONCAT('Sample doctor added: ', COUNT(*)) AS info FROM doctor;
