-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: db_colevueltasv2
-- ------------------------------------------------------
-- Server version	9.5.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '8cda5ba6-c89a-11f0-b61d-08bfb80180ad:1-487';

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bitacora_admin`
--

LOCK TABLES `bitacora_admin` WRITE;
/*!40000 ALTER TABLE `bitacora_admin` DISABLE KEYS */;
INSERT INTO `bitacora_admin` VALUES (3,1,'CREAR_PUBLICACION',8,'PUBLICACION','Creación V4.0','2025-11-23 23:04:14'),(4,1,'CREAR_PUBLICACION',9,'PUBLICACION','Creación V4.0','2025-11-23 23:04:17'),(5,1,'CREAR_PUBLICACION',10,'PUBLICACION','Creación V4.0','2025-11-23 23:05:13'),(9,1,'ADMIN_BANEAR_USUARIO',5,'USUARIO','Comportamiento sospechoso','2025-11-23 23:10:30'),(10,1,'HARD_DELETE_PUBLICACION',999,'PUBLICACION','Contenido inapropiado','2025-11-23 23:10:38');
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
INSERT INTO `bitacora_admin_acciones` VALUES ('ADMIN_BANEAR_USUARIO','Baneo de usuario y baja de publicaciones'),('CREAR_PUBLICACION','Creación de una nueva publicación por un administrador'),('HARD_DELETE_PUBLICACION','Eliminación permanente de una publicación');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calificaciones`
--

LOCK TABLES `calificaciones` WRITE;
/*!40000 ALTER TABLE `calificaciones` DISABLE KEYS */;
INSERT INTO `calificaciones` VALUES (1,1,2,'Vendedor',5,'Excelente vendedor, muy rápido','2025-11-23 23:05:37');
/*!40000 ALTER TABLE `calificaciones` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_actualizar_promedio_calificacion` AFTER INSERT ON `calificaciones` FOR EACH ROW BEGIN
    DECLARE v_nuevo_promedio DECIMAL(3,2);
    DECLARE v_total_calif INT;

    IF NEW.calificado_rol = 'Vendedor' THEN
        SELECT AVG(puntuacion), COUNT(id) 
        INTO v_nuevo_promedio, v_total_calif
        FROM calificaciones 
        WHERE id_usuario_calificado = NEW.id_usuario_calificado 
        AND calificado_rol = 'Vendedor';

        UPDATE usuarios 
        SET calificacion_vendedor_promedio = v_nuevo_promedio,
            total_calificaciones_vendedor = v_total_calif
        WHERE id = NEW.id_usuario_calificado;

    ELSEIF NEW.calificado_rol = 'Comprador' THEN
        SELECT AVG(puntuacion), COUNT(id) 
        INTO v_nuevo_promedio, v_total_calif
        FROM calificaciones 
        WHERE id_usuario_calificado = NEW.id_usuario_calificado 
        AND calificado_rol = 'Comprador';

        UPDATE usuarios 
        SET calificacion_comprador_promedio = v_nuevo_promedio,
            total_calificaciones_comprador = v_total_calif
        WHERE id = NEW.id_usuario_calificado;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,NULL,'Uniformes'),(2,NULL,'Objetos'),(3,1,'Pantalones'),(4,1,'Chombas'),(5,2,'Libros'),(6,2,'Útiles');
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
  `estado` tinyint NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_ultima_actividad` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fecha_eliminacion` datetime DEFAULT NULL,
  `activo` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `chat_unico` (`id_publicacion`,`id_usuario_comprador`),
  KEY `id_usuario_comprador` (`id_usuario_comprador`),
  KEY `id_usuario_vendedor` (`id_usuario_vendedor`),
  KEY `idx_comprador_vendedor` (`id_usuario_comprador`,`id_usuario_vendedor`),
  CONSTRAINT `chats_ibfk_1` FOREIGN KEY (`id_publicacion`) REFERENCES `publicacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chats_ibfk_2` FOREIGN KEY (`id_usuario_comprador`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chats_ibfk_3` FOREIGN KEY (`id_usuario_vendedor`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chats`
--

LOCK TABLES `chats` WRITE;
/*!40000 ALTER TABLE `chats` DISABLE KEYS */;
INSERT INTO `chats` VALUES (1,1,3,4,3,'2025-11-23 23:00:39','2025-11-25 01:16:13',NULL,_binary '\0');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colegio`
--

LOCK TABLES `colegio` WRITE;
/*!40000 ALTER TABLE `colegio` DISABLE KEYS */;
INSERT INTO `colegio` VALUES (1,'Colegio Nacional','Av. Libertador 100',NULL),(2,'Escuela Técnica Otto Krause','Paseo Colón 500',NULL),(3,'Instituto San Martin','Calle Falsa 123',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagen_publicacion`
--

