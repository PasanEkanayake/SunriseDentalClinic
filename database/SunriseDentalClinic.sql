-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: sunrise_dental
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
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
  `appointment_id` int NOT NULL AUTO_INCREMENT,
  `appointment_no` varchar(20) NOT NULL,
  `patient_id` int NOT NULL,
  `dentist_id` int NOT NULL,
  `treatment_id` int NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `status` enum('SCHEDULED','COMPLETED','CANCELLED') NOT NULL DEFAULT 'SCHEDULED',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`appointment_id`),
  UNIQUE KEY `appointment_no` (`appointment_no`),
  UNIQUE KEY `unique_dentist_slot` (`dentist_id`,`appointment_date`,`appointment_time`),
  KEY `fk_appt_patient` (`patient_id`),
  KEY `fk_appt_treatment` (`treatment_id`),
  CONSTRAINT `fk_appt_dentist` FOREIGN KEY (`dentist_id`) REFERENCES `dentist` (`dentist_id`),
  CONSTRAINT `fk_appt_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `fk_appt_treatment` FOREIGN KEY (`treatment_id`) REFERENCES `treatment_type` (`treatment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (1,'APT-000001',1,2,5,'2026-09-04','10:00:00','SCHEDULED','2026-09-03 20:08:35'),(30,'APT-000002',10,10,10,'2026-09-09','16:00:00','SCHEDULED','2026-09-04 07:07:13'),(31,'APT-000003',2,2,2,'2026-09-04','08:30:00','COMPLETED','2026-09-04 07:08:25'),(32,'APT-000004',3,3,3,'2026-09-04','11:00:00','SCHEDULED','2026-09-04 07:08:25'),(33,'APT-000005',4,4,4,'2026-09-05','09:30:00','SCHEDULED','2026-09-04 07:08:25'),(34,'APT-000006',5,5,5,'2026-09-05','10:30:00','SCHEDULED','2026-09-04 07:08:25'),(35,'APT-000007',6,6,6,'2026-09-06','09:00:00','SCHEDULED','2026-09-04 07:08:25'),(36,'APT-000008',7,7,7,'2026-09-06','11:00:00','CANCELLED','2026-09-04 07:08:25'),(37,'APT-000009',8,8,8,'2026-09-07','14:00:00','SCHEDULED','2026-09-04 07:08:25'),(38,'APT-000010',9,9,9,'2026-09-08','15:00:00','SCHEDULED','2026-09-04 07:08:25');
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill` (
  `bill_id` int NOT NULL AUTO_INCREMENT,
  `appointment_id` int NOT NULL,
  `consultation_fee` decimal(10,2) NOT NULL,
  `treatment_cost` decimal(10,2) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `generated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `generated_by` int DEFAULT NULL,
  PRIMARY KEY (`bill_id`),
  UNIQUE KEY `appointment_id` (`appointment_id`),
  KEY `fk_bill_staff` (`generated_by`),
  CONSTRAINT `fk_bill_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`),
  CONSTRAINT `fk_bill_staff` FOREIGN KEY (`generated_by`) REFERENCES `staff` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill`
--

LOCK TABLES `bill` WRITE;
/*!40000 ALTER TABLE `bill` DISABLE KEYS */;
INSERT INTO `bill` VALUES (1,1,500.00,4000.00,4500.00,'2026-09-03 20:08:53',1);
/*!40000 ALTER TABLE `bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinic_settings`
--

DROP TABLE IF EXISTS `clinic_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinic_settings` (
  `setting_id` int NOT NULL DEFAULT '1',
  `consultation_fee` decimal(10,2) NOT NULL DEFAULT '500.00',
  PRIMARY KEY (`setting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinic_settings`
--

LOCK TABLES `clinic_settings` WRITE;
/*!40000 ALTER TABLE `clinic_settings` DISABLE KEYS */;
INSERT INTO `clinic_settings` VALUES (1,500.00);
/*!40000 ALTER TABLE `clinic_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dentist`
--

DROP TABLE IF EXISTS `dentist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dentist` (
  `dentist_id` int NOT NULL AUTO_INCREMENT,
  `dentist_name` varchar(100) NOT NULL,
  `specialization` varchar(100) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`dentist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dentist`
--

LOCK TABLES `dentist` WRITE;
/*!40000 ALTER TABLE `dentist` DISABLE KEYS */;
INSERT INTO `dentist` VALUES (1,'Dr. Kasun Perera','General Dentistry','0771234567',1),(2,'Dr. Nadeesha Silva','Orthodontics','0777654321',1),(3,'Dr. Ruwan Fernando','Oral Surgery','0761122334',1),(4,'Dr. Chamara Wijesinghe','General Dentistry','0712345678',1),(5,'Dr. Ishara Madushani','Orthodontics','0723456789',1),(6,'Dr. Tharindu Senanayake','Oral Surgery','0734567890',1),(7,'Dr. Sachini Abeysekara','Pediatric Dentistry','0745678901',1),(8,'Dr. Dinesh Ratnayake','Periodontics','0756789012',1),(9,'Dr. Harini De Silva','Prosthodontics','0767890123',1),(10,'Dr. Praveen Gunasekara','Endodontics','0778901234',1),(11,'Dr. Anjali Weerasinghe','General Dentistry','0789012345',1),(12,'Dr. Kaveesha Fernando','Orthodontics','0701234567',1),(13,'Dr. Nuwan Amarasinghe','Oral Surgery','0713456789',1);
/*!40000 ALTER TABLE `dentist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inquiry`
--

DROP TABLE IF EXISTS `inquiry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inquiry` (
  `inquiry_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `submitted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`inquiry_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inquiry`
--

LOCK TABLES `inquiry` WRITE;
/*!40000 ALTER TABLE `inquiry` DISABLE KEYS */;
INSERT INTO `inquiry` VALUES (1,'Pasan','pasanekanayake@gmail.com','0711149262','Hello',1,'2026-09-03 20:13:14'),(3,'Ravi Perera','ravi.perera@example.com','0712341001','I would like to book a dental checkup.',0,'2026-09-04 07:09:56'),(4,'Nimali Silva','nimali.silva@example.com','0723451002','Do you provide orthodontic consultations?',1,'2026-09-04 07:09:56'),(5,'Kasun Fernando','kasun.fernando@example.com','0734561003','What is the cost of a root canal treatment?',0,'2026-09-04 07:09:56'),(6,'Thilini Jayasinghe','thilini.j@example.com','0745671004','I would like to know your clinic opening hours.',1,'2026-09-04 07:09:56'),(7,'Dinesh Perera','dinesh.perera@example.com','0756781005','Can I make an appointment for next week?',0,'2026-09-04 07:09:56'),(8,'Shalini Rodrigo','shalini.rodrigo@example.com','0767891006','Do you provide teeth whitening services?',1,'2026-09-04 07:09:56'),(9,'Amila Bandara','amila.bandara@example.com','0778901007','I have severe tooth pain and need an urgent appointment.',0,'2026-09-04 07:09:56'),(10,'Hiruni Gunawardena','hiruni.g@example.com','0789011008','Are dental checkups available on Saturdays?',0,'2026-09-04 07:09:56'),(11,'Ruwan Senanayake','ruwan.s@example.com','0701231009','I would like information about dental crowns.',1,'2026-09-04 07:09:56'),(12,'Kavindi Wijesinghe','kavindi.w@example.com','0713451010','How can I change or cancel an existing appointment?',0,'2026-09-04 07:09:56');
/*!40000 ALTER TABLE `inquiry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `patient_id` int NOT NULL AUTO_INCREMENT,
  `patient_name` varchar(100) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `contact_number` varchar(20) NOT NULL,
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (1,'Pasan Ekanayake','Madushan, Henepola, Uhumeeya','0711149262'),(2,'John Perera','25 Temple Road, Colombo 07','0711111111'),(3,'Sarah Fernando','18 Lake Road, Nugegoda','0722222222'),(4,'Kamal Silva','42 Main Street, Dehiwala','0733333333'),(5,'Nethmi Jayawardena','10 Park Avenue, Colombo 05','0744444444'),(6,'Rashmi Gunathilaka','55 Station Road, Maharagama','0755555555'),(7,'Dilan Wijeratne','32 Flower Road, Colombo 03','0766666666'),(8,'Ayesha Peris','21 High Level Road, Pannipitiya','0777777777'),(9,'Tharuka Bandara','67 School Lane, Kotte','0788888888'),(10,'Mihiri Senanayake','14 Beach Road, Mount Lavinia','0709090909'),(11,'Pasindu Ranasinghe','89 Negombo Road, Wattala','0710101010');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(64) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `role` enum('ADMIN','RECEPTIONIST') NOT NULL DEFAULT 'RECEPTIONIST',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'admin','240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9','System Administrator','ADMIN',1,'2026-09-03 19:21:01'),(2,'piumi','462cfa0b4ace9a02e6668b6ac68386413071e0162de52e9fe3290510a7a66a8a','Piumi Gunawardena','RECEPTIONIST',1,'2026-09-03 19:21:01'),(3,'amal','f15aa831df41fd0b523ca9c3bc24040656b0d0287245c4875d316e71b88d899c','Amal Perera','RECEPTIONIST',1,'2026-09-04 06:59:29');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treatment_type`
--

DROP TABLE IF EXISTS `treatment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `treatment_type` (
  `treatment_id` int NOT NULL AUTO_INCREMENT,
  `treatment_name` varchar(100) NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`treatment_id`),
  UNIQUE KEY `treatment_name` (`treatment_name`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treatment_type`
--

LOCK TABLES `treatment_type` WRITE;
/*!40000 ALTER TABLE `treatment_type` DISABLE KEYS */;
INSERT INTO `treatment_type` VALUES (1,'Dental Checkup',1000.00,1),(2,'Tooth Filling',3500.00,1),(3,'Tooth Extraction',4500.00,1),(4,'Root Canal Treatment',15000.00,1),(5,'Teeth Cleaning (Scaling)',4000.00,1),(6,'Braces Consultation',2500.00,1),(7,'Teeth Whitening',12000.00,1),(8,'Dental X-Ray',2000.00,1),(9,'Fluoride Treatment',1800.00,1),(10,'Gum Treatment',5500.00,1),(11,'Wisdom Tooth Removal',8500.00,1),(12,'Dental Crown',25000.00,1),(13,'Dental Bridge',30000.00,1),(14,'Denture Consultation',3000.00,1),(15,'Composite Veneer',10000.00,1),(16,'Emergency Dental Treatment',6000.00,1),(17,'Night Guard',7500.00,1);
/*!40000 ALTER TABLE `treatment_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-04 13:01:32
