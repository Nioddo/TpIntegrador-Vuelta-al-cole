package ar.com.colevueltas.site.controller;

import ar.com.colevueltas.site.dto.PublicacionCrearDTO;
import ar.com.colevueltas.site.dto.PublicacionDTO;
import ar.com.colevueltas.site.model.Compra;
import ar.com.colevueltas.site.dto.CompraDTO;
import ar.com.colevueltas.site.model.Publicacion;
import ar.com.colevueltas.site.repository.CompraRepository;
import ar.com.colevueltas.site.service.CompraService;
import ar.com.colevueltas.site.service.PublicacionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

        import java.util.List;

@RestController
@RequestMapping("/api/usuarios/{id}/publicaciones")

public class UsuariosPublicacionController {

    private final PublicacionService service;

    @Autowired
    public UsuariosPublicacionController(PublicacionService service) {
        this.service = service;
    }

    @PostMapping
    public Publicacion createPublicacion(@PathVariable int id, @ModelAttribute PublicacionCrearDTO dto) throws Exception {
        return service.create(id, dto);
    }

    @GetMapping
    public List<PublicacionDTO> verPublicaciones(@PathVariable int id){
        return service.getPublicacionesByUsuario(id);
    }
}
