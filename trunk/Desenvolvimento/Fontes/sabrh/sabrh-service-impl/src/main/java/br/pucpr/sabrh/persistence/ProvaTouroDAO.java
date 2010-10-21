/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.ProvaTouro;

/**
 * Interface ProvaTouroDAO.
 */
@Remote
public interface ProvaTouroDAO {

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
