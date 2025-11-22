CREATE DATABASE  IF NOT EXISTS `DB_coleNew` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `DB_coleNew`;
-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: localhost    Database: DB_coleNew
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
-- Table structure for table `bitacora_admin`
--

DROP TABLE IF EXISTS `bitacora_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bitacora_admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_admin_usuario` int NOT NULL,
  `accion_codigo` varchar(50) NOT NULL,
  `id_referencia_afectada` int DEFAULT NULL,
  `referencia_tabla` enum('PUBLICACION','USUARIO','CATEGORIA','COLEGIO','CURSO','VENTA','REPORTE') DEFAULT NULL COMMENT 'Indica a qué tabla apunta id_referencia_afectada',
  `motivo` text,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_bitacora_admin_usuario` (`id_admin_usuario`),
  KEY `fk_bitacora_admin_accion` (`accion_codigo`),
  CONSTRAINT `fk_bitacora_admin_accion` FOREIGN KEY (`accion_codigo`) REFERENCES `bitacora_admin_acciones` (`codigo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_bitacora_admin_usuario` FOREIGN KEY (`id_admin_usuario`) REFERENCES `usuarios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora_admin`
--

LOCK TABLES `bitacora_admin` WRITE;
/*!40000 ALTER TABLE `bitacora_admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `bitacora_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bitacora_admin_acciones`
--

