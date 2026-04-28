-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: careplus_db
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `gender` varchar(15) DEFAULT NULL,
  `age` varchar(10) DEFAULT NULL,
  `appointment_date` varchar(30) DEFAULT NULL,
  `appointment_time` varchar(20) DEFAULT '09:00',
  `email` varchar(100) DEFAULT NULL,
  `phno` varchar(20) DEFAULT NULL,
  `diseases` text,
  `doctor_id` int DEFAULT NULL,
  `address` text,
  `status` varchar(30) DEFAULT 'Pending',
  `priority` varchar(20) DEFAULT 'Normal',
  `notes` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (1,1,'Satyabrata Guru','Male','23','2026-04-29','16:00','satyabrataguru443@gmail.com','9861712147','breathing issue',2,'Jagatsinghpur,Odisha','Completed','Normal','complete','2026-04-28 11:22:11'),(2,3,'Smruti ranjan Khatua','Male','23','2026-04-29','10:30','smrutikhatua90@gmail.com','7008274210','fever, headache',20,'Baleswar','Pending','Normal',NULL,'2026-04-28 18:35:08'),(3,2,'Nisith Giri','Male','23','2026-04-28','10:30','girinisith@gmail.com','9938593942','fever',20,'Jagatsinghpur,Odisha','Pending','Normal',NULL,'2026-04-28 18:36:40');
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `dob` varchar(20) DEFAULT NULL,
  `qualification` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `specialist` varchar(100) DEFAULT NULL,
  `mobno` varchar(20) DEFAULT NULL,
  `password` varchar(100) NOT NULL,
  `status` varchar(20) DEFAULT 'Active',
  `experience` varchar(10) DEFAULT NULL,
  `consultation_fee` varchar(20) DEFAULT NULL,
  `bio` text,
  `availability` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
