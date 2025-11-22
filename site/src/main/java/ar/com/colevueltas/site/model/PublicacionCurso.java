package ar.com.colevueltas.site.model;

import jakarta.persistence.*;

@Entity
@Table(name = "publicacion_curso")
public class PublicacionCurso {

    @EmbeddedId
    private PublicacionCursoId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("idPublicacion")
    @JoinColumn(name = "id_publicacion")
    private Publicacion publicacion;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("idCurso")
    @JoinColumn(name = "id_curso")
    private Curso curso;

    public PublicacionCurso() {}

    public PublicacionCurso(Publicacion publicacion, Curso curso) {
        this.publicacion = publicacion;
        this.curso = curso;
        this.id = new PublicacionCursoId(publicacion.getId(), curso.getId());
    }

    public PublicacionCursoId getId() {
        return id;
    }

    public void setId(PublicacionCursoId id) {
        this.id = id;
    }

    public Publicacion getPublicacion() {
        return publicacion;
    }

    public void setPublicacion(Publicacion publicacion) {
        this.publicacion = publicacion;
    }

    public Curso getCurso() {
        return curso;
    }

    public void setCurso(Curso curso) {
        this.curso = curso;
    }
}
