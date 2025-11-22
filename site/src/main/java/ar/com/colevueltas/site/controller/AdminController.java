package ar.com.colevueltas.site.controller;

import ar.com.colevueltas.site.dto.CategoriaCrearDTO;
import ar.com.colevueltas.site.model.BitacoraAdmin;
import ar.com.colevueltas.site.service.CategoriaService;
import ar.com.colevueltas.site.service.PublicacionService;
import ar.com.colevueltas.site.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/admin")

public class AdminController {

    private final PublicacionService publicacionService;
    private final CategoriaService categoriaService;

    @Autowired
    public AdminController(PublicacionService publicacionService, CategoriaService categoriaService) {
        this.publicacionService = publicacionService;
        this.categoriaService = categoriaService;
    }

    @DeleteMapping("/publicaciones/{id}")
    public void deletePublicacion(@PathVariable int id) {
        /*publicacionService.delete(id);*/
        publicacionService.softDelete(id);
    }

    @PostMapping("/categoria")
    public void crearCategoria(@RequestBody CategoriaCrearDTO dto) {
        categoriaService.crearCategoria(dto);
    }

}
