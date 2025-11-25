package ar.com.colevueltas.site.service;

import ar.com.colevueltas.site.dto.NuevaPreguntaDTO;
import ar.com.colevueltas.site.dto.PreguntaDTO;
import ar.com.colevueltas.site.model.Publicacion;
import ar.com.colevueltas.site.model.PublicacionPregunta;
import ar.com.colevueltas.site.model.Usuario;
import ar.com.colevueltas.site.repository.PublicacionPreguntaRepository;
import ar.com.colevueltas.site.repository.PublicacionRepository;
import ar.com.colevueltas.site.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class PreguntaService {

    @Autowired
    private PublicacionRepository publicacionRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private PublicacionPreguntaRepository publicacionPreguntaRepository;

    public PreguntaDTO crearPregunta(NuevaPreguntaDTO dto) {
        Publicacion pub = publicacionRepository
                .getReferenceById(dto.getIdPublicacion());

        PublicacionPregunta p = new PublicacionPregunta();
        p.setPublicacion(pub);
        p.setPregunta(dto.getPregunta());
        p.setFechaPregunta(LocalDateTime.now());

        PublicacionPregunta pregunta = publicacionPreguntaRepository.save(p);

        return new PreguntaDTO(pregunta.getId(), pregunta.getPregunta(), pregunta.getFechaPregunta());
    }
}
