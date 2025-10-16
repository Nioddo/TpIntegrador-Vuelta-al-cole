-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: Cole_vueltas_Database
-- ------------------------------------------------------
-- Server version	8.0.43-0ubuntu0.24.04.2

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
-- Table structure for table `calificaciones`
--

DROP TABLE IF EXISTS `calificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calificaciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_venta` int NOT NULL,
  `id_usuario_calificador` int NOT NULL,
  `id_usuario_calificado` int NOT NULL,
  `rol_calificado` enum('Vendedor','Comprador') NOT NULL,
  `puntuacion` tinyint NOT NULL,
  `comentario` text,
  `fecha_calificacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_venta` (`id_venta`),
  KEY `id_usuario_calificador` (`id_usuario_calificador`),
  KEY `id_usuario_calificado` (`id_usuario_calificado`),
  CONSTRAINT `calificaciones_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `calificaciones_ibfk_2` FOREIGN KEY (`id_usuario_calificador`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `calificaciones_ibfk_3` FOREIGN KEY (`id_usuario_calificado`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calificaciones`
--

LOCK TABLES `calificaciones` WRITE;
/*!40000 ALTER TABLE `calificaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `calificaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categoria_padre` int DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categoria_padre` (`categoria_padre`),
  CONSTRAINT `categoria_ibfk_1` FOREIGN KEY (`categoria_padre`) REFERENCES `categoria` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chats`
--

DROP TABLE IF EXISTS `chats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chats` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_publicacion` int NOT NULL,
  `id_usuario_comprador` int NOT NULL,
  `id_usuario_vendedor` int NOT NULL,
  `estado` enum('Activo','Archivado','Vendido') DEFAULT 'Activo',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_ultima_actividad` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `chat_unico` (`id_publicacion`,`id_usuario_comprador`),
  KEY `id_usuario_comprador` (`id_usuario_comprador`),
  KEY `id_usuario_vendedor` (`id_usuario_vendedor`),
  CONSTRAINT `chats_ibfk_1` FOREIGN KEY (`id_publicacion`) REFERENCES `publicacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chats_ibfk_2` FOREIGN KEY (`id_usuario_comprador`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chats_ibfk_3` FOREIGN KEY (`id_usuario_vendedor`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chats`
--

LOCK TABLES `chats` WRITE;
/*!40000 ALTER TABLE `chats` DISABLE KEYS */;
/*!40000 ALTER TABLE `chats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colegio`
--

DROP TABLE IF EXISTS `colegio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `colegio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colegio`
--

LOCK TABLES `colegio` WRITE;
/*!40000 ALTER TABLE `colegio` DISABLE KEYS */;
/*!40000 ALTER TABLE `colegio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `id_colegio` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_colegio` (`id_colegio`),
  CONSTRAINT `curso_ibfk_1` FOREIGN KEY (`id_colegio`) REFERENCES `colegio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso`
--

LOCK TABLES `curso` WRITE;
/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
/*!40000 ALTER TABLE `curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favoritos`
--

DROP TABLE IF EXISTS `favoritos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favoritos` (
  `id_usuario` int NOT NULL,
  `id_publicacion` int NOT NULL,
  PRIMARY KEY (`id_usuario`,`id_publicacion`),
  KEY `id_publicacion` (`id_publicacion`),
  CONSTRAINT `favoritos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `favoritos_ibfk_2` FOREIGN KEY (`id_publicacion`) REFERENCES `publicacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favoritos`
--

LOCK TABLES `favoritos` WRITE;
/*!40000 ALTER TABLE `favoritos` DISABLE KEYS */;
/*!40000 ALTER TABLE `favoritos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imagen_publicacion`
--

DROP TABLE IF EXISTS `imagen_publicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `imagen_publicacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_publicacion` int NOT NULL,
  `url_imagen` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_publicacion` (`id_publicacion`),
  CONSTRAINT `imagen_publicacion_ibfk_1` FOREIGN KEY (`id_publicacion`) REFERENCES `publicacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagen_publicacion`
--

LOCK TABLES `imagen_publicacion` WRITE;
/*!40000 ALTER TABLE `imagen_publicacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `imagen_publicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mensajes`
--

DROP TABLE IF EXISTS `mensajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensajes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_chat` int NOT NULL,
  `id_usuario_envia` int NOT NULL,
  `contenido` text NOT NULL,
  `fecha_envio` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `leido` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id_chat` (`id_chat`),
  KEY `id_usuario_envia` (`id_usuario_envia`),
  CONSTRAINT `mensajes_ibfk_1` FOREIGN KEY (`id_chat`) REFERENCES `chats` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mensajes_ibfk_2` FOREIGN KEY (`id_usuario_envia`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensajes`
--

LOCK TABLES `mensajes` WRITE;
/*!40000 ALTER TABLE `mensajes` DISABLE KEYS */;
/*!40000 ALTER TABLE `mensajes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificaciones`
--

DROP TABLE IF EXISTS `notificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificaciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario_destino` int NOT NULL,
  `tipo` enum('MENSAJE_SIN_LEER','NIVEL_SUBIDO','NUEVA_CALIFICACION','PUBLICACION_VENCIDA') NOT NULL,
  `contenido` varchar(255) NOT NULL,
  `id_referencia` int DEFAULT NULL,
  `leida` tinyint(1) DEFAULT '0',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_usuario_destino` (`id_usuario_destino`),
  CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`id_usuario_destino`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificaciones`
--

LOCK TABLES `notificaciones` WRITE;
/*!40000 ALTER TABLE `notificaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `notificaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publicacion`
--

DROP TABLE IF EXISTS `publicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publicacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario_vendedor` int NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `descripcion` text,
  `precio` decimal(10,2) DEFAULT NULL,
  `condicion` enum('Nuevo','Excelente','Muy bueno','Bueno','Aceptable','Malo') DEFAULT NULL,
  `fecha_publicacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_ultima_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estado` enum('Activo','Pausado','Vendido','Inactivo','Necesita Revision') DEFAULT 'Activo',
  `descuento` decimal(5,2) DEFAULT '0.00',
  `id_categoria` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario_vendedor` (`id_usuario_vendedor`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `publicacion_ibfk_1` FOREIGN KEY (`id_usuario_vendedor`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `publicacion_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicacion`
--

LOCK TABLES `publicacion` WRITE;
/*!40000 ALTER TABLE `publicacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `publicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publicacion_colegio`
--

DROP TABLE IF EXISTS `publicacion_colegio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publicacion_colegio` (
  `id_publicacion` int NOT NULL,
  `id_colegio` int NOT NULL,
  PRIMARY KEY (`id_publicacion`,`id_colegio`),
  KEY `id_colegio` (`id_colegio`),
  CONSTRAINT `publicacion_colegio_ibfk_1` FOREIGN KEY (`id_publicacion`) REFERENCES `publicacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `publicacion_colegio_ibfk_2` FOREIGN KEY (`id_colegio`) REFERENCES `colegio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicacion_colegio`
--

LOCK TABLES `publicacion_colegio` WRITE;
/*!40000 ALTER TABLE `publicacion_colegio` DISABLE KEYS */;
/*!40000 ALTER TABLE `publicacion_colegio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publicacion_curso`
--

DROP TABLE IF EXISTS `publicacion_curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publicacion_curso` (
  `id_publicacion` int NOT NULL,
  `id_curso` int NOT NULL,
  PRIMARY KEY (`id_publicacion`,`id_curso`),
  KEY `id_curso` (`id_curso`),
  CONSTRAINT `publicacion_curso_ibfk_1` FOREIGN KEY (`id_publicacion`) REFERENCES `publicacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `publicacion_curso_ibfk_2` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicacion_curso`
--

LOCK TABLES `publicacion_curso` WRITE;
/*!40000 ALTER TABLE `publicacion_curso` DISABLE KEYS */;
/*!40000 ALTER TABLE `publicacion_curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `mail` varchar(100) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `dni` varchar(15) DEFAULT NULL,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `genero` enum('Masculino','Femenino','Otro') DEFAULT 'Otro',
  `fecha_nacimiento` date DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `nivel` int DEFAULT '1',
  `es_verificado` tinyint(1) DEFAULT '0',
  `calificacion_vendedor_promedio` decimal(3,2) DEFAULT NULL,
  `total_calificaciones_vendedor` int DEFAULT '0',
  `calificacion_comprador_promedio` decimal(3,2) DEFAULT NULL,
  `total_calificaciones_comprador` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mail` (`mail`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_publicacion` int NOT NULL,
  `id_chat_origen` int DEFAULT NULL,
  `id_comprador` int NOT NULL,
  `id_vendedor` int NOT NULL,
  `precio_final` decimal(10,2) NOT NULL,
  `punto_entrega` varchar(255) DEFAULT NULL,
  `fecha_venta` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_publicacion` (`id_publicacion`),
  KEY `id_chat_origen` (`id_chat_origen`),
  KEY `id_comprador` (`id_comprador`),
  KEY `id_vendedor` (`id_vendedor`),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_publicacion`) REFERENCES `publicacion` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`id_chat_origen`) REFERENCES `chats` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ventas_ibfk_3` FOREIGN KEY (`id_comprador`) REFERENCES `usuarios` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ventas_ibfk_4` FOREIGN KEY (`id_vendedor`) REFERENCES `usuarios` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
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

-- Dump completed on 2025-10-15  9:51:53
