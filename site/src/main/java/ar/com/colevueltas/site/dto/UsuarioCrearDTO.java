package ar.com.colevueltas.site.dto;

import ar.com.colevueltas.site.model.Genero;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.*;

import java.time.LocalDate;

public class UsuarioCrearDTO {

    @NotBlank(message = "El nombre es obligatorio")
    @JsonProperty("nombre")
    private String nombre;

    @NotBlank(message = "El apellido es obligatorio")
    @JsonProperty("apellido")
    private String apellido;

    @Email(message = "El email es inválido")
    @NotBlank(message = "El email es obligatorio")
    @JsonProperty("mail")
    private String mail;

    @NotBlank(message = "La contraseña es obligatoria")
    @Size(min = 8, message = "La contraseña debe tener al menos 8 caracteres")
    @Pattern(
            regexp = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&._-])[A-Za-z\\d@$!%*?&._-]+$",
            message = "La contraseña debe contener al menos una mayúscula, una minúscula, un número y un caracter especial (@$!%*?&._-)"
    )
    @JsonProperty("contrasenia")
    private String contrasenia;

    @NotNull(message = "El DNI es obligatorio")
    @Digits(integer = 8, fraction = 0, message = "El DNI debe tener 8 dígitos, sin puntos ni espacios")
    @JsonProperty("dni")
    private int dni;

    @NotNull(message = "Seleccione un género")
    @JsonProperty("genero")
    private Genero genero;

    @NotNull(message = "La fecha de nacimiento es obligatoria")
    @JsonProperty("fecha_nacimiento")
    private LocalDate fecha_nacimiento;

    @Pattern(
            regexp = "^\\+?(?:\\d[\\d\\s-]*){8,15}$",
            message = "El teléfono debe tener entre 8 y 15 dígitos, se aceptan espacios, guiones y +"
    )
    @JsonProperty("telefono")
    private String telefono;

    @NotBlank(message = "La contraseña es obligatoria")
    @JsonProperty("username")
    private String username;

    @JsonProperty("biografia")
    private String biografia;

    @JsonProperty("direccion")
    private String direccion;

    @JsonProperty("envio")
    private String envio;

    public UsuarioCrearDTO() {
    }

    public UsuarioCrearDTO(String nombre, String apellido, String mail, String contrasenia, int dni, Genero genero, LocalDate fecha_nacimiento, String telefono, String username, String biografia, String direccion, String envio) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.mail = mail;
        this.contrasenia = contrasenia;
        this.dni = dni;
        this.genero = genero;
        this.fecha_nacimiento = fecha_nacimiento;
        this.telefono = telefono;
        this.username = username;
        this.biografia = biografia;
        this.direccion = direccion;
        this.envio = envio;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getContrasenia() {
        return contrasenia;
    }

    public void setContrasenia(String contrasenia) {
        this.contrasenia = contrasenia;
    }

    public int getDni() {
        return dni;
    }

    public void setDni(int dni) {
        this.dni = dni;
    }

    public Genero getGenero() {
        return genero;
    }

    public void setGenero(Genero genero) {
        this.genero = genero;
    }

    public LocalDate getFecha_nacimiento() {
        return fecha_nacimiento;
    }

    public void setFecha_nacimiento(LocalDate fecha_nacimiento) {
        this.fecha_nacimiento = fecha_nacimiento;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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
}
