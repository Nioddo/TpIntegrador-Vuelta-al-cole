package ar.com.colevueltas.site.controller;

import ar.com.colevueltas.site.dto.CategoriaListadoDTO;
import ar.com.colevueltas.site.dto.ColeCursosDTO;
import ar.com.colevueltas.site.service.CategoriaService;
import ar.com.colevueltas.site.service.ColegioService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/categorias")

public class CursosController {

    private final ColegioService colegioService;

    public CursosController(ColegioService colegioService) {
        this.colegioService = colegioService;
    }

    @GetMapping("/cursos")
    public List<ColeCursosDTO> obtenerCursos() {
        return colegioService.coleCursos();
    }
}
