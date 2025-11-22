package ar.com.colevueltas.site.service;

import ar.com.colevueltas.site.dto.*;
import ar.com.colevueltas.site.globals.BadRequestException;
import ar.com.colevueltas.site.model.ImagenPublicacion;
import ar.com.colevueltas.site.model.Publicacion;
import ar.com.colevueltas.site.model.Usuario;
import ar.com.colevueltas.site.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
/*import org.springframework.security.crypto.password.PasswordEncoder;*/
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class UsuarioService {

    @Autowired
    private PasswordEncoder passwordEncoder;

    private final UsuarioRepository repository;
    private final NivelRepository nivelRepository;
    private final PublicacionRepository publicacionRepository;
    private final ImagenPublicacionRepository imagenPublicacionRepository;

    public UsuarioService(UsuarioRepository repository, NivelRepository nivelRepository, PublicacionRepository publicacionRepository, ImagenPublicacionRepository imagenPublicacionRepository) {
        this.repository = repository;
        this.nivelRepository = nivelRepository;
        this.publicacionRepository = publicacionRepository;
        this.imagenPublicacionRepository = imagenPublicacionRepository;
    }

    public Usuario create(UsuarioCrearDTO dto){
        Usuario usuario = new Usuario();

        if(repository.existsByMail(dto.getMail())){
            throw new BadRequestException("El mail ya está en uso");
        }
        if(repository.existsByDni(dto.getDni())){
            throw new BadRequestException("El dni ya está en uso");
        }
        if(repository.existsByUsername(dto.getUsername())){
            throw new BadRequestException("El user ya está en uso");
        }

        usuario.setNombre(dto.getNombre());
        usuario.setApellido(dto.getApellido());
        usuario.setMail(dto.getMail());
        usuario.setContrasenia(passwordEncoder.encode(dto.getContrasenia()));
        usuario.setDni(dto.getDni());

        usuario.setFecha_registro(LocalDateTime.now());

        usuario.setGenero(dto.getGenero());
        usuario.setFecha_nacimiento(dto.getFecha_nacimiento());
        usuario.setTelefono(dto.getTelefono());

        usuario.setUsername(dto.getUsername());
        usuario.setBiografia(dto.getBiografia());
        usuario.setEnvio(dto.getEnvio());
        usuario.setDireccion(dto.getDireccion());

        usuario.setNivel(1);
        usuario.setEs_verificado(false);
        usuario.setCalificacion_vendedor_promedio(0.0);
        usuario.setTotal_calificaciones_vendedor(0);
        usuario.setCalificacion_comprador_promedio(0.0);
        usuario.setTotal_calificaciones_comprador(0);
        usuario.setXp(0);
        usuario.setFecha_eliminacion(null);

        return repository.save(usuario);
    }

    public UsuarioPerfilDTO infoPerfilUsuario(int id){
        if (!repository.existsById(id)) {
            throw new RuntimeException("El usuario no existe");
        }
        Usuario user = repository.findById(id);
        UsuarioPerfilDTO perfil = new UsuarioPerfilDTO();

        perfil.setId(user.getId());
        perfil.setUsername(user.getUsername());
        perfil.setCalificacionComprador(user.getCalificacion_comprador_promedio());
        perfil.setCalificacionVendedor(user.getCalificacion_vendedor_promedio());
        perfil.setBiografia(user.getBiografia());
        perfil.setEnvio(user.getEnvio());
        perfil.setDireccion(user.getDireccion());

        List<Publicacion> pubs = publicacionRepository.findByIdUsuarioVendedor(id);
        List<PublicacionBuscarDTO> resultado = new ArrayList<>();
        for (Publicacion pub : pubs) {
            PublicacionBuscarDTO dto = new PublicacionBuscarDTO(
                    pub.getId(),
                    pub.getTitulo(),
                    pub.getPrecio(),
                    pub.getDescuento(),
                    imagenPublicacionRepository.findUrlImagenByPublicacionId(pub.getId())
            );
            resultado.add(dto);
        }
        perfil.setPublicaciones(resultado);
        return perfil;
    }

    public UsuarioPublicacionDTO infoPubUsuario(int id){
        if (!repository.existsById(id)) {
            throw new RuntimeException("El usuario no existe");
        }
        Usuario user = repository.findById(id);
        UsuarioPublicacionDTO perfil = new UsuarioPublicacionDTO();

        perfil.setId(user.getId());
        perfil.setUsername(user.getUsername());
        perfil.setCalificacionVendedor(user.getCalificacion_vendedor_promedio());
        perfil.setEnvio(user.getEnvio());
        perfil.setDireccion(user.getDireccion());

        return perfil;
    }

    public NivelDTO obtenerNivel(int id){
        if (!repository.existsById(id)) {
            throw new RuntimeException("El usuario no existe");
        }
        Usuario user = repository.findById(id);
        return new NivelDTO(id, user.getXp(), user.getNivel(), nivelRepository.findByNivel(user.getNivel()).getNombreNivel());
    }

    public ReputacionVendedorDTO obtenerReputacionVendedor(int id){
        if (!repository.existsById(id)) {
            throw new RuntimeException("El usuario no existe");
        }
        Usuario user = repository.findById(id);
        return new ReputacionVendedorDTO(id, user.getCalificacion_vendedor_promedio(), user.getTotal_calificaciones_vendedor());
    }
}
