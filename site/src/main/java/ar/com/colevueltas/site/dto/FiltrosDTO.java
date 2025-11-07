package ar.com.colevueltas.site.dto;

import ar.com.colevueltas.site.model.Condicion;

import java.util.List;

public class FiltrosDTO {
    private String busqueda;
    private List<Integer> cursos;
    private List<Integer> colegios;
    private Integer categoria;
    private List<Condicion> condicion;

    public FiltrosDTO() {
    }

    public FiltrosDTO(String busqueda, List<Integer> cursos, List<Integer> colegios, Integer categoria, List<Condicion> condicion) {
        this.busqueda = busqueda;
        this.cursos = cursos;
        this.colegios = colegios;
        this.categoria = categoria;
        this.condicion = condicion;
    }

    public String getBusqueda() {
        return busqueda;
    }

    public void setBusqueda(String busqueda) {
        this.busqueda = busqueda;
    }

    public List<Integer> getCursos() {
        return cursos;
    }

    public void setCursos(List<Integer> cursos) {
        this.cursos = cursos;
    }

    public List<Integer> getColegios() {
        return colegios;
    }

    public void setColegios(List<Integer> colegios) {
        this.colegios = colegios;
    }

    public Integer getCategoria() {
        return categoria;
    }

    public void setCategoria(Integer categoria) {
        this.categoria = categoria;
    }

    public List<Condicion> getCondicion() {
        return condicion;
    }

    public void setCondicion(List<Condicion> condicion) {
        this.condicion = condicion;
    }
}
