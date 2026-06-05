package ar.com.colevueltas.site.controller;

import ar.com.colevueltas.site.dto.LoginRequestDTO;
import ar.com.colevueltas.site.dto.TokenResponseDTO;
import ar.com.colevueltas.site.security.JwtService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final AuthenticationManager authManager;
    private final UserDetailsService userDetailsService;
    private final JwtService jwtService;

    public AuthController(AuthenticationManager authManager,
                          UserDetailsService userDetailsService,
                          JwtService jwtService) {
        this.authManager = authManager;
        this.userDetailsService = userDetailsService;
        this.jwtService = jwtService;
    }

    @PostMapping("/login")
    public ResponseEntity<TokenResponseDTO> login(@RequestBody LoginRequestDTO dto) {
        authManager.authenticate(new UsernamePasswordAuthenticationToken(dto.mail(), dto.contrasenia()));
        UserDetails userDetails = userDetailsService.loadUserByUsername(dto.mail());
        return ResponseEntity.ok(new TokenResponseDTO(jwtService.generateToken(userDetails)));
    }
}
