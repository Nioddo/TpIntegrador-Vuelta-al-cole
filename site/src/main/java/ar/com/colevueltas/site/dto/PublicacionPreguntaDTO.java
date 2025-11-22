package ar.com.colevueltas.site.dto;

public class PublicacionPreguntaDTO {

    private int id;
    private String pregunta;
    private String fechaPregunta;
    private String respuesta;
    private String fechaRespuesta;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getPregunta() { return pregunta; }
    public void setPregunta(String pregunta) { this.pregunta = pregunta; }

    public String getFechaPregunta() { return fechaPregunta; }
    public void setFechaPregunta(String fechaPregunta) { this.fechaPregunta = fechaPregunta; }

    public String getRespuesta() { return respuesta; }
    public void setRespuesta(String respuesta) { this.respuesta = respuesta; }

    public String getFechaRespuesta() { return fechaRespuesta; }
    public void setFechaRespuesta(String fechaRespuesta) { this.fechaRespuesta = fechaRespuesta; }
}
