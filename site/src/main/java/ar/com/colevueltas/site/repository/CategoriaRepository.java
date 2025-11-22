package ar.com.colevueltas.site.repository;

import ar.com.colevueltas.site.model.Categoria;
import ar.com.colevueltas.site.model.Chat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoriaRepository extends JpaRepository<Categoria, Integer> {
    List<Categoria> findByCategoriaPadreIsNull();
}
