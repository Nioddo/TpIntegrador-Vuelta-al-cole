package ar.com.colevueltas.site.controller;

import ar.com.colevueltas.site.dto.UsuarioCrearDTO;
import ar.com.colevueltas.site.model.Usuario;
import ar.com.colevueltas.site.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping

public class Controller {

    @GetMapping("/ola")
    public String holaMundo(){
        return "Hola Mundo";
    }

}
