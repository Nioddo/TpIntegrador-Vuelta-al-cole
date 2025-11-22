package ar.com.colevueltas.site.model;

import jakarta.persistence.*;

@Entity
@Table(name = "imagen_publicacion")
public class ImagenPublicacion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "url_imagen", nullable = false)
    private String urlImagen;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_publicacion", nullable = false)
    private Publicacion publicacion;

    public ImagenPublicacion() {
    }

    public ImagenPublicacion(String urlImagen, Publicacion publicacion) {
        this.urlImagen = urlImagen;
        this.publicacion = publicacion;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUrlImagen() {
        return urlImagen;
    }

    public void setUrlImagen(String urlImagen) {
        this.urlImagen = urlImagen;
    }

    public Publicacion getPublicacion() {
        return publicacion;
    }

    public void setPublicacion(Publicacion publicacion) {
        this.publicacion = publicacion;
    }
}