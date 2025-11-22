package ar.com.colevueltas.site.repository;

import ar.com.colevueltas.site.model.Compra;
import ar.com.colevueltas.site.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    Usuario findById(int id);
    Integer findNivelById(int id);
    boolean existsByMail(String mail);
    boolean existsByDni(int dni);
    boolean existsByUsername(String username);



}
