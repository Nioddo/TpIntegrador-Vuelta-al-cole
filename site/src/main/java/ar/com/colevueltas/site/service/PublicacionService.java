package ar.com.colevueltas.site.service;


import ar.com.colevueltas.site.dto.*;
import ar.com.colevueltas.site.globals.BadRequestException;
import ar.com.colevueltas.site.model.*;
import ar.com.colevueltas.site.repository.*;
import org.hibernate.query.sql.internal.ParameterRecognizerImpl;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.web.server.ResponseStatusException;


import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class PublicacionService {
    private final PublicacionRepository repository;
    private final ImagenPublicacionRepository imagenRepository;
    private final UsuarioRepository usuarioRepository;
    private final CategoriaRepository categoriaRepository;
    private final Cloudinary cloudinary;
    private final PublicacionColegioRepository publicacionColegioRepository;
    private final PublicacionCursoRepository publicacionCursoRepository;
    private final ColegioRepository colegioRepository;
    private final CursoRepository cursoRepository;
    private final PublicacionPreguntaRepository publicacionPreguntaRepository;

    public PublicacionService(PublicacionRepository repository, ImagenPublicacionRepository imagenRepository, UsuarioRepository usuarioRepository, CategoriaRepository categoriaRepository, Cloudinary cloudinary, PublicacionColegioRepository publicacionColegioRepository, PublicacionCursoRepository publicacionCursoRepository, ColegioRepository colegioRepository, CursoRepository cursoRepository, PublicacionPreguntaRepository publicacionPreguntaRepository) {
        this.repository = repository;
        this.imagenRepository = imagenRepository;
        this.usuarioRepository = usuarioRepository;
        this.categoriaRepository = categoriaRepository;
        this.cloudinary = cloudinary;
        this.publicacionColegioRepository = publicacionColegioRepository;
        this.publicacionCursoRepository = publicacionCursoRepository;
        this.colegioRepository = colegioRepository;
        this.cursoRepository = cursoRepository;
        this.publicacionPreguntaRepository = publicacionPreguntaRepository;
    }

    public void delete(int id) {
        if (!repository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Publicación no encontrada");
        }
        repository.deleteById(id);
    }

    public void softDelete(int id) {
        if (!repository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Publicación no encontrada");
        }
        repository.actualizarEstadoPorId(id, EstadoPublicacion.Inactivo);
        repository.actualizarFechaEliminacionPorId(id, LocalDateTime.now());
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

    public List<PublicacionBuscarDTO> getPublicacionesRecientes() {


        List<Publicacion> publicaciones = repository.findAll();

        return publicaciones.stream().map(pub -> {
            PublicacionBuscarDTO dto = new PublicacionBuscarDTO();
            dto.setId(pub.getId());
            dto.setTitulo(pub.getTitulo());
            dto.setPrecio(pub.getPrecio());
            dto.setDescuento(pub.getDescuento());
            dto.setImagenes(imagenRepository.findUrlImagenByPublicacionId(pub.getId()));
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

        if (dto.getIdsColegios() != null && !dto.getIdsColegios().isEmpty()) {
            List<Colegio> colegios = colegioRepository.findAllById(dto.getIdsColegios());
            for (Colegio colegio : colegios) {
                PublicacionColegio pc = new PublicacionColegio(publicacion, colegio);
                publicacionColegioRepository.save(pc);
            }
        }

        if (dto.getIdsCursos() != null && !dto.getIdsCursos().isEmpty()) {
            List<Curso> cursos = cursoRepository.findAllById(dto.getIdsCursos());
            for (Curso curso : cursos) {
                PublicacionCurso pc = new PublicacionCurso(publicacion, curso);
                publicacionCursoRepository.save(pc);
            }
        }

        return publicacion;
    }

    public List<PublicacionBuscarDTO> filtrarPublicaciones(FiltrosDTO dto){
        List<Publicacion> publicaciones;
        List<Publicacion> publicacionesSelec;
        if (dto.getCategoria() != null) {
            publicaciones = repository.findByIdCategoria(dto.getCategoria());
        } else {
            publicaciones = repository.findAll();
        }

        for(Publicacion pub : publicaciones){
            if(pub.getTitulo().contains(dto.getBusqueda())){
                if(dto.getCondicion().contains(pub.getCondicion())){

                }
            }
        }
        return null;
    }

    public PublicacionVerDTO getPublicacion(int id){
        if (!repository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Publicación no encontrada");
        }

        Publicacion pub = repository.getReferenceById(id);
        PublicacionVerDTO dto = new PublicacionVerDTO();
        dto.setId(pub.getId());
        dto.setId_usuario_vendedor(pub.getIdUsuarioVendedor());
        dto.setTitulo(pub.getTitulo());
        dto.setDescripcion(pub.getDescripcion());
        dto.setPrecio(pub.getPrecio());
        dto.setCondicion(pub.getCondicion());
        dto.setFecha_publicacion(pub.getFechaPublicacion());
        dto.setEstado(pub.getEstado());
        dto.setDescuento(pub.getDescuento());
        dto.setDescuento_fecha_inicio(pub.getDescuentoFechaInicio());
        dto.setDescuento_fecha_fin(pub.getDescuentoFechaFin());
        dto.setId_categoria(pub.getIdCategoria());
        dto.setNomCategoria(categoriaRepository.getReferenceById(pub.getIdCategoria()).getNombre());
        dto.setImagenes(imagenRepository.findUrlImagenByPublicacionId(id));
        List<PublicacionPreguntaDTO> preguntas = new ArrayList<>();

        for(PublicacionPregunta p : publicacionPreguntaRepository.findByPublicacionId(id)){
            PublicacionPreguntaDTO dtoP = new PublicacionPreguntaDTO();
            dtoP.setId(p.getId());
            dtoP.setPregunta(p.getPregunta());
            dtoP.setFechaPregunta(
                    p.getFechaPregunta() != null ? p.getFechaPregunta().toString() : null
            );
            dtoP.setRespuesta(p.getRespuesta());
            dtoP.setFechaRespuesta(
                    p.getFechaRespuesta() != null ? p.getFechaRespuesta().toString() : null
            );
            preguntas.add(dtoP);
        }

        dto.setPreguntas(preguntas);

        return dto;
    }

}
