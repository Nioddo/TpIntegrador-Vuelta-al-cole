package ar.com.colevueltas.site.controller;

import ar.com.colevueltas.site.dto.NivelDTO;
import ar.com.colevueltas.site.dto.PublicacionDTO;
import ar.com.colevueltas.site.model.Publicacion;
import ar.com.colevueltas.site.model.Usuario;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/usuarios/{id}/publicaciones")

public class UsuariosCompraController {

    @PostMapping
    public Compra createPublicacion(){
        return new Compra();
    }

    @GetMapping
    public List<PublicacionDTO> verPublicaciones(){
        return new PublicacionDTO();
    }

}
