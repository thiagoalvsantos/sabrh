/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.services;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Estado;

/**
 * Interface de serviço da camada core relacionado ao componente Estado.
 * 
 * @author Thiago
 * @version 1
 */
@Remote
public interface EstadoService {

	/**
	 * Listar estados.
	 * 
	 * @return list
	 */
	List<Estado> listarEstados();
}
