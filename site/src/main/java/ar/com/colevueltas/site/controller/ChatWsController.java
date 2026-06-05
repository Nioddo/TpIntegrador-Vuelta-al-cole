package ar.com.colevueltas.site.controller;

import ar.com.colevueltas.site.dto.MensajeEntranteDTO;
import ar.com.colevueltas.site.dto.MensajeSalidaDTO;
import ar.com.colevueltas.site.service.ChatService;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import java.security.Principal;

@Controller
public class ChatWsController {

    private final ChatService chatService;

    public ChatWsController(ChatService chatService) {
        this.chatService = chatService;
    }

    @MessageMapping("/chat/{chatId}")
    @SendTo("/topic/chat/{chatId}")
    public MensajeSalidaDTO handleMensaje(@DestinationVariable int chatId,
                                          MensajeEntranteDTO dto,
                                          Principal principal) {
        return chatService.procesarMensaje(chatId, principal.getName(), dto.contenido());
    }
}
