/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.services;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.ProvaTouro;

/**
 * Interface de serviço da camada core relacionado ao componente ProvaTouro.
 * 
 * @author Rony
 * @version 1
 */
@Remote
public interface ProvaTouroService {

	/**
	 * Pesquisar.
	 * 
	 * @param animal
	 *            - animal
	 * @return prova touro
	 */
	ProvaTouro pesquisar(Animal animal);

	/**
	 * Salvar.
	 * 
	 * @param provaTouro
	 *            - prova touro
	 * @return prova touro
	 */
	ProvaTouro salvar(ProvaTouro provaTouro);

}
