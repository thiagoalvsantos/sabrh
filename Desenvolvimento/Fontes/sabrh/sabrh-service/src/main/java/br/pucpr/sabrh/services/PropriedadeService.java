/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.services;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Propriedade;

/**
 * Interface de serviço da camada core relacionado ao componente Propriedade.
 * 
 * @author Thiago
 * @version 1
 */
@Remote
public interface PropriedadeService {

	/**
	 * Listar.
	 * 
	 * @param propriedade
	 *            - propriedade
	 * @return list
	 */
	List<Propriedade> pesquisar(Propriedade propriedade);

	/**
	 * Salvar.
	 * 
	 * @param propriedade
	 *            - propriedade
	 * @return propriedade
	 */
	Propriedade salvar(Propriedade propriedade);
	
	
	/**
	 * Propriedade existente.
	 * 
	 * @param propriedade
	 *            - propriedade.
	 * @return verdadeiro, se bem sucedido.
	 */
	boolean propriedadeExistente(Propriedade propriedade);

}