LOCK TABLES `imagen_publicacion` WRITE;
/*!40000 ALTER TABLE `imagen_publicacion` DISABLE KEYS */;
INSERT INTO `imagen_publicacion` VALUES (1,1000,'https://res.cloudinary.com/dsrp5xbch/image/upload/v1763946973/publicaciones/1000/axev38bkpkrmxts32oqh.webp'),(2,1000,'https://res.cloudinary.com/dsrp5xbch/image/upload/v1763946975/publicaciones/1000/tnauebt3aosuxelmlwc0.webp'),(3,1001,'https://res.cloudinary.com/dsrp5xbch/image/upload/v1763947210/publicaciones/1001/ahef7jzaer9odfdb2xsb.webp'),(4,1001,'https://res.cloudinary.com/dsrp5xbch/image/upload/v1763947213/publicaciones/1001/muh9cbwxio3iycnwhinj.webp'),(5,1002,'https://res.cloudinary.com/dsrp5xbch/image/upload/v1763948261/publicaciones/1002/spxyytifdumqiodwykoy.webp'),(6,1003,'https://res.cloudinary.com/dsrp5xbch/image/upload/v1763948615/publicaciones/1003/bjuxdlwbhelfkbzhawwn.webp'),(7,1004,'https://res.cloudinary.com/dsrp5xbch/image/upload/v1763948674/publicaciones/1004/p4jq14ddigctqvvfgadm.jpg');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensajes`
--

LOCK TABLES `mensajes` WRITE;
/*!40000 ALTER TABLE `mensajes` DISABLE KEYS */;
INSERT INTO `mensajes` VALUES (1,1,3,'Hola, la tienes?','2025-11-23 23:00:39',1),(2,1,4,'Si, aun la tengo','2025-11-23 23:00:39',1),(3,1,3,'Te sirven 4500?','2025-11-23 23:00:39',0);
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
INSERT INTO `niveles` VALUES (1,0,'Novato'),(2,50,'Principiante'),(3,150,'Habitual'),(4,300,'Activo'),(5,500,'Leyenda');
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
  `id_tipo` int NOT NULL,
  `id_venta` int DEFAULT NULL,
  `id_chat` int DEFAULT NULL,
  `id_publicacion` int DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `leida` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_notif_usuario` (`id_usuario_destino`),
  KEY `fk_notif_tipo` (`id_tipo`),
  KEY `fk_notif_venta` (`id_venta`),
  KEY `fk_notif_chat` (`id_chat`),
  KEY `fk_notif_pub` (`id_publicacion`),
  CONSTRAINT `fk_notif_chat` FOREIGN KEY (`id_chat`) REFERENCES `chats` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_notif_pub` FOREIGN KEY (`id_publicacion`) REFERENCES `publicacion` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_notif_tipo` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_notificacion` (`id`),
  CONSTRAINT `fk_notif_usuario` FOREIGN KEY (`id_usuario_destino`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_notif_venta` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificaciones`
--

LOCK TABLES `notificaciones` WRITE;
/*!40000 ALTER TABLE `notificaciones` DISABLE KEYS */;
INSERT INTO `notificaciones` VALUES (1,2,2,NULL,NULL,NULL,'2025-11-23 23:00:39',NULL),(2,3,2,NULL,NULL,NULL,'2025-11-23 23:00:39',NULL),(3,4,2,NULL,NULL,NULL,'2025-11-23 23:00:39',NULL),(4,3,4,NULL,NULL,NULL,'2025-11-23 23:00:48',NULL),(5,4,1,NULL,1,NULL,'2025-11-24 15:56:04',NULL);
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
  `id_categoria` int NOT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `descripcion` text,
  `precio` decimal(38,2) DEFAULT NULL,
  `condicion` enum('Nuevo','Excelente','Muy_bueno','Bueno','Aceptable','Malo') DEFAULT NULL,
  `fecha_publicacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_ultima_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estado` enum('Activo','Pausado','Vendido','Inactivo','Necesita_Revision') NOT NULL DEFAULT 'Activo',
  `descuento` decimal(5,2) DEFAULT '0.00',
  `descuento_fecha_inicio` datetime DEFAULT NULL,
  `descuento_fecha_fin` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario_vendedor` (`id_usuario_vendedor`),
  KEY `fk_pub_categoria` (`id_categoria`),
  KEY `idx_busqueda_optimizada` (`estado`,`precio`),
  KEY `idx_filtro_rapido` (`id_categoria`,`estado`,`precio`),
  CONSTRAINT `fk_pub_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `publicacion_ibfk_1` FOREIGN KEY (`id_usuario_vendedor`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1005 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicacion`
