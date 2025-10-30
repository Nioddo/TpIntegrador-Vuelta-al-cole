package ar.com.colevueltas.site.dto;

import java.util.List;

public class CategoriaListadoDTO {

    private Integer id;
    private String nombre;
    private List<CategoriaListadoDTO> hijos;

    public CategoriaListadoDTO() {}

    public CategoriaListadoDTO(Integer id, String nombre, List<CategoriaListadoDTO> hijos) {
        this.id = id;
        this.nombre = nombre;
        this.hijos = hijos;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public List<CategoriaListadoDTO> getHijos() {
        return hijos;
    }

    public void setHijos(List<CategoriaListadoDTO> hijos) {
        this.hijos = hijos;
    }
}
