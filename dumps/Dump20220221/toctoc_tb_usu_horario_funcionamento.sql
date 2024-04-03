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
-- Table structure for table `tb_usu_horario_funcionamento`
--

DROP TABLE IF EXISTS `tb_usu_horario_funcionamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_usu_horario_funcionamento` (
  `p_hora_id` int(11) NOT NULL,
  `f_hora_usuario` int(11) DEFAULT NULL,
  `b_hora_show` tinyint(1) DEFAULT NULL,
  `t_hora_inicio_seg` time DEFAULT NULL,
  `t_hora_inicio_seg2` time DEFAULT NULL,
  `t_hora_fim_seg` time DEFAULT NULL,
  `t_hora_fim_seg2` time DEFAULT NULL,
  `t_hora_inicio_ter` time DEFAULT NULL,
  `t_hora_inicio_ter2` time DEFAULT NULL,
  `t_hora_fim_ter` time DEFAULT NULL,
  `t_hora_fim_ter2` time DEFAULT NULL,
  `t_hora_inicio_qua` time DEFAULT NULL,
  `t_hora_inicio_qua2` time DEFAULT NULL,
  `t_hora_fim_qua` time DEFAULT NULL,
  `t_hora_fim_qua2` time DEFAULT NULL,
  `t_hora_inicio_qui` time DEFAULT NULL,
  `t_hora_inicio_qui2` time DEFAULT NULL,
  `t_hora_fim_qui` time DEFAULT NULL,
  `t_hora_fim_qui2` time DEFAULT NULL,
  `t_hora_inicio_sex` time DEFAULT NULL,
  `t_hora_inicio_sex2` time DEFAULT NULL,
  `t_hora_fim_sex` time DEFAULT NULL,
  `t_hora_fim_sex2` time DEFAULT NULL,
  `t_hora_inicio_sab` time DEFAULT NULL,
  `t_hora_inicio_sab2` time DEFAULT NULL,
  `t_hora_fim_sab` time DEFAULT NULL,
  `t_hora_fim_sab2` time DEFAULT NULL,
  `t_hora_inicio_dom` time DEFAULT NULL,
  `t_hora_inicio_dom2` time DEFAULT NULL,
  `t_hora_fim_dom` time DEFAULT NULL,
  `t_hora_fim_dom2` time DEFAULT NULL,
  `t_hora_inicio_seg_delivery` time DEFAULT NULL,
  `t_hora_fim_seg_delivery` time DEFAULT NULL,
  `t_hora_inicio_ter_delivery` time DEFAULT NULL,
  `t_hora_fim_ter_delivery` time DEFAULT NULL,
  `t_hora_inicio_qua_delivery` time DEFAULT NULL,
  `t_hora_fim_qua_delivery` time DEFAULT NULL,
  `t_hora_inicio_qui_delivery` time DEFAULT NULL,
  `t_hora_fim_qui_delivery` time DEFAULT NULL,
  `t_hora_inicio_sex_delivery` time DEFAULT NULL,
  `t_hora_fim_sex_delivery` time DEFAULT NULL,
  `t_hora_inicio_sab_delivery` time DEFAULT NULL,
  `t_hora_fim_sab_delivery` time DEFAULT NULL,
  `t_hora_inicio_dom_delivery` time DEFAULT NULL,
  `t_hora_fim_dom_delivery` time DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`p_hora_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_usu_horario_funcionamento`
--

LOCK TABLES `tb_usu_horario_funcionamento` WRITE;
/*!40000 ALTER TABLE `tb_usu_horario_funcionamento` DISABLE KEYS */;
INSERT INTO `tb_usu_horario_funcionamento` VALUES (1,1,1,'21:00:00','22:00:00','21:30:00','23:30:00','21:00:00','22:00:00','21:30:00','22:30:00','21:00:00','22:00:00','21:30:00','22:30:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','13:00:00','2022-02-08 20:37:15','2022-02-15 21:12:41');
/*!40000 ALTER TABLE `tb_usu_horario_funcionamento` ENABLE KEYS */;
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
