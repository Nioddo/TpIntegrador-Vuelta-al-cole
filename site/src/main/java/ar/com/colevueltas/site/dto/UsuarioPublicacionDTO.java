package ar.com.colevueltas.site.dto;

import java.util.List;

public class UsuarioPublicacionDTO {
    private int id;
    private String username;
    private Double calificacionVendedor;
    private String envio;
    private String direccion;

    public UsuarioPublicacionDTO() {
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Double getCalificacionVendedor() {
        return calificacionVendedor;
    }

    public void setCalificacionVendedor(Double calificacionVendedor) {
        this.calificacionVendedor = calificacionVendedor;
    }

    public String getEnvio() {
        return envio;
    }

    public void setEnvio(String envio) {
        this.envio = envio;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
