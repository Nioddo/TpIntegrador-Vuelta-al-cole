package ar.com.colevueltas.site.service;

import ar.com.colevueltas.site.dto.PublicacionDTO;
import ar.com.colevueltas.site.model.Publicacion;
import ar.com.colevueltas.site.repository.PublicacionRepository;
import org.springframework.stereotype.Service;

@Service
public class PublicacionService {
    private final PublicacionRepository repository;

    public PublicacionService(PublicacionRepository repository) {
        this.repository = repository;
    }

    public PublicacionDTO obtenerPostDeID(int idpub) {
        Publicacion pub = repository.findById(idpub).orElse(null);
        if (pub == null) return null;

        // Conversión manual a DTO
        PublicacionDTO dto = new PublicacionDTO();
        dto.setId(pub.getId());
        dto.setTitulo(pub.getTitulo());
        dto.setDescripcion(pub.getDescripcion());
        dto.setPublicacion(pub.getPublicacion());
        dto.setPrecio(pub.getPrecio());
        dto.setEstado(pub.getEstado());
        dto.setDescuento(pub.getDescuento());
        dto.setId_cat(pub.getId_cat());
        dto.setId_col(pub.getId_col());
        dto.setId_usu(pub.getId_usu());
        dto.setId_anio(pub.getId_anio());

        return dto;
    }
}
