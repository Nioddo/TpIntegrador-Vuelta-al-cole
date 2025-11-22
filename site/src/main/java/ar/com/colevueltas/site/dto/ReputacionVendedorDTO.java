package ar.com.colevueltas.site.dto;

public class ReputacionVendedorDTO {
    private int id;
    private Double calificacionVendedor;
    private int cantidadCalificaciones;

    public ReputacionVendedorDTO(int id, Double calificacionVendedor, int cantidadCalificaciones) {
        this.id = id;
        this.calificacionVendedor = calificacionVendedor;
        this.cantidadCalificaciones = cantidadCalificaciones;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Double getCalificacionVendedor() {
        return calificacionVendedor;
    }

    public void setCalificacionVendedor(Double calificacionVendedor) {
        this.calificacionVendedor = calificacionVendedor;
    }

    public int getCantidadCalificaciones() {
        return cantidadCalificaciones;
    }

    public void setCantidadCalificaciones(int cantidadCalificaciones) {
        this.cantidadCalificaciones = cantidadCalificaciones;
    }
}
