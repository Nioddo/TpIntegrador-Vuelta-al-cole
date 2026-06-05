package ar.com.colevueltas.site.repository;

import ar.com.colevueltas.site.model.Mensaje;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MensajeRepository extends JpaRepository<Mensaje, Integer> {
    List<Mensaje> findByChatIdOrderByFechaEnvioAsc(int chatId);
}
