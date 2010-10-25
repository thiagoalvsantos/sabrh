/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.services;

import java.util.List;

import javax.ejb.Remote;

import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.TipoSexoAnimal;

/**
 * Interface de serviço da camada core relacionado ao componente Animal.
 * 
 * @author Thiago
 * @version 1
 */
@Remote
public interface AnimalService {

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
	 * Recuperar animal default.
	 * 
	 * @param TipoSexoAnimal
	 *            - sexo
	 * @return animal
	 */
	Animal recuperarAnimalPadrao(TipoSexoAnimal sexo);

	/**
	 * Verificar consanguinidade.
	 * 
	 * @param femea
	 *            - femea.
	 * @param macho
	 *            - macho.
	 * @return verdadeiro, se bem sucedido.
	 */
	boolean verificarConsanguinidade(Animal femea, Animal macho);

}