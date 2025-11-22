package ar.com.colevueltas.site.repository;

import ar.com.colevueltas.site.model.ImagenPublicacion;
import ar.com.colevueltas.site.model.Publicacion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ImagenPublicacionRepository extends JpaRepository<ImagenPublicacion, Integer> {
    List<ImagenPublicacion> findByPublicacion(Publicacion publicacion);

    @Query("SELECT i.urlImagen FROM ImagenPublicacion i WHERE i.publicacion.id = :idPublicacion")
    List<String> findUrlImagenByPublicacionId(@Param("idPublicacion") Integer idPublicacion);
}
