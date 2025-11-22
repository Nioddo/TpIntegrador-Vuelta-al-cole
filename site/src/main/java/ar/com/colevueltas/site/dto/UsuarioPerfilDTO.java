package ar.com.colevueltas.site.dto;

import java.util.List;

public class UsuarioPerfilDTO {
    private int id;
    private String username;
    private Double calificacionVendedor;
    private Double calificacionComprador;
    private String biografia;
    private String envio;
    private String direccion;
    private List<PublicacionBuscarDTO> publicaciones;

    public UsuarioPerfilDTO() {
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

    public Double getCalificacionComprador() {
        return calificacionComprador;
    }

    public void setCalificacionComprador(Double calificacionComprador) {
        this.calificacionComprador = calificacionComprador;
    }

    public String getBiografia() {
        return biografia;
    }

    public void setBiografia(String biografia) {
        this.biografia = biografia;
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

    public List<PublicacionBuscarDTO> getPublicaciones() {
        return publicaciones;
    }

    public void setPublicaciones(List<PublicacionBuscarDTO> publicaciones) {
        this.publicaciones = publicaciones;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
