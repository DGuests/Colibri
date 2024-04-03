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
-- Table structure for table `tb_usu_link`
--

DROP TABLE IF EXISTS `tb_usu_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_usu_link` (
  `p_link_id` int(11) NOT NULL AUTO_INCREMENT,
  `f_link_usuario` int(11) DEFAULT NULL,
  `b_link_reserva_mesa` tinyint(1) DEFAULT NULL,
  `n_link_reserva_mesa_clicks` int(11) DEFAULT NULL,
  `b_link_cardapio` tinyint(1) DEFAULT NULL,
  `n_link_cardapio_clicks` int(11) DEFAULT NULL,
  `b_link_nome_lista` tinyint(1) DEFAULT NULL,
  `n_link_nome_lista_clicks` int(11) DEFAULT NULL,
  `b_link_comemorar` tinyint(1) DEFAULT NULL,
  `n_link_comemorar_clicks` int(11) DEFAULT NULL,
  `b_link_espera` tinyint(1) DEFAULT NULL,
  `b_link_localizacao` tinyint(1) DEFAULT NULL,
  `b_link_avaliacao` tinyint(1) DEFAULT NULL,
  `b_link_delivery` tinyint(1) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`p_link_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_usu_link`
--

LOCK TABLES `tb_usu_link` WRITE;
/*!40000 ALTER TABLE `tb_usu_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_usu_link` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-21 16:40:02
