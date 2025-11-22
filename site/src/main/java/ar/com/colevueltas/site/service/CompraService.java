package ar.com.colevueltas.site.service;

import ar.com.colevueltas.site.dto.PublicacionDTO;
import ar.com.colevueltas.site.model.Chat;
import ar.com.colevueltas.site.model.Compra;
import ar.com.colevueltas.site.dto.CompraDTO;
import ar.com.colevueltas.site.model.EstadoPublicacion;
import ar.com.colevueltas.site.model.Publicacion;
import ar.com.colevueltas.site.repository.CompraRepository;
import ar.com.colevueltas.site.repository.PublicacionRepository;
import ar.com.colevueltas.site.repository.UsuarioRepository;
import org.springframework.stereotype.Service;
import ar.com.colevueltas.site.repository.ChatRepository;

import java.util.List;

@Service
public class CompraService {
    private final CompraRepository repository;
    private final ChatRepository chatRepository;
    private final PublicacionRepository publicacionRepository;
    private final UsuarioRepository usuarioRepository;

    public CompraService(CompraRepository repository, ChatRepository chatRepository, PublicacionRepository publicacionRepository, UsuarioRepository usuarioRepository) {
        this.repository = repository;
        this.chatRepository = chatRepository;
        this.publicacionRepository = publicacionRepository;
        this.usuarioRepository = usuarioRepository;
    }

    public Compra create(int idComprador, CompraDTO dto) {
        Chat chat = chatRepository.findById(dto.getId_chat_origen())
                .orElseThrow(() -> new RuntimeException("El chat no existe"));

        if (chat.getId_usuario_comprador() != idComprador) {
            throw new RuntimeException("El chat no pertenece al usuario comprador");
        }

        Publicacion publicacion = publicacionRepository.findById(chat.getId_publicacion())
                .orElseThrow(() -> new RuntimeException("La publicación no existe"));

        if (!EstadoPublicacion.Activo.equals(publicacion.getEstado())) {
            throw new RuntimeException("La publicación no está disponible");
        }

        Compra compra = new Compra();
        compra.setId_chat_origen(dto.getId_chat_origen());
        compra.setId_publicacion(chat.getId_publicacion());
        compra.setId_comprador(idComprador);
        compra.setId_vendedor(chat.getId_usuario_vendedor());
        compra.setPrecio_final(dto.getPrecio_final());
        compra.setPunto_entrega(dto.getPunto_entrega());
        compra.setFecha_venta(dto.getFecha_venta());

        Compra savedCompra = repository.save(compra);

        publicacion.setEstado(EstadoPublicacion.Vendido);
        publicacionRepository.save(publicacion);

        return savedCompra;
    }

    public List<CompraDTO> getComprasByUsuario(int idComprador) {
        if (!usuarioRepository.existsById(idComprador)) {
            throw new RuntimeException("El usuario no existe");
        }

        // Trae todas las compras del usuario
        List<Compra> compras = repository.findByIdComprador(idComprador);

        // Convertir cada Compra a CompraDTO
        return compras.stream().map(compra -> {
            CompraDTO dto = new CompraDTO();
            dto.setId(compra.getId());
            dto.setId_chat_origen(compra.getId_chat_origen());
            dto.setPrecio_final(compra.getPrecio_final());
            dto.setPunto_entrega(compra.getPunto_entrega());
            dto.setFecha_venta(compra.getFecha_venta());
            return dto;
        }).toList();
    }


}
