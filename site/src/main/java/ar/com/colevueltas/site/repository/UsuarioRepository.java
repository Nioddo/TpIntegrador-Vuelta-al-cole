package ar.com.colevueltas.site.repository;

import ar.com.colevueltas.site.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    Usuario findById(int id);
    Optional<Usuario> findByMail(String mail);
    Integer findNivelById(int id);
    boolean existsByMail(String mail);
    boolean existsByDni(int dni);
    boolean existsByUsername(String username);
}
