package ar.com.colevueltas.site.repository;

import ar.com.colevueltas.site.model.EstadoPublicacion;
import ar.com.colevueltas.site.model.Publicacion;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface PublicacionRepository extends JpaRepository<Publicacion, Integer> {

    List<Publicacion> findByEstado(String estado);

    List<Publicacion> findByIdUsuarioVendedor(int idUsuarioVendedor);

    List<Publicacion> findByIdCategoria(int idCategoria);

    @Modifying
    @Transactional
    @Query("UPDATE Publicacion p SET p.estado = :estado WHERE p.id = :id")
    int actualizarEstadoPorId(int id, EstadoPublicacion estado);

    @Modifying
    @Transactional
    @Query("UPDATE Publicacion p SET p.fechaEliminacion = :fecha WHERE p.id = :id")
    int actualizarFechaEliminacionPorId(int id, LocalDateTime fecha);
}
