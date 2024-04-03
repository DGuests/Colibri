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
-- Table structure for table `tb_oc_estabelecimento`
--

DROP TABLE IF EXISTS `tb_oc_estabelecimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_oc_estabelecimento` (
  `p_est_id` int(11) NOT NULL,
  `f_est_usuario` int(11) DEFAULT NULL,
  `f_est_tipo_1` int(11) DEFAULT NULL,
  `f_est_tipo_2` int(11) DEFAULT NULL,
  `f_est_tipo_3` int(11) DEFAULT NULL,
  `f_est_regiao` int(11) DEFAULT NULL,
  `s_est_preco` varchar(255) DEFAULT NULL,
  `s_est_descricao` varchar(255) DEFAULT NULL,
  `t_est_hora_inicio` datetime DEFAULT NULL,
  `t_est_hora_fim` varchar(255) DEFAULT NULL,
  `s_est_foto` varchar(255) DEFAULT NULL,
  `s_est_endereco` varchar(255) DEFAULT NULL,
  `s_est_site` varchar(255) DEFAULT NULL,
  `b_est_vallet` tinyint(1) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`p_est_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_oc_estabelecimento`
--

LOCK TABLES `tb_oc_estabelecimento` WRITE;
/*!40000 ALTER TABLE `tb_oc_estabelecimento` DISABLE KEYS */;
INSERT INTO `tb_oc_estabelecimento` VALUES (1,1,1,2,3,10,'MAIOR QUE R$100','testeaaa1','2022-08-02 16:00:00','08/02/2022 22:00:00','https://dg-media.com.br/avatars/avatar_1021.png?v=1635522931','Avenida Paulista, 51 - Bela Vista, São Paulo - SP, Brasil','www.fezoupdate.com',1,'2022-02-08 17:03:20','2022-02-08 17:43:36',NULL),(2,2,1,2,3,10,'100','teste','2022-08-02 16:00:00','08/02/2022 22:00:00',NULL,'sao paulo - sp','www.google.com',0,'2022-02-08 21:24:50','2022-02-08 21:24:50',NULL);
/*!40000 ALTER TABLE `tb_oc_estabelecimento` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-21 16:40:03
