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

import br.pucpr.sabrh.entity.Estado;
import br.pucpr.sabrh.persistence.EstadoDAO;

@Stateless
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class EstadoDAOImpl implements EstadoDAO {

	/** O atributo entity manager. */
	@PersistenceContext(unitName = "SABRH")
	private EntityManager entityManager;

	/**
	 * Get entity manager.
	 * 
	 * @return the entity manager
	 * @see UsuarioDAOImpl#entityManager.
	 */
	public EntityManager getEntityManager() {
		return entityManager;
	}

	/**
	 * Set entity manager.
	 * 
	 * @param entityManager
	 *            - entity manager.
	 * @see UsuarioDAOImpl#entityManager.
	 */
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	/* (non-Javadoc)
	 * @see br.pucpr.sabrh.persistence.EstadoDAO#listarEstado()
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Estado> listarEstado() {

		Session session = (Session) entityManager.getDelegate();

		Criteria c = session.createCriteria(Estado.class);

		return c.addOrder(Order.asc("descricao")).list();
	}

}
