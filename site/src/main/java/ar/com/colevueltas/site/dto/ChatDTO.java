package ar.com.colevueltas.site.dto;

import java.time.LocalDateTime;

public record ChatDTO(
        int id,
        int idPublicacion,
        int idUsuarioComprador,
        int idUsuarioVendedor,
        String estado,
        LocalDateTime fechaCreacion,
        LocalDateTime fechaUltimaActividad
) {}
