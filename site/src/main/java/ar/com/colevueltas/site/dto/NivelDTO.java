package ar.com.colevueltas.site.dto;

import java.util.List;

public class NivelDTO {
    private int id;
    private int xp;
    private int nivel;
    private String nombre;


    public NivelDTO() {
    }

    public NivelDTO(int id, int xp, int nivel, String nombre) {
        this.id = id;
        this.xp = xp;
        this.nivel = nivel;
        this.nombre = nombre;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNivel() {
        return nivel;
    }

    public void setNivel(int nivel) {
        this.nivel = nivel;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getXp() {
        return xp;
    }

    public void setXp(int xp) {
        this.xp = xp;
    }
}
