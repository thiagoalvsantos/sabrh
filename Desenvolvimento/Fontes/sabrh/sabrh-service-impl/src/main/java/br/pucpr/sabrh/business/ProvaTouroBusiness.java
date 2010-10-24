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
import br.pucpr.sabrh.entity.ProvaTouro;
import br.pucpr.sabrh.persistence.ProvaTouroDAO;
import br.pucpr.sabrh.services.ProvaTouroService;

/**
 * Implementação abstrata da interface de fachada ProvaTouroService.
 * 
 * @author Rony
 * @version 1
 * @see ProvaTouroService
 */
@Stateless(name = "ProvaTouroService")
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class ProvaTouroBusiness implements ProvaTouroService {

	/** O atributo dao. */
	@EJB
	private ProvaTouroDAO dao;

	/**
	 * Get dao.
	 * 
	 * @return the dao
	 * @see ProvaTouroBusiness#dao.
	 */
	public ProvaTouroDAO getDao() {
		return dao;
	}

	/**
	 * Set dao.
	 * 
	 * @param dao
	 *            - dao.
	 * @see ProvaTouroBusiness#dao.
	 */
	public void setDao(ProvaTouroDAO dao) {
		this.dao = dao;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.services.ProvaTouroService#pesquisar(br.pucpr.sabrh.entity
	 * .Animal)
	 */
	@Override
	public List<ProvaTouro> pesquisar(Animal animal) {
		return dao.pesquisar(animal);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.services.ProvaTouroService#salvar(br.pucpr.sabrh.entity
	 * .ProvaTouro)
	 */
	@Override
	public ProvaTouro salvar(ProvaTouro provaTouro) {
		return dao.salvar(provaTouro);
	}

	@Override
	public void excluir(ProvaTouro provaTouro) {
		dao.excluir(provaTouro);

	}

}
