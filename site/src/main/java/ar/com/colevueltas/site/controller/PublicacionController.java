package ar.com.colevueltas.site.controller;

import ar.com.colevueltas.site.dto.FiltrosDTO;
import ar.com.colevueltas.site.dto.PublicacionBuscarDTO;
import ar.com.colevueltas.site.service.PublicacionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
