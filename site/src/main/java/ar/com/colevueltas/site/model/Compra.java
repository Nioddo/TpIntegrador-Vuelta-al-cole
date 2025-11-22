package ar.com.colevueltas.site.model;

import jakarta.persistence.*;
import org.springframework.cglib.core.Local;

import java.time.LocalDateTime;

@Entity
@Table(name = "ventas")
public class Compra {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private int id_publicacion;
    private int id_chat_origen;
    private int id_comprador;
    private int id_vendedor;
    private Double precio_final;
    private String punto_entrega;
    private LocalDateTime fecha_venta;

    public Compra() {
        this.id = 0;
        this.id_publicacion = 0;
        this.id_chat_origen = 0;
        this.id_comprador = 0;
        this.id_vendedor = 0;
        this.precio_final = 0.0;
        this.punto_entrega = "punto_entrega";
        this.fecha_venta = LocalDateTime.now();
    }

    public Compra(int id, int id_publicacion, int id_chat_origen, int id_comprador, int id_vendedor, Double precio_final, String punto_entrega, LocalDateTime fecha_venta) {
        this.id = id;
        this.id_publicacion = id_publicacion;
        this.id_chat_origen = id_chat_origen;
        this.id_comprador = id_comprador;
        this.id_vendedor = id_vendedor;
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

    public int getId_publicacion() {
        return id_publicacion;
    }

    public void setId_publicacion(int id_publicacion) {
        this.id_publicacion = id_publicacion;
    }

    public int getId_chat_origen() {
        return id_chat_origen;
    }

    public void setId_chat_origen(int id_chat_origen) {
        this.id_chat_origen = id_chat_origen;
    }

    public int getId_comprador() {
        return id_comprador;
    }

    public void setId_comprador(int id_comprador) {
        this.id_comprador = id_comprador;
    }

    public int getId_vendedor() {
        return id_vendedor;
    }

    public void setId_vendedor(int id_vendedor) {
        this.id_vendedor = id_vendedor;
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
