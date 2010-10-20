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
import br.pucpr.sabrh.entity.ClassificacaoLinear;
import br.pucpr.sabrh.persistence.ClassificacaoLinearDAO;
import br.pucpr.sabrh.services.ClassificacaoLinearService;

/**
 * Implementação abstrata da interface de fachada ClassificacaoLinearService.
 * 
 * @author Rony
 * @version 1
 * @see ClassificacaoLinearService
 */
@Stateless(name = "ClassificacaoLinearService")
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class ClassificacaoLinearBusiness implements ClassificacaoLinearService{
	
	/** O atributo dao. */
	@EJB
	private ClassificacaoLinearDAO dao;

	/**
	 * Get dao.
	 * 
	 * @return the dao
	 * @see ClassificacaoLinearBusiness#dao.
	 */
	public ClassificacaoLinearDAO getDao() {
		return dao;
	}

	/**
	 * Set dao.
	 * 
	 * @param dao
	 *            - dao.
	 * @see ClassificacaoLinearBusiness#dao.
	 */
	public void setDao(ClassificacaoLinearDAO dao) {
		this.dao = dao;
	}

	/* (non-Javadoc)
	 * @see br.pucpr.sabrh.services.ClassificacaoLinearService#pesquisar(br.pucpr.sabrh.entity.Animal)
	 */
	@Override
	public List<ClassificacaoLinear> pesquisar(Animal animal) {
		return dao.pesquisar(animal);
	}

	/* (non-Javadoc)
	 * @see br.pucpr.sabrh.services.ClassificacaoLinearService#salvar(br.pucpr.sabrh.entity.ClassificacaoLinear)
	 */
	@Override
	public ClassificacaoLinear salvar(ClassificacaoLinear classificacaoLinear) {
		return dao.salvar(classificacaoLinear);
	}

}
