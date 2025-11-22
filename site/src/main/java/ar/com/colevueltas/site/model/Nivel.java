package ar.com.colevueltas.site.model;

import jakarta.persistence.*;

@Entity
@Table(name = "niveles")
public class Nivel {

    @Id
    @Column(name = "nivel", nullable = false)
    private Integer nivel;

    @Column(name = "xp_necesaria", nullable = false)
    private Integer xpNecesaria;

    @Column(name = "nombre_nivel", length = 50)
    private String nombreNivel;

    public Nivel() {}

    public Nivel(Integer nivel, Integer xpNecesaria, String nombreNivel) {
        this.nivel = nivel;
        this.xpNecesaria = xpNecesaria;
        this.nombreNivel = nombreNivel;
    }

    public Integer getNivel() {
        return nivel;
    }

    public void setNivel(Integer nivel) {
        this.nivel = nivel;
    }

    public Integer getXpNecesaria() {
        return xpNecesaria;
    }

    public void setXpNecesaria(Integer xpNecesaria) {
        this.xpNecesaria = xpNecesaria;
    }

    public String getNombreNivel() {
        return nombreNivel;
    }

    public void setNombreNivel(String nombreNivel) {
        this.nombreNivel = nombreNivel;
    }
}

