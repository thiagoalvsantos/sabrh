package br.pucpr.sabrh.persistence;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Estado;

@Remote
public interface EstadoDAO {

	List<Estado> listarEstado();
}
