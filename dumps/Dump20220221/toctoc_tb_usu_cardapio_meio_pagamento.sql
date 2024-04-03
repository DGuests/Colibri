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
-- Table structure for table `tb_usu_cardapio_meio_pagamento`
--

DROP TABLE IF EXISTS `tb_usu_cardapio_meio_pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_usu_cardapio_meio_pagamento` (
  `p_pag_id` int(11) NOT NULL,
  `f_pag_usuario` int(11) DEFAULT NULL,
  `b_pag_show` tinyint(1) DEFAULT NULL,
  `b_pag_dinheiro` tinyint(1) DEFAULT NULL,
  `b_pag_cartao_credito` tinyint(1) DEFAULT NULL,
  `b_pag_cartao_debito` tinyint(1) DEFAULT NULL,
  `s_pag_vale_refeicao` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`p_pag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_usu_cardapio_meio_pagamento`
--

LOCK TABLES `tb_usu_cardapio_meio_pagamento` WRITE;
/*!40000 ALTER TABLE `tb_usu_cardapio_meio_pagamento` DISABLE KEYS */;
INSERT INTO `tb_usu_cardapio_meio_pagamento` VALUES (1,1,1,1,1,1,'teste1','2022-02-08 19:01:43','2022-02-15 21:12:42');
/*!40000 ALTER TABLE `tb_usu_cardapio_meio_pagamento` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-21 16:40:05
