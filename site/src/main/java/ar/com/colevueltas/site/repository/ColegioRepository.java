package ar.com.colevueltas.site.repository;

import ar.com.colevueltas.site.model.Colegio;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ColegioRepository extends JpaRepository<Colegio, Integer> {
    @EntityGraph(attributePaths = "cursos")
    List<Colegio> findAll();
}
