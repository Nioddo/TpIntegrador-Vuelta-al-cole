package ar.com.colevueltas.site.repository;

import ar.com.colevueltas.site.model.Nivel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NivelRepository extends JpaRepository<Nivel, Integer> {
    Nivel findByNivel(int nivel);
}
