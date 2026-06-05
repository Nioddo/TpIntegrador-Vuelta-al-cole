package ar.com.colevueltas.site.controller;

import ar.com.colevueltas.site.dto.ChatDTO;
import ar.com.colevueltas.site.dto.MensajeSalidaDTO;
import ar.com.colevueltas.site.service.ChatService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@RestController
@RequestMapping("/api/chats")
public class ChatController {

    private final ChatService chatService;

    public ChatController(ChatService chatService) {
        this.chatService = chatService;
    }

    @PostMapping("/iniciar")
    public ResponseEntity<ChatDTO> iniciarChat(@RequestParam int idPublicacion, Principal principal) {
        return ResponseEntity.ok(chatService.obtenerOCrearChat(idPublicacion, principal.getName()));
    }

    @GetMapping("/{chatId}/mensajes")
    public ResponseEntity<List<MensajeSalidaDTO>> getHistorial(@PathVariable int chatId, Principal principal) {
        return ResponseEntity.ok(chatService.getHistorial(chatId, principal.getName()));
    }
}
