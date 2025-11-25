package ar.com.colevueltas.site.controller;

import ar.com.colevueltas.site.dto.*;
import ar.com.colevueltas.site.model.PublicacionPregunta;
import ar.com.colevueltas.site.service.PreguntaService;
import ar.com.colevueltas.site.service.PublicacionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/publicaciones")
public class PublicacionController {
    private final PublicacionService service;
    private final PreguntaService preguntaService;

    @Autowired
    public PublicacionController(PublicacionService service, PreguntaService preguntaService) {
        this.service = service;
        this.preguntaService = preguntaService;
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

    @PostMapping("/preguntar")
    public PreguntaDTO publicarPregunta(@RequestBody NuevaPreguntaDTO dto){
        return preguntaService.crearPregunta(dto);
    }
}