DROP TABLE IF EXISTS `bitacora_admin_acciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bitacora_admin_acciones` (
  `codigo` varchar(50) NOT NULL COMMENT 'Código único para la acción, ej: HARD_DELETE_PUBLICACION',
  `descripcion` varchar(255) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora_admin_acciones`
--

LOCK TABLES `bitacora_admin_acciones` WRITE;
/*!40000 ALTER TABLE `bitacora_admin_acciones` DISABLE KEYS */;
INSERT INTO `bitacora_admin_acciones` VALUES ('ADMIN_BANEAR_USUARIO','Baneo (soft delete) de un usuario y sus publicaciones activas'),('ANULAR_VENTA','Anulación o reversión de una venta'),('APROBAR_REPORTE','Aprobación o validación de un reporte'),('BLOQUEAR_USUARIO','Bloqueo temporal o permanente de un usuario'),('CREAR_CATEGORIA','Creación de una nueva categoría'),('CREAR_COLEGIO','Alta de un nuevo colegio en el sistema'),('CREAR_CURSO','Alta de un nuevo curso'),('CREAR_PUBLICACION','Creación de una nueva publicación por un administrador'),('CREAR_REPORTE','Creación manual de un reporte'),('CREAR_USUARIO','Creación manual de un usuario desde el panel de administración'),('EDITAR_CATEGORIA','Modificación de una categoría existente'),('EDITAR_COLEGIO','Modificación de datos de un colegio'),('EDITAR_CURSO','Modificación de un curso existente'),('EDITAR_PUBLICACION','Modificación de los datos de una publicación existente'),('EDITAR_USUARIO','Edición de los datos de un usuario existente'),('ELIMINAR_CATEGORIA','Eliminación de una categoría'),('ELIMINAR_COLEGIO','Eliminación de un colegio'),('ELIMINAR_CURSO','Eliminación de un curso'),('ELIMINAR_USUARIO','Eliminación de un usuario por parte del administrador'),('HARD_DELETE_PUBLICACION','Eliminación permanente de una publicación'),('RECHAZAR_REPORTE','Rechazo de un reporte luego de revisión'),('REGISTRAR_VENTA','Registro manual de una venta'),('SOFT_DELETE_PUBLICACION','Desactivación o marcado como eliminada de una publicación');
/*!40000 ALTER TABLE `bitacora_admin_acciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calificaciones`
--

DROP TABLE IF EXISTS `calificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calificaciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_venta` int NOT NULL,
  `id_usuario_calificado` int NOT NULL COMMENT 'El ID del usuario que recibe la calificación',
  `calificado_rol` enum('Vendedor','Comprador') NOT NULL,
  `puntuacion` tinyint NOT NULL,
  `comentario` text,
  `fecha_calificacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_venta` (`id_venta`),
  UNIQUE KEY `uk_venta_rol` (`id_venta`,`calificado_rol`),
  KEY `fk_calificaciones_usuario_calificado` (`id_usuario_calificado`),
  CONSTRAINT `calificaciones_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_calificaciones_usuario_calificado` FOREIGN KEY (`id_usuario_calificado`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,NULL,'Objetos'),(2,NULL,'Uniformes'),(3,1,'Cuadernos'),(4,3,'Cuadernos rayados');
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
  `activo` bit(1) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colegio`
--

LOCK TABLES `colegio` WRITE;
/*!40000 ALTER TABLE `colegio` DISABLE KEYS */;
INSERT INTO `colegio` VALUES (1,'Colegio San Martín','Av. Rivadavia 2450, CABA','logos/sanmartin.png'),(2,'Instituto Belgrano','Calle Corrientes 1560, CABA','logos/belgrano.png'),(3,'Colegio Nuestra Señora de Luján','San Martín 785, Morón','logos/lujan.png'),(4,'Escuela Técnica N°1 Otto Krause','Av. Paseo Colón 650, CABA','logos/ottokrause.png'),(5,'Colegio Nacional Buenos Aires','Bolívar 263, CABA','logos/cnba.png'),(6,'Instituto San José','Av. Gaona 3250, Ramos Mejía','logos/sanjose.png'),(7,'Colegio Claretiano','Av. La Plata 1100, Caballito','logos/claretiano.png'),(8,'Escuela Normal Superior N°10','Charlone 343, CABA','logos/ens10.png');
/*!40000 ALTER TABLE `colegio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuracion`
--

DROP TABLE IF EXISTS `configuracion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configuracion` (
  `clave` varchar(50) NOT NULL COMMENT 'Clave única para el valor de configuración',
  `valor` varchar(255) NOT NULL COMMENT 'Valor de la configuración',
  PRIMARY KEY (`clave`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuracion`
--

LOCK TABLES `configuracion` WRITE;
/*!40000 ALTER TABLE `configuracion` DISABLE KEYS */;
INSERT INTO `configuracion` VALUES ('COMPRAS_PARA_VERIFICACION','5'),('MESES_PARA_HARD_DELETE','6');
/*!40000 ALTER TABLE `configuracion` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso`
--

LOCK TABLES `curso` WRITE;
/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
INSERT INTO `curso` VALUES (1,'1° Año A',1),(2,'1° Año B',1),(3,'2° Año A',1),(4,'3° Año',1),(5,'1° Año',2),(6,'2° Año',2),(7,'3° Año',2),(8,'1° Año A',3),(9,'2° Año B',3),(10,'3° Año Electrónica',4),(11,'4° Año Programación',4),(12,'5° Año Electrónica',4),(13,'1° Año',5),(14,'2° Año',5),(15,'3° Año',5),(16,'1° Año',6),(17,'2° Año',6),(18,'1° A',7),(19,'1° B',7),(20,'2° A',7),(21,'1° Año A',8),(22,'2° Año A',8),(23,'3° Año B',8);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagen_publicacion`
--

LOCK TABLES `imagen_publicacion` WRITE;
/*!40000 ALTER TABLE `imagen_publicacion` DISABLE KEYS */;
INSERT INTO `imagen_publicacion` VALUES (4,5,'https://res.cloudinary.com/dsrp5xbch/image/upload/v1762951531/publicaciones/5/h0lihjalas6lgcjtzk31.jpg'),(5,5,'https://res.cloudinary.com/dsrp5xbch/image/upload/v1762951534/publicaciones/5/jzbywgkhewsbw0vlaowp.jpg'),(6,6,'https://res.cloudinary.com/dsrp5xbch/image/upload/v1762951595/publicaciones/6/fwgqdqjjguqq5pwayjpk.jpg'),(7,7,'https://res.cloudinary.com/dsrp5xbch/image/upload/v1763129106/publicaciones/7/qagfa0a8ytmigohwx3fg.jpg'),(8,7,'https://res.cloudinary.com/dsrp5xbch/image/upload/v1763129107/publicaciones/7/ihhnh8s9fqwtlrwaivwx.jpg');
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
  KEY `idx_chat` (`id_chat`),
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
--

DROP TABLE IF EXISTS `notificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificaciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario_destino` int NOT NULL,
  `tipo_codigo` varchar(50) NOT NULL,
  `contenido` varchar(255) NOT NULL,
  `id_referencia` int DEFAULT NULL,
  `referencia_tabla` enum('CHAT','NIVEL','PUBLICACION','USUARIO','VENTA') DEFAULT NULL COMMENT 'Indica a qué tabla apunta id_referencia',
  `leida` tinyint(1) DEFAULT '0',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_usuario_destino` (`id_usuario_destino`),
  KEY `fk_notificaciones_tipo` (`tipo_codigo`),
  CONSTRAINT `fk_notificaciones_tipo` FOREIGN KEY (`tipo_codigo`) REFERENCES `tipo_notificacion` (`codigo`) ON DELETE RESTRICT ON UPDATE CASCADE,
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
  `titulo` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `precio` decimal(38,2) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicacion`
--

LOCK TABLES `publicacion` WRITE;
/*!40000 ALTER TABLE `publicacion` DISABLE KEYS */;
INSERT INTO `publicacion` VALUES (5,7,'Cuaderno rayado a4','Buen estado, le faltan dos paginas. Viene bien para lengua',4500.00,'Bueno','2025-11-12 12:45:30','2025-11-12 12:45:30','Activo',0.00,NULL,NULL,3,NULL),(6,7,'Tablero dibujo','Un poco rayado pero funciona bien. mide unos 45x50cm',30000.00,'Bueno','2025-11-12 12:46:34','2025-11-12 12:46:34','Activo',0.00,NULL,NULL,2,NULL),(7,7,'Remera de cole coloso','Tiene una mancha en la espalda',2500.00,'Bueno','2025-11-14 14:05:05','2025-11-14 14:05:05','Activo',0.00,NULL,NULL,1,NULL);
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
INSERT INTO `publicacion_colegio` VALUES (5,1),(6,1),(7,1);
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
INSERT INTO `publicacion_curso` VALUES (5,1),(6,1),(7,1);
/*!40000 ALTER TABLE `publicacion_curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publicacion_preguntas`
--

DROP TABLE IF EXISTS `publicacion_preguntas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publicacion_preguntas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_publicacion` int NOT NULL,
  `pregunta` text NOT NULL COMMENT 'Pregunta anónima del usuario',
  `fecha_pregunta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `respuesta` text COMMENT 'Respuesta única del vendedor',
  `fecha_respuesta` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_preguntas_publicacion` (`id_publicacion`),
  CONSTRAINT `fk_preguntas_publicacion` FOREIGN KEY (`id_publicacion`) REFERENCES `publicacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicacion_preguntas`
--

LOCK TABLES `publicacion_preguntas` WRITE;
/*!40000 ALTER TABLE `publicacion_preguntas` DISABLE KEYS */;
/*!40000 ALTER TABLE `publicacion_preguntas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporte_publicacion`
--

DROP TABLE IF EXISTS `reporte_publicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporte_publicacion` (
  `id_reporte` int NOT NULL,
  `id_publicacion` int NOT NULL,
  PRIMARY KEY (`id_reporte`),
  KEY `fk_reporte_pub_publicacion` (`id_publicacion`),
  CONSTRAINT `fk_reporte_pub_base` FOREIGN KEY (`id_reporte`) REFERENCES `reportes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_reporte_pub_publicacion` FOREIGN KEY (`id_publicacion`) REFERENCES `publicacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporte_publicacion`
--

LOCK TABLES `reporte_publicacion` WRITE;
/*!40000 ALTER TABLE `reporte_publicacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `reporte_publicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporte_usuario`
--

DROP TABLE IF EXISTS `reporte_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporte_usuario` (
  `id_reporte` int NOT NULL,
  `id_usuario_reportado` int NOT NULL,
  PRIMARY KEY (`id_reporte`),
  KEY `fk_reporte_usr_usuario` (`id_usuario_reportado`),
  CONSTRAINT `fk_reporte_usr_base` FOREIGN KEY (`id_reporte`) REFERENCES `reportes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_reporte_usr_usuario` FOREIGN KEY (`id_usuario_reportado`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporte_usuario`
--

LOCK TABLES `reporte_usuario` WRITE;
/*!40000 ALTER TABLE `reporte_usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `reporte_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reporte_venta`
--

DROP TABLE IF EXISTS `reporte_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reporte_venta` (
  `id_reporte` int NOT NULL,
  `id_venta` int NOT NULL,
  PRIMARY KEY (`id_reporte`),
  KEY `fk_reporte_vta_venta` (`id_venta`),
  CONSTRAINT `fk_reporte_vta_base` FOREIGN KEY (`id_reporte`) REFERENCES `reportes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_reporte_vta_venta` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reporte_venta`
--

LOCK TABLES `reporte_venta` WRITE;
/*!40000 ALTER TABLE `reporte_venta` DISABLE KEYS */;
/*!40000 ALTER TABLE `reporte_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reportes`
--

DROP TABLE IF EXISTS `reportes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reportes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario_reportante` int NOT NULL,
  `id_motivo` int NOT NULL COMMENT 'Referencia a reportes_motivos.id',
  `descripcion_adicional` text COMMENT 'Detalles adicionales del usuario',
  `estado` enum('Pendiente','En Revision','Resuelto') NOT NULL DEFAULT 'Pendiente',
  `resolucion` text COMMENT 'Notas del administrador sobre la resolución',
  `fecha_reporte` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_resolucion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_reportes_reportante` (`id_usuario_reportante`),
  KEY `fk_reportes_motivo` (`id_motivo`),
  CONSTRAINT `fk_reportes_motivo` FOREIGN KEY (`id_motivo`) REFERENCES `reportes_motivos` (`id`) ON DELETE RESTRICT,
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_codigo_motivo` (`codigo_motivo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reportes_motivos`
--

LOCK TABLES `reportes_motivos` WRITE;
/*!40000 ALTER TABLE `reportes_motivos` DISABLE KEYS */;
INSERT INTO `reportes_motivos` VALUES (1,'PUBLICACION_ENGAÑOSA','La publicación es engañosa o el producto no coincide','PUBLICACION'),(2,'PRODUCTO_PROHIBIDO','El producto está prohibido por las normas del sitio','PUBLICACION'),(3,'PRECIO_IRREAL','El precio de la publicación es claramente irreal o engañoso','PUBLICACION'),(4,'CHAT_ACOSO','He recibido mensajes ofensivos o acoso en el chat','CHAT'),(5,'CHAT_SPAM','He recibido spam o publicidad no deseada','CHAT'),(6,'INTENTO_ESTAFA','El usuario intentó estafarme','GENERAL'),(7,'NO_SE_PRESENTO','El usuario no se presentó en el punto de encuentro acordado','VENTA'),(8,'PERFIL_FALSO','Creo que el perfil del usuario es falso','USUARIO'),(9,'COMENTARIO_OFENSIVO','La calificación contiene un comentario ofensivo','CALIFICACION'),(10,'OTRO','Otro motivo no listado','GENERAL');
/*!40000 ALTER TABLE `reportes_motivos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_notificacion`
--

DROP TABLE IF EXISTS `tipo_notificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_notificacion` (
  `codigo` varchar(50) NOT NULL COMMENT 'Ej: NUEVO_MENSAJE, NIVEL_SUBIDO',
  `descripcion` varchar(255) NOT NULL,
  `icono` varchar(50) DEFAULT NULL COMMENT 'Opcional: un nombre de ícono para el frontend',
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_notificacion`
--

LOCK TABLES `tipo_notificacion` WRITE;
/*!40000 ALTER TABLE `tipo_notificacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_notificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `apellido` varchar(255) DEFAULT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `contraseña` varchar(255) NOT NULL,
  `dni` int DEFAULT NULL,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `genero` enum('Masculino','Femenino','Otro') DEFAULT 'Otro',
  `fecha_nacimiento` date DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `xp` int NOT NULL DEFAULT '0',
  `nivel` int DEFAULT '1',
  `es_verificado` tinyint(1) DEFAULT '0',
  `calificacion_vendedor_promedio` double DEFAULT NULL,
  `total_calificaciones_vendedor` int DEFAULT '0',
  `calificacion_comprador_promedio` double DEFAULT NULL,
  `total_calificaciones_comprador` int DEFAULT '0',
  `fecha_eliminacion` datetime DEFAULT NULL,
  `es_admin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 = Usuario regular, 1 = Administrador',
  `username` varchar(255) DEFAULT NULL,
  `biografia` varchar(2550) DEFAULT NULL,
  `envio` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mail` (`mail`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (4,'aa','a','b.b@a.com','$2a$10$AAbIuErl0oKU6NfEBL7x4.Nac2ZQr3vtNpgVBmedCGkV7BMRe7Nn6',68394827,'2025-11-12 11:51:21','Masculino','2007-05-20','+54 11 2344-5423',0,1,0,0,0,0,0,NULL,0,'aaaaaaaaaaaaaaaaaaaaaaaaaaaAaAa','Soy Thiago Miranda , acabo de terminar el cole en el Instituto Politecnico Modelo y estoy vendiendo mis uniformes porque ya no los voy a usar.','El envio lo podemos coordinar, o puedes pasarlo a buscar por Madrid',NULL),(5,'aa','a','h.b@a.com','$2a$10$A1VtMsQWxOzK/1/kAC07B.lhabuhDigf7jh9epnI/hDcp3Z1u1w2m',69394827,'2025-11-12 11:51:46','Masculino','2007-05-20','+54 11 2344-5423',0,1,0,0,0,0,0,NULL,0,'bbbbbbbbbbb','Soy Thiago Miranda , acabo de terminar el cole en el Instituto Politecnico Modelo y estoy vendiendo mis uniformes porque ya no los voy a usar.','El envio lo podemos coordinar, o puedes pasarlo a buscar por Madrid',NULL),(6,'Matias','Cardozo','matiCardozo@cursos.com','$2a$10$H3c3ahAwk9ch5.l1Zjn2feeYa2fEVb69cvwjDK0cS.V88EOaBnYtm',11212121,'2025-11-12 11:59:29','Masculino','2003-04-13','+54 11 2344-5423',0,1,0,0,0,0,0,NULL,0,'MatiCar03','Soy matias cardozo, tambien conocido como el colo ponzi. Estoy aca para vender todo lo que ya no uso ya que deje la uni cuando empeze a vender cursos. Si compras mi curso te doy un descuentito pero no se lo digas a nadie pq me banean. en fin no se que mas escribir para llegar al maximo de caracteres. Lorem ipsum dolor sit amet','El envio lo podemos coordinar, o puedes pasarlo a buscar por Madrid',NULL),(7,'Camila','Rossi','camila.rossi@ejemplo.com','$2a$10$UHyg1c04J99utldvX0/72O/aOwjy6wQgAoOJW2ecrMkzXWyIyZG/y',42789563,'2025-11-12 12:44:49','Femenino','2001-09-22','+54 9 11 6543-2810',0,1,0,0,0,0,0,NULL,0,'CamiRossi22','Soy Camila, estudiante de diseño gráfico y fanática del arte digital. Me encanta personalizar prendas y crear ilustraciones. Estoy vendiendo algunas cosas que ya no uso, desde tablets gráficas hasta materiales de dibujo. Si tenés alguna duda o querés ver más fotos de los productos, escribime sin problema :)','Puedo enviar por Correo Argentino o Andreani, según te quede más cómodo. También podés pasar a retirar por Palermo durante la semana.','Calle Fitz Roy 1280, CABA');
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
  `precio_final` double DEFAULT NULL,
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`alumno26.oddo.nicolas`@`localhost`*/ /*!50003 TRIGGER `trg_actualizar_nivel_por_venta` AFTER INSERT ON `ventas` FOR EACH ROW BEGIN
    DECLARE v_xp_ganada INT DEFAULT 25;
    
    -- Variables Comprador
    DECLARE v_es_admin_comprador TINYINT;
    DECLARE v_xp_actual_comprador INT;
    DECLARE v_nivel_actual_comprador INT;
    DECLARE v_nivel_nuevo_comprador INT;
    
    -- Variables Vendedor
    DECLARE v_es_admin_vendedor TINYINT;
    DECLARE v_xp_actual_vendedor INT;
    DECLARE v_nivel_actual_vendedor INT;
    DECLARE v_nivel_nuevo_vendedor INT;

    -- --- LÓGICA DEL COMPRADOR ---
    SELECT es_admin, xp, nivel INTO v_es_admin_comprador, v_xp_actual_comprador, v_nivel_actual_comprador
    FROM usuarios WHERE id = NEW.id_comprador;

    IF v_es_admin_comprador = 0 THEN
        UPDATE usuarios SET xp = xp + v_xp_ganada WHERE id = NEW.id_comprador;
        
        SELECT nivel INTO v_nivel_nuevo_comprador
        FROM niveles
        WHERE xp_necesaria <= (v_xp_actual_comprador + v_xp_ganada)
        ORDER BY xp_necesaria DESC
        LIMIT 1;
        
        IF v_nivel_nuevo_comprador > v_nivel_actual_comprador THEN
            UPDATE usuarios SET nivel = v_nivel_nuevo_comprador WHERE id = NEW.id_comprador;
            
            INSERT INTO notificaciones (id_usuario_destino, tipo_codigo, referencia_tabla, id_referencia, contenido)
            VALUES (NEW.id_comprador, 'NIVEL_SUBIDO', 'NIVEL', v_nivel_nuevo_comprador, CONCAT('¡Felicidades! Has subido al Nivel ', v_nivel_nuevo_comprador));
        END IF;
    END IF;

    -- --- LÓGICA DEL VENDEDOR ---
    SELECT es_admin, xp, nivel INTO v_es_admin_vendedor, v_xp_actual_vendedor, v_nivel_actual_vendedor
    FROM usuarios WHERE id = NEW.id_vendedor;

    IF v_es_admin_vendedor = 0 THEN
        UPDATE usuarios SET xp = xp + v_xp_ganada WHERE id = NEW.id_vendedor;
        
        SELECT nivel INTO v_nivel_nuevo_vendedor
        FROM niveles
        WHERE xp_necesaria <= (v_xp_actual_vendedor + v_xp_ganada)
        ORDER BY xp_necesaria DESC
        LIMIT 1;
        
        IF v_nivel_nuevo_vendedor > v_nivel_actual_vendedor THEN
            UPDATE usuarios SET nivel = v_nivel_nuevo_vendedor WHERE id = NEW.id_vendedor;

            INSERT INTO notificaciones (id_usuario_destino, tipo_codigo, referencia_tabla, id_referencia, contenido)
            VALUES (NEW.id_vendedor, 'NIVEL_SUBIDO', 'NIVEL', v_nivel_nuevo_vendedor, CONCAT('¡Felicidades! Has subido al Nivel ', v_nivel_nuevo_vendedor));
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`alumno26.oddo.nicolas`@`localhost`*/ /*!50003 TRIGGER `trg_verificar_usuario_por_compras` AFTER INSERT ON `ventas` FOR EACH ROW BEGIN
    DECLARE v_total_compras INT DEFAULT 0;
    DECLARE v_limite_compras INT DEFAULT 0;
    DECLARE v_es_admin TINYINT DEFAULT 0;
    DECLARE v_ya_esta_verificado TINYINT DEFAULT 0;

    -- Obtenemos el límite de compras desde la tabla 'configuracion'
    SELECT CAST(valor AS UNSIGNED) INTO v_limite_compras 
    FROM configuracion 
    WHERE clave = 'COMPRAS_PARA_VERIFICACION';

    -- Verificamos si el comprador es admin y si ya está verificado
    SELECT es_admin, es_verificado INTO v_es_admin, v_ya_esta_verificado
    FROM usuarios 
    WHERE id = NEW.id_comprador;

    -- Si el comprador NO es admin, NO está verificado y el límite está configurado
    IF v_es_admin = 0 AND v_ya_esta_verificado = 0 AND v_limite_compras > 0 THEN
    
        -- Contamos las compras de este usuario
        SELECT COUNT(*) INTO v_total_compras 
        FROM ventas 
        WHERE id_comprador = NEW.id_comprador;

        -- Si alcanza el límite, lo verificamos
        IF v_total_compras >= v_limite_compras THEN
            UPDATE usuarios 
            SET es_verificado = 1 
            WHERE id = NEW.id_comprador;
            
            -- Creamos una notificación de que fue verificado
            INSERT INTO notificaciones (id_usuario_destino, tipo_codigo, referencia_tabla, id_referencia, contenido)
            VALUES (NEW.id_comprador, 'USUARIO_VERIFICADO', 'USUARIO', NEW.id_comprador, '¡Felicitaciones! Has alcanzado el límite de compras y ahora eres un usuario verificado.');
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'DB_coleNew'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `ev_limpieza_publicaciones_soft_delete` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`alumno26.oddo.nicolas`@`localhost`*/ /*!50106 EVENT `ev_limpieza_publicaciones_soft_delete` ON SCHEDULE EVERY 1 DAY STARTS '2025-10-30 05:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    DECLARE v_meses_espera INT DEFAULT 6;

    -- Obtenemos el límite de meses desde la tabla 'configuracion'
    SELECT CAST(valor AS UNSIGNED) INTO v_meses_espera 
    FROM configuracion 
    WHERE clave = 'MESES_PARA_HARD_DELETE';

    -- Borrado masivo en cascada
    -- Borramos la publicación y todas sus dependencias (excepto ventas/calificaciones)
    -- en una sola consulta multi-tabla.
    
    DELETE p, rep, rep_pub, img, fav, p_col, p_cur, p_preg, ch
    FROM publicacion AS p
    
    -- Unir reportes
    LEFT JOIN reporte_publicacion AS rep_pub ON p.id = rep_pub.id_publicacion
    LEFT JOIN reportes AS rep ON rep_pub.id_reporte = rep.id
    
    -- Unir imágenes
    LEFT JOIN imagen_publicacion AS img ON p.id = img.id_publicacion
    
    -- Unir favoritos
    LEFT JOIN favoritos AS fav ON p.id = fav.id_publicacion
    
    -- Unir M:N colegios y cursos
    LEFT JOIN publicacion_colegio AS p_col ON p.id = p_col.id_publicacion
    LEFT JOIN publicacion_curso AS p_cur ON p.id = p_cur.id_publicacion
    
    -- Unir preguntas
    LEFT JOIN publicacion_preguntas AS p_preg ON p.id = p_preg.id_publicacion
    
    -- Unir chats (y sus mensajes se irán por ON DELETE CASCADE)
    LEFT JOIN chats AS ch ON p.id = ch.id_publicacion

    WHERE 
        -- Solo publicaciones que tienen un soft-delete
        p.fecha_eliminacion IS NOT NULL
        -- Y que son más antiguas que el límite configurado
        AND p.fecha_eliminacion < (NOW() - INTERVAL v_meses_espera MONTH);

END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `ev_notificar_mensajes_no_leidos` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb3 */ ;;
/*!50003 SET character_set_results = utf8mb3 */ ;;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = '+00:00' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`alumno26.oddo.nicolas`@`localhost`*/ /*!50106 EVENT `ev_notificar_mensajes_no_leidos` ON SCHEDULE EVERY 1 DAY STARTS '2025-10-24 08:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    INSERT INTO notificaciones (id_usuario_destino, tipo_codigo, contenido, id_referencia)
    SELECT 
        c.id_usuario_comprador AS id_destino, 
        'MENSAJE_SIN_LEER' AS tipo_codigo, 
        CONCAT('Tienes ', COUNT(m.id), ' mensajes nuevos sin leer.') AS contenido, 
        c.id AS id_referencia -- ID del Chat
    FROM mensajes AS m
    JOIN chats AS c ON m.id_chat = c.id
    WHERE 
        m.leido = 0 
        AND m.id_usuario_envia = c.id_usuario_vendedor -- Mensajes del Vendedor al Comprador
    GROUP BY c.id_usuario_comprador, c.id

    UNION

    SELECT 
        c.id_usuario_vendedor AS id_destino, 
        'MENSAJE_SIN_LEER' AS tipo_codigo, 
        CONCAT('Tienes ', COUNT(m.id), ' mensajes nuevos sin leer.') AS contenido, 
        c.id AS id_referencia -- ID del Chat
    FROM mensajes AS m
    JOIN chats AS c ON m.id_chat = c.id
    WHERE 
        m.leido = 0 
        AND m.id_usuario_envia = c.id_usuario_comprador -- Mensajes del Comprador al Vendedor
    GROUP BY c.id_usuario_vendedor, c.id;
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `ev_revisar_publicaciones_antiguas` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb3 */ ;;
/*!50003 SET character_set_results = utf8mb3 */ ;;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = '+00:00' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`alumno26.oddo.nicolas`@`localhost`*/ /*!50106 EVENT `ev_revisar_publicaciones_antiguas` ON SCHEDULE EVERY 1 DAY STARTS '2025-10-24 03:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    UPDATE publicacion
    SET estado = 'Necesita Revision'
    WHERE 
        estado = 'Activo' 
        AND fecha_publicacion < (NOW() - INTERVAL 6 MONTH);
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'DB_coleNew'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_admin_banear_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`alumno26.oddo.nicolas`@`localhost` PROCEDURE `sp_admin_banear_usuario`(
    IN p_id_admin_usuario INT, 
    IN p_id_usuario_a_banear INT, 
    IN p_motivo TEXT
)
BEGIN
    -- Declaraciones al inicio
    DECLARE v_es_admin TINYINT;
    DECLARE v_fecha_actual DATETIME;

    DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    -- Lógica
    SELECT es_admin INTO v_es_admin 
    FROM usuarios 
    WHERE id = p_id_admin_usuario;

    IF v_es_admin = 0 OR v_es_admin IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: Permiso denegado. El usuario no es administrador.';
    END IF;
    
    -- Un admin no se puede banear a sí mismo
    IF p_id_admin_usuario = p_id_usuario_a_banear THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: Un administrador no puede banearse a sí mismo.';
    END IF;

    SET v_fecha_actual = NOW();

    START TRANSACTION;

    -- 1. Banear al usuario (Soft delete)
    UPDATE usuarios
    SET fecha_eliminacion = v_fecha_actual
    WHERE id = p_id_usuario_a_banear;

    -- 2. Dar de baja todas sus publicaciones activas
    UPDATE publicacion
    SET 
        estado = 'Inactivo',
        fecha_eliminacion = v_fecha_actual
    WHERE 
        id_usuario_vendedor = p_id_usuario_a_banear
        AND estado = 'Activo';

    -- 3. Auditar la acción
    INSERT INTO bitacora_admin (id_admin_usuario, accion_codigo, referencia_tabla, id_referencia_afectada, motivo) 
    VALUES (p_id_admin_usuario, 'ADMIN_BANEAR_USUARIO', 'USUARIO', p_id_usuario_a_banear, p_motivo);
            
    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_admin_crear_publicacion_prueba` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`alumno26.oddo.nicolas`@`localhost` PROCEDURE `sp_admin_crear_publicacion_prueba`(
    IN p_id_admin_usuario INT,
    IN p_id_usuario_vendedor INT,
    IN p_titulo VARCHAR(150),
    IN p_descripcion TEXT,
    IN p_precio DECIMAL(10,2),
    IN p_condicion ENUM('Nuevo','Excelente','Muy bueno','Bueno','Aceptable','Malo'),
    IN p_id_categoria INT
)
BEGIN
    -- Declaraciones al inicio
    DECLARE v_es_admin TINYINT;
    DECLARE v_publicacion_id INT;

    DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    -- Lógica
    SELECT es_admin INTO v_es_admin 
    FROM usuarios 
    WHERE id = p_id_admin_usuario;

    IF v_es_admin = 0 OR v_es_admin IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: Permiso denegado. El usuario no es administrador.';
    END IF;

    START TRANSACTION;

    INSERT INTO publicacion (id_usuario_vendedor, titulo, descripcion, precio, condicion, id_categoria, estado)
    VALUES (p_id_usuario_vendedor, p_titulo, p_descripcion, p_precio, p_condicion, p_id_categoria, 'Activo');
    
    SET v_publicacion_id = LAST_INSERT_ID();
    
    INSERT INTO bitacora_admin (id_admin_usuario, accion_codigo, referencia_tabla, id_referencia_afectada, motivo) 
    VALUES (p_id_admin_usuario, 'ADMIN_CREAR_PUBLICACION_PRUEBA', 'PUBLICACION', v_publicacion_id, 'Creación de publicación de prueba (SP)');
    
    COMMIT;
    
    SELECT * FROM publicacion WHERE id = v_publicacion_id;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_admin_hard_delete_publicacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`alumno26.oddo.nicolas`@`localhost` PROCEDURE `sp_admin_hard_delete_publicacion`(
    IN p_id_admin_usuario INT, 
    IN p_id_publicacion_a_eliminar INT, 
    IN p_motivo_eliminacion TEXT
)
BEGIN
    -- TODOS LOS DECLARES DEBEN IR AL INICIO
    DECLARE v_es_admin TINYINT;
    
    DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
        RESIGNAL; -- Devuelve el error original al cliente
    END;
    
    -- AHORA COMIENZA LA LÓGICA
    
    -- 1. Guardia de Seguridad: Verificar permisos de Admin
    SELECT es_admin INTO v_es_admin 
    FROM usuarios 
    WHERE id = p_id_admin_usuario;

    IF v_es_admin = 0 OR v_es_admin IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: Permiso denegado. El usuario no es administrador.';
    END IF;

    -- 2. Iniciar Transacción
    START TRANSACTION;

    -- 3. Auditar la acción (con la nueva columna 'referencia_tabla')
    INSERT INTO bitacora_admin (id_admin_usuario, accion_codigo, referencia_tabla, id_referencia_afectada, motivo) 
    VALUES (p_id_admin_usuario, 'HARD_DELETE_PUBLICACION', 'PUBLICACION', p_id_publicacion_a_eliminar, p_motivo_eliminacion);

    -- 4. Limpieza manual de dependencias
    DELETE rep FROM reportes AS rep
    JOIN reporte_publicacion AS rep_pub ON rep.id = rep_pub.id_reporte
    WHERE rep_pub.id_publicacion = p_id_publicacion_a_eliminar;
    
    DELETE FROM imagen_publicacion WHERE id_publicacion = p_id_publicacion_a_eliminar;
    DELETE FROM favoritos WHERE id_publicacion = p_id_publicacion_a_eliminar;
    DELETE FROM publicacion_colegio WHERE id_publicacion = p_id_publicacion_a_eliminar;
    DELETE FROM publicacion_curso WHERE id_publicacion = p_id_publicacion_a_eliminar;
    DELETE FROM publicacion_preguntas WHERE id_publicacion = p_id_publicacion_a_eliminar;
    DELETE FROM chats WHERE id_publicacion = p_id_publicacion_a_eliminar;
    
    -- 5. Borrado final
    DELETE FROM publicacion WHERE id = p_id_publicacion_a_eliminar;
    
    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_crear_calificacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`alumno26.oddo.nicolas`@`localhost` PROCEDURE `sp_crear_calificacion`(
    IN p_id_venta INT,
    IN p_id_usuario_que_califica INT,
    IN p_puntuacion TINYINT,
    IN p_comentario TEXT
)
BEGIN
    DECLARE v_id_comprador INT;
    DECLARE v_id_vendedor INT;
    DECLARE v_id_usuario_calificado INT;
    DECLARE v_rol_calificado ENUM('Vendedor','Comprador');
    
    DECLARE v_avg_puntuacion DECIMAL(3,2);
    DECLARE v_total_calificaciones INT;

    -- 1. Obtener los IDs de la venta
    SELECT id_comprador, id_vendedor INTO v_id_comprador, v_id_vendedor
    FROM ventas
    WHERE id = p_id_venta;

    -- 2. Deducir quién es el calificado
    IF v_id_comprador = p_id_usuario_que_califica THEN
        SET v_id_usuario_calificado = v_id_vendedor;
        SET v_rol_calificado = 'Vendedor';
        
    ELSEIF v_id_vendedor = p_id_usuario_que_califica THEN
        SET v_id_usuario_calificado = v_id_comprador;
        SET v_rol_calificado = 'Comprador';
        
    ELSE
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: El usuario no participó en esta venta.';
    END IF;

    START TRANSACTION;

    -- 3. Insertar la calificación (¡AHORA INCLUYE EL ID!)
    INSERT INTO calificaciones (id_venta, id_usuario_calificado, calificado_rol, puntuacion, comentario)
    VALUES (p_id_venta, v_id_usuario_calificado, v_rol_calificado, p_puntuacion, p_comentario);
    
    -- 4. Recalcular el promedio (¡AHORA ES EFICIENTE!)
    -- Ya no necesitamos hacer JOIN con 'ventas', podemos consultar 'calificaciones'
    
    IF v_rol_calificado = 'Vendedor' THEN
        SELECT AVG(puntuacion), COUNT(id)
        INTO v_avg_puntuacion, v_total_calificaciones
        FROM calificaciones
        WHERE 
            id_usuario_calificado = v_id_usuario_calificado
            AND calificado_rol = 'Vendedor';
            
        UPDATE usuarios
        SET calificacion_vendedor_promedio = v_avg_puntuacion,
            total_calificaciones_vendedor = v_total_calificaciones
        WHERE id = v_id_usuario_calificado;
        
    ELSE
        SELECT AVG(puntuacion), COUNT(id)
        INTO v_avg_puntuacion, v_total_calificaciones
        FROM calificaciones
        WHERE 
            id_usuario_calificado = v_id_usuario_calificado
            AND calificado_rol = 'Comprador';
            
        UPDATE usuarios
        SET calificacion_comprador_promedio = v_avg_puntuacion,
            total_calificaciones_comprador = v_total_calificaciones
        WHERE id = v_id_usuario_calificado;
    END IF;

    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reporte_compras_por_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`alumno26.oddo.nicolas`@`localhost` PROCEDURE `sp_reporte_compras_por_usuario`(
    IN p_id_admin_usuario INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE,
    IN p_id_categoria INT
)
BEGIN
    DECLARE v_es_admin TINYINT;

    -- Guardia de seguridad
    SELECT es_admin INTO v_es_admin 
    FROM usuarios 
    WHERE id = p_id_admin_usuario;

    IF v_es_admin = 0 OR v_es_admin IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: Permiso denegado. El usuario no es administrador.';
    END IF;

    -- Lógica del Reporte
    SELECT 
        u.id AS id_comprador,
        u.nombre,
        u.apellido,
        u.mail,
        COUNT(v.id) AS total_compras,
        SUM(v.precio_final) AS gasto_total
    FROM ventas AS v
    JOIN usuarios AS u ON v.id_comprador = u.id
    JOIN publicacion AS p ON v.id_publicacion = p.id
    WHERE
        -- Filtro de fecha (obligatorio)
        (v.fecha_venta >= p_fecha_inicio AND v.fecha_venta <= p_fecha_fin)
        AND
        -- Filtro de categoría (opcional, si es NULL lo ignora)
        (p_id_categoria IS NULL OR p.id_categoria = p_id_categoria)
    GROUP BY u.id, u.nombre, u.apellido, u.mail
    ORDER BY total_compras DESC, gasto_total DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-17  9:26:21
