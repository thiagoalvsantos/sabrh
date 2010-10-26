/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.services;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.TipoAcasalamento;
import br.pucpr.sabrh.entity.TipoEventoAcasalamento;
import br.pucpr.sabrh.entity.TipoStatus;
import br.pucpr.sabrh.entity.TipoStatusFemea;

/**
 * Interface de serviço da camada core relacionado ao componente Status.
 * 
 * @author Thiago
 * @version 1
 */
@Remote
public interface StatusService {

	/**
	 * Listar status do usuario.
	 * 
	 * @return list
	 */
	List<TipoStatus> listarStatusUsuario();

	
	/**
	 * Listar status femea.
	 * 
	 * @return list
	 */
	List<TipoStatusFemea> listarStatusFemea();
	
	List<TipoAcasalamento> listarStatusAcasalamento();
	
	List<TipoEventoAcasalamento> listarStatusEventoAcasalamento();
}
