package ar.com.colevueltas.site.controller;

import ar.com.colevueltas.site.dto.*;
import ar.com.colevueltas.site.model.Usuario;
import ar.com.colevueltas.site.service.UsuarioService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/usuarios")

public class UsuariosController {

    private final UsuarioService usuarioService;

    @Autowired
    public UsuariosController(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }


    @PostMapping
    public Usuario createUsuario(@Valid @RequestBody UsuarioCrearDTO dto){
        System.out.println(dto);
        return usuarioService.create(dto);
    }

    @GetMapping("/{id}")
    public UsuarioPerfilDTO perfilUsuario(@PathVariable("id") int id){
        return usuarioService.infoPerfilUsuario(id);
    }
    @GetMapping("/pub/{id}")
    public UsuarioPublicacionDTO perfilUsuarioPub(@PathVariable("id") int id){
        return usuarioService.infoPubUsuario(id);
    }

    @GetMapping("/{id}/nivel")
    public NivelDTO buscarNivel(@PathVariable("id") int id){
        return usuarioService.obtenerNivel(id);
    }

    @GetMapping("/{id}/reputacion")
    public ReputacionVendedorDTO buscarReputacion(@PathVariable("id") int id){
        return usuarioService.obtenerReputacionVendedor(id);
    }
}
