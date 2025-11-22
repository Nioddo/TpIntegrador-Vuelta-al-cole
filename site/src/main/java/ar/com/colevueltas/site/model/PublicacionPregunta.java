package ar.com.colevueltas.site.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "publicacion_preguntas")
public class PublicacionPregunta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "id_publicacion", nullable = false)
    private Publicacion publicacion;  // relación en vez de id_publicacion

    @Column(nullable = false, columnDefinition = "TEXT")
    private String pregunta;

    @Column(name = "fecha_pregunta", nullable = false)
    private LocalDateTime fechaPregunta;

    @Column(columnDefinition = "TEXT")
    private String respuesta;

    @Column(name = "fecha_respuesta")
    private LocalDateTime fechaRespuesta;

    // Getters y setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Publicacion getPublicacion() { return publicacion; }
    public void setPublicacion(Publicacion publicacion) { this.publicacion = publicacion; }

    public String getPregunta() { return pregunta; }
    public void setPregunta(String pregunta) { this.pregunta = pregunta; }

    public LocalDateTime getFechaPregunta() { return fechaPregunta; }
    public void setFechaPregunta(LocalDateTime fechaPregunta) { this.fechaPregunta = fechaPregunta; }

    public String getRespuesta() { return respuesta; }
    public void setRespuesta(String respuesta) { this.respuesta = respuesta; }

    public LocalDateTime getFechaRespuesta() { return fechaRespuesta; }
    public void setFechaRespuesta(LocalDateTime fechaRespuesta) { this.fechaRespuesta = fechaRespuesta; }
}
