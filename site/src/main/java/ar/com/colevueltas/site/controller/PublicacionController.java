package ar.com.colevueltas.site.controller;

import ar.com.colevueltas.site.dto.FiltrosDTO;
import ar.com.colevueltas.site.dto.PublicacionBuscarDTO;
import ar.com.colevueltas.site.dto.PublicacionDTO;
import ar.com.colevueltas.site.dto.PublicacionVerDTO;
import ar.com.colevueltas.site.service.PublicacionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/publicaciones")
public class PublicacionController {

    private final PublicacionService service;

    @Autowired
    public PublicacionController(PublicacionService service) {
        this.service = service;
    }

    @GetMapping()
    public List<PublicacionBuscarDTO> buscarPublicaciones(@RequestBody FiltrosDTO dto){
        return null;
    }

    @GetMapping("/destacados")
    public List<PublicacionBuscarDTO> publicacionesDestacadas(){
        return service.getPublicacionesRecientes();
    }

    @GetMapping("/{id}")
    public PublicacionVerDTO verPublicacion(@PathVariable("id") int id){
        return service.getPublicacion(id);
    }
}
