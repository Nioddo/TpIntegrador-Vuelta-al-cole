package ar.com.colevueltas.site.dto;

import ar.com.colevueltas.site.model.Condicion;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.util.List;

public class PublicacionCrearDTO {

    @NotBlank(message = "El titulo es obligatorio")
    private String titulo;

    private String descripcion;

    @NotNull(message = "El precio es obligatorio")
    @Min(value = 0, message = "El precio no puede ser menor a cero")
    private BigDecimal precio;

    @NotNull(message = "Elegir una condición")
    private Condicion condicion;

    @NotNull(message = "Elegir una categoría")
    private Integer idCategoria;


    @NotNull(message = "Debe agregar al menos una imagen")
    private List<MultipartFile> imagenes;

    @NotNull(message = "Debe seleccionar al menos un curso")
    private List<Integer> idsCursos;

    @NotNull(message = "Debe seleccionar al menos un colegio")
    private List<Integer> idsColegios;


    public PublicacionCrearDTO() {
    }

    public PublicacionCrearDTO(String titulo, String descripcion, BigDecimal precio, Condicion condicion, Integer idCategoria, List<MultipartFile> imagenes, List<Integer> idsCursos, List<Integer> idsColegios) {
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.precio = precio;
        this.condicion = condicion;
        this.idCategoria = idCategoria;
        this.imagenes = imagenes;
        this.idsCursos = idsCursos;
        this.idsColegios = idsColegios;
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

    public Integer getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(Integer idCategoria) {
        this.idCategoria = idCategoria;
    }

    public List<MultipartFile> getImagenes() {
        return imagenes;
    }

    public void setImagenes(List<MultipartFile> imagenes) {
        this.imagenes = imagenes;
    }

    public List<Integer> getIdsCursos() {
        return idsCursos;
    }

    public void setIdsCursos(List<Integer> idsCursos) {
        this.idsCursos = idsCursos;
    }

    public List<Integer> getIdsColegios() {
        return idsColegios;
    }

    public void setIdsColegios(List<Integer> idsColegios) {
        this.idsColegios = idsColegios;
    }
}
