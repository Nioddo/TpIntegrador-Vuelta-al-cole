package ar.com.colevueltas.site.dto;

import jakarta.persistence.*;
import org.springframework.cglib.core.Local;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class CompraDTO {
    private int id;
    private int id_chat_origen;
    private Double precio_final;
    private String punto_entrega;
    private LocalDateTime fecha_venta;

    public CompraDTO() {
        this.id = 0;
        this.id_chat_origen = 0;
        this.precio_final = 0.0;
        this.punto_entrega = "punto_entrega";
        this.fecha_venta = LocalDateTime.now();
    }

    public CompraDTO(int id, int id_chat_origen, Double precio_final, String punto_entrega, LocalDateTime fecha_venta) {
        this.id = id;
        this.id_chat_origen = id_chat_origen;
        this.precio_final = precio_final;
        this.punto_entrega = punto_entrega;
        this.fecha_venta = fecha_venta;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_chat_origen() {
        return id_chat_origen;
    }

    public void setId_chat_origen(int id_chat_origen) {
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
