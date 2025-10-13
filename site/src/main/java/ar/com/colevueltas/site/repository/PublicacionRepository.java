package ar.com.colevueltas.site.repository;

import ar.com.colevueltas.site.model.Publicacion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PublicacionRepository extends JpaRepository<Publicacion, Integer> {

}
