package ar.com.colevueltas.site.service;

import ar.com.colevueltas.site.dto.ColeCursosDTO;
import ar.com.colevueltas.site.dto.CursoDTO;
import ar.com.colevueltas.site.model.Colegio;
import ar.com.colevueltas.site.model.Curso;
import ar.com.colevueltas.site.repository.ColegioRepository;
import ar.com.colevueltas.site.repository.CursoRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ColegioService {
    private final ColegioRepository colegioRepository;

    public ColegioService(ColegioRepository colegioRepository) {
        this.colegioRepository = colegioRepository;
    }

    public List<ColeCursosDTO> coleCursos(){
        List<ColeCursosDTO> listaColeCursos=new ArrayList<>();
        for(Colegio cole : colegioRepository.findAll()){
            ColeCursosDTO coleDto = new ColeCursosDTO();
            List<CursoDTO> cursosDto=new ArrayList<>();

            coleDto.setNombre(cole.getNombre());
            coleDto.setId(cole.getId());
            coleDto.setDireccion(cole.getDireccion());
            coleDto.setLogo(cole.getLogo());

            for (Curso curso : cole.getCursos()){
                CursoDTO cursoDTO = new CursoDTO();
                cursoDTO.setId(curso.getId());
                cursoDTO.setNombre(curso.getNombre());
                cursosDto.add(cursoDTO);
            }
            coleDto.setCursos(cursosDto);
            listaColeCursos.add(coleDto);
        }
        return listaColeCursos;
    }
}
