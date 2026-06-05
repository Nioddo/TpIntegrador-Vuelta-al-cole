
DELIMITER ;;

-- -----------------------------------------------------------------------------
-- 1. "Trigger que, al realizarse cierta cantidad de compras, coloque al usuario como verificado."
-- -----------------------------------------------------------------------------
DROP TRIGGER IF EXISTS trg_verificar_usuario_por_compras;;

CREATE TRIGGER trg_verificar_usuario_por_compras 
AFTER INSERT ON ventas 
FOR EACH ROW 
BEGIN
    DECLARE v_total_compras INT;
    DECLARE v_limite_compras INT;
    DECLARE v_es_verificado TINYINT;
    DECLARE v_id_tipo_notif INT;

    -- Obtenemos configuración y estado actual
    SELECT CAST(valor AS UNSIGNED) INTO v_limite_compras FROM configuracion WHERE clave = 'COMPRAS_PARA_VERIFICACION';
    SELECT es_verificado INTO v_es_verificado FROM usuarios WHERE id = NEW.id_comprador;

    -- Si no está verificado y existe un límite configurado
    IF v_es_verificado = 0 AND v_limite_compras > 0 THEN
        SELECT COUNT(*) INTO v_total_compras FROM ventas WHERE id_comprador = NEW.id_comprador;

        -- Si alcanzó el límite, actualizamos
        IF v_total_compras >= v_limite_compras THEN
            UPDATE usuarios SET es_verificado = 1 WHERE id = NEW.id_comprador;
            
            -- Buscamos el ID del tipo de notificación y notificamos
            SELECT id INTO v_id_tipo_notif FROM tipo_notificacion WHERE nombre_clave = 'USUARIO_VERIFICADO' LIMIT 1;
            INSERT INTO notificaciones (id_usuario_destino, id_tipo, id_venta)
            VALUES (NEW.id_comprador, v_id_tipo_notif, NULL);
        END IF;
    END IF;
END ;;

-- -----------------------------------------------------------------------------
-- 2. "Trigger que, al realizarse una compra... modifique el nivel de los usuarios (vendedor y comprador)."
-- -----------------------------------------------------------------------------
DROP TRIGGER IF EXISTS trg_actualizar_nivel_por_venta;;

CREATE TRIGGER trg_actualizar_nivel_por_venta 
AFTER INSERT ON ventas 
FOR EACH ROW 
BEGIN
    DECLARE v_xp_ganada INT DEFAULT 25;
    DECLARE v_xp_actual INT;
    DECLARE v_nivel_actual INT;
    DECLARE v_nivel_nuevo INT;
    DECLARE v_id_tipo_notif INT;

    -- Obtenemos el ID para notificar subida de nivel
    SELECT id INTO v_id_tipo_notif FROM tipo_notificacion WHERE nombre_clave = 'NIVEL_SUBIDO' LIMIT 1;

    -- A. LÓGICA DEL COMPRADOR
    SELECT xp, nivel INTO v_xp_actual, v_nivel_actual FROM usuarios WHERE id = NEW.id_comprador;
    UPDATE usuarios SET xp = xp + v_xp_ganada WHERE id = NEW.id_comprador;
    
    -- Calculamos si corresponde nuevo nivel
    SELECT nivel INTO v_nivel_nuevo FROM niveles WHERE xp_necesaria <= (v_xp_actual + v_xp_ganada) ORDER BY xp_necesaria DESC LIMIT 1;
    
    IF v_nivel_nuevo > v_nivel_actual THEN
        UPDATE usuarios SET nivel = v_nivel_nuevo WHERE id = NEW.id_comprador;
        INSERT INTO notificaciones (id_usuario_destino, id_tipo) VALUES (NEW.id_comprador, v_id_tipo_notif);
    END IF;

    -- B. LÓGICA DEL VENDEDOR
    SELECT xp, nivel INTO v_xp_actual, v_nivel_actual FROM usuarios WHERE id = NEW.id_vendedor;
    UPDATE usuarios SET xp = xp + v_xp_ganada WHERE id = NEW.id_vendedor;
    
    SELECT nivel INTO v_nivel_nuevo FROM niveles WHERE xp_necesaria <= (v_xp_actual + v_xp_ganada) ORDER BY xp_necesaria DESC LIMIT 1;
    
    IF v_nivel_nuevo > v_nivel_actual THEN
        UPDATE usuarios SET nivel = v_nivel_nuevo WHERE id = NEW.id_vendedor;
        INSERT INTO notificaciones (id_usuario_destino, id_tipo) VALUES (NEW.id_vendedor, v_id_tipo_notif);
    END IF;
END ;;

-- -----------------------------------------------------------------------------
-- 3. "Procedimiento que permita a los administradores publicar contenido."
-- -----------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_admin_crear_publicacion_prueba;;

