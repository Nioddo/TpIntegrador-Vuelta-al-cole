package ar.com.colevueltas.site.model;

import jakarta.persistence.*;
import org.springframework.cglib.core.Local;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "usuarios")
public class Usuario {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String nombre;
    private String apellido;
    private String mail;

    @Column(name = "contraseña")
    private String contrasenia;

    private int dni;
    private LocalDateTime fecha_registro;

    @Enumerated(EnumType.STRING)
    private Genero genero;

    private LocalDate fecha_nacimiento;
    private String telefono;

    private int xp;
    private int nivel;
    @Column(columnDefinition = "tinyint(1)")
    private boolean es_verificado;
    private Double calificacion_vendedor_promedio;
    private int total_calificaciones_vendedor;
    private Double calificacion_comprador_promedio;
    private int total_calificaciones_comprador;
    private LocalDateTime fecha_eliminacion;

    private String username;
    @Column(length = 2550)
    private String biografia;
    private String envio;
    private String direccion;

    public Usuario() {
    }

    public Usuario(int id, String nombre, String apellido, String mail, String contrasenia, int dni, LocalDateTime fecha_registro, Genero genero, LocalDate fecha_nacimiento, String telefono, int xp, int nivel, boolean es_verificado, Double calificacion_vendedor_promedio, int total_calificaciones_vendedor, Double calificacion_comprador_promedio, int total_calificaciones_comprador, LocalDateTime fecha_eliminacion, String username, String biografia, String envio) {
        this.id = id;
        this.nombre = nombre;
        this.apellido = apellido;
        this.mail = mail;
        this.contrasenia = contrasenia;
        this.dni = dni;
        this.fecha_registro = fecha_registro;
        this.genero = genero;
        this.fecha_nacimiento = fecha_nacimiento;
        this.telefono = telefono;
        this.xp = xp;
        this.nivel = nivel;
        this.es_verificado = es_verificado;
        this.calificacion_vendedor_promedio = calificacion_vendedor_promedio;
        this.total_calificaciones_vendedor = total_calificaciones_vendedor;
        this.calificacion_comprador_promedio = calificacion_comprador_promedio;
        this.total_calificaciones_comprador = total_calificaciones_comprador;
        this.fecha_eliminacion = fecha_eliminacion;
        this.username = username;
        this.biografia = biografia;
        this.envio = envio;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public LocalDateTime getFecha_registro() {
        return fecha_registro;
    }

    public void setFecha_registro(LocalDateTime fecha_registro) {
        this.fecha_registro = fecha_registro;
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

    public int getNivel() {
        return nivel;
    }

    public void setNivel(int nivel) {
        this.nivel = nivel;
    }

    public boolean isEs_verificado() {
        return es_verificado;
    }

    public void setEs_verificado(boolean es_verificado) {
        this.es_verificado = es_verificado;
    }

    public Double getCalificacion_vendedor_promedio() {
        return calificacion_vendedor_promedio;
    }

    public void setCalificacion_vendedor_promedio(Double calificacion_vendedor_promedio) {
        this.calificacion_vendedor_promedio = calificacion_vendedor_promedio;
    }

    public int getTotal_calificaciones_vendedor() {
        return total_calificaciones_vendedor;
    }

    public void setTotal_calificaciones_vendedor(int total_calificaciones_vendedor) {
        this.total_calificaciones_vendedor = total_calificaciones_vendedor;
    }

    public Double getCalificacion_comprador_promedio() {
        return calificacion_comprador_promedio;
    }

    public void setCalificacion_comprador_promedio(Double calificacion_comprador_promedio) {
        this.calificacion_comprador_promedio = calificacion_comprador_promedio;
    }

    public int getTotal_calificaciones_comprador() {
        return total_calificaciones_comprador;
    }

    public void setTotal_calificaciones_comprador(int total_calificaciones_comprador) {
        this.total_calificaciones_comprador = total_calificaciones_comprador;
    }

    public int getXp() {
        return xp;
    }

    public void setXp(int xp) {
        this.xp = xp;
    }

    public LocalDateTime getFecha_eliminacion() {
        return fecha_eliminacion;
    }

    public void setFecha_eliminacion(LocalDateTime fecha_eliminacion) {
        this.fecha_eliminacion = fecha_eliminacion;
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
