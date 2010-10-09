/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.business;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;

import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.persistence.AnimalDAO;
import br.pucpr.sabrh.services.AnimalService;

/**
 * Implementação abstrata da interface de fachada AnimalService.
 * 
 * @author Thiago
 * @version 1
 * @see AnimalService
 */
@Stateless(name = "AnimalService")
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class AnimalBusiness implements AnimalService {

	/** O atributo dao. */
	@EJB
	private AnimalDAO dao;

	/**
	 * Get dao.
	 * 
	 * @return the dao
	 * @see AnimalBusiness#dao.
	 */
	public AnimalDAO getDao() {
		return dao;
	}

	/**
	 * Set dao.
	 * 
	 * @param dao
	 *            - dao.
	 * @see AnimalBusiness#dao.
	 */
	public void setDao(AnimalDAO dao) {
		this.dao = dao;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.services.AnimalService#pesquisar(br.pucpr.sabrh.entity
	 * .Animal)
	 */
	@Override
	public List<Animal> pesquisar(Animal animal) {
		return dao.pesquisar(animal);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.services.AnimalService#salvar(br.pucpr.sabrh.entity.Animal
	 * )
	 */
	@Override
	public Animal salvar(Animal animal) {
		return dao.salvar(animal);
	}

}
