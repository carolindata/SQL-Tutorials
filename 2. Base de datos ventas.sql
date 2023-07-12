-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: storesales
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
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `Id_prod` int NOT NULL AUTO_INCREMENT,
  `Categoría` varchar(100) NOT NULL,
  `Producto` varchar(100) DEFAULT NULL,
  `costo` int DEFAULT NULL,
  PRIMARY KEY (`Id_prod`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Herramientas','Martillo de carpintero',15),(2,'Herramientas','Destornillador Phillips',5),(3,'Herramientas','Sierra circular',45),(4,'Herramientas','Llave inglesa',10),(5,'Accesorios','Cinta métrica',7),(6,'Accesorios','Gafas de seguridad',12),(7,'Accesorios','Guantes de trabajo',8),(8,'Pintura mural','Pintura de pared blanca',20),(9,'Pintura mural','Pintura de pared gris',25),(10,'Pintura mural','Pintura de pared beige',30),(11,'Pintura mural','Pintura de pared amarilla',35),(12,'Pintura mural','Pintura de pared roja',40),(13,'Pintura mural','Pintura de pared azul',45),(14,'Pintura en spray','Pintura en spray negra',10),(15,'Pintura en spray','Pintura en spray blanca',10),(16,'Pintura en spray','Pintura en spray dorada',15),(17,'Pintura en spray','Pintura en spray plateada',15),(18,'Pintura en spray','Pintura en spray verde',10),(19,'Pintura en spray','Pintura en spray roja',10);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tiendas`
--

DROP TABLE IF EXISTS `tiendas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tiendas` (
  `Id_tienda` int NOT NULL AUTO_INCREMENT,
  `País` varchar(45) DEFAULT NULL,
  `Ciudad` varchar(45) DEFAULT NULL,
  `Nombre_tienda` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id_tienda`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiendas`
--

LOCK TABLES `tiendas` WRITE;
/*!40000 ALTER TABLE `tiendas` DISABLE KEYS */;
INSERT INTO `tiendas` VALUES (1,'Argentina','Buenos Aires','Pintuland'),(2,'Perú','Lima','La casa del pintor'),(3,'México','Ciudad de México','Pinturama'),(4,'Colombia','Bogotá','Super Pinturas');
/*!40000 ALTER TABLE `tiendas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendedores`
--

DROP TABLE IF EXISTS `vendedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendedores` (
  `Id_vend` int NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `Apellido` varchar(45) DEFAULT NULL,
  `Tienda` int DEFAULT NULL,
  `Salario` int DEFAULT NULL,
  PRIMARY KEY (`Id_vend`),
  KEY `Id_vend_idx` (`Tienda`),
  CONSTRAINT `Id_vend` FOREIGN KEY (`Tienda`) REFERENCES `tiendas` (`Id_tienda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendedores`
--

LOCK TABLES `vendedores` WRITE;
/*!40000 ALTER TABLE `vendedores` DISABLE KEYS */;
INSERT INTO `vendedores` VALUES (1,'Juan','Pérez',1,2000),(2,'María','González',2,2500),(3,'Pedro','Sánchez',3,2200),(4,'Ana','López',4,2800),(5,'Luis','Hernández',1,1900),(6,'Lucía','Martínez',2,2700),(7,'Carlos','Ramírez',3,2400),(8,'Sofía','Díaz',4,3000);
/*!40000 ALTER TABLE `vendedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `Id_Vtas` int NOT NULL AUTO_INCREMENT,
  `Producto` int NOT NULL,
  `Vendedor` int NOT NULL,
  `Tienda` int NOT NULL,
  `Unidades` int NOT NULL,
  `Venta_total_$` int NOT NULL,
  `Fecha_venta` date NOT NULL,
  PRIMARY KEY (`Id_Vtas`),
  KEY `Id_produ_idx` (`Producto`),
  KEY `Id_vended_idx` (`Vendedor`),
  KEY `Id_Tienda_idx` (`Tienda`),
  CONSTRAINT `Id_produ` FOREIGN KEY (`Producto`) REFERENCES `productos` (`Id_prod`),
  CONSTRAINT `Id_Tienda` FOREIGN KEY (`Tienda`) REFERENCES `tiendas` (`Id_tienda`),
  CONSTRAINT `Id_vended` FOREIGN KEY (`Vendedor`) REFERENCES `vendedores` (`Id_vend`)
) ENGINE=InnoDB AUTO_INCREMENT=355 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (268,1,1,1,10,100,'2023-01-01'),(269,2,2,2,20,200,'2023-01-02'),(270,3,3,3,30,300,'2023-01-03'),(271,4,4,4,40,400,'2023-01-04'),(272,5,5,1,50,500,'2023-01-05'),(273,6,6,2,60,600,'2023-01-06'),(274,7,7,3,70,700,'2023-01-07'),(275,8,8,4,80,800,'2023-01-08'),(276,9,1,1,90,900,'2023-01-09'),(277,10,2,2,100,1000,'2023-01-10'),(278,11,3,3,110,1100,'2023-01-11'),(279,12,4,4,120,1200,'2023-01-12'),(280,13,5,1,130,1300,'2023-01-13'),(281,14,6,2,140,1400,'2023-01-14'),(282,15,7,3,150,1500,'2023-01-15'),(283,16,8,4,160,1600,'2023-01-16'),(284,17,1,1,170,1700,'2023-01-17'),(285,18,2,2,180,1800,'2023-01-18'),(286,19,3,3,190,1900,'2023-01-19'),(287,1,4,4,200,2000,'2023-01-20'),(288,2,5,1,210,2100,'2023-01-21'),(289,3,6,2,220,2200,'2023-01-22'),(290,4,7,3,230,2300,'2023-01-23'),(291,5,8,4,240,2400,'2023-01-24'),(292,6,1,1,250,2500,'2023-01-25'),(293,7,2,2,260,2600,'2023-01-26'),(294,8,3,3,270,2700,'2023-01-27'),(295,9,4,4,280,2800,'2023-01-28'),(296,10,5,1,290,2900,'2023-01-29'),(297,12,6,3,50,500,'2023-02-01'),(298,13,7,4,60,600,'2023-02-02'),(299,14,8,1,70,700,'2023-02-03'),(300,15,1,2,80,800,'2023-02-04'),(301,16,2,3,90,900,'2023-02-05'),(302,17,3,4,100,1000,'2023-02-06'),(303,18,4,1,110,1100,'2023-02-07'),(304,19,5,2,120,1200,'2023-02-08'),(305,1,6,3,130,1300,'2023-02-09'),(306,2,7,4,140,1400,'2023-02-10'),(307,3,8,1,150,1500,'2023-02-11'),(308,4,1,2,160,1600,'2023-02-12'),(309,5,2,3,170,1700,'2023-02-13'),(310,6,3,4,180,1800,'2023-02-14'),(311,7,4,1,190,1900,'2023-02-15'),(312,8,5,2,200,2000,'2023-02-16'),(313,9,6,3,210,2100,'2023-02-17'),(314,10,7,4,220,2200,'2023-02-18'),(315,11,8,1,230,2300,'2023-02-19'),(316,12,1,2,240,2400,'2023-02-20'),(317,13,2,3,250,2500,'2023-02-21'),(318,14,3,4,260,2600,'2023-02-22'),(319,15,4,1,270,2700,'2023-02-23'),(320,16,5,2,280,2800,'2023-02-24'),(321,17,6,3,290,2900,'2023-02-25'),(322,18,7,4,300,3000,'2023-02-26'),(323,11,8,1,310,3100,'2023-02-27'),(324,1,1,2,320,3200,'2023-02-28'),(325,2,2,3,330,3300,'2023-03-01'),(326,4,1,1,15,150,'2023-03-02'),(327,7,2,2,24,240,'2023-03-03'),(328,10,3,3,33,330,'2023-03-04'),(329,13,4,4,42,420,'2023-03-05'),(330,16,5,1,51,510,'2023-03-06'),(331,19,6,2,60,600,'2023-03-07'),(332,2,7,3,69,690,'2023-03-08'),(333,5,8,4,78,780,'2023-03-09'),(334,8,1,1,87,870,'2023-03-10'),(335,11,2,2,96,960,'2023-03-11'),(336,14,3,3,105,1050,'2023-03-12'),(337,17,4,4,114,1140,'2023-03-13'),(338,1,5,1,123,1230,'2023-03-14'),(339,4,6,2,132,1320,'2023-03-15'),(340,7,7,3,141,1410,'2023-03-16'),(341,10,8,4,150,1500,'2023-03-17'),(342,13,1,1,159,1590,'2023-03-18'),(343,16,2,2,168,1680,'2023-03-19'),(344,19,3,3,177,1770,'2023-03-20'),(345,2,4,4,186,1860,'2023-03-21'),(346,5,5,1,195,1950,'2023-03-22'),(347,8,6,2,204,2040,'2023-03-23'),(348,11,7,3,213,2130,'2023-03-24'),(349,14,8,4,222,2220,'2023-03-25'),(350,17,1,1,231,2310,'2023-03-26'),(351,1,2,2,240,2400,'2023-03-27'),(352,4,3,3,249,2490,'2023-03-28'),(353,7,4,4,258,2580,'2023-03-29'),(354,10,5,1,267,2670,'2023-03-30');
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-24 23:31:09
