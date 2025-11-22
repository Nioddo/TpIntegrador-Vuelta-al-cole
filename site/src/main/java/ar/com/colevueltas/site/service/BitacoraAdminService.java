package ar.com.colevueltas.site.service;

import ar.com.colevueltas.site.model.BitacoraAdmin;
import ar.com.colevueltas.site.repository.BitacoraAdminRepository;
import org.springframework.stereotype.Service;

@Service
public class BitacoraAdminService {

    private final BitacoraAdminRepository bitacoraAdminRepository;

    public BitacoraAdminService(BitacoraAdminRepository bitacoraAdminRepository) {
        this.bitacoraAdminRepository = bitacoraAdminRepository;
    }

    public BitacoraAdmin crear(BitacoraAdmin registro) {
        return bitacoraAdminRepository.save(registro);
    }
}
