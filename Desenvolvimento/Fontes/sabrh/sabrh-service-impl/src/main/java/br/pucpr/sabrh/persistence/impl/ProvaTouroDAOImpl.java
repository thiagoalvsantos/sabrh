/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence.impl;

import java.util.List;

import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import br.pucpr.sabrh.entity.Animal;
import br.pucpr.sabrh.entity.FiltroAcasalamento;
import br.pucpr.sabrh.entity.ProvaTouro;
import br.pucpr.sabrh.persistence.ProvaTouroDAO;

/**
 * Class ProvaTouroDAOImpl.
 */
@Stateless
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class ProvaTouroDAOImpl implements ProvaTouroDAO {

	/** O atributo entity manager. */
	@PersistenceContext(unitName = "SABRH")
	private EntityManager entityManager;

	/**
	 * Get entity manager.
	 * 
	 * @return the entity manager
	 * @see ClassificacaoLinearDAOImpl#entityManager.
	 */
	public EntityManager getEntityManager() {
		return entityManager;
	}

	/**
	 * Set entity manager.
	 * 
	 * @param entityManager
	 *            - entity manager.
	 * @see ClassificacaoLinearDAOImpl#entityManager.
	 */
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.persistence.ProvaTouroDAO#pesquisar(br.pucpr.sabrh.entity
	 * .Animal)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<ProvaTouro> pesquisar(Animal animal) {
		Session s = (Session) entityManager.getDelegate();
		Criteria c = s.createCriteria(ProvaTouro.class, "provaTouro");
		c.add(Restrictions.eq("animal", animal));

		List<ProvaTouro> result = c.list();
		return result;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.persistence.ProvaTouroDAO#salvar(br.pucpr.sabrh.entity
	 * .ProvaTouro)
	 */
	@Override
	public ProvaTouro salvar(ProvaTouro provaTouro) {

		ProvaTouro result = null;
		result = entityManager.merge(provaTouro);
		entityManager.flush();

		return result;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.persistence.ProvaTouroDAO#excluir(br.pucpr.sabrh.entity
	 * .ProvaTouro)
	 */
	@Override
	public void excluir(ProvaTouro provaTouro) {
		provaTouro = entityManager.merge(provaTouro);
		entityManager.remove(provaTouro);
		entityManager.flush();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.pucpr.sabrh.persistence.ProvaTouroDAO#pesquisarReprodutor(br.pucpr
	 * .sabrh.entity.FiltroAcasalamento)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<ProvaTouro> pesquisarReprodutor(
			FiltroAcasalamento filtroAcasalamento) {
		Session s = (Session) entityManager.getDelegate();
		Criteria c = s.createCriteria(ProvaTouro.class, "provaTouro");

		if (filtroAcasalamento.getConfiabilidadeConformacao() >= 0)
			c.add(Restrictions.ge("confiabilidadeConformacao",
					filtroAcasalamento.getConfiabilidadeConformacao()));

		if (filtroAcasalamento.getConfiabilidadeProducao() >= 0)
			c.add(Restrictions.ge("confiabilidadeProducao",
					filtroAcasalamento.getConfiabilidadeProducao()));

		for (String atributo : filtroAcasalamento.getListaProducao()) {
			c.addOrder(Order.asc(atributo));
		}

		for (String atributo : filtroAcasalamento.getListaConformacao()) {
			c.addOrder(Order.asc(atributo));
		}

		List<ProvaTouro> result = c.list();
		return result;
	}

}
