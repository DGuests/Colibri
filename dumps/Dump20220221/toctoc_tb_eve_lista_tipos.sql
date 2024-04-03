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
-- Table structure for table `tb_eve_lista_tipos`
--

DROP TABLE IF EXISTS `tb_eve_lista_tipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_eve_lista_tipos` (
  `p_lista_tipo_id` int(11) NOT NULL,
  `f_lista_tipo_estabelecimento` int(11) DEFAULT NULL,
  `s_lista_tipo_nome` varchar(255) DEFAULT NULL,
  `s_lista_tipo_cor` varchar(255) DEFAULT NULL,
  `s_lista_tipo_valor` varchar(255) DEFAULT NULL,
  `t_lista_tipo_data_cadastro` datetime DEFAULT NULL,
  `s_lista_tipo_fb` varchar(255) DEFAULT NULL,
  `s_lista_tipo_status` varchar(255) DEFAULT NULL,
  `s_lista_tipo_sexo` varchar(255) DEFAULT NULL,
  `s_lista_tipo_consumacao` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`p_lista_tipo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_eve_lista_tipos`
--

LOCK TABLES `tb_eve_lista_tipos` WRITE;
/*!40000 ALTER TABLE `tb_eve_lista_tipos` DISABLE KEYS */;
INSERT INTO `tb_eve_lista_tipos` VALUES (1,1,'VIP Azul','#fffa86','1599','2022-07-02 03:00:00','não sei oq é ainda','Entrada?','masculino','10','2022-02-07 20:00:32','2022-02-07 20:12:52'),(2,1,'teste','#ff9f00','10','2022-02-15 21:16:49','n sei oq é','Consome','unissex','10','2022-02-15 21:16:53','2022-02-15 21:16:53'),(3,1,'teste','#de17a4','1000','2022-02-17 17:14:57','n sei oq é','Consome','unissex','100','2022-02-17 17:15:00','2022-02-17 17:15:00'),(4,1,'oãoJ','#e3b3d9','1000','2022-02-18 16:55:16','n sei oq é','Consome','Feminino','111','2022-02-18 16:55:20','2022-02-18 16:55:20');
/*!40000 ALTER TABLE `tb_eve_lista_tipos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-21 16:40:06