--

LOCK TABLES `publicacion` WRITE;
/*!40000 ALTER TABLE `publicacion` DISABLE KEYS */;
INSERT INTO `publicacion` VALUES (1,4,4,'Chomba Otto Krause','Usada buen estado',5000.00,'Bueno','2025-11-23 23:00:39','2025-11-25 00:35:03','Vendido',0.00,NULL,NULL,NULL),(2,2,3,'Pantalón Nacional','Casi nuevo',8000.00,'Excelente','2025-11-23 23:00:39','2025-11-23 23:00:39','Vendido',0.00,NULL,NULL,'2025-11-23 20:00:39'),(3,4,6,'Calculadora Casio','Científica fx-95',15000.00,'Muy_bueno','2025-11-23 23:00:39','2025-11-24 01:37:13','Vendido',0.00,NULL,NULL,'2025-11-23 20:00:39'),(4,2,5,'Libro Matemática 1','Editorial Santillana',2000.00,'Aceptable','2025-11-23 23:00:39','2025-11-23 23:00:39','Vendido',0.00,NULL,NULL,'2025-11-23 20:00:39'),(5,2,6,'Regla Vieja','De hace un año',100.00,NULL,'2024-01-01 13:00:00','2025-11-24 18:43:09','Necesita_Revision',0.00,NULL,NULL,NULL),(6,2,6,'Regla de Prueba SP','Creada por Procedure',550.00,'Nuevo','2025-11-23 23:02:49','2025-11-23 23:02:49','Activo',0.00,NULL,NULL,NULL),(7,4,3,'Pollera Test SP','Uniforme creado por SP',12000.00,'Bueno','2025-11-23 23:02:59','2025-11-23 23:02:59','Activo',0.00,NULL,NULL,NULL),(8,2,6,'Regla de Prueba SP','Creada por Procedure',550.00,'Nuevo','2025-11-23 23:04:14','2025-11-23 23:04:14','Activo',0.00,NULL,NULL,NULL),(9,4,3,'Pollera Test SP','Uniforme creado por SP',12000.00,'Bueno','2025-11-23 23:04:17','2025-11-23 23:04:17','Activo',0.00,NULL,NULL,NULL),(10,4,3,'Pollera Test SP','Uniforme creado por SP',12000.00,'Bueno','2025-11-23 23:05:13','2025-11-23 23:05:13','Activo',0.00,NULL,NULL,NULL),(1000,4,6,'Tablero dibujo','El Set de Tablero de Dibujo Técnico Dozent es la herramienta ideal para profesionales y estudiantes que buscan precisión y calidad en sus proyectos.',35000.00,'Bueno','2025-11-24 01:16:12','2025-11-24 01:16:12','Activo',0.00,NULL,NULL,NULL),(1001,4,6,'Tablero dibujo','El Set de Tablero de Dibujo Técnico Dozent es la herramienta ideal para profesionales y estudiantes que buscan precisión y calidad en sus proyectos. Este tablero de 50x60 cm está meticulosamente fabricado con melamina blanca de alta resistencia, con un espesor de 12 mm que garantiza durabilidad y una superficie de trabajo estable. Su borde plástico perimetral en color negro no solo añade un toque de elegancia, sino que también protege los bordes del desgaste. La paralela inyectada es de fácil manejo y ofrece movimientos suaves y precisos, asegurando líneas rectas y constantes gracias a su hilo trenzado y fijatones especiales diseñados para no dañar el hilo. Además, este set incluye un práctico maletín para transportar y proteger tu tablero, facilitando el traslado a diferentes lugares de trabajo o estudio. Con el modelo 12652 de Dozent, no necesitas una mesa adicional, ya que su diseño portátil te permite trabajar cómodamente en cualquier espacio.',35000.00,'Bueno','2025-11-24 01:20:10','2025-11-24 01:20:10','Activo',0.00,NULL,NULL,NULL),(1002,4,6,'10 Lapices HB Lote','Me sobraron del anterior año y x eso los vendo baratos.',5000.00,'Muy_bueno','2025-11-24 01:37:40','2025-11-24 01:37:40','Activo',0.00,NULL,NULL,NULL),(1003,4,4,'Chomba del Otto Krause','Era de mi hijo pero se cambió de colegio',15300.00,'Aceptable','2025-11-24 01:43:34','2025-11-24 14:39:02','Inactivo',0.00,NULL,NULL,'2025-11-24 11:39:02'),(1004,4,4,'Chomba del Otto Krause','Era de mi hijo pero se cambió de colegio',15300.00,'Aceptable','2025-11-24 01:44:34','2025-11-24 21:54:53','Inactivo',0.00,NULL,NULL,'2025-11-24 18:54:54');
/*!40000 ALTER TABLE `publicacion` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicacion_preguntas`
--

LOCK TABLES `publicacion_preguntas` WRITE;
/*!40000 ALTER TABLE `publicacion_preguntas` DISABLE KEYS */;
INSERT INTO `publicacion_preguntas` VALUES (5,1002,'Hola, ¿Cual es el tamaño?','2025-11-24 18:45:24',NULL,NULL),(6,1002,'Hola, ¿Cual es el tamaño?','2025-11-25 01:26:56',NULL,NULL),(7,1002,'Hola, que marca?','2025-11-25 01:33:09',NULL,NULL),(8,1002,'lol','2025-11-25 01:36:43',NULL,NULL),(9,1002,'lol','2025-11-25 01:36:44',NULL,NULL),(10,1002,'hola','2025-11-25 01:38:10',NULL,NULL);
/*!40000 ALTER TABLE `publicacion_preguntas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publicacion_uniforme`
--

DROP TABLE IF EXISTS `publicacion_uniforme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publicacion_uniforme` (
  `id_publicacion` int NOT NULL,
  `id_talle` int DEFAULT NULL,
  `id_colegio` int DEFAULT NULL,
  PRIMARY KEY (`id_publicacion`),
  KEY `fk_uni_talle` (`id_talle`),
  KEY `fk_uni_colegio` (`id_colegio`),
  CONSTRAINT `fk_uni_colegio` FOREIGN KEY (`id_colegio`) REFERENCES `colegio` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_uni_publicacion` FOREIGN KEY (`id_publicacion`) REFERENCES `publicacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_uni_talle` FOREIGN KEY (`id_talle`) REFERENCES `talles` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicacion_uniforme`
--

LOCK TABLES `publicacion_uniforme` WRITE;
/*!40000 ALTER TABLE `publicacion_uniforme` DISABLE KEYS */;
INSERT INTO `publicacion_uniforme` VALUES (1,2,2),(2,5,1),(5,1,1),(7,2,1),(9,2,1),(10,2,1),(1003,4,NULL),(1004,4,NULL);
/*!40000 ALTER TABLE `publicacion_uniforme` ENABLE KEYS */;
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
/*!40000 ALTER TABLE `reportes_motivos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `talles`
--

DROP TABLE IF EXISTS `talles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `talles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `talle` varchar(255) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL COMMENT 'Ej: Medidas de referencia',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_talle` (`talle`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `talles`
--

LOCK TABLES `talles` WRITE;
/*!40000 ALTER TABLE `talles` DISABLE KEYS */;
INSERT INTO `talles` VALUES (1,'S',NULL),(2,'M',NULL),(3,'L',NULL),(4,'XL',NULL),(5,'40',NULL),(6,'42',NULL);
/*!40000 ALTER TABLE `talles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_notificacion`
--

DROP TABLE IF EXISTS `tipo_notificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_notificacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `objetivo` enum('SOCIAL','VENTA','SISTEMA','SEGURIDAD','PUBLICACION') NOT NULL,
  `nombre_clave` varchar(50) NOT NULL,
  `plantilla_texto` varchar(255) NOT NULL,
  `icono` varchar(20) DEFAULT 0xF09F9494,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_notificacion`
--

LOCK TABLES `tipo_notificacion` WRITE;
/*!40000 ALTER TABLE `tipo_notificacion` DISABLE KEYS */;
INSERT INTO `tipo_notificacion` VALUES (1,'SOCIAL','NUEVO_MENSAJE','Tienes un nuevo mensaje','?'),(2,'SISTEMA','NIVEL_SUBIDO','¡Felicidades! Subiste de nivel','⭐'),(3,'VENTA','VENTA_NUEVA','¡Vendiste un producto!','?'),(4,'SEGURIDAD','USUARIO_VERIFICADO','Tu identidad ha sido verificada','✅');
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
INSERT INTO `usuarios` VALUES (1,'Admin','Supremo','admin@cole.com','pass123',11111111,'2025-11-23 23:00:39','Otro',NULL,NULL,1000,5,1,NULL,0,NULL,0,NULL,1,'admin_god',NULL,NULL,NULL),(2,'Juan','Vendedor','juan@mail.com','pass123',42111111,'2025-11-23 23:00:39','Otro',NULL,NULL,100,2,0,5,1,NULL,0,NULL,0,'juan_ventas',NULL,NULL,NULL),(3,'Pedro','Comprador','pedro@mail.com','pass123',23327422,'2025-11-23 23:00:39','Otro',NULL,NULL,250,3,1,NULL,0,NULL,0,NULL,0,'comprador_compulsivo',NULL,NULL,NULL),(4,'Ana','Pro','ana@mail.com','pass123',36576473,'2025-11-23 23:00:39','Otro',NULL,NULL,149,2,1,NULL,0,NULL,0,NULL,0,'ana_uniformes',NULL,'Solo entrego en la esquina de Av Gral Paz y Los Arollos','La Plata'),(5,'Maria','Nueva','maria@mail.com','pass123',32453565,'2025-11-23 23:00:39','Otro',NULL,NULL,25,1,0,NULL,0,NULL,0,'2025-11-23 20:10:30',0,'mary_new',NULL,NULL,NULL),(6,'Camila','Rossi','camila.rossi@ejemplo.com','$2a$10$rYNrbJu3Egfx2uGzxOkmaecKbmHRtFn2.vQfq2bU.Brhj2ouyeFe.',42789563,'2025-11-24 14:36:50','Femenino','2001-09-22','+54 9 11 6543-2810',0,1,0,0,0,0,0,NULL,0,'CamiRossi22','Soy Camila, estudiante de diseño gráfico y fanática del arte digital. Me encanta personalizar prendas y crear ilustraciones. Estoy vendiendo algunas cosas que ya no uso, desde tablets gráficas hasta materiales de dibujo. Si tenés alguna duda o querés ver más fotos de los productos, escribime sin problema :)','Puedo enviar por Correo Argentino o Andreani, según te quede más cómodo. También podés pasar a retirar por Palermo durante la semana.','Calle Fitz Roy 1280, CABA'),(7,'Camila','Rossi','camila.rossi2@ejemplo.com','$2a$10$qAuX0rYrpZzpbkMMRK6W1eyRhwVV/R2FsgAF/ZM14Kc/NW.qmHLn.',42782563,'2025-11-25 00:58:50','Femenino','2001-09-22','+54 9 11 6543-2810',0,1,0,0,0,0,0,NULL,0,'CamiR2si22','Soy Camila, estudiante de diseño gráfico y fanática del arte digital. Me encanta personalizar prendas y crear ilustraciones. Estoy vendiendo algunas cosas que ya no uso, desde tablets gráficas hasta materiales de dibujo. Si tenés alguna duda o querés ver más fotos de los productos, escribime sin problema :)','Puedo enviar por Correo Argentino o Andreani, según te quede más cómodo. También podés pasar a retirar por Palermo durante la semana.','Calle Fitz Roy 1280, CABA');
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
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (1,2,NULL,3,2,8000,NULL,'2025-11-23 23:00:39'),(2,4,NULL,3,2,2000,NULL,'2025-11-23 23:00:39'),(3,2,NULL,3,4,8000,NULL,'2025-11-23 23:00:39'),(4,4,NULL,3,4,2000,NULL,'2025-11-23 23:00:39'),(100,3,NULL,5,2,15000,NULL,'2025-11-13 23:00:39'),(106,1,1,3,4,25000,'Puerta del shopping Abasto','2025-11-25 00:55:00');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_verificar_usuario_por_compras` AFTER INSERT ON `ventas` FOR EACH ROW BEGIN
    DECLARE v_total_compras INT;
    DECLARE v_limite_compras INT;
    DECLARE v_es_verificado TINYINT;
    DECLARE v_id_tipo_notif INT;

    SELECT CAST(valor AS UNSIGNED) INTO v_limite_compras FROM configuracion WHERE clave = 'COMPRAS_PARA_VERIFICACION';
    SELECT es_verificado INTO v_es_verificado FROM usuarios WHERE id = NEW.id_comprador;

    IF v_es_verificado = 0 AND v_limite_compras > 0 THEN
        SELECT COUNT(*) INTO v_total_compras FROM ventas WHERE id_comprador = NEW.id_comprador;

        IF v_total_compras >= v_limite_compras THEN
            UPDATE usuarios SET es_verificado = 1 WHERE id = NEW.id_comprador;
            
            SELECT id INTO v_id_tipo_notif FROM tipo_notificacion WHERE nombre_clave = 'USUARIO_VERIFICADO' LIMIT 1;
            
            INSERT INTO notificaciones (id_usuario_destino, id_tipo, id_venta)
            VALUES (NEW.id_comprador, v_id_tipo_notif, NULL);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_actualizar_nivel_por_venta` AFTER INSERT ON `ventas` FOR EACH ROW BEGIN
    DECLARE v_xp_ganada INT DEFAULT 25;
    DECLARE v_xp_actual INT;
    DECLARE v_nivel_actual INT;
    DECLARE v_nivel_nuevo INT;
    DECLARE v_id_tipo_notif INT;

    SELECT id INTO v_id_tipo_notif FROM tipo_notificacion WHERE nombre_clave = 'NIVEL_SUBIDO' LIMIT 1;

    SELECT xp, nivel INTO v_xp_actual, v_nivel_actual FROM usuarios WHERE id = NEW.id_comprador;
    UPDATE usuarios SET xp = xp + v_xp_ganada WHERE id = NEW.id_comprador;
    
    SELECT nivel INTO v_nivel_nuevo FROM niveles WHERE xp_necesaria <= (v_xp_actual + v_xp_ganada) ORDER BY xp_necesaria DESC LIMIT 1;
    
    IF v_nivel_nuevo > v_nivel_actual THEN
        UPDATE usuarios SET nivel = v_nivel_nuevo WHERE id = NEW.id_comprador;
        INSERT INTO notificaciones (id_usuario_destino, id_tipo) VALUES (NEW.id_comprador, v_id_tipo_notif);
    END IF;

    SELECT xp, nivel INTO v_xp_actual, v_nivel_actual FROM usuarios WHERE id = NEW.id_vendedor;
    UPDATE usuarios SET xp = xp + v_xp_ganada WHERE id = NEW.id_vendedor;
    
    SELECT nivel INTO v_nivel_nuevo FROM niveles WHERE xp_necesaria <= (v_xp_actual + v_xp_ganada) ORDER BY xp_necesaria DESC LIMIT 1;
    
    IF v_nivel_nuevo > v_nivel_actual THEN
        UPDATE usuarios SET nivel = v_nivel_nuevo WHERE id = NEW.id_vendedor;
        INSERT INTO notificaciones (id_usuario_destino, id_tipo) VALUES (NEW.id_vendedor, v_id_tipo_notif);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_cerrar_publicacion_al_vender` AFTER INSERT ON `ventas` FOR EACH ROW BEGIN
    UPDATE publicacion  
    SET estado = 3, 
        fecha_eliminacion = NOW()
    WHERE id = NEW.id_publicacion;

    IF NEW.id_chat_origen IS NOT NULL THEN
        UPDATE chats  
        SET estado = 3
        WHERE id = NEW.id_chat_origen;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `vista_objetos`
--

DROP TABLE IF EXISTS `vista_objetos`;
/*!50001 DROP VIEW IF EXISTS `vista_objetos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_objetos` AS SELECT 
 1 AS `id`,
 1 AS `titulo`,
 1 AS `precio`,
 1 AS `condicion`,
 1 AS `estado`,
 1 AS `nombre_categoria`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_uniformes`
