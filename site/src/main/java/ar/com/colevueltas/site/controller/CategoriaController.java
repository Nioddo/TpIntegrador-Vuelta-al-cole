package ar.com.colevueltas.site.controller;

import ar.com.colevueltas.site.dto.CategoriaListadoDTO;
import ar.com.colevueltas.site.service.CategoriaService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/categorias")

public class CategoriaController {

    private final CategoriaService categoriaService;

    public CategoriaController(CategoriaService categoriaService) {
        this.categoriaService = categoriaService;
    }

    @GetMapping()
    public List<CategoriaListadoDTO> obtenerCategorias() {
        return categoriaService.obtenerArbolCategorias();
    }
}
