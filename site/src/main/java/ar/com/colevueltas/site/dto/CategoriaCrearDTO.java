package ar.com.colevueltas.site.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public class CategoriaCrearDTO {

    private Integer idPadre;

    @NotBlank(message = "El nombre es obligatorio")
    private String nombre;

    public CategoriaCrearDTO() {}

    public CategoriaCrearDTO(Integer idPadre, String nombre) {
        this.idPadre = idPadre;
        this.nombre = nombre;
    }

    public Integer getIdPadre() {
        return idPadre;
    }

    public void setIdPadre(Integer idPadre) {
        this.idPadre = idPadre;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
}
