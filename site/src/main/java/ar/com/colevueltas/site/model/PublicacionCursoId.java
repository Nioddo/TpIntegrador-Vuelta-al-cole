package ar.com.colevueltas.site.model;

import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class PublicacionCursoId implements Serializable {

    private Integer idPublicacion;
    private Integer idCurso;

    public PublicacionCursoId() {}

    public PublicacionCursoId(Integer idPublicacion, Integer idCurso) {
        this.idPublicacion = idPublicacion;
        this.idCurso = idCurso;
    }

    public Integer getIdPublicacion() {
        return idPublicacion;
    }

    public Integer getIdCurso() {
        return idCurso;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof PublicacionCursoId)) return false;
        PublicacionCursoId that = (PublicacionCursoId) o;
        return Objects.equals(idPublicacion, that.idPublicacion) &&
                Objects.equals(idCurso, that.idCurso);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idPublicacion, idCurso);
    }
}
