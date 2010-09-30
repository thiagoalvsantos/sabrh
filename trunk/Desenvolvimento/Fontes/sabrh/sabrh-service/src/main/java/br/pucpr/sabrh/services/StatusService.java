/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.services;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.TipoStatus;

/**
 * Interface de serviço da camada core relacionado ao componente Status.
 *  
 * @author Thiago
 * @version 1
 */
@Remote
public interface StatusService {

	/**
	 * Listar status.
	 * 
	 * @return list
	 */
	List<TipoStatus> listarStatus();
}
