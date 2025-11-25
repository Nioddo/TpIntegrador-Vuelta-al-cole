package ar.com.colevueltas.site.dto;

public class NuevaPreguntaDTO {

    private int idPublicacion;
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
