CREATE DATABASE  IF NOT EXISTS `db0309` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db0309`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: db0309
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `거래정보`
--

DROP TABLE IF EXISTS `거래정보`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `거래정보` (
  `제품번호` varchar(45) NOT NULL,
  `품명` varchar(45) DEFAULT NULL,
  `규격` varchar(15) DEFAULT NULL,
  `수량` int DEFAULT NULL,
  `단가` int DEFAULT NULL,
  PRIMARY KEY (`제품번호`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `거래정보`
--

LOCK TABLES `거래정보` WRITE;
/*!40000 ALTER TABLE `거래정보` DISABLE KEYS */;
INSERT INTO `거래정보` VALUES ('1','aa','a',1,1000);
/*!40000 ALTER TABLE `거래정보` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `견적서`
--

DROP TABLE IF EXISTS `견적서`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `견적서` (
  `견적서번호` varchar(45) NOT NULL,
  `견적날짜` date DEFAULT NULL,
  `공급자번호` int DEFAULT NULL,
  `견적접수자` int DEFAULT NULL,
  `제품번호` int DEFAULT NULL,
  `공급가액` int DEFAULT NULL,
  `비고` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`견적서번호`),
  KEY `fk_견적서_거래정보_idx` (`제품번호`),
  KEY `fk_견적서_공급자1_idx` (`공급자번호`),
  KEY `fk_견적서_사원1_idx` (`견적접수자`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `견적서`
--

LOCK TABLES `견적서` WRITE;
/*!40000 ALTER TABLE `견적서` DISABLE KEYS */;
INSERT INTO `견적서` VALUES ('1','2023-03-09',1,1,1,1000,NULL);
/*!40000 ALTER TABLE `견적서` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `공급자`
--

DROP TABLE IF EXISTS `공급자`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `공급자` (
  `등록번호` int NOT NULL,
  `상호` varchar(45) DEFAULT NULL,
  `대표성명` varchar(45) DEFAULT NULL,
  `사업장주소` varchar(45) DEFAULT NULL,
  `업태` varchar(45) DEFAULT NULL,
  `종목` varchar(45) DEFAULT NULL,
  `전화번호` int DEFAULT NULL,
  PRIMARY KEY (`등록번호`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `공급자`
--

LOCK TABLES `공급자` WRITE;
/*!40000 ALTER TABLE `공급자` DISABLE KEYS */;
INSERT INTO `공급자` VALUES (1,'pnu','홍길동','부곡로','it','it',-1171);
/*!40000 ALTER TABLE `공급자` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `사원`
--

DROP TABLE IF EXISTS `사원`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `사원` (
  `사원번호` int NOT NULL,
  `전화번호` int DEFAULT NULL,
  `부서` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`사원번호`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `사원`
--

LOCK TABLES `사원` WRITE;
/*!40000 ALTER TABLE `사원` DISABLE KEYS */;
INSERT INTO `사원` VALUES (1,-2282,'it부서');
/*!40000 ALTER TABLE `사원` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-09 17:57:55
