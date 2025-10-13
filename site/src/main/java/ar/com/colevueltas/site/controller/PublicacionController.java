package ar.com.colevueltas.site.controller;

import ar.com.colevueltas.site.dto.PublicacionDTO;
import ar.com.colevueltas.site.service.PublicacionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/productos")

public class PublicacionController {

    private final PublicacionService publicacionService;

    @Autowired
    public PublicacionController(PublicacionService publicacionService) {
        this.publicacionService = publicacionService;
    }

    @GetMapping
    public String pagPrinc(){
        return "PAGIUNA PRINCIPAL PRODICTOS";
    }

    @GetMapping("/{id}")
    public PublicacionDTO prodInd(@PathVariable("id") int id){
        return publicacionService.obtenerPostDeID(id);
    }
}
