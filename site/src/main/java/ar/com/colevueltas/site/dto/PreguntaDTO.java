package ar.com.colevueltas.site.dto;

import java.time.LocalDateTime;

public class PreguntaDTO {
    private int id;
    private String pregunta;
    private LocalDateTime fechaPregunta;

    public PreguntaDTO(int id, String pregunta, LocalDateTime fechaPregunta) {
        this.id = id;
        this.pregunta = pregunta;
        this.fechaPregunta = fechaPregunta;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPregunta() {
        return pregunta;
    }

    public void setPregunta(String pregunta) {
        this.pregunta = pregunta;
    }

    public LocalDateTime getFechaPregunta() {
        return fechaPregunta;
    }

    public void setFechaPregunta(LocalDateTime fechaPregunta) {
        this.fechaPregunta = fechaPregunta;
    }
}
