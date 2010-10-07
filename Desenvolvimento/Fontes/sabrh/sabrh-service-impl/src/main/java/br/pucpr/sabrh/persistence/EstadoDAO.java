/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Estado;

/**
 * Interface EstadoDAO.
 */
@Remote
public interface EstadoDAO {

	/**
	 * Listar estado.
	 * 
	 * @return list
	 */
	List<Estado> listarEstado();
	
	
}
