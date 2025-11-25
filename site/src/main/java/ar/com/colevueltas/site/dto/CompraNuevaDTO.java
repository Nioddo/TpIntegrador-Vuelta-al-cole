package ar.com.colevueltas.site.dto;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDateTime;

public class CompraNuevaDTO {
    @NotNull(message = "El chat de origen es obligatorio")
    private Integer id_chat_origen;

    @NotNull(message = "El precio final es obligatorio")
    private Double precio_final;

    @NotEmpty(message = "El punto de entrega es obligatorio")
    private String punto_entrega;

    private LocalDateTime fecha_venta;

    public CompraNuevaDTO() {
        this.fecha_venta = LocalDateTime.now();
    }

    public CompraNuevaDTO(Integer id_chat_origen, Double precio_final, String punto_entrega, LocalDateTime fecha_venta) {
        this.id_chat_origen = id_chat_origen;
        this.precio_final = precio_final;
        this.punto_entrega = punto_entrega;
        this.fecha_venta = fecha_venta;
    }

    public Integer getId_chat_origen() {
        return id_chat_origen;
    }

    public void setId_chat_origen(Integer id_chat_origen) {
        this.id_chat_origen = id_chat_origen;
    }

    public Double getPrecio_final() {
        return precio_final;
    }

    public void setPrecio_final(Double precio_final) {
        this.precio_final = precio_final;
    }

    public String getPunto_entrega() {
        return punto_entrega;
    }

    public void setPunto_entrega(String punto_entrega) {
        this.punto_entrega = punto_entrega;
    }

    public LocalDateTime getFecha_venta() {
        return fecha_venta;
    }

    public void setFecha_venta(LocalDateTime fecha_venta) {
        this.fecha_venta = fecha_venta;
    }
}
