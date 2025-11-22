
    package ar.com.colevueltas.site.model;

import jakarta.persistence.*;

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

        @Column(name = "activo", nullable = false)
        private boolean activo = true;

        // 🔹 Constructores
        public Chat() {}

        public Chat(int id_publicacion, int id_usuario_comprador, int id_usuario_vendedor, boolean activo) {
            this.id_publicacion = id_publicacion;
            this.id_usuario_comprador = id_usuario_comprador;
            this.id_usuario_vendedor = id_usuario_vendedor;
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
    }


