package ar.com.colevueltas.site.repository;

import ar.com.colevueltas.site.model.Compra;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CompraRepository extends JpaRepository<Compra, Integer> {
    @Query("SELECT c FROM Compra c WHERE c.id_comprador = :idComprador")
    List<Compra> findByIdComprador(@Param("idComprador") int idComprador);
}
