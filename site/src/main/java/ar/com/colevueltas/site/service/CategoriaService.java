package ar.com.colevueltas.site.service;

import ar.com.colevueltas.site.dto.CategoriaCrearDTO;
import ar.com.colevueltas.site.dto.CategoriaListadoDTO;
import ar.com.colevueltas.site.model.Categoria;
import ar.com.colevueltas.site.repository.CategoriaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoriaService {

    private final CategoriaRepository categoriaRepository;

    public CategoriaService(CategoriaRepository categoriaRepository) {
        this.categoriaRepository = categoriaRepository;
    }

    public Categoria crearCategoria(CategoriaCrearDTO dto) {
        Categoria categoriaPadre = null;
        if (dto.getIdPadre() != null) {
            categoriaPadre = categoriaRepository.findById(dto.getIdPadre())
                    .orElseThrow(() -> new RuntimeException("Categoría padre no encontrada"));
        }

        Categoria nuevaCategoria = new Categoria();
        nuevaCategoria.setNombre(dto.getNombre());
        nuevaCategoria.setCategoriaPadre(categoriaPadre);

        return categoriaRepository.save(nuevaCategoria);
    }

    public List<CategoriaListadoDTO> obtenerArbolCategorias() {
        List<Categoria> categoriasRaiz = categoriaRepository.findByCategoriaPadreIsNull();
        return categoriasRaiz.stream()
                .map(this::toDTO)
                .toList();
    }

    private CategoriaListadoDTO toDTO(Categoria categoria) {
        var hijos = categoria.getSubcategorias() != null
                ? categoria.getSubcategorias().stream().map(this::toDTO).toList()
                : null;

        return new CategoriaListadoDTO(
                categoria.getId(),
                categoria.getNombre(),
                hijos
        );
    }
}
