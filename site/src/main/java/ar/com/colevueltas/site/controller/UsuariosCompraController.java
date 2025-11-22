package ar.com.colevueltas.site.controller;

import ar.com.colevueltas.site.dto.PublicacionDTO;
import ar.com.colevueltas.site.model.Compra;
import ar.com.colevueltas.site.dto.CompraDTO;
import ar.com.colevueltas.site.repository.CompraRepository;
import ar.com.colevueltas.site.service.CompraService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/usuarios/{id}/compras")

public class UsuariosCompraController {

    private final CompraService compraService;

    @Autowired
    public UsuariosCompraController(CompraService compraService) {
        this.compraService = compraService;
    }

    @Autowired
    private CompraRepository repository;

    @PostMapping
    public Compra createCompra(@PathVariable int id, @RequestBody CompraDTO dto){
        return compraService.create(id, dto);
    }

    @GetMapping
    public List<CompraDTO> verCompras(@PathVariable int id){
        return compraService.getComprasByUsuario(id);
    }

}
