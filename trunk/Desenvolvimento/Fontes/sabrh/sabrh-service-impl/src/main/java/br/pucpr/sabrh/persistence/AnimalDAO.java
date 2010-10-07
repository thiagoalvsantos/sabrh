/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Animal;

/**
 * Interface AnimalDAO.
 */
@Remote
public interface AnimalDAO {

	/**
	 * Pesquisar.
	 * 
	 * @param animal
	 *            - animal
	 * @return list
	 */
	List<Animal> pesquisar(Animal animal);

	/**
	 * Salvar.
	 * 
	 * @param animal
	 *            - animal
	 * @return animal
	 */
	Animal salvar(Animal animal);

	/**
	 * Realiza Excluir.
	 * 
	 * @param animal
	 *            - animal.
	 */
	void excluir(Animal animal);

}
