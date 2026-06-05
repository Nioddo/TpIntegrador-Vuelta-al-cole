
    package ar.com.colevueltas.site.model;

import jakarta.persistence.*;

import java.time.LocalDateTime;

    @Entity
    @Table(name = "chats")
    public class Chat {

        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private int id;

        @Column(name = "id_publicacion", nullable = false)
        private int id_publicacion;

        @Column(name = "id_usuario_comprador", nullable = false)
        private int id_usuario_comprador;

        @Column(name = "id_usuario_vendedor", nullable = false)
        private int id_usuario_vendedor;

        @Enumerated(EnumType.STRING)
        @Column(name = "estado", nullable = false)
        private EstadoChat estado;

        @Column(name = "fecha_creacion")
        private LocalDateTime fecha_creacion;

        @Column(name = "fecha_ultima_actividad")
        private LocalDateTime fecha_ultima_actividad;

        @Column(name = "activo", nullable = false)
        private boolean activo = true;

        // 🔹 Constructores
        public Chat() {}

        public Chat(int id, int id_publicacion, int id_usuario_comprador, int id_usuario_vendedor, EstadoChat estado, LocalDateTime fecha_creacion, LocalDateTime fecha_ultima_actividad, boolean activo) {
            this.id = id;
            this.id_publicacion = id_publicacion;
            this.id_usuario_comprador = id_usuario_comprador;
            this.id_usuario_vendedor = id_usuario_vendedor;
            this.estado = estado;
            this.fecha_creacion = fecha_creacion;
            this.fecha_ultima_actividad = fecha_ultima_actividad;
            this.activo = activo;
        }

        // 🔹 Getters y Setters
        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public int getId_publicacion() {
            return id_publicacion;
        }

        public void setId_publicacion(int id_publicacion) {
            this.id_publicacion = id_publicacion;
        }

        public int getId_usuario_comprador() {
            return id_usuario_comprador;
        }

        public void setId_usuario_comprador(int id_usuario_comprador) {
            this.id_usuario_comprador = id_usuario_comprador;
        }

        public int getId_usuario_vendedor() {
            return id_usuario_vendedor;
        }

        public void setId_usuario_vendedor(int id_usuario_vendedor) {
            this.id_usuario_vendedor = id_usuario_vendedor;
        }

        public boolean isActivo() {
            return activo;
        }

        public void setActivo(boolean activo) {
            this.activo = activo;
        }

        public EstadoChat getEstado() {
            return estado;
        }

        public void setEstado(EstadoChat estado) {
            this.estado = estado;
        }

        public LocalDateTime getFecha_creacion() {
            return fecha_creacion;
        }

        public void setFecha_creacion(LocalDateTime fecha_creacion) {
            this.fecha_creacion = fecha_creacion;
        }

        public LocalDateTime getFecha_ultima_actividad() {
            return fecha_ultima_actividad;
        }

        public void setFecha_ultima_actividad(LocalDateTime fecha_ultima_actividad) {
            this.fecha_ultima_actividad = fecha_ultima_actividad;
        }
    }


