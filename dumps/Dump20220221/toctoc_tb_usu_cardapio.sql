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
-- Table structure for table `tb_usu_cardapio`
--

DROP TABLE IF EXISTS `tb_usu_cardapio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_usu_cardapio` (
  `p_usu_car_id` int(11) NOT NULL AUTO_INCREMENT,
  `f_usu_car_usuario` int(11) DEFAULT NULL,
  `b_usu_car_wpp` tinyint(1) DEFAULT NULL,
  `n_usu_car_entrega` float DEFAULT NULL,
  `b_usu_car_exige_entrega` tinyint(1) DEFAULT NULL,
  `b_usu_car_permite_retirar` tinyint(1) DEFAULT NULL,
  `s_usu_car_telefone` varchar(255) DEFAULT NULL,
  `s_usu_car_nascimento` varchar(255) DEFAULT NULL,
  `b_usu_car_exige_login` tinyint(1) DEFAULT NULL,
  `t_usu_car_hora_inicio` varchar(255) DEFAULT NULL,
  `t_usu_car_hora_fim` varchar(255) DEFAULT NULL,
  `s_usu_car_wifi_rede` varchar(255) DEFAULT NULL,
  `s_usu_car_wifi` varchar(255) DEFAULT NULL,
  `s_usu_car_tipo_estabelecimento` varchar(255) DEFAULT NULL,
  `s_usu_car_observacao` varchar(255) DEFAULT NULL,
  `n_usu_car_tempo_entrega` varchar(255) DEFAULT NULL,
  `s_usu_car_cor_cardapio` varchar(255) DEFAULT NULL,
  `b_usu_car_template_novo` tinyint(1) DEFAULT NULL,
  `b_usu_car_avaliacao` tinyint(1) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`p_usu_car_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_usu_cardapio`
--

LOCK TABLES `tb_usu_cardapio` WRITE;
/*!40000 ALTER TABLE `tb_usu_cardapio` DISABLE KEYS */;
INSERT INTO `tb_usu_cardapio` VALUES (1,1,1,10.5,1,0,'11940028922','25/11/2001',0,'20:00:00','00:00:00','wifiFera1','coxinha1231','Bar','Só comida boa','30min','#1da861',1,0,'2022-02-08 19:58:01','2022-02-15 21:12:41',NULL),(2,2,1,10.5,1,0,'11940028922','26/11/2001',0,'20:00:00','00:00:00','wifiFera','coxinha123','Bar','Só comida boa','30min','#ffffff',1,0,'2022-02-08 20:15:01','2022-02-08 20:15:01','2022-02-08 20:15:20');
/*!40000 ALTER TABLE `tb_usu_cardapio` ENABLE KEYS */;
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
