package ar.com.colevueltas.site.service;


import ar.com.colevueltas.site.dto.CompraDTO;
import ar.com.colevueltas.site.dto.PublicacionCrearDTO;
import ar.com.colevueltas.site.dto.PublicacionDTO;
import ar.com.colevueltas.site.globals.BadRequestException;
import ar.com.colevueltas.site.model.Compra;
import ar.com.colevueltas.site.model.EstadoPublicacion;
import ar.com.colevueltas.site.model.ImagenPublicacion;
import ar.com.colevueltas.site.model.Publicacion;
import ar.com.colevueltas.site.repository.CategoriaRepository;
import ar.com.colevueltas.site.repository.ImagenPublicacionRepository;
import ar.com.colevueltas.site.repository.PublicacionRepository;
import ar.com.colevueltas.site.repository.UsuarioRepository;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.web.server.ResponseStatusException;


import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Service
public class PublicacionService {
    private final PublicacionRepository repository;
    private final ImagenPublicacionRepository imagenRepository;
    private final UsuarioRepository usuarioRepository;
    private final CategoriaRepository categoriaRepository;
    private final Cloudinary cloudinary;

    public PublicacionService(PublicacionRepository repository,
                              ImagenPublicacionRepository imagenRepository,
                              Cloudinary cloudinary,
                              UsuarioRepository usuarioRepository,
                              CategoriaRepository categoriaRepository) {
        this.repository = repository;
        this.imagenRepository = imagenRepository;
        this.cloudinary = cloudinary;
        this.usuarioRepository = usuarioRepository;
        this.categoriaRepository = categoriaRepository;
    }

    public void delete(int id) {
        if (!repository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Publicación no encontrada");
        }
        repository.deleteById(id);
    }

    public List<PublicacionDTO> getPublicacionesByUsuario(int idVendedor) {
        if (!usuarioRepository.existsById(idVendedor)) {
            throw new RuntimeException("El usuario no existe");
        }

        List<Publicacion> publicaciones = repository.findByIdUsuarioVendedor(idVendedor);

        return publicaciones.stream().map(pub -> {
            PublicacionDTO dto = new PublicacionDTO();
            dto.setId(pub.getId());
            dto.setTitulo(pub.getTitulo());
            dto.setDescripcion(pub.getDescripcion());
            dto.setPrecio(pub.getPrecio());
            dto.setCondicion(pub.getCondicion());
            dto.setEstado(pub.getEstado());
            dto.setId_categoria(pub.getIdCategoria());
            dto.setFecha_publicacion(pub.getFechaPublicacion());
            return dto;
        }).toList();
    }

    public Publicacion create(int id_usuario_vendedor, PublicacionCrearDTO dto) throws Exception {
        Publicacion publicacion = new Publicacion();
        if (dto.getPrecio().compareTo(BigDecimal.ZERO) < 0) {
            throw new BadRequestException("El precio no puede ser menor a cero");
        }
        if (!usuarioRepository.existsById(id_usuario_vendedor)) {
            throw new BadRequestException("El usuario no existe");
        }
        if (!categoriaRepository.existsById(dto.getIdCategoria())) {
            throw new BadRequestException("La categoria no existe");
        }
        publicacion.setIdUsuarioVendedor(id_usuario_vendedor);
        publicacion.setTitulo(dto.getTitulo());
        publicacion.setDescripcion(dto.getDescripcion());
        publicacion.setPrecio(dto.getPrecio());
        publicacion.setCondicion(dto.getCondicion());
        publicacion.setIdCategoria(dto.getIdCategoria());
        publicacion.setEstado(EstadoPublicacion.Activo);
        publicacion.setFechaPublicacion(LocalDateTime.now());
        publicacion.setFechaUltimaActualizacion(LocalDateTime.now());
        publicacion.setDescuento(BigDecimal.ZERO);
        publicacion.setDescuentoFechaInicio(null);
        publicacion.setDescuentoFechaFin(null);
        publicacion.setFechaEliminacion(null);
        publicacion = repository.save(publicacion);

        List<MultipartFile> imagenes = dto.getImagenes();
        System.out.println("Cantidad de imágenes recibidas: " + (imagenes != null ? imagenes.size() : "null"));

        if (imagenes != null && !imagenes.isEmpty()) {
            for (MultipartFile file : imagenes) {
                if (!file.isEmpty()) {
                    Map uploadResult = cloudinary.uploader().upload(file.getBytes(),
                            ObjectUtils.asMap(
                                    "folder", "publicaciones/" + publicacion.getId()
                            ));
                    String url = (String) uploadResult.get("secure_url");
                    ImagenPublicacion imagenPublicacion = new ImagenPublicacion();
                    imagenPublicacion.setPublicacion(publicacion);
                    imagenPublicacion.setUrlImagen(url);
                    imagenRepository.save(imagenPublicacion);
                }
            }
        }
        return publicacion;
    }

}
