-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: DB_Colevueltas
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
<<<<<<< HEAD
=======
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
  UNIQUE KEY `uk_venta_calificador` (`id_venta`,`id_usuario_calificador`),
  KEY `id_usuario_calificador` (`id_usuario_calificador`),
  KEY `id_usuario_calificado` (`id_usuario_calificado`),
  CONSTRAINT `calificaciones_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `calificaciones_ibfk_2` FOREIGN KEY (`id_usuario_calificador`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `calificaciones_ibfk_3` FOREIGN KEY (`id_usuario_calificado`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
>>>>>>> e68f1a8 (subimos bien la base v1.2)
-- Dumping data for table `calificaciones`
--

LOCK TABLES `calificaciones` WRITE;
/*!40000 ALTER TABLE `calificaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `calificaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
<<<<<<< HEAD
=======
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
  KEY `idx_comprador_vendedor` (`id_usuario_comprador`,`id_usuario_vendedor`),
  CONSTRAINT `chats_ibfk_1` FOREIGN KEY (`id_publicacion`) REFERENCES `publicacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chats_ibfk_2` FOREIGN KEY (`id_usuario_comprador`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chats_ibfk_3` FOREIGN KEY (`id_usuario_vendedor`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
>>>>>>> e68f1a8 (subimos bien la base v1.2)
-- Dumping data for table `chats`
--

LOCK TABLES `chats` WRITE;
/*!40000 ALTER TABLE `chats` DISABLE KEYS */;
/*!40000 ALTER TABLE `chats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `colegio`
--

LOCK TABLES `colegio` WRITE;
/*!40000 ALTER TABLE `colegio` DISABLE KEYS */;
/*!40000 ALTER TABLE `colegio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `curso`
--

LOCK TABLES `curso` WRITE;
/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
/*!40000 ALTER TABLE `curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `favoritos`
--

LOCK TABLES `favoritos` WRITE;
/*!40000 ALTER TABLE `favoritos` DISABLE KEYS */;
/*!40000 ALTER TABLE `favoritos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `imagen_publicacion`
--

LOCK TABLES `imagen_publicacion` WRITE;
/*!40000 ALTER TABLE `imagen_publicacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `imagen_publicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
<<<<<<< HEAD
=======
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
  KEY `idx_chat` (`id_chat`),
  CONSTRAINT `mensajes_ibfk_1` FOREIGN KEY (`id_chat`) REFERENCES `chats` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mensajes_ibfk_2` FOREIGN KEY (`id_usuario_envia`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
>>>>>>> e68f1a8 (subimos bien la base v1.2)
-- Dumping data for table `mensajes`
--

LOCK TABLES `mensajes` WRITE;
/*!40000 ALTER TABLE `mensajes` DISABLE KEYS */;
/*!40000 ALTER TABLE `mensajes` ENABLE KEYS */;
UNLOCK TABLES;

--
<<<<<<< HEAD
-- Dumping data for table `niveles`
=======
-- Table structure for table `niveles`
--

DROP TABLE IF EXISTS `niveles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `niveles` (
  `nivel` int NOT NULL,
  `xp_necesaria` int NOT NULL COMMENT 'XP total necesaria para alcanzar este nivel',
  `nombre_nivel` varchar(50) DEFAULT NULL COMMENT 'Ej: Novato, Intermedio, Experto',
  PRIMARY KEY (`nivel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `niveles`
--

LOCK TABLES `niveles` WRITE;
/*!40000 ALTER TABLE `niveles` DISABLE KEYS */;
INSERT INTO `niveles` VALUES (1,0,'Novato'),(2,50,'Principiante'),(3,150,'Habitual'),(4,300,'Activo'),(5,500,'Entusiasta'),(6,800,'Veterano'),(7,1200,'Experto'),(8,1700,'Maestro'),(9,2500,'Coleccionista'),(10,5000,'Leyenda');
/*!40000 ALTER TABLE `niveles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificaciones`
>>>>>>> e68f1a8 (subimos bien la base v1.2)
--

LOCK TABLES `niveles` WRITE;
/*!40000 ALTER TABLE `niveles` DISABLE KEYS */;
INSERT INTO `niveles` VALUES (1,0,'Novato'),(2,50,'Principiante'),(3,150,'Habitual'),(4,300,'Activo'),(5,500,'Entusiasta'),(6,800,'Veterano'),(7,1200,'Experto'),(8,1700,'Maestro'),(9,2500,'Coleccionista'),(10,5000,'Leyenda');
/*!40000 ALTER TABLE `niveles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `notificaciones`
--

LOCK TABLES `notificaciones` WRITE;
/*!40000 ALTER TABLE `notificaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `notificaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
<<<<<<< HEAD
=======
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
  `descuento_fecha_inicio` datetime DEFAULT NULL,
  `descuento_fecha_fin` datetime DEFAULT NULL,
  `id_categoria` int NOT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario_vendedor` (`id_usuario_vendedor`),
  KEY `id_categoria` (`id_categoria`),
  KEY `idx_busqueda` (`estado`,`id_categoria`,`precio`),
  CONSTRAINT `publicacion_ibfk_1` FOREIGN KEY (`id_usuario_vendedor`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `publicacion_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
>>>>>>> e68f1a8 (subimos bien la base v1.2)
-- Dumping data for table `publicacion`
--

LOCK TABLES `publicacion` WRITE;
/*!40000 ALTER TABLE `publicacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `publicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `publicacion_colegio`
--

LOCK TABLES `publicacion_colegio` WRITE;
/*!40000 ALTER TABLE `publicacion_colegio` DISABLE KEYS */;
/*!40000 ALTER TABLE `publicacion_colegio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `publicacion_curso`
--

LOCK TABLES `publicacion_curso` WRITE;
/*!40000 ALTER TABLE `publicacion_curso` DISABLE KEYS */;
/*!40000 ALTER TABLE `publicacion_curso` ENABLE KEYS */;
UNLOCK TABLES;

--
<<<<<<< HEAD
-- Dumping data for table `reportes`
--

LOCK TABLES `reportes` WRITE;
/*!40000 ALTER TABLE `reportes` DISABLE KEYS */;
/*!40000 ALTER TABLE `reportes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `reportes_motivos`
--

LOCK TABLES `reportes_motivos` WRITE;
/*!40000 ALTER TABLE `reportes_motivos` DISABLE KEYS */;
INSERT INTO `reportes_motivos` VALUES (1,'PUBLICACION_ENGAÑOSA','La publicación es engañosa o el producto no coincide','PUBLICACION',1),(2,'PRODUCTO_PROHIBIDO','El producto está prohibido por las normas del sitio','PUBLICACION',1),(3,'PRECIO_IRREAL','El precio de la publicación es claramente irreal o engañoso','PUBLICACION',1),(4,'CHAT_ACOSO','He recibido mensajes ofensivos o acoso en el chat','CHAT',1),(5,'CHAT_SPAM','He recibido spam o publicidad no deseada','CHAT',1),(6,'INTENTO_ESTAFA','El usuario intentó estafarme','GENERAL',1),(7,'NO_SE_PRESENTO','El usuario no se presentó en el punto de encuentro acordado','VENTA',1),(8,'PERFIL_FALSO','Creo que el perfil del usuario es falso','USUARIO',1),(9,'COMENTARIO_OFENSIVO','La calificación contiene un comentario ofensivo','CALIFICACION',1),(10,'OTRO','Otro motivo no listado','GENERAL',1);
/*!40000 ALTER TABLE `reportes_motivos` ENABLE KEYS */;
UNLOCK TABLES;
=======
-- Table structure for table `reportes`
--

DROP TABLE IF EXISTS `reportes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reportes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario_reportante` int NOT NULL,
  `id_usuario_reportado` int NOT NULL,
  `id_motivo` int NOT NULL COMMENT 'Referencia a reportes_motivos.id',
  `descripcion_adicional` text COMMENT 'Detalles adicionales del usuario',
  `tipo_referencia` enum('PUBLICACION','CHAT','VENTA','USUARIO','CALIFICACION') NOT NULL COMMENT 'Contexto del reporte',
  `id_referencia` int NOT NULL COMMENT 'ID del elemento reportado (publicación, chat, etc.)',
  `estado` enum('Pendiente','En Revision','Resuelto') NOT NULL DEFAULT 'Pendiente',
  `resolucion` text COMMENT 'Notas del administrador sobre la resolución',
  `fecha_reporte` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_resolucion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_reportado_estado` (`id_usuario_reportado`,`estado`),
  KEY `fk_reportes_reportante` (`id_usuario_reportante`),
  KEY `fk_reportes_motivo` (`id_motivo`),
  CONSTRAINT `fk_reportes_motivo` FOREIGN KEY (`id_motivo`) REFERENCES `reportes_motivos` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_reportes_reportado` FOREIGN KEY (`id_usuario_reportado`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_reportes_reportante` FOREIGN KEY (`id_usuario_reportante`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reportes`
--

LOCK TABLES `reportes` WRITE;
/*!40000 ALTER TABLE `reportes` DISABLE KEYS */;
/*!40000 ALTER TABLE `reportes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reportes_motivos`
--

DROP TABLE IF EXISTS `reportes_motivos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reportes_motivos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo_motivo` varchar(50) NOT NULL COMMENT 'Identificador único para el backend',
  `descripcion` varchar(255) NOT NULL COMMENT 'Texto que se muestra al usuario',
  `tipo_contexto` enum('PUBLICACION','CHAT','VENTA','USUARIO','CALIFICACION','GENERAL') NOT NULL COMMENT 'Ayuda a filtrar motivos relevantes',
  `activo` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Permite desactivar motivos sin borrarlos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_codigo_motivo` (`codigo_motivo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reportes_motivos`
--

LOCK TABLES `reportes_motivos` WRITE;
/*!40000 ALTER TABLE `reportes_motivos` DISABLE KEYS */;
INSERT INTO `reportes_motivos` VALUES (1,'PUBLICACION_ENGAÑOSA','La publicación es engañosa o el producto no coincide','PUBLICACION',1),(2,'PRODUCTO_PROHIBIDO','El producto está prohibido por las normas del sitio','PUBLICACION',1),(3,'PRECIO_IRREAL','El precio de la publicación es claramente irreal o engañoso','PUBLICACION',1),(4,'CHAT_ACOSO','He recibido mensajes ofensivos o acoso en el chat','CHAT',1),(5,'CHAT_SPAM','He recibido spam o publicidad no deseada','CHAT',1),(6,'INTENTO_ESTAFA','El usuario intentó estafarme','GENERAL',1),(7,'NO_SE_PRESENTO','El usuario no se presentó en el punto de encuentro acordado','VENTA',1),(8,'PERFIL_FALSO','Creo que el perfil del usuario es falso','USUARIO',1),(9,'COMENTARIO_OFENSIVO','La calificación contiene un comentario ofensivo','CALIFICACION',1),(10,'OTRO','Otro motivo no listado','GENERAL',1);
/*!40000 ALTER TABLE `reportes_motivos` ENABLE KEYS */;
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
  `dni` int DEFAULT NULL,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `genero` enum('Masculino','Femenino','Otro') DEFAULT 'Otro',
  `fecha_nacimiento` date DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `xp` int NOT NULL DEFAULT '0',
  `nivel` int DEFAULT '1',
  `es_verificado` tinyint(1) DEFAULT '0',
  `calificacion_vendedor_promedio` decimal(3,2) DEFAULT NULL,
  `total_calificaciones_vendedor` int DEFAULT '0',
  `calificacion_comprador_promedio` decimal(3,2) DEFAULT NULL,
  `total_calificaciones_comprador` int DEFAULT '0',
  `fecha_eliminacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mail` (`mail`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
>>>>>>> e68f1a8 (subimos bien la base v1.2)

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

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

<<<<<<< HEAD
-- Dump completed on 2025-10-22  9:08:03
=======
-- Dump completed on 2025-10-22  9:28:39
>>>>>>> e68f1a8 (subimos bien la base v1.2)
