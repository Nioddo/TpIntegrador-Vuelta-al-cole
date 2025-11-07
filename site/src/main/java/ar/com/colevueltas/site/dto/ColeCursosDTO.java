package ar.com.colevueltas.site.dto;

import java.util.List;

public class ColeCursosDTO {
    private Integer id;
    private String nombre;
    private String direccion;
    private String logo;
    private List<CursoDTO> cursos;

    public ColeCursosDTO() {
    }

    public ColeCursosDTO(Integer id, String nombre, String direccion, String logo, List<CursoDTO> cursos) {
        this.id = id;
        this.nombre = nombre;
        this.direccion = direccion;
        this.logo = logo;
        this.cursos = cursos;
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

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public List<CursoDTO> getCursos() {
        return cursos;
    }

    public void setCursos(List<CursoDTO> cursos) {
        this.cursos = cursos;
    }
}
