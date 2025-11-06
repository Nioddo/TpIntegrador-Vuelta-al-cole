package ar.com.colevueltas.site.model;

import jakarta.persistence.*;

@Entity
@Table(name = "publicacion_colegio")
public class PublicacionColegio {

    @EmbeddedId
    private PublicacionColegioId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("idPublicacion")
    @JoinColumn(name = "id_publicacion")
    private Publicacion publicacion;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("idColegio")
    @JoinColumn(name = "id_colegio")
    private Colegio colegio;

    public PublicacionColegio() {}

    public PublicacionColegio(Publicacion publicacion, Colegio colegio) {
        this.publicacion = publicacion;
        this.colegio = colegio;
        this.id = new PublicacionColegioId(publicacion.getId(), colegio.getId());
    }

    public PublicacionColegioId getId() {
        return id;
    }

    public void setId(PublicacionColegioId id) {
        this.id = id;
    }

    public Publicacion getPublicacion() {
        return publicacion;
    }

    public void setPublicacion(Publicacion publicacion) {
        this.publicacion = publicacion;
    }

    public Colegio getColegio() {
        return colegio;
    }

    public void setColegio(Colegio colegio) {
        this.colegio = colegio;
    }
}