CREATE PROCEDURE sp_admin_crear_publicacion_prueba(
    IN p_id_admin_usuario INT,
    IN p_id_usuario_vendedor INT,
    IN p_titulo VARCHAR(150),
    IN p_descripcion TEXT,
    IN p_precio DECIMAL(10,2),
    IN p_condicion ENUM('Nuevo','Excelente','Muy bueno','Bueno','Aceptable','Malo'),
    IN p_id_categoria INT, 
    IN p_tipo_publicacion ENUM('Objeto', 'Uniforme'),
    IN p_id_colegio INT,
    IN p_id_talle INT
)
BEGIN
    DECLARE v_es_admin TINYINT;
    DECLARE v_publicacion_id INT;

    -- Validar que sea Admin
    SELECT es_admin INTO v_es_admin FROM usuarios WHERE id = p_id_admin_usuario;
    IF v_es_admin = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No eres admin.'; END IF;

    START TRANSACTION;

    -- 1. Insertar en Tabla Padre (Incluyendo la categoría)
    INSERT INTO publicacion (id_usuario_vendedor, id_categoria, titulo, descripcion, precio, condicion, estado)
    VALUES (p_id_usuario_vendedor, p_id_categoria, p_titulo, p_descripcion, p_precio, p_condicion, 'Activo');
    
    SET v_publicacion_id = LAST_INSERT_ID();
    
    -- 2. Insertar en Tabla Hija (Solo si es Uniforme, Objeto no tiene tabla hija)
    IF p_tipo_publicacion = 'Uniforme' THEN
        INSERT INTO publicacion_uniforme (id_publicacion, id_talle, id_colegio)
        VALUES (v_publicacion_id, p_id_talle, p_id_colegio);
    END IF;

    -- 3. Auditoría en Bitácora
    INSERT INTO bitacora_admin (id_admin_usuario, accion_codigo, referencia_tabla, id_referencia_afectada, motivo) 
    VALUES (p_id_admin_usuario, 'CREAR_PUBLICACION', 'PUBLICACION', v_publicacion_id, 'Creación vía Procedimiento');
    
    COMMIT;
    SELECT * FROM publicacion WHERE id = v_publicacion_id;
END ;;

-- -----------------------------------------------------------------------------
-- 4. "Procedimiento que muestre la cantidad de compras por usuario... rango de fechas y categoría."
-- -----------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_reporte_compras_por_usuario;;

CREATE PROCEDURE sp_reporte_compras_por_usuario(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE,
    IN p_id_categoria INT -- Parametro opcional (Si es NULL, trae todo)
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
        -- Filtro inteligente: Si p_id_categoria es NULL, ignora esta condición
        (p_id_categoria IS NULL OR p.id_categoria = p_id_categoria)
    GROUP BY u.id, u.nombre, u.apellido
    ORDER BY total_compras DESC;
END ;;

-- -----------------------------------------------------------------------------
-- 5. "Evento que, todos los días a las 8:00am, notifique mensajes sin responder."
-- -----------------------------------------------------------------------------
DROP EVENT IF EXISTS ev_notificar_mensajes_no_leidos;;

CREATE EVENT ev_notificar_mensajes_no_leidos
ON SCHEDULE EVERY 1 DAY STARTS '2025-11-24 08:00:00'
DO BEGIN
    DECLARE v_id_tipo INT;
    -- Buscamos el ID del tipo de notificación correspondiente
    SELECT id INTO v_id_tipo FROM tipo_notificacion WHERE nombre_clave = 'NUEVO_MENSAJE' LIMIT 1;

    -- Insertamos una notificación por cada chat que tenga mensajes no leídos
    INSERT INTO notificaciones (id_usuario_destino, id_tipo, id_chat)
    SELECT 
        CASE 
            WHEN m.id_usuario_envia = c.id_usuario_vendedor THEN c.id_usuario_comprador
            ELSE c.id_usuario_vendedor 
        END AS id_destino,
        v_id_tipo,
        c.id -- Referencia al chat para poder abrirlo
    FROM mensajes m
    JOIN chats c ON m.id_chat = c.id
    WHERE m.leido = 0
    GROUP BY id_destino, c.id;
END ;;

-- -----------------------------------------------------------------------------
-- 6. "Evento que, todos los días, cambie el estado de las publicaciones > 6 meses."
-- -----------------------------------------------------------------------------
DROP EVENT IF EXISTS ev_revisar_publicaciones_antiguas;;

CREATE EVENT ev_revisar_publicaciones_antiguas
ON SCHEDULE EVERY 1 DAY STARTS '2025-11-24 03:00:00'
DO BEGIN
    UPDATE publicacion
    SET estado = 'Necesita Revision'
    WHERE 
        estado = 'Activo' 
        AND fecha_publicacion < (NOW() - INTERVAL 6 MONTH);
END ;;

DELIMITER ;