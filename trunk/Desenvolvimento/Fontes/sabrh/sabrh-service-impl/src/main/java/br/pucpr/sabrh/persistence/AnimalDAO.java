/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.TipoSexoAnimal;

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
	
	/**
	 * Retorna um animal Padrão.
	 * 
	 * @param TipoAnimalSexo
	 *            - sexo.
	 */
	Animal recuperarAnimalPadrao(TipoSexoAnimal sexo);
	
	/**
	 * Existe animal.
	 * 
	 * @param animal
	 *            - animal.
	 * @return verdadeiro, se bem sucedido.
	 */
	boolean existeAnimal(Animal animal);

}
