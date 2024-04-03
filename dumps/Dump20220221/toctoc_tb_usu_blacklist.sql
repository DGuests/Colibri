-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: toctoc
-- ------------------------------------------------------
-- Server version	5.7.37

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
-- Table structure for table `tb_usu_blacklist`
--

DROP TABLE IF EXISTS `tb_usu_blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_usu_blacklist` (
  `p_blk_id` int(11) NOT NULL AUTO_INCREMENT,
  `s_blk_nome` varchar(255) NOT NULL,
  `s_blk_documento` varchar(255) NOT NULL,
  `t_blk_data_ocorrido` datetime NOT NULL,
  `s_blk_observacao` varchar(255) DEFAULT NULL,
  `f_blk_usuario` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`p_blk_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_usu_blacklist`
--

LOCK TABLES `tb_usu_blacklist` WRITE;
/*!40000 ALTER TABLE `tb_usu_blacklist` DISABLE KEYS */;
INSERT INTO `tb_usu_blacklist` VALUES (1,'joao','11111111111','2022-07-02 03:00:00','cccccc',1,'2022-02-07 18:34:59','2022-02-07 18:34:59'),(2,'teste','11111111111','2021-01-01 00:00:00','aa',1,'2022-02-11 19:51:39','2022-02-11 19:51:39'),(3,'aaaaaa','11111111111','2021-01-01 00:00:00','aaaaaa',1,'2022-02-11 19:52:55','2022-02-11 19:52:55'),(4,'teste','11111111111','2022-11-11 00:00:00','aa',1,'2022-02-15 21:15:12','2022-02-15 21:15:12'),(5,'teste5','11111111111','2022-11-11 00:00:00','aaaaaaa',1,'2022-02-17 17:23:37','2022-02-17 17:23:37'),(6,'teste6','11111111111','2022-12-12 00:00:00','adsadasdasdas',1,'2022-02-17 17:24:57','2022-02-17 17:24:57'),(7,'teste8','11111111111','2021-11-11 00:00:00','ds',1,'2022-02-17 17:38:13','2022-02-17 17:38:13'),(8,'João Andrade','11111111111','2222-02-11 00:00:00','adasd',1,'2022-02-17 17:39:57','2022-02-17 17:39:57'),(9,'João iiiiii','11111111111','2022-11-11 00:00:00','sasa',1,'2022-02-17 17:42:38','2022-02-17 17:42:38'),(10,'teste10','11111111111','2021-01-12 00:00:00','111',1,'2022-02-17 17:43:27','2022-02-17 17:43:27'),(11,'aaaa','11111111111','2021-01-01 00:00:00','z',1,'2022-02-18 16:33:34','2022-02-18 16:33:34'),(12,'teste43543','11111111111','2021-01-01 00:00:00','reteer',1,'2022-02-18 16:42:30','2022-02-18 16:42:30'),(13,'João Pedro','22222222222','2222-02-22 00:00:00','asdsadasdasdasdas',1,'2022-02-18 16:44:12','2022-02-18 16:44:12');
/*!40000 ALTER TABLE `tb_usu_blacklist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-21 16:40:04
