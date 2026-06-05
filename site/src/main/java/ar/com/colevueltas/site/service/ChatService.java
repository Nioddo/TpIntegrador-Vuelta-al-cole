package ar.com.colevueltas.site.service;

import ar.com.colevueltas.site.dto.ChatDTO;
import ar.com.colevueltas.site.dto.MensajeSalidaDTO;
import ar.com.colevueltas.site.globals.BadRequestException;
import ar.com.colevueltas.site.model.Chat;
import ar.com.colevueltas.site.model.Mensaje;
import ar.com.colevueltas.site.model.Publicacion;
import ar.com.colevueltas.site.model.Usuario;
import ar.com.colevueltas.site.model.EstadoChat;
import ar.com.colevueltas.site.repository.ChatRepository;
import ar.com.colevueltas.site.repository.MensajeRepository;
import ar.com.colevueltas.site.repository.PublicacionRepository;
import ar.com.colevueltas.site.repository.UsuarioRepository;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ChatService {

    private final ChatRepository chatRepository;
    private final MensajeRepository mensajeRepository;
    private final UsuarioRepository usuarioRepository;
    private final PublicacionRepository publicacionRepository;

    public ChatService(ChatRepository chatRepository,
                       MensajeRepository mensajeRepository,
                       UsuarioRepository usuarioRepository,
                       PublicacionRepository publicacionRepository) {
        this.chatRepository = chatRepository;
        this.mensajeRepository = mensajeRepository;
        this.usuarioRepository = usuarioRepository;
        this.publicacionRepository = publicacionRepository;
    }

    @Transactional
    public ChatDTO obtenerOCrearChat(int idPublicacion, String mailComprador) {
        Usuario comprador = usuarioRepository.findByMail(mailComprador)
                .orElseThrow(() -> new UsernameNotFoundException("Usuario no encontrado"));

        return chatRepository.findByPublicacionYComprador(idPublicacion, comprador.getId())
                .map(this::toDTO)
                .orElseGet(() -> {
                    Publicacion pub = publicacionRepository.findById(idPublicacion)
                            .orElseThrow(() -> new BadRequestException("Publicación no encontrada"));

                    if (pub.getIdUsuarioVendedor() == comprador.getId()) {
                        throw new BadRequestException("No podés iniciar un chat con tu propia publicación");
                    }

                    Chat chat = new Chat();
                    chat.setId_publicacion(idPublicacion);
                    chat.setId_usuario_comprador(comprador.getId());
                    chat.setId_usuario_vendedor(pub.getIdUsuarioVendedor());
                    chat.setEstado(EstadoChat.Activo);
                    chat.setFecha_creacion(LocalDateTime.now());
                    chat.setFecha_ultima_actividad(LocalDateTime.now());
                    chat.setActivo(true);
                    return toDTO(chatRepository.save(chat));
                });
    }

    public List<MensajeSalidaDTO> getHistorial(int chatId, String mailUsuario) {
        Usuario usuario = usuarioRepository.findByMail(mailUsuario)
                .orElseThrow(() -> new UsernameNotFoundException("Usuario no encontrado"));

        chatRepository.findByIdYParticipante(chatId, usuario.getId())
                .orElseThrow(() -> new BadRequestException("Chat no encontrado o sin acceso"));

        return mensajeRepository.findByChatIdOrderByFechaEnvioAsc(chatId)
                .stream()
                .map(this::toMensajeDTO)
                .toList();
    }

    @Transactional
    public MensajeSalidaDTO procesarMensaje(int chatId, String mailUsuario, String contenido) {
        Usuario usuario = usuarioRepository.findByMail(mailUsuario)
                .orElseThrow(() -> new UsernameNotFoundException("Usuario no encontrado"));

        Chat chat = chatRepository.findByIdYParticipante(chatId, usuario.getId())
                .orElseThrow(() -> new BadRequestException("Chat no encontrado o sin acceso"));

        Mensaje mensaje = new Mensaje();
        mensaje.setChat(chat);
        mensaje.setUsuarioEnvia(usuario);
        mensaje.setContenido(contenido);
        mensaje.setFechaEnvio(LocalDateTime.now());
        mensaje.setLeido(false);

        chat.setFecha_ultima_actividad(LocalDateTime.now());
        chatRepository.save(chat);

        return toMensajeDTO(mensajeRepository.save(mensaje));
    }

    private ChatDTO toDTO(Chat c) {
        return new ChatDTO(c.getId(), c.getId_publicacion(), c.getId_usuario_comprador(),
                c.getId_usuario_vendedor(), c.getEstado().name(),
                c.getFecha_creacion(), c.getFecha_ultima_actividad());
    }

    private MensajeSalidaDTO toMensajeDTO(Mensaje m) {
        return new MensajeSalidaDTO(m.getId(), m.getChat().getId(),
                m.getUsuarioEnvia().getId(), m.getContenido(),
                m.getFechaEnvio(), m.isLeido());
    }
}
