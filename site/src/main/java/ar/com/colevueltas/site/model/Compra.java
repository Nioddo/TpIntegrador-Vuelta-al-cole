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

    @Column(name = "id_publicacion")
    private int id_publicacion;

    @Column(name = "id_chat_origen")
    private Integer id_chat_origen;

    @Column(name = "id_comprador")
    private Integer idComprador;

    @Column(name = "id_vendedor")
    private int id_vendedor;

    @Column(name = "precio_final")
    private Double precio_final;

    @Column(name = "punto_entrega")
    private String punto_entrega;

    @Column(name = "fecha_venta")
    private LocalDateTime fecha_venta;

    public Compra() {
        this.fecha_venta = LocalDateTime.now();
    }

    public Compra(int id, int id_publicacion, Integer id_chat_origen, int idComprador, int id_vendedor, Double precio_final, String punto_entrega, LocalDateTime fecha_venta) {
        this.id = id;
        this.id_publicacion = id_publicacion;
        this.id_chat_origen = id_chat_origen;
        this.idComprador = idComprador;
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

    public Integer getId_chat_origen() {
        return id_chat_origen;
    }

    public void setId_chat_origen(Integer id_chat_origen) {
        this.id_chat_origen = id_chat_origen;
    }

    public int getIdComprador() {
        return idComprador;
    }

    public void setIdComprador(int idComprador) {
        this.idComprador = idComprador;
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
