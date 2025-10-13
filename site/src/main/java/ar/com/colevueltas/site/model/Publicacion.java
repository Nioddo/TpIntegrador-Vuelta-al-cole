package ar.com.colevueltas.site.model;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "publicaciones")
public class Publicacion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String titulo;
    private String descripcion;
    private LocalDate publicacion;
    private Double precio;

    @Enumerated(EnumType.STRING)
    private Estado estado;

    private Double descuento;
    private int id_cat;
    private int id_col;
    private int id_usu;
    private int id_anio;

    public Publicacion() {
        this.id = 0;
        this.titulo = "titulo";
        this.descripcion = "descripcion";
        this.publicacion = LocalDate.now();
        this.precio = 0.0;
        this.estado = Estado.BUENO;
        this.descuento = 0.0;
        this.id_cat = 0;
        this.id_col = 0;
        this.id_usu = 0;
        this.id_anio = 0;
    }

    public Publicacion(int id, String titulo, String descripcion, LocalDate publicacion, Double precio, Estado estado, Double descuento, int id_cat, int id_col, int id_usu, int id_anio) {
        this.id = id;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.publicacion = publicacion;
        this.precio = precio;
        this.estado = estado;
        this.descuento = descuento;
        this.id_cat = id_cat;
        this.id_col = id_col;
        this.id_usu = id_usu;
        this.id_anio = id_anio;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public LocalDate getPublicacion() {
        return publicacion;
    }

    public void setPublicacion(LocalDate publicacion) {
        this.publicacion = publicacion;
    }

    public Double getPrecio() {
        return precio;
    }

    public void setPrecio(Double precio) {
        this.precio = precio;
    }

    public Estado getEstado() {
        return estado;
    }

    public void setEstado(Estado estado) {
        this.estado = estado;
    }

    public Double getDescuento() {
        return descuento;
    }

    public void setDescuento(Double descuento) {
        this.descuento = descuento;
    }

    public int getId_cat() {
        return id_cat;
    }

    public void setId_cat(int id_cat) {
        this.id_cat = id_cat;
    }

    public int getId_col() {
        return id_col;
    }

    public void setId_col(int id_col) {
        this.id_col = id_col;
    }

    public int getId_usu() {
        return id_usu;
    }

    public void setId_usu(int id_usu) {
        this.id_usu = id_usu;
    }

    public int getId_anio() {
        return id_anio;
    }

    public void setId_anio(int id_anio) {
        this.id_anio = id_anio;
    }
}
