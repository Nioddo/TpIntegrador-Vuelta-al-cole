package ar.com.colevueltas.site.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;

public class NuevaPreguntaDTO {

    @Min(value = 1, message = "El ID de la publicación debe ser mayor que 0")
    private int idPublicacion;
    @NotEmpty(message = "La pregunta es obligatoria")
    private String pregunta;

    public NuevaPreguntaDTO() {}

    public int getIdPublicacion() {
        return idPublicacion;
    }

    public void setIdPublicacion(int idPublicacion) {
        this.idPublicacion = idPublicacion;
    }

    public String getPregunta() {
        return pregunta;
    }

    public void setPregunta(String pregunta) {
        this.pregunta = pregunta;
    }
}
