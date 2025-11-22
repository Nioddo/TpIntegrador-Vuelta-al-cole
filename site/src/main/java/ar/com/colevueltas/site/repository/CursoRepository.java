package ar.com.colevueltas.site.repository;

import ar.com.colevueltas.site.model.Curso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CursoRepository extends JpaRepository<Curso, Integer> {
    List<Curso> findByColegioId(Integer idColegio);
}
