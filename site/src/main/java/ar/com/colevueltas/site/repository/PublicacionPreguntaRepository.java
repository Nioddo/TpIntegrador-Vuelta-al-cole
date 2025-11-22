package ar.com.colevueltas.site.repository;

import ar.com.colevueltas.site.model.PublicacionPregunta;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface PublicacionPreguntaRepository extends JpaRepository<PublicacionPregunta, Integer> {
    List<PublicacionPregunta> findByPublicacionId(int publicacionId);
}
