package ar.com.colevueltas.site.model;

import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class PublicacionColegioId implements Serializable {

    private Integer idPublicacion;
    private Integer idColegio;

    public PublicacionColegioId() {}

    public PublicacionColegioId(Integer idPublicacion, Integer idColegio) {
        this.idPublicacion = idPublicacion;
        this.idColegio = idColegio;
    }

    public Integer getIdPublicacion() {
        return idPublicacion;
    }

    public Integer getIdColegio() {
        return idColegio;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof PublicacionColegioId)) return false;
        PublicacionColegioId that = (PublicacionColegioId) o;
        return Objects.equals(idPublicacion, that.idPublicacion) &&
                Objects.equals(idColegio, that.idColegio);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idPublicacion, idColegio);
    }
}
