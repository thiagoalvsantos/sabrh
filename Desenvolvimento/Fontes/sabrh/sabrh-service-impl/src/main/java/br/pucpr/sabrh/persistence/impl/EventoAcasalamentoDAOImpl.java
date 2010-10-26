/*
 * Todos os direitos reservados a TR Consulting.
 */
package br.pucpr.sabrh.persistence.impl;

import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.hibernate.Criteria;
import org.hibernate.classic.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import br.pucpr.sabrh.entity.Acasalamento;
import br.pucpr.sabrh.entity.EventoAcasalamento;
import br.pucpr.sabrh.persistence.EventoAcasalamentoDAO;

/**
 * Class EventoAcasalamentoDAOImpl.
 */
@Stateless
public class EventoAcasalamentoDAOImpl implements EventoAcasalamentoDAO {

	/** O atributo entity manager. */
	@PersistenceContext(unitName = "SABRH")
	private EntityManager entityManager;

	/**
	 * Get entity manager.
	 * 
	 * @return the entity manager
	 * @see EventoAcasalamentoDAOImpl#entityManager.
	 */
	public EntityManager getEntityManager() {
		return entityManager;
	}

	/**
	 * Set entity manager.
	 * 
	 * @param entityManager
	 *            - entity manager.
	 * @see EventoAcasalamentoDAOImpl#entityManager.
	 */
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	/* (non-Javadoc)
	 * @see br.pucpr.sabrh.persistence.EventoAcasalamentoDAO#salvar(br.pucpr.sabrh.entity.EventoAcasalamento)
	 */
	@Override
	public EventoAcasalamento salvar(EventoAcasalamento eventoAcasalamento) {

		eventoAcasalamento = entityManager.merge(eventoAcasalamento);
		entityManager.flush();
		return eventoAcasalamento;
	}

	/* (non-Javadoc)
	 * @see br.pucpr.sabrh.persistence.EventoAcasalamentoDAO#pesquisar(br.pucpr.sabrh.entity.Acasalamento)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<EventoAcasalamento> pesquisar(Acasalamento acasalamento) {
		Session s = (Session) entityManager.getDelegate();
		Criteria c = s.createCriteria(EventoAcasalamento.class);
		c.add(Restrictions.eq("acasalamento", acasalamento));
		c.addOrder(Order.asc("codigo"));
		return c.list();

	}

}
