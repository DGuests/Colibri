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
-- Table structure for table `tb_usu_colaborador_fixo`
--

DROP TABLE IF EXISTS `tb_usu_colaborador_fixo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_usu_colaborador_fixo` (
  `p_fixo_id` int(11) NOT NULL,
  `f_fixo_estabelecimento` int(11) DEFAULT NULL,
  `f_fixo_usuario` int(11) DEFAULT NULL,
  `f_fixo_funcao` int(11) DEFAULT NULL,
  `e_fixo_status` enum('p','a','r') DEFAULT NULL,
  `t_fixo_data_cadastro` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`p_fixo_id`),
  KEY `f_fixo_estabelecimento` (`f_fixo_estabelecimento`),
  KEY `f_fixo_usuario` (`f_fixo_usuario`),
  KEY `f_fixo_funcao` (`f_fixo_funcao`),
  CONSTRAINT `tb_usu_colaborador_fixo_ibfk_1` FOREIGN KEY (`f_fixo_estabelecimento`) REFERENCES `tb_oc_estabelecimento` (`p_est_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `tb_usu_colaborador_fixo_ibfk_2` FOREIGN KEY (`f_fixo_usuario`) REFERENCES `tb_usu_usuario` (`p_usu_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `tb_usu_colaborador_fixo_ibfk_3` FOREIGN KEY (`f_fixo_funcao`) REFERENCES `tb_eve_funcao` (`p_func_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_usu_colaborador_fixo`
--

LOCK TABLES `tb_usu_colaborador_fixo` WRITE;
/*!40000 ALTER TABLE `tb_usu_colaborador_fixo` DISABLE KEYS */;
INSERT INTO `tb_usu_colaborador_fixo` VALUES (1,1,1,1,'a','2022-02-16 21:55:25','2022-02-16 20:28:19','2022-02-16 20:48:35'),(2,1,2,2,'a','2022-02-18 21:33:54','2022-02-18 21:33:59','2022-02-18 21:33:59');
/*!40000 ALTER TABLE `tb_usu_colaborador_fixo` ENABLE KEYS */;
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
