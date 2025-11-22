package ar.com.colevueltas.site.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "bitacora_admin")
public class BitacoraAdmin {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_admin_usuario", nullable = false)
    private Integer idAdminUsuario;

    @Column(name = "accion_codigo", nullable = false, length = 50)
    private String accionCodigo;

    @Column(name = "id_referencia_afectada")
    private Integer idReferenciaAfectada;

    @Enumerated(EnumType.STRING)
    @Column(name = "referencia_tabla")
    private ReferenciaTabla referenciaTabla;

    @Column(columnDefinition = "text")
    private String motivo;

    @Column(nullable = false)
    private LocalDateTime fecha;

    @PrePersist
    protected void onCreate() {
        this.fecha = LocalDateTime.now();
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getIdAdminUsuario() { return idAdminUsuario; }
    public void setIdAdminUsuario(Integer idAdminUsuario) { this.idAdminUsuario = idAdminUsuario; }

    public String getAccionCodigo() { return accionCodigo; }
    public void setAccionCodigo(String accionCodigo) { this.accionCodigo = accionCodigo; }

    public Integer getIdReferenciaAfectada() { return idReferenciaAfectada; }
    public void setIdReferenciaAfectada(Integer idReferenciaAfectada) { this.idReferenciaAfectada = idReferenciaAfectada; }

    public ReferenciaTabla getReferenciaTabla() { return referenciaTabla; }
    public void setReferenciaTabla(ReferenciaTabla referenciaTabla) { this.referenciaTabla = referenciaTabla; }

    public String getMotivo() { return motivo; }
    public void setMotivo(String motivo) { this.motivo = motivo; }

    public LocalDateTime getFecha() { return fecha; }
    public void setFecha(LocalDateTime fecha) { this.fecha = fecha; }
}
