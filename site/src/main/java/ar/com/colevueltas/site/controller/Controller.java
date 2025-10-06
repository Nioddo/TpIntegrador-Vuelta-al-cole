package ar.com.colevueltas.site.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping

public class Controller {
    @GetMapping("/ola")
    public String holaMundo(){
        return "Hola Mundo";
    }
}
