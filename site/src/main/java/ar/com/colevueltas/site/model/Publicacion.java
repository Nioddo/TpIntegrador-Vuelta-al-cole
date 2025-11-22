package ar.com.colevueltas.site.model;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "publicacion")
public class Publicacion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "id_usuario_vendedor")
    private int idUsuarioVendedor;

    private String titulo;

    private String descripcion;

    private BigDecimal precio;

    @Enumerated(EnumType.STRING)
    private Condicion condicion;

    @Column(name = "fecha_publicacion")
    private LocalDateTime fechaPublicacion;

    @Column(name = "fecha_ultima_actualizacion")
    private LocalDateTime fechaUltimaActualizacion;

    @Enumerated(EnumType.STRING)
    private EstadoPublicacion estado;

    @Column(precision = 5, scale = 2)
    private BigDecimal descuento;

    @Column(name = "descuento_fecha_inicio")
    private LocalDateTime descuentoFechaInicio;

    @Column(name = "descuento_fecha_fin")
    private LocalDateTime descuentoFechaFin;

    @Column(name = "id_categoria")
    private int idCategoria;

    @Column(name = "fecha_eliminacion")
    private LocalDateTime fechaEliminacion;

    public Publicacion() {
        this.estado = EstadoPublicacion.Activo;
        this.descuento = BigDecimal.ZERO;
    }

    public Publicacion(int idUsuarioVendedor, String titulo, String descripcion, BigDecimal precio,
                       Condicion condicion, LocalDateTime fechaPublicacion, LocalDateTime fechaUltimaActualizacion,
                       EstadoPublicacion estado, BigDecimal descuento, LocalDateTime descuentoFechaInicio,
                       LocalDateTime descuentoFechaFin, int idCategoria, LocalDateTime fechaEliminacion) {
        this.idUsuarioVendedor = idUsuarioVendedor;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.precio = precio;
        this.condicion = condicion;
        this.fechaPublicacion = fechaPublicacion;
        this.fechaUltimaActualizacion = fechaUltimaActualizacion;
        this.estado = estado;
        this.descuento = descuento;
        this.descuentoFechaInicio = descuentoFechaInicio;
        this.descuentoFechaFin = descuentoFechaFin;
        this.idCategoria = idCategoria;
        this.fechaEliminacion = fechaEliminacion;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdUsuarioVendedor() {
        return idUsuarioVendedor;
    }

    public void setIdUsuarioVendedor(int idUsuarioVendedor) {
        this.idUsuarioVendedor = idUsuarioVendedor;
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

    public BigDecimal getPrecio() {
        return precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    public Condicion getCondicion() {
        return condicion;
    }

    public void setCondicion(Condicion condicion) {
        this.condicion = condicion;
    }

    public LocalDateTime getFechaPublicacion() {
        return fechaPublicacion;
    }

    public void setFechaPublicacion(LocalDateTime fechaPublicacion) {
        this.fechaPublicacion = fechaPublicacion;
    }

    public LocalDateTime getFechaUltimaActualizacion() {
        return fechaUltimaActualizacion;
    }

    public void setFechaUltimaActualizacion(LocalDateTime fechaUltimaActualizacion) {
        this.fechaUltimaActualizacion = fechaUltimaActualizacion;
    }

    public EstadoPublicacion getEstado() {
        return estado;
    }

    public void setEstado(EstadoPublicacion estado) {
        this.estado = estado;
    }

    public BigDecimal getDescuento() {
        return descuento;
    }

    public void setDescuento(BigDecimal descuento) {
        this.descuento = descuento;
    }

    public LocalDateTime getDescuentoFechaInicio() {
        return descuentoFechaInicio;
    }

    public void setDescuentoFechaInicio(LocalDateTime descuentoFechaInicio) {
        this.descuentoFechaInicio = descuentoFechaInicio;
    }

    public LocalDateTime getDescuentoFechaFin() {
        return descuentoFechaFin;
    }

    public void setDescuentoFechaFin(LocalDateTime descuentoFechaFin) {
        this.descuentoFechaFin = descuentoFechaFin;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public LocalDateTime getFechaEliminacion() {
        return fechaEliminacion;
    }

    public void setFechaEliminacion(LocalDateTime fechaEliminacion) {
        this.fechaEliminacion = fechaEliminacion;
    }
}
