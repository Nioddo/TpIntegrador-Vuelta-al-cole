package ar.com.colevueltas.site.dto;

import ar.com.colevueltas.site.model.Condicion;
import ar.com.colevueltas.site.model.EstadoPublicacion;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public class PublicacionVerDTO {

    private int id;
    private int id_usuario_vendedor;
    private String titulo;
    private String descripcion;
    private BigDecimal precio;
    private Condicion condicion;
    private LocalDateTime fecha_publicacion;
    private EstadoPublicacion estado;
    private BigDecimal descuento;
    private LocalDateTime descuento_fecha_inicio;
    private LocalDateTime descuento_fecha_fin;
    private int id_categoria;
    private String nomCategoria;
    private List<PublicacionPreguntaDTO> preguntas;
    private List<String> imagenes;

    public PublicacionVerDTO() {}

    public PublicacionVerDTO(int id, int id_usuario_vendedor, String titulo, String descripcion, BigDecimal precio,
                             Condicion condicion, LocalDateTime fecha_publicacion, EstadoPublicacion estado,
                             BigDecimal descuento, LocalDateTime descuento_fecha_inicio, LocalDateTime descuento_fecha_fin,
                             int id_categoria, List<String> imagenes) {
        this.id = id;
        this.id_usuario_vendedor = id_usuario_vendedor;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.precio = precio;
        this.condicion = condicion;
        this.fecha_publicacion = fecha_publicacion;
        this.estado = estado;
        this.descuento = descuento;
        this.descuento_fecha_inicio = descuento_fecha_inicio;
        this.descuento_fecha_fin = descuento_fecha_fin;
        this.id_categoria = id_categoria;
        this.imagenes = imagenes;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_usuario_vendedor() {
        return id_usuario_vendedor;
    }

    public void setId_usuario_vendedor(int id_usuario_vendedor) {
        this.id_usuario_vendedor = id_usuario_vendedor;
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

    public LocalDateTime getFecha_publicacion() {
        return fecha_publicacion;
    }

    public void setFecha_publicacion(LocalDateTime fecha_publicacion) {
        this.fecha_publicacion = fecha_publicacion;
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

    public LocalDateTime getDescuento_fecha_inicio() {
        return descuento_fecha_inicio;
    }

    public void setDescuento_fecha_inicio(LocalDateTime descuento_fecha_inicio) {
        this.descuento_fecha_inicio = descuento_fecha_inicio;
    }

    public LocalDateTime getDescuento_fecha_fin() {
        return descuento_fecha_fin;
    }

    public void setDescuento_fecha_fin(LocalDateTime descuento_fecha_fin) {
        this.descuento_fecha_fin = descuento_fecha_fin;
    }

    public int getId_categoria() {
        return id_categoria;
    }

    public void setId_categoria(int id_categoria) {
        this.id_categoria = id_categoria;
    }

    public String getNomCategoria() {
        return nomCategoria;
    }

    public void setNomCategoria(String nomCategoria) {
        this.nomCategoria = nomCategoria;
    }

    public List<PublicacionPreguntaDTO> getPreguntas() {
        return preguntas;
    }

    public void setPreguntas(List<PublicacionPreguntaDTO> preguntas) {
        this.preguntas = preguntas;
    }

    public List<String> getImagenes() {
        return imagenes;
    }

    public void setImagenes(List<String> imagenes) {
        this.imagenes = imagenes;
    }
}
