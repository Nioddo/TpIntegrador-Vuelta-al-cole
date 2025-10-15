package ar.com.colevueltas.site.controller;

import ar.com.colevueltas.site.dto.NivelDTO;
import ar.com.colevueltas.site.dto.ReputacionDTO;
import ar.com.colevueltas.site.model.Usuario;
import ar.com.colevueltas.site.dto.UsuarioDTO;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/usuarios")

public class UsuariosController {

    @PostMapping
    public Usuario createUsuario(@RequestBody UsuarioDTO dto){
        return new Usuario();
    }

    @GetMapping("/{id}/nivel")
    public NivelDTO buscarNivel(@PathVariable("id") int id){
        return new NivelDTO();
    }

    @GetMapping("/{id}/reputacion")
    public ReputacionDTO buscarReputacion(@PathVariable("id") int id){
        return new ReputacionDTO();
    }

}
