package ar.com.colevueltas.site.repository;

import ar.com.colevueltas.site.model.BitacoraAdmin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BitacoraAdminRepository extends JpaRepository<BitacoraAdmin, Integer> {
}