--

DROP TABLE IF EXISTS `vista_uniformes`;
/*!50001 DROP VIEW IF EXISTS `vista_uniformes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_uniformes` AS SELECT 
 1 AS `id`,
 1 AS `titulo`,
 1 AS `precio`,
 1 AS `condicion`,
 1 AS `estado`,
 1 AS `nombre_categoria`,
 1 AS `id_colegio`,
 1 AS `nombre_colegio`,
 1 AS `id_talle`,
 1 AS `nombre_talle`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'db_colevueltasv2'
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
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `ev_limpieza_publicaciones_soft_delete` ON SCHEDULE EVERY 1 DAY STARTS '2025-10-30 05:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    DECLARE v_meses_espera INT DEFAULT 6;
    SELECT CAST(valor AS UNSIGNED) INTO v_meses_espera FROM configuracion WHERE clave = 'MESES_PARA_HARD_DELETE';

    -- Borrado masivo actualizado (Sin tablas viejas)
    DELETE p, rep, rep_pub, img, fav, p_preg, ch, pu
    FROM publicacion AS p
    LEFT JOIN reporte_publicacion AS rep_pub ON p.id = rep_pub.id_publicacion
    LEFT JOIN reportes AS rep ON rep_pub.id_reporte = rep.id
    LEFT JOIN imagen_publicacion AS img ON p.id = img.id_publicacion
    LEFT JOIN favoritos AS fav ON p.id = fav.id_publicacion
    LEFT JOIN publicacion_preguntas AS p_preg ON p.id = p_preg.id_publicacion
    LEFT JOIN chats AS ch ON p.id = ch.id_publicacion
    LEFT JOIN publicacion_uniforme AS pu ON p.id = pu.id_publicacion

    WHERE 
        p.fecha_eliminacion IS NOT NULL
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
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `ev_notificar_mensajes_no_leidos` ON SCHEDULE EVERY 1 DAY STARTS '2025-11-24 08:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    DECLARE v_id_tipo INT;
    SELECT id INTO v_id_tipo FROM tipo_notificacion WHERE nombre_clave = 'NUEVO_MENSAJE' LIMIT 1;

    INSERT INTO notificaciones (id_usuario_destino, id_tipo, id_chat)
    SELECT 
        CASE 
            WHEN m.id_usuario_envia = c.id_usuario_vendedor THEN c.id_usuario_comprador
            ELSE c.id_usuario_vendedor 
        END AS id_destino,
        v_id_tipo,
        c.id -- Referencia correcta al chat
    FROM mensajes m
    JOIN chats c ON m.id_chat = c.id
    WHERE m.leido = 0
    GROUP BY id_destino, c.id;
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
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `ev_revisar_publicaciones_antiguas` ON SCHEDULE EVERY 1 DAY STARTS '2025-11-24 03:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
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
-- Dumping routines for database 'db_colevueltasv2'
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_banear_usuario`(
    IN p_id_admin_usuario INT, 
    IN p_id_usuario_a_banear INT, 
    IN p_motivo TEXT
)
    SQL SECURITY INVOKER
BEGIN
    DECLARE v_es_admin TINYINT;
    DECLARE v_fecha_actual DATETIME;
    
    -- Handler de errores
    DECLARE exit handler for SQLEXCEPTION 
    BEGIN 
        ROLLBACK; 
        RESIGNAL; 
    END;

    -- Validaciones
    SELECT es_admin INTO v_es_admin FROM usuarios WHERE id = p_id_admin_usuario;

    IF v_es_admin = 0 THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No eres admin.'; 
    END IF;
    
    IF p_id_admin_usuario = p_id_usuario_a_banear THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Auto-baneo no permitido.'; 
    END IF;

    SET v_fecha_actual = NOW();

    START TRANSACTION;

    -- 1. Banear usuario
    UPDATE usuarios 
    SET fecha_eliminacion = v_fecha_actual
    WHERE id = p_id_usuario_a_banear;

    -- 2. Bajar publicaciones
    UPDATE publicacion
    SET estado = 'Inactivo',
        fecha_eliminacion = v_fecha_actual
    WHERE id_usuario_vendedor = p_id_usuario_a_banear
    AND estado = 'Activo';

    -- 3. Bitácora (Aquí se cortaba antes)
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_crear_publicacion_prueba`(
    IN p_id_admin_usuario INT,
    IN p_id_usuario_vendedor INT,
    IN p_titulo VARCHAR(150),
    IN p_descripcion TEXT,
    IN p_precio DECIMAL(10,2),
    IN p_condicion ENUM('Nuevo','Excelente','Muy bueno','Bueno','Aceptable','Malo'),
    IN p_id_categoria INT, -- AHORA OBLIGATORIO EN EL PADRE
    IN p_tipo_publicacion ENUM('Objeto', 'Uniforme'),
    IN p_id_colegio INT,
    IN p_id_talle INT
)
BEGIN
    DECLARE v_es_admin TINYINT;
    DECLARE v_publicacion_id INT;

    -- Validar Admin
    SELECT es_admin INTO v_es_admin FROM usuarios WHERE id = p_id_admin_usuario;
    IF v_es_admin = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No eres admin.'; END IF;

    START TRANSACTION;

    -- 1. Insertar en PADRE (Incluyendo la categoría)
    INSERT INTO publicacion (id_usuario_vendedor, id_categoria, titulo, descripcion, precio, condicion, estado)
    VALUES (p_id_usuario_vendedor, p_id_categoria, p_titulo, p_descripcion, p_precio, p_condicion, 'Activo');
    
    SET v_publicacion_id = LAST_INSERT_ID();
    
    -- 2. Insertar en HIJA (Solo si es uniforme)
    IF p_tipo_publicacion = 'Uniforme' THEN
        INSERT INTO publicacion_uniforme (id_publicacion, id_talle, id_colegio)
        VALUES (v_publicacion_id, p_id_talle, p_id_colegio);
    END IF;
    -- (Si es Objeto no hacemos nada porque borramos la tabla publicacion_objeto)

    -- 3. Auditoría
    INSERT INTO bitacora_admin (id_admin_usuario, accion_codigo, referencia_tabla, id_referencia_afectada, motivo) 
    VALUES (p_id_admin_usuario, 'CREAR_PUBLICACION', 'PUBLICACION', v_publicacion_id, 'Creación V4.0');
    
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_hard_delete_publicacion`(
    IN p_id_admin_usuario INT, 
    IN p_id_publicacion_a_eliminar INT, 
    IN p_motivo_eliminacion TEXT
)
    SQL SECURITY INVOKER
BEGIN
    DECLARE v_es_admin TINYINT;
    
    DECLARE exit handler for SQLEXCEPTION 
    BEGIN 
        ROLLBACK; 
        RESIGNAL; 
    END;
    
    SELECT es_admin INTO v_es_admin FROM usuarios WHERE id = p_id_admin_usuario;

    IF v_es_admin = 0 THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No eres admin.'; 
    END IF;

    START TRANSACTION;

    -- 1. Bitácora
    INSERT INTO bitacora_admin (id_admin_usuario, accion_codigo, referencia_tabla, id_referencia_afectada, motivo) 
    VALUES (p_id_admin_usuario, 'HARD_DELETE_PUBLICACION', 'PUBLICACION', p_id_publicacion_a_eliminar, p_motivo_eliminacion);

    -- 2. Borrar dependencias
    DELETE rep FROM reportes AS rep JOIN reporte_publicacion AS rep_pub ON rep.id = rep_pub.id_reporte WHERE rep_pub.id_publicacion = p_id_publicacion_a_eliminar;
    DELETE FROM imagen_publicacion WHERE id_publicacion = p_id_publicacion_a_eliminar;
    DELETE FROM favoritos WHERE id_publicacion = p_id_publicacion_a_eliminar;
    DELETE FROM publicacion_preguntas WHERE id_publicacion = p_id_publicacion_a_eliminar;
    DELETE FROM chats WHERE id_publicacion = p_id_publicacion_a_eliminar;
    
    -- 3. Borrar tablas hijas
    DELETE FROM publicacion_uniforme WHERE id_publicacion = p_id_publicacion_a_eliminar;
    
    -- 4. Borrar publicación padre
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_crear_calificacion`(
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
    
    SELECT id_comprador, id_vendedor INTO v_id_comprador, v_id_vendedor
    FROM ventas WHERE id = p_id_venta;

    IF v_id_comprador = p_id_usuario_que_califica THEN
        SET v_id_usuario_calificado = v_id_vendedor;
        SET v_rol_calificado = 'Vendedor';
        
    ELSEIF v_id_vendedor = p_id_usuario_que_califica THEN
        SET v_id_usuario_calificado = v_id_comprador;
        SET v_rol_calificado = 'Comprador';
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Este usuario no participó en la venta.';
    END IF;

    INSERT INTO calificaciones (id_venta, id_usuario_calificado, calificado_rol, puntuacion, comentario)
    VALUES (p_id_venta, v_id_usuario_calificado, v_rol_calificado, p_puntuacion, p_comentario);
    
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reporte_compras_por_usuario`(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE,
    IN p_id_categoria INT -- Parametro de filtro
)
BEGIN
    SELECT 
        u.id AS id_comprador,
        u.nombre,
        u.apellido,
        COUNT(v.id) AS total_compras,
        SUM(v.precio_final) AS gasto_total
    FROM ventas AS v
    JOIN usuarios AS u ON v.id_comprador = u.id
    JOIN publicacion AS p ON v.id_publicacion = p.id
    WHERE
        (v.fecha_venta BETWEEN p_fecha_inicio AND p_fecha_fin)
        AND
        (p_id_categoria IS NULL OR p.id_categoria = p_id_categoria)
    GROUP BY u.id, u.nombre, u.apellido
    ORDER BY total_compras DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vista_objetos`
--

/*!50001 DROP VIEW IF EXISTS `vista_objetos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_objetos` AS select `p`.`id` AS `id`,`p`.`titulo` AS `titulo`,`p`.`precio` AS `precio`,`p`.`condicion` AS `condicion`,`p`.`estado` AS `estado`,`c`.`nombre` AS `nombre_categoria` from (`publicacion` `p` join `categoria` `c` on((`p`.`id_categoria` = `c`.`id`))) where (`p`.`fecha_eliminacion` is null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_uniformes`
--

/*!50001 DROP VIEW IF EXISTS `vista_uniformes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_uniformes` AS select `p`.`id` AS `id`,`p`.`titulo` AS `titulo`,`p`.`precio` AS `precio`,`p`.`condicion` AS `condicion`,`p`.`estado` AS `estado`,`c`.`nombre` AS `nombre_categoria`,`pu`.`id_colegio` AS `id_colegio`,`col`.`nombre` AS `nombre_colegio`,`pu`.`id_talle` AS `id_talle`,`t`.`talle` AS `nombre_talle` from ((((`publicacion` `p` join `categoria` `c` on((`p`.`id_categoria` = `c`.`id`))) join `publicacion_uniforme` `pu` on((`p`.`id` = `pu`.`id_publicacion`))) left join `colegio` `col` on((`pu`.`id_colegio` = `col`.`id`))) left join `talles` `t` on((`pu`.`id_talle` = `t`.`id`))) where (`p`.`fecha_eliminacion` is null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-24 23:17:50