INSERT INTO `doctor` VALUES (1,'Arun Kumar Sharma','1980-05-15','MBBS, MD (Cardiology)','doctor@careplus.com','Cardiologist','9876543210','doctor123','Active','15','800','Senior cardiologist with 15 years of experience in interventional cardiology.','Mon-Sat 9AM-5PM','2026-04-28 10:51:14'),(2,'Rakesh Malick','1985-02-26','MBBS,MD','rakeshmalick123@gmail.com','Pediatrician','9861714567','rakesh890','Active','10','500',' Senior Pediatrician with 10 years of experience in interventional Pediatrician.','Mon-sat 9AM-5AM','2026-04-28 11:12:14'),(3,'Subashis Jena','1982-08-12','MBBS,MS','subashis123@gamil.com','Dermatologist','8173684990','subashis123','Active','10','999','Senior dermatologist with 10 years of experience in interventional dermatologist .','Mon-sat 10AM-4PM','2026-04-28 16:00:26'),(4,'Rahul Pattnaik','1995-02-08','MBBS','rahul123@gamil.com','Dermatologist','9878373899','rahul123','Active','4','799','Senior Dermatologist with 6 years of experience in interventional Dermatologist .','Mon-sat 9AM-5PM','2026-04-28 16:02:58'),(7,'Subashis Jena','1985-12-12','MBBS','subashis123@careplus.com','Cardiologist','8260926038','subashis123','Active','10','1000',' Senior cardiologist with 10 years of experience in interventional cardiology.','Mon-sat 10AM-4PM','2026-04-28 16:19:20'),(8,'Satyabrata Swain','1995-01-12','MBBS','sataybrata@careplus.com','Pediatrician','9927492017','satya123','Active','8','700','Senior Pediatrician with 8 years of experience in interventional Pediatrician.','Mon-sat 9AM-5PM','2026-04-28 16:21:13'),(9,'Asmita Patra','1995-03-10','MBBS','asmita@careplus.com','Gynecologist','9938184857','asmita123','Active','6','800','Senior Gynecologist with 6 years of experience in interventional Gynecologist .','Mon-sat 10AM-4PM','2026-04-28 16:23:34'),(10,'Rohanjit Das','1982-01-10','MBBS','Rohanjit@careplus.com','Gynecologist','7488393000','rohanjit123','Active','13','700','Senior Gynecologist with 12 years of experience in interventional Gynecologist .','Tue-sat, 10AM-4PM','2026-04-28 16:26:01'),(11,'Rn Sahoo','1990-04-12','MBBS','rnSahoo@careplus.com','Neurologist','7746839879','rnsahoo123','Active','10','900','Senior neurologist with 10 years of experience in interventional neurologist ','Wed-Fri , 10AM-4PM','2026-04-28 16:30:03'),(12,'Surya Narayana Sahoo','1983-10-08','MBBS','suraya@careplus.com','Neurologist','9861893422','Surya 123','Active','10','800',' Senior neurologist with 10 years of experience in interventional neurologist','Mon-wed 10AM-4PM','2026-04-28 16:34:13'),(13,'Shakti kumar Roy','1988-12-10','MBBS','shakti@careplus.com','Orthopedist','8827467890','shakti123','Active','10','800','Senior Orthopedist with 10 years of experience in interventional Orthopedist','Fri-Sat, 10AM-2PM','2026-04-28 16:36:47'),(14,'Nisith Ray','1980-05-10','MBBS','nisith@careplus.com','Orthopedist','9938471234','nisith123','Active','15','799','Senior Orthopedist with 15 years of experience in interventional Orthopedist','Tue-Thurs ,2PM-5PM','2026-04-28 16:39:40'),(15,'Suraj sekhar jena','1990-08-09','MBBS','suraj@careplus.com','Pediatrician','8200987635','suraj123','Active','6','1000','Senior Pediatrician with 6 years of experience in interventional Pediatrician ','Tue-sat, 9AM-2PM','2026-04-28 18:08:13'),(16,'Smruti rajan Sahoo','1987-11-21','MBBS','smruti@careplush.com','Pediatrician','7724369910','smruti123','Active','7','800','Senior Pediatrician with 7 years of experience in interventional Pediatrician ','Mon-wed 8AM-12PM','2026-04-28 18:11:27'),(17,'Manoj kumar Panda','1984-12-12','MBBS','manoj@careplush.com','Psychiatrist','6370026836','manoj123','Active','12','1000','Senior Psychiatrist with 12 years of experience in interventional Psychiatrist.','Tue-sat, 10AM-4PM','2026-04-28 18:13:55'),(18,'Pravat Kumar Jena','1989-02-22','MBBS','pravatkumar2005@gmail.com','Urologist','8908218576','pravat123','Active','7','800','Senior Urologist with 7 years of experience in interventional Urologist ','Mon-sat 10AM-4PM','2026-04-28 18:16:16'),(19,'Sunil Nayak','1984-04-12','MBBS,MD','sunil@careplus.com','General Physician','9938027485','sunil123','Active','012','799','Senior General physician with 12 years of experience in interventional General physician.','Mon-sat 9AM-5PM','2026-04-28 18:19:11'),(20,'Tulshi Mohapatra','1990-09-01','MBBS','tulshi@careplus.com','General Physician','9861893426','tulsi123','Active','8','600',' Senior General physician with 8 years of experience in interventional General physician','Mon-sat 9AM-5PM','2026-04-28 18:21:15');
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specialist`
--

DROP TABLE IF EXISTS `specialist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `specialist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `spec_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specialist`
--

LOCK TABLES `specialist` WRITE;
/*!40000 ALTER TABLE `specialist` DISABLE KEYS */;
INSERT INTO `specialist` VALUES (1,'Cardiologist'),(2,'Neurologist'),(3,'Dermatologist'),(4,'Orthopedist'),(6,'Psychiatrist'),(7,'Pediatrician'),(9,'Gynecologist'),(11,'Urologist'),(13,'cardiologist'),(14,'General Physician');
/*!40000 ALTER TABLE `specialist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_details`
--

DROP TABLE IF EXISTS `user_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `gender` varchar(15) DEFAULT NULL,
  `dob` varchar(20) DEFAULT NULL,
  `blood_group` varchar(10) DEFAULT NULL,
  `address` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_details`
--

LOCK TABLES `user_details` WRITE;
/*!40000 ALTER TABLE `user_details` DISABLE KEYS */;
INSERT INTO `user_details` VALUES (1,'Satyabrata Guru','satyabrataguru443@gmail.com','satya8090','9348460717','Male','2003-10-23','B+','Jagatsinghpur,Odisha','2026-04-28 11:15:06'),(2,'Nisith Giri','girinisith@gmail.com','nisith123','9938593942','Male','2004-01-01','O+','Jagatsinghpur,Odisha','2026-04-28 18:31:22'),(3,'Smruti ranjan Khatua','smrutikhatua90@gmail.com','smruti123','7008274210','Male','2005-06-17','AB+','Baleswar','2026-04-28 18:33:05');
/*!40000 ALTER TABLE `user_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-28 19:06:06
