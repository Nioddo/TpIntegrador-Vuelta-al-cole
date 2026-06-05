package ar.com.colevueltas.site.dto;

import java.time.LocalDateTime;

public record MensajeSalidaDTO(
        int id,
        int idChat,
        int idUsuarioEnvia,
        String contenido,
        LocalDateTime fechaEnvio,
        boolean leido
) {}
