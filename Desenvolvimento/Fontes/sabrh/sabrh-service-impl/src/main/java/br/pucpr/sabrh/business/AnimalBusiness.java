/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.business;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;

import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.TipoSexoAnimal;
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.services.AnimalService#recuperarAnimalPadrao(br.pucpr.
	 * sabrh.entity.TipoSexoAnimal)
	 */
	@Override
	public Animal recuperarAnimalPadrao(TipoSexoAnimal sexo) {
		return dao.recuperarAnimalPadrao(sexo);
	}

	@Override
	public boolean verificarConsanguinidade(Animal femea, Animal macho) {

		List<Animal> pais = new ArrayList<Animal>();
		List<Animal> avos = new ArrayList<Animal>();
		List<Animal> bisavos = new ArrayList<Animal>();
		List<Animal> arvore = new ArrayList<Animal>();

		pais.add(femea.getPai());
		pais.add(femea.getMae());

		try {
			adiocionarGeracao(arvore, pais);

			avos = criarGeracao(pais);
			adiocionarGeracao(arvore, avos);

			bisavos = criarGeracao(avos);
			adiocionarGeracao(arvore, bisavos);

		} catch (Exception e) {
			return false;
		}

		return true;
	}

	private List<Animal> adiocionarGeracao(List<Animal> arvore,
			List<Animal> geracao) throws Exception {

		for (Animal animal : geracao) {
			if (!arvore.contains(animal)) {
				arvore.add(animal);
			} else {
				throw new Exception();
			}
		}

		return arvore;
	}

	private List<Animal> criarGeracao(List<Animal> filhos) throws Exception {
		ArrayList<Animal> geracao = new ArrayList<Animal>();
		for (Animal animal : filhos) {
			if (!geracao.contains(animal.getPai())) {
				geracao.add(animal.getPai());
			} else {
				throw new Exception();
			}
			if (!geracao.contains(animal.getMae())) {
				geracao.add(animal.getMae());
			} else {
				throw new Exception();
			}
		}
		return geracao;
	}

}
