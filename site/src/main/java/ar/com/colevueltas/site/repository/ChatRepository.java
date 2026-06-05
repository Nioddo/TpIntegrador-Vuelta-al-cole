package ar.com.colevueltas.site.repository;

import ar.com.colevueltas.site.model.Chat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ChatRepository extends JpaRepository<Chat, Integer> {

    @Query("SELECT c FROM Chat c WHERE c.id_publicacion = :idPublicacion AND c.id_usuario_comprador = :idComprador")
    Optional<Chat> findByPublicacionYComprador(@Param("idPublicacion") int idPublicacion,
                                               @Param("idComprador") int idComprador);

    @Query("SELECT c FROM Chat c WHERE c.id = :chatId AND (c.id_usuario_comprador = :userId OR c.id_usuario_vendedor = :userId)")
    Optional<Chat> findByIdYParticipante(@Param("chatId") int chatId, @Param("userId") int userId);
}
