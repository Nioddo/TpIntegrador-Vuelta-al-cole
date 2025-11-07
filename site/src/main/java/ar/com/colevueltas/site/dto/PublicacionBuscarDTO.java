package ar.com.colevueltas.site.dto;

import java.math.BigDecimal;
import java.util.List;

public class PublicacionBuscarDTO {
    private Integer id;
    private String titulo;
    private BigDecimal precio;
    private List<String> imagenes;

    public PublicacionBuscarDTO() {
    }

    public PublicacionBuscarDTO(Integer id, String titulo, BigDecimal precio, List<String> imagenes) {
        this.id = id;
        this.titulo = titulo;
        this.precio = precio;
        this.imagenes = imagenes;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public BigDecimal getPrecio() {
        return precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    public List<String> getImagenes() {
        return imagenes;
    }

    public void setImagenes(List<String> imagenes) {
        this.imagenes = imagenes;
    }
}
