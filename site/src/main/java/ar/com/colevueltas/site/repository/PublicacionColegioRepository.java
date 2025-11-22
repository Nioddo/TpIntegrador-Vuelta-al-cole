package ar.com.colevueltas.site.repository;

import ar.com.colevueltas.site.model.PublicacionColegio;
import ar.com.colevueltas.site.model.PublicacionColegioId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PublicacionColegioRepository extends JpaRepository<PublicacionColegio, PublicacionColegioId> {
}
