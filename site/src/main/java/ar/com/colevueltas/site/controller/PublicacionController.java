package ar.com.colevueltas.site.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/productos")

public class PublicacionController {
    @GetMapping("")
    public String pagPrinc(){
        return "PAGIUNA PRINCIPAL PRODICTOS";
    }

    @GetMapping("/")
    public String pagPrinc2(){
        return "PAGIUNA PRINCIPAL PRODICTOS";
    }

    @GetMapping("/{id}")
    public String prodInd(@PathVariable("id") Long id){
        return "PAGIUNA indifvidual " + id;
    }
}
