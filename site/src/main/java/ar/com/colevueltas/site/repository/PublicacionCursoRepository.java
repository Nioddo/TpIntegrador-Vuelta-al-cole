package ar.com.colevueltas.site.repository;

import ar.com.colevueltas.site.model.PublicacionCurso;
import ar.com.colevueltas.site.model.PublicacionCursoId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PublicacionCursoRepository extends JpaRepository<PublicacionCurso, PublicacionCursoId> {
}
