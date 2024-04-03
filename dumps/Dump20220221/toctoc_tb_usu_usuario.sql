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
-- Table structure for table `tb_usu_usuario`
--

DROP TABLE IF EXISTS `tb_usu_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_usu_usuario` (
  `p_usu_id` int(11) NOT NULL AUTO_INCREMENT,
  `s_usu_nome` varchar(255) NOT NULL,
  `s_usu_slug` varchar(255) DEFAULT NULL,
  `s_usu_documento` varchar(255) DEFAULT '00000000000',
  `s_usu_email` varchar(255) DEFAULT NULL,
  `s_usu_celular` varchar(255) DEFAULT NULL,
  `s_usu_senha_oc` varchar(255) NOT NULL,
  `t_usu_data_cadastro` datetime DEFAULT NULL,
  `s_usu_foto` varchar(255) DEFAULT NULL,
  `s_usu_banner` varchar(255) DEFAULT NULL,
  `s_usu_instagram` varchar(255) DEFAULT NULL,
  `s_usu_facebook` varchar(255) DEFAULT NULL,
  `b_usu_comum` tinyint(1) DEFAULT '1',
  `b_usu_email_validado_oc` tinyint(1) DEFAULT '0',
  `f_usu_cidade` varchar(255) DEFAULT NULL,
  `s_usu_endereco` varchar(255) DEFAULT NULL,
  `s_usu_latitude` varchar(255) DEFAULT NULL,
  `s_usu_longitude` varchar(255) DEFAULT NULL,
  `b_colaborador_parceiro_oc` tinyint(1) DEFAULT '0',
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`p_usu_id`),
  UNIQUE KEY `tb_usu_usuario_slug_unique` (`s_usu_slug`),
  UNIQUE KEY `tb_usu_usuario_documento_unique` (`s_usu_documento`),
  UNIQUE KEY `tb_usu_usuario_email_unique` (`s_usu_email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_usu_usuario`
--

LOCK TABLES `tb_usu_usuario` WRITE;
/*!40000 ALTER TABLE `tb_usu_usuario` DISABLE KEYS */;
INSERT INTO `tb_usu_usuario` VALUES (1,'Bar Modelo1','BMaaaaa1','11111111111111','joao1@gmail.com','(11) 94004-8921','1234','2022-07-02 03:00:00','https://dg-media.com.br/avatars/avatar_1021.png?v=1635522931','https://www.dguests.com/uploads/banners/banner_1021.png?v=1606856037','barmodelosss1','barmodeloaaa1',1,0,'São Paulo','Avenida Paulista, 51 - Bela Vista, São Paulo - SP, Brasil','0.2131213','1.2321317',0,'2022-02-07 21:51:52','2022-02-07 21:51:52',NULL),(2,'Bar Modelo bbbb','BMAAA','11111111111121','jo2ao@gmail.com','11946048922','1234','2022-07-02 03:00:00',NULL,NULL,'@teste','fbok.com/aaa',1,0,'São Paulo','Av. Paulista','0.2131213','1.2321317',0,'2022-02-08 16:13:20','2022-02-08 16:24:02','2022-02-08 16:24:18'),(3,'Bar Modelo','BMAoo','11111111111131','jo3ao@gmail.com','11946048922','1234','2022-07-02 03:00:00',NULL,NULL,'@teste','fbok.com/aaa',1,0,'São Paulo','Av. Paulista','0.2131213','1.2321317',0,'2022-02-08 16:23:19','2022-02-08 16:23:19',NULL),(4,'20MATAR70CORRER','lastdance19h','11111111111','lindao@gmail.com','11932323232','semfnxsemmajor','2022-02-18 18:20:00',NULL,NULL,'lastdance','lastdance',1,1,'1','aa','0.092312','0.987321',1,'2022-02-18 18:21:12','2022-02-18 18:21:12',NULL),(5,'teste123','aaa','11111111131','banana@gmail.com','11932323222','aaaa','2022-02-21 19:00:00',NULL,NULL,'aaaa','aaaa',1,1,'2','111','0.092342','0.987221',1,'2022-02-21 19:03:28','2022-02-21 19:03:28',NULL);
/*!40000 ALTER TABLE `tb_usu_usuario` ENABLE KEYS */;
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
